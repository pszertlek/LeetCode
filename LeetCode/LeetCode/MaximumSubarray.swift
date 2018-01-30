//
//  MaximumSubarray.swift
//  LeetCode
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

/*Find the contiguous subarray within an array (containing at least one number) which has the largest sum.
 
 For example, given the array [-2,1,-3,4,-1,2,1,-5,4],
 the contiguous subarray [4,-1,2,1] has the largest sum = 6.*/


func maxSubArray(_ nums: [Int]) -> Int {
    var i = 0, maxSum = Int.min, currentSum = 0
    while i < nums.count {
        if nums[i] >= 0 {
            currentSum = currentSum + nums[i]
            maxSum = max(maxSum, currentSum)
        } else if (currentSum + nums[i] > 0) {
            currentSum = currentSum < 0 ? 0 : currentSum
            currentSum = currentSum + nums[i]
        } else {
            maxSum = max(maxSum, nums[i])
            currentSum = 0
        }
        i += 1
    }
    return maxSum
}

func sum(_ nums:[Int], _ range: Range<Int>) {
    var sum = 0
    for i in range.lowerBound..<range.upperBound {
        
    }
}

