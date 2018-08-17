//
//  main.swift
//  isPalindrome
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation


let node1 = BinaryTree.TreeNode(1)
let node2 = BinaryTree.TreeNode(2)
let node3 = BinaryTree.TreeNode(3)




let node4 = BinaryTree.TreeNode(1)
let node5 = BinaryTree.TreeNode(2)
let node6 = BinaryTree.TreeNode(3)

node1.left = node2
node1.right = node3
node2.left = node4
node2.right = node5

node4.left = node6
node4.right = node5
node5.left = node1
node5.right = node2



print(BinaryTree().isSymmetric(node1, node4))
