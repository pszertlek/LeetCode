//
//  Heap.swift
//  LeetCode
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

public struct Heap<T> where T: Comparable {
    var nodes = [T]()
    private var orderCriteria: (T, T) -> Bool
    public init(sort: @escaping (T, T) -> Bool) {
        orderCriteria = sort
    }
    
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    public var count: Int {
        return nodes.count
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
}
