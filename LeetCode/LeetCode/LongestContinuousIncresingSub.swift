//
//  LongestContinuousIncresingSub.swift
//  LeetCode
//
//  Created by Pszertlek on 2018/2/19.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

/*
 Given an unsorted array of integers, find the length of longest continuous increasing subsequence (subarray).
 
 Example 1:
 
 Input: [1,3,5,4,7]
 Output: 3
 Explanation: The longest continuous increasing subsequence is [1,3,5], its length is 3.
 Even though [1,3,5,7] is also an increasing subsequence, it's not a continuous one where 5 and 7 are separated by 4.
 
 Example 2:
 
 Input: [2,2,2,2,2]
 Output: 1
 Explanation: The longest continuous increasing subsequence is [2], its length is 1.
 
 Note: Length of the array will not exceed 10,000.
 */

func findLengthOfLCIS(_ nums: [Int]) -> Int {
    guard nums.count > 1 else {
        return nums.count
    }
    var result = 1
    var current = nums[0]
    var maxN = 1
    for i in nums {
        if current < i {
            result += 1
        } else {
            maxN = max(result, maxN)
            result = 1
        }
        current = i
    }
    return max(result, maxN)
}

/*
 
 Given an array with n integers, your task is to check if it could become non-decreasing by modifying at most 1 element.
 
 We define an array is non-decreasing if array[i] <= array[i + 1] holds for every i (1 <= i < n).
 
 Example 1:
 
 Input: [4,2,3]
 Output: True
 Explanation: You could modify the first 4 to 1 to get a non-decreasing array.
 
 Example 2:
 
 Input: [4,2,1]
 Output: False
 Explanation: You can't get a non-decreasing array by modify at most one element.
 
 Note: The n belongs to [1, 10,000].
 */

func checkPossibility(_ nums: [Int]) -> Bool {
    var count = 0
    var i = 0
    while i < nums.count - 1 {
        if (!(nums[i] <= nums[i + 1])) {
            if (count > 0) { return false }
            if (i - 1 >= 0 && i + 2 < nums.count && (nums[i] > nums[i + 2] && nums[i + 1] < nums[i - 1])) {
                return false
            }
            count += 1
        }
        i += 1
    }
    return true

}

