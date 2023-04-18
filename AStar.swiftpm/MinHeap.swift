//
//  MinHeap.swift
//  AStar
//
//  Created by matheusvb on 17/04/23.
//

import Foundation

class Heap<E, P: Comparable> {
    private var elements = [(element: E, priority: P)]()
    private let isMinHeap: Bool
    
    init(isMinHeap: Bool) {
        self.isMinHeap = isMinHeap
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var size: Int {
        return elements.count
    }
    
    private func getParentIndex(_ i: Int) -> Int {
        return (i - 1) / 2
    }
    
    private func getLeftChildIndex(_ i: Int) -> Int {
        return (2 * i) + 1
    }
    
    private func getRightChildIndex(_ i: Int) -> Int {
        return (2 * i) + 2
    }
    
    private func isPriorityHigher(_ e1: (element: E, priority: P), _ e2: (element: E, priority: P)) -> Bool {
        if isMinHeap {
            return e1.priority < e2.priority
        } else {
            return e1.priority > e2.priority
        }
    }
    
    private func swap(_ aIdx: Int, _ bIdx: Int) {
        let temp = elements[aIdx]
        elements[aIdx] = elements[bIdx]
        elements[bIdx] = temp
        
        return
    }
    
    private func bubbleUp(_ i: Int) {
        var index = i
        
        while index > 0 && isPriorityHigher(elements[index], elements[getParentIndex(index)]) {
            swap(index, getParentIndex(index))
            index = getParentIndex(index)
        }
    }
    
    private func bubbleDown(_ i: Int) {
        var index = i
        
        while true {
            let leftIdx = getLeftChildIndex(index)
            let rightIdx = getRightChildIndex(index)
            var priorityIdx = index
            
            if leftIdx < size && isPriorityHigher(elements[leftIdx], elements[priorityIdx]) {
                priorityIdx = leftIdx
            }
            
            if rightIdx < size && isPriorityHigher(elements[rightIdx], elements[priorityIdx]) {
                priorityIdx = rightIdx
            }
            
            if priorityIdx == index {
                break
            }
            
            swap(index, priorityIdx)
            index = priorityIdx
        }
    }
    
    func insert(_ element: E, priority: P) {
        elements.append((element, priority))
        bubbleUp(size - 1)
    }
    
    func pop() -> E? {
        if isEmpty {
            return nil
        }
        
        if size == 1 {
            return elements.removeFirst().element
        } else {
            let element = elements[0].element
            elements[0] = elements.removeLast()
            bubbleDown(0)
            
            return element
        }
    }
}
