//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation
//从前到后，先找到1的所有朋友，然后在1的非朋友中再找下一个



//print(ArraySolution().maxAreaOfIsland(([[0,0,1,0,0,0,0,1,0,0,0,0,0],
//                                        [0,0,0,0,0,0,0,1,1,1,0,0,0],
//                                        [0,1,1,0,1,0,0,0,0,0,0,0,0],
//                                        [0,1,0,0,1,1,0,0,1,0,1,0,0],
//                                        [0,1,0,0,1,1,0,0,1,1,1,0,0],
//                                        [0,0,0,0,0,0,0,0,0,0,1,0,0],
//                                        [0,0,0,0,0,0,0,1,1,1,0,0,0],
//                                        [0,0,0,0,0,0,0,1,1,0,0,0,0]])))


//func largestSub(_ nums: [Int]) -> Int {
//
//    var curSum = 0
//    var maxSum = nums[0]
//    for i in 0..<nums.count {
//        curSum = (nums[i] > curSum + nums[i]) ? nums[i] : curSum + nums[i];//1---------
//        maxSum = (maxSum > curSum) ? maxSum : curSum;//2---------
//    }
//    return maxSum
//}
//
//
//func findMsss(_ target: Int, array: [[Int]]) -> Bool {
//    var i = 0, j = array.count - 1
//    while i < array.count && j >= 0 {
//        if target == array[i][j] {
//            return true
//        } else if target > array[i][j] {
//            i = i + 1
//        } else {
//            j = j - 1
//        }
//    }
//    return false
//}
//
//let One = AllOne()
//
//let a = ["AllOne","inc","inc","inc","inc","inc","inc","dec", "dec","getMinKey","dec","getMaxKey","getMinKey"]
//let b = [[],["a"],["b"],["b"],["c"],["c"],["c"],["b"],["b"],[],["a"],[],[]]
//
//for (index,s) in a.enumerated() {
//    print("\(s) \(b[index])")
//}
//
//One.inc("hello")
//One.inc("hello")
//One.inc("leet")
////One.dec("hello")
//print(One.getMaxKey())
//print(One.getMinKey())

for i in 0...0 {
    print(i)
}

let i = StringSolution().fullJustify(["What","must","be","acknowledgment","shall","be"],16)
for e in i {
    print(e)
}
