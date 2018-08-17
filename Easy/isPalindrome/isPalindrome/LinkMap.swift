//
//  LinkMap.swift
//  isPalindrome
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

class LinkMap {
    public class ListNode: CustomStringConvertible {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
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
    

}
