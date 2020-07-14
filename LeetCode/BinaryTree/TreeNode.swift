//
//  TreeNode.swift
//  BinaryTree
//
//  Created by Pszertlek on 2018/2/20.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation


public class TreeNode<T>: ExpressibleByArrayLiteral,CustomStringConvertible {
    public var description: String {
        let levelArray = levelOrder(self)
        var string = ""
        levelArray.forEach { (level) in
            string.append("\(level)\n")
        }
        return string
    }
    
    
    
    public typealias ArrayLiteralElement = T?
    
    public var val: T
    public var left: TreeNode?
    public var right: TreeNode?
    public var next: TreeNode?
    public init(_ val: T) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    public required init(arrayLiteral elements: T?...) {
        self.val = elements[0]!
        var levelArray = [TreeNode]()
        levelArray.append(self)
        var i = 1
        while i < elements.count {
            let node = levelArray[0]
            var left: TreeNode? = nil , right:TreeNode? = nil
            if let leftVal = elements[i] {
                left = TreeNode(leftVal)
                node.left = left
                levelArray.append(left!)
            }
            if i + 1 < elements.count , let rightVal = elements[i+1] {
                right = TreeNode(rightVal)
                node.right = right
                levelArray.append(right!)
            }
            levelArray.removeFirst()
            i = i + 2
        }
    }
    
    
    
    func preorderTraversal(_ root: TreeNode?) -> [T] {
        var nums = [T]()
        var node: TreeNode? = root
        var nodeStack = [TreeNode]()
        while let theNode = node {
            nums.append(theNode.val)
            if theNode.left != nil {
                nodeStack.append(theNode)
                node = theNode.left
            } else if theNode.right != nil {
                node = theNode.right
            } else {
                if nodeStack.last == nil {
                    break
                }
                while let root = nodeStack.last {
                    if root.right != nil {
                        node = root.right
                        nodeStack.removeLast()
                        break;
                    } else {
                        nodeStack.removeLast()
                        if nodeStack.count == 0 {
                            return nums
                        }
                    }
                }
            }
        }
        return nums
    }
    
    func inorderTraversal(_ root: TreeNode?) -> [T] {
        var stack = [TreeNode](),result = [T]()
        var node = root
        while let theNode = node {
            if theNode.left != nil {
                stack.append(theNode)
                node = theNode.left
            } else if theNode.right != nil {
                result.append(theNode.val)
                node = theNode.right
            } else {
                result.append(theNode.val)
                node = nil
                while let root = stack.last {
                    result.append(root.val)
                    if root.right != nil {
                        stack.removeLast()
                        node = root.right
                        break;
                    } else {
                        stack.removeLast()
                        if stack.count == 0 {
                            node = nil
                        }
                    }
                }
            }
        }
        return result
    }
    
    func levelOrder(_ root: TreeNode?) -> [[T]] {
        var result = [[T]]()
        guard let node = root else {
            return result
        }
        var lastLevel = [node]
        while lastLevel.count != 0 {
            var levelArray = [T]()
            var newLevel = [TreeNode]()
            for n in lastLevel {
                levelArray.append(n.val)
                if let left = n.left {
                    newLevel.append(left)
                }
                if let right = n.right {
                    newLevel.append(right)
                }
            }
            result.append(levelArray)
            lastLevel = newLevel
        }
        return result
    }
}


//extension TreeNode: ExpressibleByArrayLiteral {
//    public typealias ArrayLiteralElement = T
//
//    public required convenience init(arrayLiteral elements: T...) {
//        assert(elements.count == 0)
//        var node = TreeNode(elements[0])
//        for i in 1..<elements.count {
//            let next = TreeNode(elements[i])
//
//        }
//    }
//}

extension TreeNode where T: Comparable {
    public func equal (_ lhs: TreeNode<T>?,_ rhs: TreeNode<T>?) -> Bool {
        if lhs == nil && rhs == nil {
            return true
        } else if let left = lhs, let right = rhs {
            return left.val == right.val
        } else {
            return false
        }
    }
    
    func preorderTraversal1(_ root: TreeNode<T>?) -> [T] {
        var result = [T]()
        
        func travel(_ root: TreeNode<T>?) {
            guard let node = root else {
                return
            }
            visit(node)
            travel(node.left)
            travel(node.right)
        }
        func visit(_ node: TreeNode<T>) {
            result.append(node.val)
        }
        travel(root)
        
        return result
    }
    
    func inorderTraversal1(_ root: TreeNode?) -> [T] {
        var result = [T]()
        
        func travel(_ root: TreeNode<T>?) {
            guard let node = root else {
                return
            }
            travel(node.left)
            visit(node)
            travel(node.right)
        }
        func visit(_ node: TreeNode<T>) {
            result.append(node.val)
        }
        travel(root)
        
        return result
    }
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let left = maxDepth(node.left)
        let right = maxDepth(node.right)
        return max(left, right) + 1
    }
    
    func inorderTraversal2(_ root: TreeNode?) -> [T] {
        var result = [T]()
        
        func travel(_ root: TreeNode<T>?) {
            guard let node = root else {
                return
            }
            travel(node.right)
            visit(node)
            travel(node.left)

        }
        func visit(_ node: TreeNode<T>) {
            result.append(node.val)
        }
        travel(root)
        
        return result
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        let left = root?.left, right = root?.right

        guard equal(left, right) else {
            return false
        }
        var lastLeftLevel = [left], lastRightLevel = [right]
        while  lastLeftLevel.count != 0 && lastRightLevel.count != 0 {
            var newLeftLevel = [TreeNode?](), newRightLevel = [TreeNode?]()
            if lastRightLevel.count != lastLeftLevel.count {
                return false
            }
            var nilCount = 0
            for i in 0..<lastRightLevel.count {
                
                let leftLeft = lastLeftLevel[i]?.left
                let rightRight = lastRightLevel[i]?.right
                guard equal(leftLeft,rightRight) else {
                    return false
                }
                let leftRight = lastLeftLevel[i]?.right
                let rightLeft = lastRightLevel[i]?.left
                guard equal(leftRight,rightLeft) else {
                    return false
                }
                if leftRight == nil {
                    nilCount = nilCount + 1
                }
                newLeftLevel.append(leftLeft)
                newLeftLevel.append(leftRight)
                newRightLevel.append(rightRight)
                newRightLevel.append(rightLeft)

            }
            if nilCount == lastRightLevel.count {
                return true
            }
            nilCount = 0
            lastLeftLevel = newLeftLevel
            lastRightLevel = newRightLevel
        }
        return true
    }
    
    
    func connect(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        var queue = [TreeNode]()
        queue.append(root)
        while queue.count > 0 {
            var newQueue = [TreeNode]()
            for n in queue {
                if let left = n.left {
                    if let last = queue.last {
                        last.next = left
                    }
                    newQueue.append(left)
                }
                
                if let right = n.right {
                    if let last = queue.last {
                        last.next = right
                    }
                    newQueue.append(right)
                }
            }
            queue = newQueue
        }
        return root
    }
    
    func connect1(_ root: TreeNode?) -> TreeNode? {
        var prev: TreeNode?, leftmost: TreeNode?
        func processChild(_ childNode: TreeNode?) {
            guard let childNode = childNode else {
                return
            }
            if prev != nil {
                prev?.next = childNode
            } else {
                leftmost = childNode
            }
            prev = childNode
        }
        guard let root = root else {
            return nil
        }
        leftmost = root
        var curr = leftmost
        while leftmost != nil {
            prev = nil
            curr = leftmost
            leftmost = nil
            while curr != nil {
                processChild(curr?.left)
                processChild(curr?.right)
                curr = curr?.next
            }
        }
        return root
    }
//    func hasPathSum(_ root: TreeNode<T>?, _ sum: Int) -> Bool {
//        var nums = [T]()
//        var node: TreeNode? = root
//        var nodeStack = [TreeNode]()
//        while let theNode = node {
//            nums.append(theNode.val)
//            if theNode.left != nil {
//                nodeStack.append(theNode)
//                node = theNode.left
//            } else if theNode.right != nil {
//                node = theNode.right
//            } else {
//                if nodeStack.last == nil {
//                    break
//                }
//                while let root = nodeStack.last {
//                    if root.right != nil {
//                        node = root.right
//                        nodeStack.removeLast()
//                        break;
//                    } else {
//                        nodeStack.removeLast()
//                        if nodeStack.count == 0 {
//                            return nums
//                        }
//                    }
//                }
//            }
//        }
//        return nums
//    }


}

extension TreeNode where T == Int {
    public func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard preorder.count > 0 else {
            return nil
        }
        var rootIndex = 0
        func build(_ left: Int, _ right: Int) -> TreeNode? {
            guard left <= right else {
                return nil
            }
            let rootVal = preorder[rootIndex]
            var midIndex = -1
            for i in left...right {
                if inorder[i] == rootVal {
                    midIndex = i
                    break
                }
            }
            if midIndex == -1 {
                return nil
            } else {
                let root = TreeNode<Int>(rootVal)
                rootIndex += 1
                root.left = build(left, midIndex - 1)
                root.right = build(midIndex + 1, right)
                return root
            }
        }
        return build(0, preorder.count - 1)
    }
}
