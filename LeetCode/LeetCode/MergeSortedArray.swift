//
//  MergeSortedArray.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

class MergeSortedArray {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var k = n + m - 1, j = n - 1,i = m - 1
        
        while j > 0 {
            nums1[k] = nums2[j] > nums1[i] ? nums2[j--]:nums1[i--]
            if (nums2[j] > nums1[i]) {
                nums1[k] =
            }
            nums1[j]
            n = n - 1
            
        }
    }
}

extension Int {
    operator func--(i: Int){
        
    }
}
