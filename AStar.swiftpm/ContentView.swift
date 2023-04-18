import SwiftUI
import AVFoundation

let rows = 25
let cols = 25

var player: AVAudioPlayer!

var pathCount = 0

struct ContentView: View {
    
    @State var matrix = [[Node]](repeating: [Node](repeating: Node(), count: cols), count: rows)
    
    @State var selectedNodes: [Node] = []
    @State var nodeFrames = [CGRect]()
    
    @State var startSet = false
    @State var startNode: Node = Node()
    
    @State var endSet = false
    @State var endNode: Node = Node()
    
    @State var idCounter: Int = 0
    
    var body: some View {
        ZStack{
            VStack {
                VStack(spacing: 2){
                    ForEach(0..<rows, id: \.self) {row in
                        HStack(spacing: 2){
                            ForEach(0..<cols, id: \.self) {col in
                                Rectangle()
                                    .frame(width: 24, height: 24)
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
                            }
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                .onChanged({ (value) in
                                    if let match = nodeFrames.firstIndex(where: { $0.contains(value.location) }) {
                                        let row = match / cols
                                        let col = match % cols
                                        print("\(matrix[row][col].col), \(matrix[row][col].row)")
                                        
                                        if !startSet {
                                            matrix[row][col].status = .start
                                            startSet = true
                                            startNode = matrix[row][col]
                                            
                                        } else if !endSet {
                                            matrix[row][col].status = .end
                                            endSet = true
                                            endNode = matrix[row][col]
                                            
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
                Spacer()
                Button("Find path") {
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
                            await print(aStarAlgorithm())
                            let end = NSDate().timeIntervalSince1970
                            print(end - start)
                            print(pathCount)
                            pathCount = 0
                        }
                    }
                    
                    
                }
                
                Spacer()
                
                Button("Reset") {
                    for row in 0..<rows {
                        for col in 0..<cols {
                            matrix[row][col].status = .free
                        }
                    }
                    
                    startSet = false
                    endSet = false
                }
                
                Spacer()
            }
        }
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

