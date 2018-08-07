//
//  main.swift
//  isPalindrome
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation


var l1 = LinkMap.ListNode(-11)
var l2 = LinkMap.ListNode(-11)
var l3 = LinkMap.ListNode(-9)
l1.next = l2
l2.next = l3

var l4 = LinkMap.ListNode(-4)
var l5 = LinkMap.ListNode(1)
var l6 = LinkMap.ListNode(6)

var l7 = LinkMap.ListNode(6)
var l8 = LinkMap.ListNode(-7)
l3.next = l4
l5.next = l6
l4.next = l5
l6.next = l7
print(NSDate())
print(Solution().climbStairs1(44))
print(NSDate())

print(Solution().climbStairs(44))
print(NSDate())

print(Solution().climbStairs(3))
print(Solution().climbStairs(4))
print(Solution().climbStairs(5))
print(Solution().climbStairs(6))
