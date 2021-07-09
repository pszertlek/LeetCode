//
//  LRUCache.swift
//  LeetCode
//
//  Created by Apple on 2020/8/27.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

class LRUCache: CustomStringConvertible {
    class Item: Comparable, CustomStringConvertible {
        static func == (lhs: LRUCache.Item, rhs: LRUCache.Item) -> Bool {
            return lhs.val == rhs.val
        }
        var key: Int
        var val: Int
        var pre: Item?
        var next: Item?
        init(_ val: Int, _ key: Int) {
            self.val = val
            self.key = key
        }
        
        static func < (lhs: Item, rhs: Item) -> Bool {
            return lhs.val < rhs.val
        }
        static func <= (lhs: Item, rhs: Item) -> Bool {
            return lhs.val <= rhs.val
        }

        static func >= (lhs: Item, rhs: Item) -> Bool {
            return lhs.val >= rhs.val
        }
        static func > (lhs: Item, rhs: Item) -> Bool {
            return lhs.val > rhs.val
        }
        
        var description: String {
            return "key:\(key) val: \(val)"
        }
    }
    
    var dict = [Int: Item]()
    var capacity: Int
    var head: Item?
    var tail: Item?
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        if let item = self.dict[key] {
            self.replaceHead(item)
            return item.val
        } else {
            return -1
        }
    }
    
    func put(_ key: Int, _ value: Int) {
        if let item = self.dict[key] {
            item.val = value
            self.replaceHead(item)
        } else {
            let item = Item(value,key)
            self.insert(item)
        }
    }
    
    func replaceHead(_ item: Item) {
        removeNode(item)
        item.pre = nil
        item.next = nil
        insert(item)
    }
    
    func removeNode(_ item: Item?) {
        guard let item = item else {
            return
        }
        if item.key == head?.key {
            let curHead = head
            head = curHead?.next
        }
        if item.key == tail?.key {
            let curTail = tail
            tail = curTail?.pre
        }
        let itemPre = item.pre
        let itemNext = item.next
        itemPre?.next = itemNext
        itemNext?.pre = itemPre
        dict[item.key] = nil
    }
    
    func insert(_ item: Item) {
        dict[item.key] = item
        let postHead = head
        item.next = postHead
        head = item
        postHead?.pre = head
        if dict.count == 1 {
            tail = item
        }
        if dict.count > capacity {
            self.removeTail()
        }

    }
    
    func removeTail() {
        removeNode(tail)
    }
    
    var description: String {
        var s = "head:"
        var node = head
        while let n = node {
            s += "\(n.key)    "
            node = n.next
        }
        node = tail
        s += "tail:"
        while let n = node {
            s += "\(n.key)    "
            node = n.pre
        }
        return s
    }
}
