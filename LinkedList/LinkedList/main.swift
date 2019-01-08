//
//  main.swift
//  LinkedList
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation


let a = ListNode(arrayLiteral: 1,2,3)
let b = ListNode(arrayLiteral: 5)

//print(ListNode.addTwoNumbers(a, b))
print(a.swapPairs(ListNode(arrayLiteral: 1,2,3)))
print(a.swapPairs(ListNode(arrayLiteral: 1,2,3,4)))
print(a.swapPairs(ListNode(arrayLiteral: 1,2,3,4,5)))
print(a.swapPairs(ListNode(arrayLiteral: 1,2,3,4,5,6)))
print(a.swapPairs(ListNode(arrayLiteral: 1)))
print(a.swapPairs(ListNode(arrayLiteral: 1,2,3,4,5)))
