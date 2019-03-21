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
    
    func ss(_ index: Int, _ results:inout [[Int]], _ nums: [Int]) {
        let temp = results
        for var i in temp {
            i.append(nums[index])
            results.append(i)
        }
        results.append([nums[index]])
        if index + 1 < nums.count {
            ss(index + 1, &results, nums)
        }
    }
    
    func subsets1(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        
        ss(0, &results, nums)
        results.append([Int]())
        return results
        
    }
    
    func generateParenthesis(_ n: Int) -> [String] {
        var leftK = 0
        var result = [String]()
        func generate(_ currentLeft: Int, _ currentRight: Int, s: String) {
            if currentLeft > currentRight {
                if currentLeft < n {
                    generate(currentLeft + 1, currentRight, s: s + "(")
                    generate(currentLeft, currentRight + 1, s: s + ")")
                } else {
                    var s = s
                    for _ in 0..<currentLeft - currentRight  {
                        s.append(")")
                    }
                    result.append(s)
                }
            } else {
                if currentLeft < n {
                    generate(currentLeft + 1, currentRight, s: s + "(")
                } else {
                    result.append(s)
                }
            }
        }
        
        generate(0, 0, s: "")
        return result
    }
    
    func permute(_ nums: [Int]) -> [[Int]] {
        
        
    }
}
