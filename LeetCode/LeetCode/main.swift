//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation
import BinaryTree
import CryptoKit


class ZZZZZZ {
    func rotate(_ nums: inout [Int], _ k: Int) {
        guard nums.count > 1 && k > 0 else {
            return
        }
        let mod = gcd(nums.count, k)
        for i in 0..<mod {
            move(i, nums.count / mod, &nums, k)
        }
    }
    
    func move(_ start: Int, _ circuleCount: Int, _ nums: inout [Int], _ k: Int) {
        var from = start, to = start, cur = nums[from]
        for _ in 0..<circuleCount {
            to = (from + k) % nums.count
            swap(&nums[to], &cur)
            from = to
        }
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var n = a, m = b
        while m != 0 {
            let temp = n % m
            n = m
            m = temp
        }
        return n
    }
}

var nums = [1,2,3,4,5,6,7]
print(ZZZZZZ().rotate(&nums, 3))
