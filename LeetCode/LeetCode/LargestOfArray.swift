//
//  LargestOfArray.swift
//  LeetCode
//
//  Created by apple on 2018/1/24.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation
/*In a given integer array nums, there is always exactly one largest element.
 
 Find whether the largest element in the array is at least twice as much as every other number in the array.
 
 If it is, return the index of the largest element, otherwise return -1.
 
 Example 1:
 Input: nums = [3, 6, 1, 0]
 Output: 1
 Explanation: 6 is the largest integer, and for every other number in the array x,
 6 is more than twice as big as x.  The index of value 6 is 1, so we return 1.
 Example 2:
 Input: nums = [1, 2, 3, 4]
 Output: -1
 Explanation: 4 isn't at least as big as twice the value of 3, so we return -1.
 Note:
 nums will have a length in the range [1, 50].
 Every nums[i] will be an integer in the range [0, 99].*/


func dominantIndex(_ nums: [Int]) -> Int {
    var numIndex = 0
    var isTwice = true
    guard nums.count > 1 else {
        return 0
    }
    for (index,num) in nums.enumerated() {
        if nums[numIndex] < num {
            isTwice = 2 * nums[numIndex] <= num
            numIndex = index
        } else if isTwice && nums[numIndex] != num {
            isTwice = nums[numIndex] >= 2 * num
        }
    }
    return nums[numIndex] == 0 ? 0 : (isTwice ? numIndex : -1)
}
