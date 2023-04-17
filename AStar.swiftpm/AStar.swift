//
//  AStar.swift
//  AStar
//
//  Created by matheusvb on 16/04/23.
//

import Foundation

func heuristic(p1: CGPoint, p2: CGPoint) -> CGFloat {
    return abs(p1.x - p2.x) + abs(p1.y - p2.y)
}

extension ContentView {
    func aStarAlgorithm() -> Bool {
        var count = 0
        let openQueue = PriorityQueue<Node, CGFloat> { (p1: CGFloat, p2: CGFloat) -> (Bool) in
            return p1 < p2
        }
        
        openQueue.enqueue(startNode, 0)
        
        var parentNode = [Node: Node]()
        var gScore = [Node: Double]()
        
        for row in 0..<rows {
            for col in 0..<cols {
                gScore[matrix[row][col]] = 10000000
                print("\(row), \(col)")
            }
        }
        
        
        gScore[startNode] = 0
        
        var fScore = [Node: Double]()
        
        for row in 0..<rows {
            for col in 0..<cols {
                fScore[matrix[row][col]] = 10000000
            }
        }


        fScore[startNode] = heuristic(p1: CGPoint(x: startNode.row, y: startNode.col), p2: CGPoint(x: endNode.row, y: endNode.col))

        
        var openQueueHash = [startNode]
        
        while !openQueue.isEmpty() {
            guard var currentNode = openQueue.dequeue() else {
                return false
            }
            
            if let index = openQueueHash.firstIndex(of: currentNode) {
                openQueueHash.remove(at: index)
            }
            
            if currentNode == endNode {
                //FOUND PATH
                return true
            }
            
            for var neighbour in currentNode.neighbours {
                let tempGScore = gScore[currentNode]! + 1
                
                if tempGScore < gScore[neighbour]! {
                    parentNode[neighbour] = currentNode
                    gScore[neighbour] = tempGScore
                    fScore[neighbour] = tempGScore + heuristic(p1: CGPoint(x: neighbour.row, y: neighbour.col), p2: CGPoint(x: endNode.row, y: endNode.col))
                    
                    if !openQueueHash.contains(neighbour) {
                        count += 1
                        openQueue.enqueue(neighbour, CGFloat(fScore[neighbour]!))
                        openQueueHash.append(neighbour)
                        neighbour.status = .open
                    }
                }
            }
            
            //UPDATE
            
            if currentNode != startNode {
                currentNode.status = .closed
            }
        }
        
        return false
        
        
    }
}

