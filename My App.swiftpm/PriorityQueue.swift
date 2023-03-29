//
//  PriorityQueue.swift
//  HuffEncoder
//
//  Created by Giulia Casucci on 29/03/23.
//


///Priority Queue is an abstract data-type where each element in a priority queue has an associated priority, and elements with high priority are served before elements with low priority (so they're in front of the queue)
///Priority Queues are often implemented using heaps, that are specialized tree-based data structure which is essentially an almost complete tree that satisfies the heap property.
///In a complete binary tree, all the levels of a tree are filled entirely except the last level. In the last level, nodes might or might not be filled fully. Also, let’s note that all the nodes should be filled from the left.
///All operations are O(lg n).
import Foundation


public struct PriorityQueue<T> {
    ///fileprivate declared is accessible within the same file.
    fileprivate var heap: Heap<T>
    
    ///To create a max-priority queue, supply a > sort function. For a min-priority queue, use <.
    public init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(sort: sort)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public var count: Int {
        return heap.count
    }
    
    public func peek() -> T? {
        return heap.peek()
    }
    
    public mutating func enqueue(_ element: T) {
        heap.insert(element)
    }
    
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    
    ///Allows you to change the priority of an element. In a max-priority queue, the new priority should be larger than the old one; in a min-priority queue it should be smaller.
    public mutating func changePriority(index i: Int, value: T) {
        return heap.replace(index: i, value: value)
    }
}

extension PriorityQueue where T: Equatable {
    public func indexOf(element: T) -> Int? {
        return heap.index(of: element)
    }
}


