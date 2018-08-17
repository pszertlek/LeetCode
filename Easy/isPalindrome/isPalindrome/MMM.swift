//
//  MMM.swift
//  isPalindrome
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Cocoa

class MMM: NSObject {
//    enum Direction: Optional<Character> {
//        typealias RawValue = Character?
//        
//        case A = "+"
//        case D = "D"
//        case C = "C"
//        case None
//    }
//
//    func calPoints(_ ops: [String]) -> Int {
//        var sum = 0,last = 0,lastTwo = 0
//        for (_, c) in ops.enumerated() {
//            let s = Direction.init(rawValue: c.first)
//            switch s {
//            case .A:
//                sum = sum + last + lastTwo
//                lastTwo = last
//                last = last + lastTwo
//            case .D:
//                sum = sum + 2 * last
//                lastTwo = last
//                last = last * 2
//            case .C:
//                sum = sum - last
//                lastTwo = last
//                last = 0 - last
//            default:
//                sum = sum + (c as NSString).integerValue
//                lastTwo = last
//                last = (c as NSString).integerValue
//            }
//        }
//    }
    
    func uncommonFromSentences(_ A: String, _ B: String) -> [String] {
        let first = A.components(separatedBy: CharacterSet.init(charactersIn: " "))
        let second = B.components(separatedBy: CharacterSet.init(charactersIn: " "))
        var result = [String]()
        var dict = [String: Int]()
        for s in first {
            dict[s] = ( dict[s] ?? 0) + 1
        }
        for s in second {
            dict[s] = ( dict[s] ?? 0) + 1
        }
        for key in dict.keys {
            if dict[key] == 1 {
                result.append(key)
            }
        }
        return result
    }
}
