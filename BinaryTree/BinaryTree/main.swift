//
//  main.swift
//  BinaryTree
//
//  Created by Pszertlek on 2018/2/20.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

let node1 = TreeNode(1)
let node2 = TreeNode(2)
let node3 = TreeNode(3)
let node4 = TreeNode(4)

node4.left = node2
node2.left = node1
node2.right = node3

print(node1.levelOrder(node4))

