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
        var set = Set<Int>();
        for num in nums {
            if set.contains(num) {
                return true
            }
        }
        
        return false
    }
}
