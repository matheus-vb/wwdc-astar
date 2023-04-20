import SwiftUI
import AVFoundation

let rows = 12
let cols = 12

var pathCount = 0

struct AStarView: View {
    
    @EnvironmentObject var appStatus: AppStatus
    
    @State var matrix = [[Node]](repeating: [Node](repeating: Node(), count: cols), count: rows)
    
    @State var selectedNodes: [Node] = []
    @State var nodeFrames = [CGRect]()
    
    @State var startSet = false
    @State var startNode: Node = Node()
    
    @State var currentRect = CGRect()
    @State var endRect = CGRect()
    
    @State var endSet = false
    @State var endNode: Node = Node()
    
    @State var foundPath: Bool = false
    @State var path: [Node] = []
    @State var unavailablePath: Bool = false
    
    @State var idCounter: Int = 0
    
    @State var animateX: CGFloat = 0
    @State var animateY: CGFloat = 0
    
    @State var showingTutorial: Bool = true
    @State var tutorialAnimation: Bool = true
    
    @State var showDonePath: Bool = false
    
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        ZStack{
            Color.theme.background
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 2) {
                ZStack{
                    Image(uiImage: UIImage(imageLiteralResourceName: "logo"))
                        .resizable()
                        .scaledToFit()
                    
                    Button(action: {
                        showingTutorial = true
                        soundPlayer.playSound(name: "ticker", type: "mp3")

                    }, label: {
                        Image(uiImage: UIImage(imageLiteralResourceName: "tutorial"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .position(x: UIScreen.main.bounds.width - 50, y: 50)
                    })
                    
                    Button(action: {
                        soundPlayer.playSound(name: "ticker", type: "mp3")
                        
                        withAnimation {
                            appStatus.appStatus = .credits
                        }

                    }, label: {
                        Image(uiImage: UIImage(imageLiteralResourceName: "info"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .position(x: UIScreen.main.bounds.width - 50, y: 50)
                    })
                }
                VStack(spacing: 2){
                    ForEach(0..<rows, id: \.self) {row in
                        HStack(spacing: 2){
                            ForEach(0..<cols, id: \.self) {col in
                                ZStack {
                                    Rectangle()
                                        .frame(width: 56, height: 56)
                                        .foregroundColor(matrix[row][col].getColor())
                                        .overlay(
                                            GeometryReader { geo in
                                                Color.clear
                                                    .onAppear {
                                                        nodeFrames.insert((geo.frame(in: .global)), at: 0)
                                                        matrix[row][col].col = col
                                                        matrix[row][col].row = row
                                                        matrix[row][col].id = idCounter
                                                        idCounter += 1
                                                    }
                                            }
                                        )
                                        .cornerRadius(10)
                                }
                            }
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                .onChanged({ (value) in
                                    if let match = nodeFrames.firstIndex(where: { $0.contains(value.location) }) {
                                        let row = match / cols
                                        let col = match % cols
                                        
                                        if !startSet {
                                            soundPlayer.playSound(name: "place", type: "wav")
                                            matrix[row][col].status = .start
                                            startSet = true
                                            startNode = matrix[row][col]
                                            currentRect = nodeFrames[match]
                                            animateX = nodeFrames[match].midX
                                            animateY = nodeFrames[match].minY
                                            
                                        } else if !endSet {
                                            soundPlayer.playSound(name: "place", type: "wav")
                                            if matrix[row][col].status != .start {
                                                matrix[row][col].status = .end
                                                endSet = true
                                                endNode = matrix[row][col]
                                                endRect = nodeFrames[match]
                                            }
                                            
                                        } else {
                                            matrix[row][col].status = .barrier
                                        }
                                        
                                    } else {
                                        //deactivateSounds()
                                    }
                                })
                                    .onEnded({ (_) in
                                        //deactivateSounds()
                                    })
                            )
                        }
                    }
                }
                
                GameCardView(step: {
                    if !startSet {
                        return .first
                    } else if !endSet {
                        return .second
                    } else {
                        return .third
                    }
                }()).padding(.top)
                
                HStack (spacing: 80){
                    Button(action: {
                        soundPlayer.playSound(name: "ticker", type: "mp3")

                        withAnimation {
                            appStatus.appStatus = .intro
                        }
                            
                    }, label: {
                        Image(uiImage: UIImage(imageLiteralResourceName: "back"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 108, height: 108)
                    })
                    
                    Button(action: {
                        soundPlayer.playSound(name: "ticker", type: "mp3")

                        for row in 0..<rows {
                            for col in 0..<cols {
                                matrix[row][col].updateNeighbours(grid: matrix)
                            }
                        }
                        
                        startNode.neighboursIds = matrix[startNode.row][startNode.col].neighboursIds
                        
                        endNode.neighboursIds = matrix[endNode.row][endNode.col].neighboursIds
                        
                        DispatchQueue.main.async {
                            Task {
                                let start = NSDate().timeIntervalSince1970
                                let done = await aStarAlgorithm()
                                let end = NSDate().timeIntervalSince1970
                                pathCount = 0
                                if !done {
                                    await showNoPathCard()
                                }
                                
                            }
                        }
                    }, label: {
                        Image(uiImage: UIImage(imageLiteralResourceName: "astar"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    })
                    
                    Button(action: {
                        soundPlayer.playSound(name: "ticker", type: "mp3")

                        for row in 0..<rows {
                            for col in 0..<cols {
                                matrix[row][col].status = .free
                            }
                        }
                        
                        startSet = false
                        endSet = false
                        foundPath = false
                        path = []
                        currentRect = CGRect()
                        endRect = CGRect()
                    }, label: {
                        Image(uiImage: UIImage(imageLiteralResourceName: "reset"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 108, height: 108)
                    })
                }
                .frame(height: 220)
                
            }
            
            if endSet {
                Image(uiImage: UIImage(imageLiteralResourceName: "house"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .position(x: endRect.midX, y: endRect.minY)
            }

            if startSet {
                Image(uiImage: UIImage(imageLiteralResourceName: "biker"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .position(x: animateX, y: animateY)
                    .animation(.default, value: animateX)
                    .animation(.default, value: animateY)
            }
            
            
            
            TutorialView(showingTutorial: $showingTutorial)
                .opacity(showingTutorial ? 1 : 0 )
                .animation(.default, value: showingTutorial)
                .transition(.opacity)
            
            NoPathView()
                .opacity(unavailablePath ? 1 : 0)
                .animation(.default, value: unavailablePath)
                .transition(.opacity)
            
            PathDoneView()
                .opacity(showDonePath ? 1 : 0)
                .animation(.default, value: showDonePath)
                .transition(.opacity)
        }
        .onChange(of: showingTutorial) {_ in
            withAnimation(Animation.easeOut(duration: 0.5)) {
                tutorialAnimation.toggle()
            }
        }
        
        .onChange(of: foundPath) {_ in
            if foundPath {
                DispatchQueue.main.async {
                    Task {
                        await delayAnimation()
                    }
                }
            }
        }
    }
    
    func showNoPathCard() async {
        
        unavailablePath.toggle()
        
        try? await Task.sleep(nanoseconds: 2_750_000_000)
        
        unavailablePath.toggle()
    }
    
    func delayAnimation() async {
        let reversedPath = path.reversed()
        
        for node in reversedPath {
            currentRect = nodeFrames[node.row * cols + node.col]
            animateX = currentRect.midX
            animateY = currentRect.minY
            try? await Task.sleep(nanoseconds: 175_000_000)
        }
        
        soundPlayer.playSound(name: "doorbell", type: "wav")

        showDonePath.toggle()
        try? await Task.sleep(nanoseconds: 2_750_000_000)
        showDonePath.toggle()
        
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "ticker", withExtension: "wav")
        
        guard url != nil else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player.play()
        } catch {
            print("\(error)")
        }
    }
}

