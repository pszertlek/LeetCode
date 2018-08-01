//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

func isPalindrome(_ x: Int) -> Bool {
    var i = 10, xx = x
    var array = [Int]()
    while xx != 0 {
        array.append(xx % 10)
        xx = xx / 10
    }
    i = 0
    while i < array.count / 2 {
        if array[i] != array[array.count - 1 - i] {
            return false
        }
        i += 1
    }
    return true
}

print(isPalindrome(-121))
print(isPalindrome(0))

print(isPalindrome(11321))

print(isPalindrome(121))
print(isPalindrome(121))
