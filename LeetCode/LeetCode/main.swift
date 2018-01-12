//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation


if let url = URL(string: "http://device/sss") {
    print(url.host)
    print(url.path)
    print(url.path.replacingOccurrences(of: "/", with: ""))
}

func reverse(_ x: Int) -> Int {
    if x >= 1 << 31 || x < -(1 << 31) + 1 {
        return 0
    }
    var sum = 0 , xx = x
    while xx != 0 {
        sum = sum * 10 + xx % 10
        xx = xx / 10
    }
    return sum
}



func longestPalindrome(_ s: String) -> String {
    var dict = Dictionary<Character,(Int,Int,Int)>()
    var stringArray = Array(s)
    var i = 0, n = stringArray.count
    var max = (0,0,0)
    while i < n {
        let char = stringArray[i]
        if var tuple = dict[char] {
            tuple.0 = tuple.0 + 1
            tuple.2 = i
            dict[char] = tuple
            if max.2 - max.1 < tuple.2 - tuple.1
                && (tuple.2 - tuple.1 + 1 != n
                    || tuple.0 == tuple.2 - tuple.1 + 1){
                max = tuple
            }
        } else {
            dict[char] = (1,i,i)
        }
        i = i + 1
    }
    let result = stringArray[max.1...max.2]
    return String(result)
}
print(longestPalindrome("sdfas"))



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


