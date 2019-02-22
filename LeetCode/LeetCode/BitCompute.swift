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
    
    func letterCasePermutation(_ S: String) -> [String] {
        for c in S.utf8 {
            
        }
        let c1 = Character("a")
        let c2 = Character("A")
        var indexs = [Int]()
        var array = [Character]()
        for (index, c) in S.utf8.enumerated() {
            if c >= 97 && c <= 132 {
                indexs.append(index)
            }
            
        }
        let total = Int(powf(2, Float(indexs.count)))
        String.Index(encodedOffset: 0)
        S.replacingCharacters(in: [<#T##RangeExpression#>], with: <#T##StringProtocol#>)
        for i in 0..<total {
            S.replacingCharacters(in: Range(uncheckedBounds: String.Index(encodedOffset: indexs[0])), with: "<#T##StringProtocol#>")
        }
        
        S.replacingCharacters(in: , with: "<#T##StringProtocol#>")
        for c in S {
            
        }
        return [""]
    }
    
}
