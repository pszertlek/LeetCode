//
//  File.swift
//  LeetCode
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class Backtracking {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        let total = Int(powf(2, Float(nums.count)))
        for i in 0..<total {
            var current = [Int]()
            for j in 0..<nums.count {
                if 1 << j & i != 0 {
                    current.append(nums[j])
                }
            }
            results.append(current)
        }
        return results
    }
    
//    func sss(_ nums: [Int])
    
    func subsets1(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        
        func ss(_ index: Int) {
            
            for i in results {
                var array = i

                array.append(nums[index])
                results.append(array)
            }
        }
        
        for i in 1..<nums.count {
            if results.count == 0 {
                results.append([Int]())
            }
            results.append([Int](arrayLiteral: nums[i]))
            ss(i)
        }
        return results
        
    }
}
