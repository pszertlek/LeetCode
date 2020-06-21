//
//  LinkNode.swift
//  LinkedList
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation
import BinaryTree

public class MyLinkedList:CustomStringConvertible {
    var node: ListNode?
    
    public var description: String {
        return node?.description ?? "null"
    }
    
    func get(_ index: Int) -> Int {
        var i = 0
        var next:ListNode? = node
        while i < index, let _ = next {
            next = next?.next
            i = i + 1
        }
        return next?.val ?? -1
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        addAtIndex(0, val)
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        guard node != nil else {
            node = ListNode(val)
            return
        }
        var next:ListNode? = node
        while let _ = next?.next {
            next = next!.next
        }
        next?.next = ListNode(val)
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        let sentry = ListNode(0)
        sentry.next = node
        var i = 0
        var next:ListNode? = sentry
        while i < index, let _ = next {
            next = next?.next
            i = i + 1
        }
        if i == index {
            let nextNext = next?.next
            next?.next = ListNode(val)
            next?.next?.next = nextNext
            node = sentry.next
        }
        
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        let sentry = ListNode(0)
        sentry.next = node
        var pre: ListNode? = sentry
        var i = 0
        while i < index {
            pre = pre?.next
            i = i + 1
        }
        if i == index {
            pre?.next = pre?.next?.next
            node = sentry.next
        }
    }
}


public class ListNode: CustomStringConvertible, ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Int
    
    public var val: Int = 0
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    
    required public init(arrayLiteral elements: Int ...) {
        guard elements.count > 0 else {
            return
        }
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
    
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var first = head
        while let firstNode = first, firstNode.val == val {
            first = first?.next
        }
        var next = first?.next,pre = first

        while let nextNode = next, let preNode = pre {
            if nextNode.val == val {
                preNode.next = nextNode.next
                next = pre?.next
            } else {
                pre = preNode.next
                next = pre?.next
            }

        }
        return first
    }
    
//    func quickSort(_ head: ListNode?) -> ListNode? {
//        
//    }
//    @discardableResult
//    func quickSortss(_ head: ListNode?) -> ListNode? {
//        var midPre: ListNode? = nil, first: ListNode? = nil
//        let mid = head
//        var next = mid?.next
//        while let nextNode = next {
//            let nextNext = nextNode.next
//            if nextNode.val > mid!.val {
//                let midNext = mid?.next
//                mid?.next = nextNode
//                nextNode.next = midNext
//            } else {
//                if midPre == nil {
//                    first = nextNode
//                    midPre = nextNode
//                } else {
//                    midPre?.next = nextNode
//                    nextNode.next = mid
//                    midPre = nextNode
//                }
//            }
//            next = nextNext
//        }
//        midPre?.next = nil
//        quickSortss(first)
//        quickSortss(mid)
//        return nil;
////        return (first,midPre)
//
//    }
    
//    func sortList(_ head: ListNode?) -> ListNode? {
//
//        var headers = [ListNode?]()
//        func ssss(_ head: ListNode?) -> (ListNode?,ListNode?) {
//            var midPre: ListNode? = nil, first: ListNode? = nil
//            var mid = head
//            var next = mid?.next
//            while let nextNode = next {
//                let nextNext = nextNode.next
//                if nextNode.val > mid!.val {
//                    let midNext = mid?.next
//                    mid?.next = nextNode
//                    nextNode.next = midNext
//                } else {
//                    if midPre == nil {
//                        first = nextNode
//                        midPre = nextNode
//                    } else {
//                        midPre?.next = nextNode
//                        nextNode.next = mid
//                        midPre = nextNode
//                    }
//                }
//                next = nextNext
//            }
//            midPre?.next = nil
//            return (first,midPre)
//        }
//        var next = head
//        if next?.next != nil {
//            let re = ssss(next)
//
//        }
//        while next != nil {
//
//        }
//
//    }
//
    
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode?{
        var nextA = headA, nextB = headB
        var n = 0, m = 0
        while let _ = nextA {
            nextA = nextA?.next
            n = n + 1
        }
        while let _ = nextB {
            nextB = nextB?.next
            m = m + 1
        }
        nextA = headA
        nextB = headB
        if n <= m {

            swap(&nextA, &nextB)
            swap(&n, &m)
        }
        var i = n - m
        while i > 0 {
            nextA = nextA?.next
//            nextB = nextB?.next
            i = i - 1
        }
        while let nextNextA = nextA, let nextNextB = nextB {
            if nextNextA === nextNextB {
                return nextNextA
            }
            nextA = nextA?.next
            nextB = nextB?.next
        }
        return nil
    }
    
//    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
//
//    }
    //1,4,3,2,5,2
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        guard head != nil else {
            return nil
        }
        var node: ListNode? = ListNode(0)
        node!.next = head
        let start = node
        var pre: ListNode?
        let move: ListNode = ListNode(0)
        var moveTo:ListNode? = move

        while let n = node?.next {
            if n.val >= x {
                moveTo?.next = n
                moveTo = moveTo?.next
                node?.next = n.next
                n.next = nil
            } else {
                pre = n
                node = node?.next
            }
        }
        if pre == nil {
            return move.next
        } else {
            pre?.next = move.next
            return start?.next
        }
    }
    
    func sortList(_ head: ListNode?) -> ListNode? {
        return mergeSort(head)

    }
    
    func mergeSort(_ head: ListNode?) -> ListNode? {
        guard head?.next != nil else {
            return head
        }
        var lowPoint = head, fastPoint = head,pre = head
        while fastPoint != nil && fastPoint?.next != nil {
            pre = lowPoint
            fastPoint = fastPoint?.next?.next
            lowPoint = lowPoint?.next
        }
        pre?.next = nil
        let l = mergeSort(head)
        let r = mergeSort(lowPoint)
        return merge(l, r)
    }
    
    func merge(_ left: ListNode?, _ right: ListNode?) -> ListNode? {
        let start = ListNode(0)
        var cur = start, leftNode = left, rightNode = right
        while let l = leftNode, let r = rightNode {
            if l.val < r.val {
                cur.next = l
                leftNode = l.next
            } else {
                cur.next = r
                rightNode = r.next
            }
            cur = cur.next!
        }
        if leftNode != nil {
            cur.next = leftNode
        } else {
            cur.next = rightNode
        }
        return start.next
    }
    

    
    func findMidAndSplit(_ head: ListNode?) -> ListNode? {
        var slowPoint = head, fastPoint = head
        while fastPoint != nil && fastPoint?.next != nil {
            fastPoint = fastPoint?.next?.next
            slowPoint = slowPoint?.next
        }
        return slowPoint
    }
    
    
    
//    func findMid(_ head: ListNode?,_ end: inout ListNode?) -> ListNode? {
//        var slowPoint = head, fastPoint = head
//        while fastPoint != end && fastPoint?.next != end {
//            fastPoint = fastPoint?.next?.next
//            slowPoint = slowPoint?.next
//        }
//        return slowPoint
//    }
//
//    func fastSort(_ head: ListNode?) -> ListNode? {
//        guard head != nil else {
//            return head
//        }
//
//
//
//    }
//
//    func partition(_ head: ListNode?, end: inout ListNode?) -> ListNode? {
//        guard head?.next != nil else {
//            return head
//        }
//        let stand = findMid(head, &end)
//        let left = ListNode(0)
//        let right = stand
//        var leftCur: ListNode? = left, righCur = stand, cur = head
//
//        while let current = cur {
//            if current.val >= stand!.val {
//                righCur?.next = current
//                righCur = righCur?.next
//            } else {
//                leftCur?.next = current
//                leftCur = leftCur?.next
//            }
//        }
//        partition(left.next)
//        partition(right)
//    }
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        let start = ListNode(0)
        var startPre = start
        var cur = head
        while let current = cur {
            cur = cur?.next

            startPre = start
            while startPre.next != nil && startPre.next!.val < current.val {
                startPre = startPre.next!
            }
            let temp = startPre.next
            startPre.next = current
            current.next = temp
        }
        return start.next
    }

    func sortedListToBST(_ head: ListNode?) -> TreeNode<Int>? {
        return createBitree(head)
    }
    
    func createBitree(_ head: ListNode?) -> TreeNode<Int>? {
        guard let head = head else {
            return nil
        }
        guard let _ = head.next else {
            return TreeNode(head.val)
        }
        var fast: ListNode? = head, slow: ListNode? = head,temp: ListNode?
        while fast != nil && fast?.next != nil {
            temp = slow
            fast = fast?.next?.next
            slow = slow?.next
        }
        temp?.next = nil
        let root = TreeNode(slow!.val)
        root.left = createBitree(head)
        root.right = createBitree(slow?.next)
        return root
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
            return nil
        }
        var node: ListNode? = head
        var last: ListNode?
        while node != nil || node?.next != nil {
            let next = node?.next
            node?.next = last
            last = node
            node = next
        }
        return last
    }
    
    func reverseListRecursion(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
            return nil
        }
        
        func recursion(_ node: ListNode, last: ListNode?) -> ListNode {
            guard let nextNode = node.next else {
                node.next = last
                return node
            }
            node.next = last
            
            return recursion(nextNode, last: node)
        }
        return recursion(head, last: nil)
    }
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var vals = [Int]()
        for list in lists {
            var node = list
            while let theNode = node {
                vals.append(theNode.val)
                node = node?.next
            }
        }
        vals.sort()
        let result = ListNode(Int.min)
        var node: ListNode? = result
        for i in vals {
            node?.next = ListNode(i)
            node = node?.next
        }
        return result.next
    }
    
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        //1.逆转每一组
        //2.连接每一组的尾部与头部
        var node = head
        var pre: ListNode? = nil
        var theHead: ListNode?
        func reverseK(_ head: ListNode?) -> (ListNode?, ListNode?) {
            
            var node = head
            var i = 0
            while let theNode = node, i < k {
                node = theNode.next
                i += 1
            }
            guard i >= k else {
                return (head, nil)
            }
            node = head
            var pre: ListNode? = nil
            var count = 0
            while let theNode = node, count < k {
                count += 1
                let next = theNode.next
                theNode.next = pre
                pre = theNode
                node = next
            }
            return (pre, node)
        }
        while let theNode = node {
            let reverseChain = reverseK(theNode)
            if theHead == nil {
                theHead = reverseChain.0
            }
            pre?.next = reverseChain.0
            pre = theNode
            
            node = reverseChain.1
        }
        return theHead
    }
    
    func reorderList(_ head: ListNode?) {
        var node = head
        var i = 0
        while let n = node {
            i += 1
            node = n.next
        }
        var j = 0
        var tail: ListNode? = head
        while j <= i / 2 {
            let next = tail?.next
            if j == i / 2 {
                tail?.next = nil
            }
            tail = next
            j += 1

        }
        var pre: ListNode? = nil
        while let _ = tail {
            let next = tail?.next
            tail?.next = pre
            pre = tail
            tail = next
        }
        var lead = head
        tail = pre
        while let theLead = lead , let theTrail = tail {
            
            lead = theLead.next
            tail = theTrail.next
            theLead.next = theTrail
            theTrail.next = lead
        }
    }
}


