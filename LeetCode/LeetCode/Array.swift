//
//  Array.swift
//  LeetCode
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class ArraySolution {
    //给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。
    func rotate(_ nums: inout [Int], _ k: Int) {
        var cache = [Int]()
        let k = k % nums.count
        for index in 0..<nums.count {
            let toIndex = (index + k) % nums.count
            if cache.count == k {
                cache.append(nums[toIndex])
                nums[toIndex] = cache.first!
                cache.removeFirst()
            } else {
                cache.append(nums[toIndex])
                nums[toIndex] = nums[index]
            }
        }
    }
    
    func rotate1(_ nums: inout [Int], _ k: Int) {
        var cur = nums[0], count = 0, start = 0
        var index = 0
        while count < nums.count {
            index = (index + k) % nums.count
            let t = nums[index]
            nums[index] = cur
            if index == start {
                start = start + 1
                index = index + 1
                cur = nums[index]
            } else {
                cur = t
            }
            count = count + 1
            print(nums)
        }
    }
    
    func rotate2(_ nums: inout [Int], _ k: Int) {
        let k = k % nums.count
        func reverse(_ from: Int, _ to: Int) {
            for i in 0..<(to - from + 1)/2 {
                nums.swapAt(from + i, to - i)
            }
        }
        reverse(0 , nums.count - k - 1)
        reverse(nums.count - k, nums.count - 1)
        reverse(0, nums.count - 1)
    }

    
    func plusOne(_ digits: [Int]) -> [Int] {
        var digits = digits
        var cc = digits.count - 1
        while cc >= 0 {
            if digits[cc] + 1 > 9 {
                digits[cc] = 0
                cc = cc - 1
            } else {
                digits[cc] = digits[cc] + 1
                break
            }
        }
        
        if cc >= 0{
            return digits
        } else {
            digits.insert(1, at: 0)
            return digits
        }
    }
    
    func rotate(_ matrix: inout [[Int]]) {
        var i = 0, j = 0
        let n = matrix.count
        func toChange(_ i: Int, _ j: Int) -> (Int,Int) {
            if i < n / 2 && j < n / 2 {
                return (n - j,n / 2 + i)
            } else  if i < n / 2 && j >= n / 2 {
                return (n - j, n - i)
            } else if i > n / 2 && j > n / 2 {
                return (j,i)
            } else {
                return (j,n - i)
            }
        }
        for i in 0..<n/2 {
            for j in 0..<n/2 {
                for _ in 0..<4 {
                    
                }
            }
        }
    }
}
