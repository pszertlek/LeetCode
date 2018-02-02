//
//  LC2Sum.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

func binarySearch(_ numbers: [Int],target: Int) -> Int {
    guard numbers.count == 0 else {
        return -1
    }
    var low = 0, high = numbers.count, mid = 0
    while low < high {
        mid = (low + high) / 2
        if numbers[mid] < target {
            low = mid + 1
        } else if numbers[mid] > target {
            high = mid
        } else {
            return mid
        }
    }
    return -1
}

func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var i = 0, j = numbers.count - 1
    while i < j {
        let sum = numbers[i] + numbers[j]
        if sum > target {
            j -= 1
        } else if sum < target {
            i += 1
        } else {
            return [i+1,j+1]
        }
    }
    return []
    
}

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
    
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var i = 0, j = numbers.count - 1
        while i < j {
            let sum = numbers[i] + numbers[j]
            if sum > target {
                j -= 1
            } else if sum < target {
                i -= 1
            } else {
                return [i,j]
            }
        }
        return []
        
    }
}
