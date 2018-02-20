//
//  MaximumAverageSubarray.swift
//  LeetCode
//
//  Created by Pszertlek on 2018/2/20.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

/*
 Given an array consisting of n integers, find the contiguous subarray of given length k that has the maximum average value. And you need to output the maximum average value.
 
 Example 1:
 
 Input: [1,12,-5,-6,50,3], k = 4
 Output: 12.75
 Explanation: Maximum average is (12-5-6+50)/4 = 51/4 = 12.75
 
 Note:
 
 1 <= k <= n <= 30,000.
 Elements of the given array will be in the range [-10,000, 10,000].

 */

func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
    var sum = 0
    for i in 0..<k {
        sum += nums[i]
    }
    var maxN = sum
    guard k <= nums.count - 1 else {
        return Double(maxN) / Double(k)
    }
    for i in k...(nums.count - 1) {
        sum = sum + nums[i] - nums[i - k]
        maxN = max(sum, maxN)
    }
    return Double(maxN) / Double(k)
}

/*
 Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
 
 For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].
 
 Note:
 
 You must do this in-place without making a copy of the array.
 Minimize the total number of operations.
*/

func moveZeroes(_ nums: inout [Int]) {
    var zeroNumber = 0
    for i in 0...nums.count - 1 {
        if nums[i] == 0 {
            zeroNumber += 1
        } else {
            nums[i - zeroNumber] = nums[i]
        }
    }
    guard zeroNumber != 0 else {
        return
    }
    for i in (nums.count - zeroNumber)...(nums.count - 1) {
        nums[i] = 0
    }
}

func thirdMax(_ nums: [Int]) -> Int {
    var maxTuple = (Int.min,Int.min,Int.min)
//    func insertNumber(_ num: Int) {
//        guard num > maxTuple.2 else {
//            return
//        }
//        if num > maxTuple.0 {
//            maxTuple.2 = maxTuple.1
//            maxTuple.1 = maxTuple.0
//            maxTuple.0 = num
//        } else if num == maxTuple.0 {
//
//        } else if num > maxTuple.1 {
//            maxTuple.2 = maxTuple.1
//            maxTuple.1 = num
//        } else if num == maxTuple.1 {
//
//        } else {
//            maxTuple.2 = num
//        }
//    }
    for i in nums {
        guard i > maxTuple.2 else {
            continue
        }
        if i > maxTuple.0 {
            maxTuple.2 = maxTuple.1
            maxTuple.1 = maxTuple.0
            maxTuple.0 = i
        } else if i == maxTuple.0 {
            
        } else if i > maxTuple.1 {
            maxTuple.2 = maxTuple.1
            maxTuple.1 = i
        } else if i == maxTuple.1 {
            
        } else {
            maxTuple.2 = i
        }
    }
    if maxTuple.2 == Int.min {
        return maxTuple.0
    }
    return maxTuple.2
}
