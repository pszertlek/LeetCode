//
//  PlusOne.swift
//  LeetCode
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

/*Given a non-negative integer represented as a non-empty array of digits, plus one to the integer.
 
 You may assume the integer do not contain any leading zero, except the number 0 itself.
 
 The digits are stored such that the most significant digit is at the head of the list.*/

func plusOne(_ digits: [Int]) -> [Int] {
    let n = digits.count
    var i = n - 1
    var digit = digits
    while i >= 0 {
        if digit[i] != 9 {
            digit[i] += 1
            break
        } else {
            digit[i] = 0
        }
        i -= 1
    }
    if digit[0] == 0 {
        digit.insert(1, at: 0)
    }
    return digit
}
