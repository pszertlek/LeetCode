//
//  LinkNode.swift
//  LinkedList
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

public class ListNode: CustomStringConvertible, ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Int
    
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    
    required public init(arrayLiteral elements: Int ...) {
        val = elements[0]
        var next: ListNode? = self
        for i in 1 ..< elements.count {
            next?.next = ListNode(elements[i])
            next = next?.next
        }
    }

    
    public var description: String {
        var s = "\(val)"
        var next: ListNode? = self.next
        repeat {
            s = s + "->\(next?.val ?? 999)"
            next = next?.next
        } while next != nil
        return s
    }
    
    class func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var next1 = l1, next2 = l2
        if next1 == nil {
            return next2
        }
        if next2 == nil {
            return next1
        }
        let node = ListNode(next1!.val + next2!.val)
        next1 = next1?.next
        next2 = next2?.next
        var nextAdd: Bool = node.val > 9
        node.val = nextAdd ? node.val - 10 : node.val
        var next: ListNode? = node
        while next1 != nil || next2 != nil || nextAdd {
            var value = (next1?.val ?? 0) + (next2?.val ?? 0) + (nextAdd ? 1 : 0)
            nextAdd = value > 9
            value = nextAdd ? value - 10 : value
            next?.next = ListNode(value)
            next = next?.next
            next1 = next1?.next
            next2 = next2?.next
        }
        return node
    }
    
    
}
