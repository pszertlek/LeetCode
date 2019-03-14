//
//  Heap.swift
//  LeetCode
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

public struct Heap<T> {
    public var nodes = [T]()
    private var orderCriteria: (T, T) -> Bool
    
    public init(sort: @escaping (T, T) -> Bool) {
        orderCriteria = sort
    }
    
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    public var count: Int {
        return nodes.count
    }
    
    public mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: nodes.count / 2 - 1, through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    public mutating func reset() {
        for i in stride(from: nodes.count / 2 - 1, through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    @inline(__always) internal func parentIndex(ofIndex index: Int) -> Int {
        return (index - 1) / 2
    }
    
    @inline(__always) internal func leftChildIndex(ofIndex index: Int) -> Int {
        return index * 2 + 1
    }
    
    @inline(__always) internal func rightChildIndex(ofIndex index: Int) -> Int {
        return index * 2 + 2
    }
    
    public func peek() -> T? {
        return nodes.first
    }
    
    internal mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: index)
        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        nodes[childIndex] = child
    }
    
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = self.rightChildIndex(ofIndex: index)
        
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        if first == index {
            return
        }
        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
    
    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }
    
    public mutating func insert<S: Sequence>(_ sequence:S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }
    
    public mutating func replace(index i: Int, value: T) {
        guard i < nodes.count else {
            return
        }
        remove(at: i)
        insert(value)
    }
    
    @discardableResult
    public mutating func remove() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil}
        let size = nodes.count - 1
        if index != size {
            nodes.swapAt(index, size)
            shiftDown(from: index,  until: size)
            shiftUp(index)
        }
        return nodes.removeLast()
    }
    
    public mutating func sort() -> [T] {
        for i in stride(from: self.nodes.count - 1, to: 0, by: -1) {
            nodes.swapAt(0, i)
            shiftDown(from: 0, until: i)
        }
        return nodes
    }

}

public func heapSort<T>(_ a:[T], _ sort: @escaping (T,T) -> Bool) -> [T] {
    var heap = Heap(array: a, sort: sort)
    return heap.sort()
}

public extension Heap where T: Equatable {
    /** Get the index of a node in the heap. Performance: O(n). */
    public func index(of node: T) -> Int? {
        return nodes.index(where: { $0 == node })
    }
    
    /** Removes the first occurrence of a node from the heap. Performance: O(n log n). */
    @discardableResult public mutating func remove(node: T) -> T? {
        if let index = index(of: node) {
            return remove(at: index)
        }
        return nil
    }
}



public struct PriorityQueue<T> where T: Comparable {
    private var heap: Heap<T>
    
    init(sort: @escaping (T,T) -> Bool) {
        heap = Heap<T>(sort: sort)
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
    
    public mutating func enqueue(element: T) {
        heap.insert(element)
    }
    
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    
    public mutating func changePriority(index i: Int, value: T) {
        return heap.replace(index: i, value: value)
    }
}

extension PriorityQueue where T: Equatable {
    public func index(of element: T) -> Int? {
        return heap.index(of: element)
    }
}



class KthLargest {
    var array: [Int]
    let k: Int
    init(_ k: Int, _ nums: [Int]) {
        array = nums.sorted().reversed()
        self.k = k
    }
    
    func add(_ val: Int) -> Int {
        guard array.count > 1 else {
            array.insert(val, at: val > array.first! ? 0 : 1)
            return array[k - 1]
        }
        var left = 0, right = array.count - 1
        while left < right {
            let mid = (left + right) / 2
            if array[mid] >= val {
                left = mid + 1
            } else {
                right = mid
            }
        }
        array.insert(val, at: left)
        print(array)
        return array[k - 1]
    }
}

class KthLargest1 {
    var heap: Heap<Int>
    let k: Int
    init(_ k: Int, _ nums: [Int]) {
        let array = nums.sorted()
        heap = Heap(array:Array(array.suffix(k)),sort: <)
        self.k = k
    }
    
    func add(_ val: Int) -> Int {
        heap.insert(val)
        heap.remove()
        print(heap.nodes)
        return heap.peek()!
    }
}


public class HeapSolution {

    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var heap = Heap<(Int, Int)>.init { (f, s) -> Bool in
            return f.1 < s.1
        }
        var dict = [Int: Int]()
        for i in nums {
            dict[i] = (dict[i] ?? 0) + 1
        }
        
        for i in dict {
            heap.insert(i)
            if heap.count > k {
                heap.remove()
            }
        }
        var array = [Int]()
        while heap.count > 0 {
            array.append(heap.peek()!.0)
            heap.remove()
        }
        return array.reversed()
    }
    
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var heap = Heap<(String, Int)>.init { (f, s) -> Bool in
            if ( f.1 < s.1 ) {
                return true
            } else if f.1 == s.1 {
                return f.0 > s.0
            } else {
                return false
            }
        }
        var dict = [String: Int]()
        for i in words {
            dict[i] = (dict[i] ?? 0) + 1
        }
        
        for i in dict {
            heap.insert(i)
            if heap.count > k {
                heap.remove()
            }
        }
        var array = [String]()
        while heap.count > 0 {
            array.append(heap.peek()!.0)
            heap.remove()
        }
        return array.reversed()
    }

}
