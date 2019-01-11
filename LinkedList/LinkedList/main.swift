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
print(a.isPalindrome(ListNode(arrayLiteral: 1,2,2,1)))
print(a.isPalindrome(ListNode(arrayLiteral: 1,1)))
print(a.isPalindrome(ListNode(arrayLiteral: 1)))
print(a.isPalindrome(ListNode(arrayLiteral: 1,2)))

print(a.isPalindrome(ListNode(arrayLiteral: 1,2,3,2,1)))
print(a.isPalindrome(ListNode(arrayLiteral: 1,2,3,4,5,6)))
