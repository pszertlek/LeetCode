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
let node3 = TreeNode(2)
let node4 = TreeNode(4)

node1.left = node2
node1.right = node3
//node2.left = node4


let node = TreeNode(arrayLiteral: 1,2)
print(node.isSymmetric(node))
