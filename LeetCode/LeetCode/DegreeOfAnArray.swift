//
//  DegreeOfAnArray.swift
//  LeetCode
//
//  Created by apple on 2017/11/29.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

class DegreeOfAnArray {
    class Degree {
        var num = -1
        var frequency = 1
        var first = 0,last = 0
        init(_ num: Int,_ first: Int) {
            self.num = num
            self.first = first
            self.last = first
        }
    }
    func findShortestSubArray(_ nums: [Int]) -> Int {
        var dict = [Int:Degree]()
        var maxFrequecy = 0
        for (index,num) in nums.enumerated() {
            if let degree = dict[num] {
                degree.last = index
                degree.frequency += 1
                maxFrequecy = max(maxFrequecy, degree.frequency)
            } else {
                let degree = Degree(num,index)
                dict[num] = degree
                maxFrequecy = max(maxFrequecy, degree.frequency)
            }
        }
        var minX = 50000
        for degree in dict.values {
            if maxFrequecy == degree.frequency {
                minX = min(minX, degree.last - degree.first)
            }
        }
        return minX + 1
    }
    
    
    func findShortestSubArrayy(_ nums: [Int]) -> Int {
        var dict = [Int:(Int,Int,Int)]()
        var maxFrequecy = 0,minLength = 50000
        for i in 0..<nums.count {
            if let (count,head,_) = dict[nums[i]] {
                dict[nums[i]] = (count + 1, head, i - head + 1)
            } else {
                dict[nums[i]] = (1,i,1)
            }
            if (maxFrequecy < dict[nums[i]]!.0) {
                maxFrequecy = dict[nums[i]]!.0
            }
        }
        
        for i in dict {
            if (i.value.0 == maxFrequecy) {
                if minLength > i.value.2 {
                    minLength = i.value.2
                }
            }
        }
        return minLength
    }
}
