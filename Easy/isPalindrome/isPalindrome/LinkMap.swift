//
//  LinkMap.swift
//  isPalindrome
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

class LinkMap {
    public class ListNode: CustomStringConvertible, Equatable {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
        
        public init(_ vals: [Int]) {
            guard vals.count != 0 else {
                fatalError()
                return
            }
            self.val = vals[0]
            var node: ListNode? = self
            for i in 1..<vals.count {
                node?.next = ListNode(vals[i])
                node = node?.next
            }
            
        }
        
        public var description: String {
            var s = String()
            var node: ListNode? = self
            while node != nil {
                s.append(",\(node!.val)")
                node = node?.next
            }
            return s
        }
        
        public static func == (lhs: LinkMap.ListNode, rhs: LinkMap.ListNode) -> Bool {
            return lhs.val == rhs.val
        }
    }
    

    
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let node1 = l1 else {
            return l2
        }
        guard let node2 = l2 else {
            return l1
        }
        var node11: ListNode? = node1.val < node2.val ? node1 : node2
        var node22: ListNode? = node1.val >= node2.val ? node1 : node2
        
        while let next = node11?.next {
            if next.val <= node22!.val {
                node11 = node11?.next
            } else {
                node11?.next = node22
                node22 = node22?.next
                node11?.next?.next = next
                node11 = node11?.next
                if node22 == nil {
                    break;
                }
            }
        }
        if node22 != nil {
            node11?.next = node22
        }
        return node1.val < node2.val ? node1 : node2
    }
    
    func middleNode(_ head: ListNode?) -> ListNode? {
        var array = [ListNode](), next = head
        while next != nil {
            array.append(next!)
            next = next?.next
        }
        return array[array.count / 2]

    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        var next = head , last: ListNode? = nil
        
        while next != nil {
            let temp = next?.next
            next?.next = last
            last = next
            next = temp
        }
        
        return last
        
    }
    
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var last: ListNode? = nil, current = head
        while current != nil {
            if current != last {
                last = current
                current = current?.next
            } else {
                last?.next = current?.next
                current = current?.next
            }
        }
        return head
    }
    
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var last: ListNode? = nil, current = head
        while current != nil {
            if current?.val != val {
                last = current
                current = current?.next
            } else {
                last?.next = current?.next
                current = current?.next
            }
        }
        return head
    }
}
