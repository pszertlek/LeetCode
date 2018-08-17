//
//  Tree.swift
//  isPalindrome
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

class BinaryTree {
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    func lrd(_ root: TreeNode? , visit: (TreeNode?) -> Void ) {
        visit(root)
        if root != nil {
            lrd(root?.left, visit: visit)
            lrd(root?.right, visit: visit)
        }
    }
    
    func lrdResult(_ root: TreeNode?) -> [Int?] {
        var result = [Int?]()
        lrd(root) { (node) in
            result.append(node?.val)
        }
        return result
    }
    
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        return lrdResult(p) == lrdResult(q)
    }
    func isSameTree1(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        guard let p = p else {
            return q == nil
        }
        guard let q = q else {
            return false
        }
        if p.val != q.val {
            return false
        }
        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right)
    }
    
    func isSymmetric(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        print("right:\(p?.val) left:\(q?.val)")
        guard let p = p else {
            return q == nil
        }
        guard let q = q else {
            return false
        }
        if p.val != q.val {
            return false
        }
        return isSymmetric(p.left, q.right) && isSymmetric(p.left, q.right)
    }
}
