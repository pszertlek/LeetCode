//
//  LongestPalindrome.swift
//  LeetCode
//
//  Created by apple on 2017/12/9.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

class LongestPalindrome {
    func longestPalindrome(_ s: String) -> String {
        var dict = Dictionary<Character,(Int,Int,Int)>()
        let stringArray = Array(s)
        var i = 0, n = stringArray.count
        var max = (0,0,0)
        while i < n {
            let char = stringArray[i]
            if var tuple = dict[char] {
                tuple.0 = tuple.0 + 1
                tuple.2 = i
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
}
