//
//  DeleteNumber.swift
//  isPalindrome
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

class DeleteNumber {
    //排序数组
    class func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count == 1 && nums.count == 0 {
            return nums.count
        }
        var current = Int.min
        var count = 0,duplicateCount = 0,i = 0
        while i < nums.count {
            if current == nums[i] && count > 0 {
                count = count + 1
                duplicateCount = duplicateCount + 1
            } else {
                current = nums[i]
                nums[i - duplicateCount] = current
                count = 1
            }
            i = i + 1
        }
        nums.removeLast(duplicateCount)
        return nums.count
    }
    
    class func removeDuplicate(_ nums: inout [Int]) -> Int {
        if nums.count == 1 && nums.count == 0 {
            return nums.count
        }
        var k = 0
        for i in 1..<nums.count {
            if nums[i] != nums[k] {
                nums[k+1] = nums[i]
                k = k + 1
            }
        }
        nums.removeLast(nums.count - (k + 1))
        return k
    }
}
