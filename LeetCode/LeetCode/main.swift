//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

let matrix = [6,5,5]

func majorityElement(_ nums: [Int]) -> Int {
    var vote = 0,count = 0
    for num in nums {
        if count == 0 {
            vote = num
            count = 1
        } else if vote == num {
            count += 1
        } else {
            count -= 1
        }
    }
    return vote
}
print(majorityElement(matrix))


