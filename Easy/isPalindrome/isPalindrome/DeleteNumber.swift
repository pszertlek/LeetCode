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
    
    func missingNumber(_ nums: [Int]) -> Int {
        let sum = (nums.count + 1) * nums.count / 2
        var result = sum
        for i in nums {
            result = result - i
        }
        return result
    }
    
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var count = 0, maxCount = 0
        for i in nums {
            if i == 1 {
                count += 1
            } else {
                count = 0
            }
            if count > maxCount {
                maxCount = count
            }
        }
        return maxCount
    }
    
    func findPairs(_ nums: [Int], _ k: Int) -> Int {
        guard nums.count > 1 else {
            return 0
        }
        let sortNums = nums.sorted()
        var count = 0,i = 0, j = 1, lastI = 0, lastJ = 0
//        let kk = k > 0 ? k : -k
        while i < nums.count - 1,j < nums.count {
            
            let diff = sortNums[j] - sortNums[i]
            if k == diff {
                count += 1
                i += 1
                j += 1
                while j < nums.count, sortNums[lastJ] == sortNums[j]  {
                    j += 1
                }
                while i < nums.count, sortNums[lastI] == sortNums[i]  {
                    i += 1
                }
            } else if k > diff {
                while j < nums.count, sortNums[lastJ] == sortNums[j]  {
                    j += 1
                }
            } else {
                while i < nums.count, sortNums[lastI] == sortNums[i]  {
                    i += 1
                }
            }


            lastI = i
            if j == i {
                j = j + 1
            }
            lastJ =  j
        }
        return count
    }
    
    func arrayPairSum(_ nums: [Int]) -> Int {
        var index = 0, sum = 0
        let sortNums = nums.sorted()
        while index < nums.count {
            sum = sortNums[index] + sum
            index += 2
        }
        return sum
    }
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let sorted = (nums1 + nums2).sorted()
        let count = nums1.count + nums2.count;
        if count % 2 == 0 {
            return Double(sorted[count / 2]  + sorted[count / 2 - 1]) / 2
        } else {
            return Double(sorted[count/2])
        }
    }
    
//    func findMedianSortedArrays1(_ nums1: [Int], _ nums2: [Int]) -> Double {
//        let mid_left1 = nums1[nums1.count / 2]
//        let mid_right1 = nums1[nums1.count / 2 + 1]
//        let indexLeft = nums2.index { (i) -> Bool in
//            return i >= mid_left1
//        }
////        let indexRight = nums2.index { (i) -> Bool in
////            return i <= mid_right1
////        }
////        guard let indexL = indexLeft else {
////
////        }
//    }
    
    func firstMissingPositive1(_ nums: [Int]) -> Int {
        var newNums = nums
        for i in 0..<nums.count {
            while newNums[i] > i + 1 && newNums[i] <= nums.count && newNums[i] != newNums[newNums[i]-1] {
                if newNums[i] <= nums.count && newNums[i] != newNums[newNums[i]-1] {
                    let temp = newNums[i]
                    newNums[i] = newNums[temp-1]
                    newNums[temp-1] = temp
                }
            }
            if newNums[i] > 0 && i + 1 > newNums[i] {
                let temp = newNums[i]
                newNums[i] = newNums[temp-1]
                newNums[temp-1] = temp
            }
        }
        var i = 0
        while i < nums.count {
            if i + 1 != newNums[i] {
                return i + 1
            }
            i = i + 1
        }
        return i + 1
    }
    
    
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var newNums = nums, i = 0
        while i < nums.count {
            if newNums[i] > i + 1 && newNums[i] <= nums.count {
                if newNums[i] <= nums.count && newNums[i] != newNums[newNums[i]-1]{
                    let temp = newNums[i]
                    newNums[i] = newNums[temp-1]
                    newNums[temp-1] = temp
                    i = i - 1
                }
            } else if newNums[i] > 0 && newNums[i] < i + 1 {
                let temp = newNums[i]
                newNums[i] = newNums[temp-1]
                newNums[temp-1] = temp
            }
            i = i + 1
        }
        i = 0
        while i < nums.count {
            if i + 1 != newNums[i] {
                return i + 1
            }
            i = i + 1
        }
        return i
    }
    func rob(_ nums: [Int]) -> Int {//至少取间隔一的数字
        
        var a = 0, b = 0
        for i in 0..<nums.count {
            if i % 2 == 0 {
                a = max(a + nums[i], b)
            } else {
                b = max(a, b + nums[i])
            }
        }
        return max(a, b)
    }
    
    func isHappy(_ n: Int) -> Bool {
        var result = n
        var set = Set<Int>()
        
        func calculate(_ num: Int) -> Int {
            var divisor = num ,sum = 0
            while divisor != 0 {
                let reminder = divisor % 10
                sum = sum + reminder * reminder
                divisor = divisor / 10
            }
            return sum
        }
        while !set.contains(result) {
            set.insert(result)
            result = calculate(result)
        }
        return result == 1
    }

}
