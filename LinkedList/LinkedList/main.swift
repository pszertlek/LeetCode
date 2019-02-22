//
//  main.swift
//  LinkedList
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation


var common = ListNode(arrayLiteral: 8,4,5)
var A = ListNode(arrayLiteral:4,1)
var B = ListNode(arrayLiteral: 5,0,1)

A.next?.next = common
B.next?.next?.next = common
print(A)
print(B)
print(A.getIntersectionNode(A, B))



