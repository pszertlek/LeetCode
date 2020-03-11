//
//  TreeNode(more).swift
//  BinaryTree
//
//  Created by Pszertlek on 2020/1/22.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

extension TreeNode {

    func distributeCoins(_ root: TreeNode<Int>?) -> Int {
        var step = 0
        func dfs(_ root: TreeNode<Int>?) -> Int {
            guard let root = root else {
                return 0
            }
            let left = dfs(root.left)
            let right = dfs(root.right)
            step += abs(root.val - 1 + left + right)
            return root.val - 1 + left + right
            
        }
        dfs(root)
        return step
    }
    
    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        func dfs(_ root: TreeNode?) -> (Int,TreeNode?) {
            guard let root = root else {
                return (0,nil)
            }
            let left = dfs(root.left)
            let right = dfs(root.right)
            if left.0 == right.0 {
                return (left.0 + 1, root)
            } else if left.0 > right.0 {
                return (left.0 + 1, left.1)
            } else {
                return (right.0 + 1, right.1)
            }
            
        }
        return dfs(root).1
    }
}
