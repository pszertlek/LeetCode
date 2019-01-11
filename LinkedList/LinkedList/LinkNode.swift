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
    
    func removeNode(_ head: ListNode, _ remove: ListNode) -> ListNode? {
        if head === remove {
            return head.next
        } else {
            var next: ListNode? = head
            while next?.next !== remove {
                next = next?.next
            }
        }
        return head
    }
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var nodeArray = [ListNode]()
        var next = head
        while let nextNode = next {
            nodeArray.append(nextNode)
            next = next?.next
        }
        if nodeArray.count < n {
            return head
        }
        if nodeArray.count - n - 1 >= 0 {
            nodeArray[nodeArray.count - n - 1].next = nodeArray[nodeArray.count - n].next
            return head
        } else {
            return head?.next
        }
    }
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        var next = head
        var nextNext = head?.next
        var lastNode: ListNode?
        let first = head?.next ?? head
        while let nextNode = next, let nextNextNode = nextNext {
            let nextCalculate = nextNextNode.next
            nextNode.next = nextCalculate
            nextNextNode.next = nextNode
            lastNode?.next = nextNextNode
            lastNode = nextNode
            next = nextNode.next
            nextNext = nextNode.next?.next
        }
        return first
    }
    
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil else {
            return nil
        }
        var nodeArray = [ListNode]()
        var next = head
        while let nextNode = next {
            nodeArray.append(nextNode)
            next = next?.next
        }
        let rotateK = k % nodeArray.count
        if rotateK == 0 {
            return head
        }
        let first = nodeArray[nodeArray.count - rotateK]
        nodeArray[nodeArray.count - 1].next = head
        nodeArray[nodeArray.count - rotateK - 1].next = nil
        return first
    }
    
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard let headNode = head, headNode.next != nil else {
            return head
        }
        var next:ListNode? = headNode
        var lastVal = headNode.val
        var valCount = 0
        var first: ListNode? = headNode.val == headNode.next!.val ? nil : headNode
        var lastDif:ListNode? = nil
        var last: ListNode!
        while let nextNode = next {
            if lastVal == nextNode.val {
                valCount = valCount + 1
                if valCount > 1 {
                    lastDif?.next = nextNode.next
                }
            } else {
                if first == nil {
                    first = valCount == 1 ? lastDif :nil
                }
                lastDif = last
                lastVal = nextNode.val
            }
            last = nextNode
            next = next?.next
        }
        return first
    }
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        var next = head
        var count = 0
        while let _ = next {
            count = count + 1
            next = next?.next
        }
        let half = count / 2
        var i = 0
        var pre = head
        next = head?.next
        while i < half - 1 {
            let nextNode = next?.next
            next?.next = pre
            pre = next
            next = nextNode
            i = i + 1
        }
        next = count % 2 == 1 ? next?.next : next
        while let preNode = pre, let nextNode = next {
            if (preNode.val != nextNode.val) {
                return false
            } else {
                pre = preNode.next
                next = nextNode.next
            }
        }
        return true;
    }
}
