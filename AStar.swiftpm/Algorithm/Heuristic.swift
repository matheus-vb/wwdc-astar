//
//  File.swift
//  
//
//  Created by matheusvb on 20/04/23.
//

import Foundation

func heuristic(p1: CGPoint, p2: CGPoint) -> CGFloat {
    return abs(p1.x - p2.x) + abs(p1.y - p2.y)
}
