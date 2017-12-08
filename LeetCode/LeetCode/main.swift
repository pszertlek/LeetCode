//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation


let s : NSString = "ss"
let set = NSSet.init(array: [12,21,21,23,32])
let predict = NSPredicate.init { (j, i) -> Bool in
    print(j,i)
    return true
}
set.filtered(using: predict)

print(LC2Sum().twoSumResult(nums: [1,2,3,4,5,6,7], 9))
func ssss(_ str: String) -> Int {
    var set =  Set<Character>()
    var max = 0
    var i = 0, j = 0
    let n = str.count
    var string = Array(str)
    while i < n && j < n {
        let s = string[j]
        if set.contains(s) {
            set.remove(string[i])
            i = i + 1
        } else {
            set.insert(s)
            max = max > (j - i + 1) ? max: (j - i + 1)
            j = j + 1
        }
    }
    return max
}

print(ssss("adsaswxsxd"))
