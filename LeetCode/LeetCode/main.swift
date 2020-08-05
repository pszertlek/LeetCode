//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation
import BinaryTree

//print(TreeNode(0).recoverFromPreorder("1-2--3--4-5--6--7"))
//print(TreeNode(0).recoverFromPreorder("1-2--3---4-5--6---7"))
print(TreeNode(0).recoverFromPreorder("1-401--349---90--88"))
struct ABC: Codable {
    var a = "1"
    var b = "2"
}
let zzz = ABC()

UserDefaults.standard.set(try! JSONEncoder().encode(zzz), forKey: "fsadfasd")
