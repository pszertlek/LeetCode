//
//  DoublyLinkedList.swift
//  LeetCode
//
//  Created by Apple on 2021/2/12.
//  Copyright © 2021 Pszertlek. All rights reserved.
//

import Foundation

class DoublyLinkedNode<T> {
    var next: DoublyLinkedNode?
    var pre: DoublyLinkedNode?
    
    var v: T
    init(_ v: T) {
        self.v = v
    }
}

class DoublyLinkedList<T> {
    
    var head: DoublyLinkedNode<T>?
    var tail: DoublyLinkedNode<T>?
    
    var count = 0
    
    func insertHead(_ item: DoublyLinkedNode<T>) {
        let postHead = head
        item.next = postHead
        head = item
        postHead?.pre = head
        if tail == nil {
            tail = item
        }
        
        count += 1
    }
    
    func remove(_ item: DoublyLinkedNode<T>) {
        if item === head {
            let curHead = head
            head = curHead?.next
        }
        if item === tail {
            let curTail = tail
            tail = curTail?.pre
        }
        let itemPre = item.pre
        let itemNext = item.next
        itemPre?.next = itemNext
        itemNext?.pre = itemPre
        item.next = nil
        item.pre = nil
        
        count -= 1
    }
    
    func insertHead(_ value: T) {
        let item = DoublyLinkedNode(value)
        insertHead(item)
    }
    
    func append(_ item:DoublyLinkedNode<T>) {
        guard head != nil else {
            head = item
            tail = item
            count += 1
            return
        }
        tail?.next = item
        item.pre = tail
        tail = item
        count += 1
    }
    
    func append(_ value: T) {
        let item = DoublyLinkedNode(value)
        append(item)
    }
    
    func removeTail() -> DoublyLinkedNode<T>? {
        guard let item = tail else {
            return nil
        }
        remove(item)
        return item
    }
    
    func removeHead() -> DoublyLinkedNode<T>? {
        guard let item = head else {
            return nil
        }
        remove(item)
        return item
    }
    
    
}


