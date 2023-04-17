//
//  PriorityQueue.swift
//  AStar
//
//  Created by matheusvb on 16/04/23.
//

import Foundation

typealias PriorityDefinition<P> = (_ p1: P, _ p2: P) -> (Bool)

class PriorityQueue<E, P: Hashable> {
    var priDef: PriorityDefinition<P>!
    var elemments = [P: [E]]()
    var priority = [P]()
    init(_ priDef: @escaping PriorityDefinition<P>) {
        self.priDef = priDef
    }
    func enqueue(_ element: E!, _ priorityValue: P!) {
        if let _ = elemments[priorityValue] {
            elemments[priorityValue]!.append(element)
        } else {
            elemments[priorityValue] = [element]
        }
        if !priority.contains(priorityValue) {
            priority.append(priorityValue)
            let lastIndex = priority.count - 1
            siftUp(0, lastIndex, lastIndex)
        }
    }
    func dequeue() -> E? {
        var result: E? = nil
        if priority.count > 0 {
            var p = priority.first!
            if elemments[p]!.count == 1 {
                if priority.count > 1 {
                    let _temp = priority[0]
                    priority[0] = priority[priority.count - 1]
                    priority[priority.count - 1] = _temp
                    p = priority.last!
                    siftDown(0, priority.count - 2)
                }
                result = elemments[p]!.removeFirst()
                elemments[p] = nil
                priority.remove(at: priority.firstIndex(of: p)!)
            } else {
                result = elemments[p]!.removeFirst()
            }
        }
        return result
    }
    func siftDown(_ start: Int, _ end: Int) {
        let iLeftChild = 2 * start + 1
        if iLeftChild <= end {
            var largestChild = priDef(priority[iLeftChild], priority[start]) ? iLeftChild : start
            let iRightChild = 2 * start + 2
            if iRightChild <= end {
                if priDef(priority[iRightChild], priority[iLeftChild]) {
                    largestChild = iRightChild
                }
            }
            if largestChild == start {
                return
            } else {
                let _temp = priority[start]
                priority[start] = priority[largestChild]
                priority[largestChild] = _temp
                siftDown(largestChild, end)
            }
        }
    }
    func siftUp(_ start: Int, _ end: Int, _ nodeIndex: Int) {
        let parent = (nodeIndex - 1) / 2
        if parent >= start {
            if priDef(priority[nodeIndex], priority[parent]) {
                let _temp = priority[nodeIndex]
                priority[nodeIndex] = priority[parent]
                priority[parent] = _temp
                siftUp(start, end, parent)
            } else {
                return
            }
        }
    }
    func isEmpty() -> Bool {
        return priority.count == 0
    }
}
