//
//  AStar.swift
//  AStar
//
//  Created by matheusvb on 16/04/23.
//

import Foundation

extension AStarView {
    func aStarAlgorithm() async -> Bool {
        let openHeap = Heap<Node, CGFloat> { (p1: CGFloat, p2: CGFloat) -> (Bool) in
            return p1 < p2
        }
        
        openHeap.insert(startNode, priority: 0)
        
        var parentNode = [Int: Int]()
        var gScore = [Int: Double]()
        var fScore = [Int: Double]()
        
        for row in 0..<rows {
            for col in 0..<cols {
                gScore[matrix[row][col].id] = Double.infinity
                fScore[matrix[row][col].id] = Double.infinity
            }
        }
    
        gScore[startNode.id] = 0
        fScore[startNode.id] = heuristic(p1: CGPoint(x: startNode.row, y: startNode.col), p2: CGPoint(x: endNode.row, y: endNode.col))
        
        var openHeapHash = [startNode]
        
        while !openHeap.isEmpty {
            soundPlayer.playSound(name: "check", type: "wav")

            try? await Task.sleep(nanoseconds: 50_000_000)

            guard var currentNode = openHeap.pop() else {
                print ("ERRO")
                return false
            }
            
            
            if let index = openHeapHash.firstIndex(of: currentNode) {
                openHeapHash.remove(at: index)
            }
            
            if currentNode == endNode {
                var currentPath = currentNode
                
                while currentPath.id != startNode.id {
                    soundPlayer.playSound(name: "click", type: "wav")
                    
                    path.append(currentPath)
                    
                    pathCount += 1
                    
                    if currentPath.id != endNode.id {
                        matrix[currentPath.row][currentPath.col].status = .path
                    } else {
                        matrix[currentPath.row][currentPath.col].status = .end
                    }
                    
                    let currentPathId = parentNode[currentPath.id]
                    
                    let matchingRow = matrix.filter { nodes in
                        nodes.first(where: { $0.id == currentPathId }) != nil
                    }.first
                    
                    guard let foundPath = matchingRow?.first(where: { $0.id == currentPathId }) else {
                        return false
                    }
                    
                    currentPath = foundPath
                                        
                    try? await Task.sleep(nanoseconds: 35_000_000)
                }
                
                foundPath = true
                //FOUND PATH
                return true
            }
            
            for neighbourId in currentNode.neighboursIds {
                let matchingRow = matrix.filter { nodes in
                    nodes.first(where: { $0.id == neighbourId }) != nil
                }.first
                
                guard var neighbour = matchingRow?.first(where: { $0.id == neighbourId }) else {
                    return false
                }
                
                
                let tempGScore = gScore[currentNode.id]! + 1
                
                if tempGScore < gScore[neighbour.id]! {
                    parentNode[neighbour.id] = currentNode.id
                    gScore[neighbour.id] = tempGScore
                    fScore[neighbour.id] = tempGScore + heuristic(p1: CGPoint(x: neighbour.row, y: neighbour.col), p2: CGPoint(x: endNode.row, y: endNode.col))
                    
                    if !openHeapHash.contains(neighbour) {
                        openHeap.insert(neighbour, priority: CGFloat(fScore[neighbour.id]!))
                        openHeapHash.append(neighbour)
                        neighbour.status = .open
                        
                        matrix[neighbour.row][neighbour.col].status = .open
                    }
                }
            }
 
            matrix[currentNode.row][currentNode.col] = currentNode
            
            if currentNode != startNode {
                currentNode.status = .closed
                matrix[currentNode.row][currentNode.col].status = .closed
            }
        }
        
        return false

    }
}

