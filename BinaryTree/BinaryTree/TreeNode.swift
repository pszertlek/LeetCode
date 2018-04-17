//
//  TreeNode.swift
//  BinaryTree
//
//  Created by Pszertlek on 2018/2/20.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var nums = [Int]()
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
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack = [TreeNode](),result = [Int]()
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
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let node = root else {
            return result
        }
        var lastLevel = [node]
        while lastLevel.count != 0 {
            var levelArray = [Int]()
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
