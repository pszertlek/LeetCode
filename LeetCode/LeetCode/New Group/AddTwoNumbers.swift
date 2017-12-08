//
//  AddTwoNumbers.swift
//  LeetCode
//
//  Created by apple on 2017/11/29.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class AddTwoNumbers {
    public class ListNode {
             public var val: Int
             public var next: ListNode?
             public init(_ val: Int) {
                     self.val = val
                         self.next = nil
                }
    }
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var sum = l1!.val

        l1!.val = (l1!.val + l2!.val)%10
        while let nextL1 = l1?.next, let nextL2 = l2?.next {
            nextL1.val = (nextL1.val + nextL2.val) % 10
        }
        return l1
    }
//
//    func addList(_ node: ListNode) -> ListNode {
//        var sum = node.val
//        while let next = node.next {
//            sum += next.val
//        }
//        return ListNode(sum)
//
//    }
}


