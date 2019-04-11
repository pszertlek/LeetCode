//
//  BitCompute.swift
//  LeetCode
//
//  Created by apple on 2019/2/22.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class BitComputeSolution {
    func hasAlternatingBits(_ num: Int) -> Bool {
        let bitCount = num.bitWidth - num.leadingZeroBitCount
        guard bitCount > 0 else {
            return true
        }
        var i = 1, result = num & i
        for i in 1..<bitCount {
            let j = (num >> i) & 1
            if result ^ j != 1 {
                return false
            }
            result = j
        }
        return true
    }
    
    func countPrimeSetBits(_ L: Int, _ R: Int) -> Int {
        let set = Set(arrayLiteral: 2,3,5,7,11,13,17)
        var count = 0
        for i in L...R {
            if set.contains(i.nonzeroBitCount) {
                count = count + 1
            }
        }
        return count
    }
    
    func isPowerOfFour(_ num: Int) -> Bool {
        
        guard num != 0 else {
            return false
        }
        return (num.bitWidth - num.leadingZeroBitCount - 1) % 2 == 0 && 1 << (num.bitWidth - num.leadingZeroBitCount - 1) == num
    }
    
    func isPowerOfTwo(_ n: Int) -> Bool {
        return n != 0 && 1 << (n.bitWidth - n.leadingZeroBitCount - 1) == n
    }
    
    func toHex(_ num: Int) -> String {
        
        var n = num
        if n < 0 {
            n = n + Int(powf(2, 32))
        }
        var array = [Character]()
        func toHexNumber(_ num: Int) -> Character {
            switch num {
            case 0..<10:
                return Character("\(num)")
            case 10:
                return "a"
            case 11:
                return "b"
            case 12:
                return "c"
            case 13:
                return "d"
            case 14:
                return "e"
            case 15:
                return "f"
            default:
                print("error")
            }
            return Character("z")
        }
        
        while n > 0 {
            let i = n % 16
            array.append(toHexNumber(i))
            n = n / 16
        }
        return String(array.reversed())
    }

    func countBits(_ num: Int) -> [Int] {
        var result = Array<Int>.init(repeating: 0, count: num+1)
        for i in 1...num {
            result[i] = result[i&(i - 1)] + 1
        }
        return result
    }
//    func readBinaryWatch(_ num: Int) -> [String] {
//        func minute(_ num: Int) -> [Int]? {
//
//            guard num < 6 else{
//                return nil
//            }
//            if num == 5 {
//                return [31,63 - 16, 63 - 8]
//            }
//            if num == 4 {
//                return [63 - 32 - 16, 63 - 32 - 8, 63 - 32 - 4,63 - 32 - 2, 63 - 32 - 1, 63 - 16 - 8, 63 - 16 - 4, 63 - 16 - 2, 63 - 16 - 1, 63 - 8 - 4, 63 - 8 - 2, 63 - 8 - 1, 63 - 4 - 2, 63 - 4 - 1]
//            }
//            if num == 2 {
//                return [1 + 2, 1 + 4, 1 + 8, 1 + 16, 1 + 32, 2 + 4 , 2 + 8, 2 + 1]
//            }
//        }
//        return 
//    }
    
//    func letterCasePermutation(_ S: String) -> [String] {
//        for c in S.utf8 {
//
//        }
//        let c1 = Character("a")
//        let c2 = Character("A")
//        var indexs = [Int]()
//        var array = [Character]()
//        for (index, c) in S.utf8.enumerated() {
//            if c >= 97 && c <= 132 {
//                indexs.append(index)
//            }
//
//        }
//        let total = Int(powf(2, Float(indexs.count)))
//        String.Index(encodedOffset: 0)
//        S.replacingCharacters(in: [<#T##RangeExpression#>], with: <#T##StringProtocol#>)
//        for i in 0..<total {
//            S.replacingCharacters(in: Range(uncheckedBounds: String.Index(encodedOffset: indexs[0])), with: "<#T##StringProtocol#>")
//        }
//
//        S.replacingCharacters(in: , with: "<#T##StringProtocol#>")
//        for c in S {
//
//        }
//        return [""]
//    }
//
}
