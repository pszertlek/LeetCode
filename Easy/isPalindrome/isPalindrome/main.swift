//
//  main.swift
//  isPalindrome
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

var i = [1,2,3,3,3,4,4,4,5,6,7,7]

let str = "BADFADSFADS"
let S = "abcdefgeevvvv"
print(StockProfit.hammingDistance(8, 3))

print(StockProfit.toLowerCase(str))
func isPalindrome(_ x: Int) -> Bool {
    guard x >= 0 else {
        return false
    }
    var i = 10, xx = x
    var array = [Int]()
    while xx != 0 {
        array.append(xx % 10)
        xx = xx / 10
    }
    i = 0
    while i < array.count / 2 {
        if array[i] != array[array.count - 1 - i] {
            return false
        }
        i += 1
    }
    return true
}

func isPalindrome1(_ x: Int) -> Bool {
//    guard x >= 0 else {
//        return false
//    }
    func reverse(_ x: Int) -> Int {
        var remain = x
        var result = 0
        while remain != 0 {
            result = remain % 10 + result * 10
            remain /= 10
        }
        return result
    }
    return x >= 0 && x == reverse(x)
}



/*字符          数值
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000*/



//func romanToInt(_ s: String) -> Int {
//    var i = s.count, result = 0
//    var stack = [Int]()
//    let Number = "MDCLXVI"
//    func stringToInt(_ s: String, _ index: Int) -> Int {
//        return Int((s as NSString).character(at: index))
//    }
//    let M = stringToInt(Number, 6)
//    let D = stringToInt(Number, 5)
//    let C = stringToInt(Number, 4)
//    let L = stringToInt(Number, 3)
//    let X = stringToInt(Number, 2)
//    let V = stringToInt(Number, 1)
//    let I = stringToInt(Number, 0)
//    var last = M
//
//    while i > 0 {
//        let current = stringToInt(s, i - 1)
//        if (current == M) {
//            result = result + 1000
//        } else if current == D {
//
//        }
//    }
//}
