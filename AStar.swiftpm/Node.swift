//
//  Node.swift
//  AStar
//
//  Created by matheusvb on 16/04/23.
//

import Foundation
import SwiftUI

struct Node: Identifiable, Hashable {
    var id =  0
    var status: NodeStatus = .free
    var row: Int = 0
    var col: Int = 0
    var neighboursIds: [Int] = []
    
    func getColor() -> Color {
        switch(self.status) {
        case .path:
            return .purple
            
        case .free:
            return .gray
            
        case .open:
            return .green
            
        case .closed:
            return .red
            
        case .barrier:
            return .black
            
        case .start:
            return .orange
            
        case .end :
            return .blue
        }
    }
    
    func setNewStatus() {
        switch(self.status) {
        case .path:
            return
            
        case .free:
            return
            
        case .open:
            return
            
        case .closed:
            return
            
        case .barrier:
            return
            
        case .start:
            return
            
        case .end :
            return
        }
    }
    
    mutating func updateNeighbours(grid: [[Node]]) {
        neighboursIds = []
        
        if row < (rows - 1) && grid[row + 1][col].status != .barrier {
            neighboursIds.append(grid[row + 1][col].id)
        }
        
        if row > 0 && grid[row - 1][col].status != .barrier {
            neighboursIds.append(grid[row - 1][col].id)
        }
        
        if col < (cols - 1) && grid[row][col + 1].status != .barrier {
            neighboursIds.append(grid[row][col + 1].id)
        }
        
        if col > 0 && grid[row][col - 1].status != .barrier {
            neighboursIds.append(grid[row][col - 1].id)
        }
    }
}

enum NodeStatus {
    case path
    case free
    case closed
    case open
    case barrier
    case start
    case end
}
