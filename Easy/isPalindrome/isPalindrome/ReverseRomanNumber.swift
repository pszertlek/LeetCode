//
//  ReverseRomanNumber.swift
//  isPalindrome
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

class ReverseRoman {
    enum RomanNumber:Character {
        typealias RawValue = Character
        
        case I = "I"
        case V = "V"
        case X = "X"
        case L = "L"
        case C = "C"
        case D = "D"
        case M = "M"
        
        func value() -> Int {
            switch self {
            case .I:
                return 1
            case .V:
                return 5
            case .X:
                return 10
            case .L:
                return 50
            case .C:
                return 100
            case .D:
                return 500
            case .M:
                return 1000
            }
        }
    }
    

    
    class func romanToInt(_ s: String) -> Int {
        var last = 0, sum = 0
        for (_,c) in s.enumerated() {
            let current = RomanNumber(rawValue: c)!.value()
            sum = sum + current
            if current == 10 * last || current == 5 * last {
                sum = sum - last * 2
            }
            last = current
        }
        return sum
    }
    
}
