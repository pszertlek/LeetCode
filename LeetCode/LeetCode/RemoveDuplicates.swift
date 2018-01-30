//
//  RemoveDuplicates.swift
//  LeetCode
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

/*Given a sorted array, remove the duplicates in-place such that each element appear only once and return the new length.
 
 Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
 
 Example:
 
 Given nums = [1,1,2],
 
 Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively.
 It doesn't matter what you leave beyond the new length.*/

func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    var n = nums.count
    var i = 1
    var current = nums[0]
    while i < n {
        if nums[i] == current {
            nums.remove(at: i)
            n -= 1
        } else {
            current = nums[i]
            i += 1
        }
    }
    return nums.count
}
