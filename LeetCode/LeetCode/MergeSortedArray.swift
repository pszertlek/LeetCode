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
/*
 输入：[3,2,4,1]
 输出：[4,2,4,3]
 解释：
 我们执行 4 次煎饼翻转，k 值分别为 4，2，4，和 3。
 初始状态 A = [3, 2, 4, 1]
 第一次翻转后 (k=4): A = [1, 4, 2, 3]
 第二次翻转后 (k=2): A = [4, 1, 2, 3]
 第三次翻转后 (k=4): A = [3, 2, 1, 4]
 第四次翻转后 (k=3): A = [1, 2, 3, 4]，此时已完成排序。
 */
//3: 4，2，3，1
//4: 1,3,2,4
//2: 3,1,2,4
//3: 2,1,3,4
//2: 1,2,3,4

class SortSolution {
    func pancakeSort(_ A: [Int]) -> [Int] {
//        let sortA = A.sorted()
        var A = A
        var result = [Int]()
        var i = A.count
        while i > 0 {
            let index = A.firstIndex(of: i)!
            if index != i - 1  {
                if index == 0 {
                    result.append(i)
                    for j in 0..<i/2 {
                        A.swapAt(i - j - 1, j)
                    }
                    print("\(i):")
                    i = i - 1
                } else {
                    result.append(index+1)
                    for j in 0...index/2 {
                        A.swapAt(index - j, j)
                    }
                    print("\(result):")
                }
                print(A)
            } else {
                i = i - 1
            }
        }
        
        return result
    }
}
