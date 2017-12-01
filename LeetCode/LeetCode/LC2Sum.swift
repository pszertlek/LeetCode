//
//  LC2Sum.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

class LC2Sum {
    func twoSum(nums:[Int], _ target:Int) -> Bool {
        //set查找效率为O(1)
        var set = Set<Int>(nums);
        for num in nums {
            if set.contains(target - num) {
                return true
            }
        }
        
        return false
    }
    
    func twoSumSort(nums:[Int], _ target: Int) -> [Int] {
        var left = 0,right = nums.count - 1
        while left < right {
            if target == nums[left] + nums[right] {
                return [left,right]
            } else if target < (nums[left] + nums[right]) {
                right -= 1
            } else {
                left += 1
            }
        }
        return []
    }
    
    func twoSumResult(nums:[Int], _ target:Int) -> [Int] {
        var dict = [Int:Int]()
        for (i,num) in nums.enumerated() {
            if let result = dict[target - num] {
                return [i,result]
            } else {
                dict[num] = i
            }
        }
        return []
    }
}
