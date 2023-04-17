import SwiftUI

let rows = 50
let cols = 50



struct ContentView: View {
    
    @State var matrix = [[Node]](repeating: [Node](repeating: Node(), count: cols), count: rows)
    
    @State var selectedNodes: [Node] = []
    @State var nodeFrames = [CGRect]()
    
    @State var startSet = false
    @State var startNode: Node = Node()
    
    @State var endSet = false
    @State var endNode: Node = Node()
    
    var body: some View {
        ZStack{
            VStack {
                VStack(spacing: 2){
                    ForEach(0..<rows, id: \.self) {row in
                        HStack(spacing: 2){
                            ForEach(0..<cols, id: \.self) {col in
                                Rectangle()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(matrix[row][col].getColor())
                                    .overlay(
                                        GeometryReader { geo in
                                            Color.clear
                                                .onAppear {
                                                    nodeFrames.insert((geo.frame(in: .global)), at: 0)
                                                    matrix[row][col].col = col
                                                    matrix[row][col].row = row
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
                Button("hello") {
                    for row in 0..<rows {
                        for col in 0..<cols {
                            matrix[row][col].updateNeighbours(grid: matrix)
                        }
                    }
                    
                    print(aStarAlgorithm())
                    
                    
                }
                Spacer()
            }
        }
    }
}

