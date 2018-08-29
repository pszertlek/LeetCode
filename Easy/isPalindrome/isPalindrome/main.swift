//
//  main.swift
//  isPalindrome
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation



func countPrimes(_ n: Int) -> Int {
    if n < 3 {
        return 0
    }
    if n == 3 {
        return 1
    }
    var notPrime = Set<Int>.init(minimumCapacity: n)
    for i in 2..<n {
        if !notPrime.contains(i) {
            var j = i + i
            while j < n {
                notPrime.insert(j)
                j = j + i
            }
        }
    }
    var count = 0
    for i in 2..<n {
        if !notPrime.contains(i) {
            count = count + 1
        }
    }
    return count
}
