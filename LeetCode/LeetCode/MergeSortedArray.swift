//
//  MergeSortedArray.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

extension Int {
    static postfix func --(i: inout Int) -> Int {
        let n = i
        i = i - 1
        return n
    }
    static prefix func --(i: inout Int) -> Int {
        i = i - 1
        return i
    }
}

class MergeSortedArray {
    static func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var k = n + m - 1, j = n - 1,i = m - 1
        
        while j > -1 && i > -1 {
            nums1[k--] = nums1[i] < nums2[j]  ? nums2[j--]:nums1[i--]
        }
        while j > -1 {
            nums1[k--] = nums2[j--]
        }
    }
}


