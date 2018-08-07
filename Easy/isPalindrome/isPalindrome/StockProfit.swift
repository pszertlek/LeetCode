//
//  StockProfit.swift
//  isPalindrome
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Cocoa

class StockProfit: NSObject {
    class func maxProfit(_ nums: [Int]) -> Int {
//        var lastBuyIndex = -1
//        for i in 0..<nums.count {
//
//        }
        return 0
    }
    
    class func numJewelsInStones(_ J: String, _ S: String) -> Int {
        var sum = 0
        for (_, value) in S.enumerated() {
            if J.contains(value) {
                sum = sum + 1
            }
        }
        return sum
    }
    
    class func numJewelsInStonesss(_ J:String, _ S: String) -> Int {
        let set1 = Set.init(J)
        var s2 = [Character](S)
        
        var n = 0
        
        for i in 0..<s2.count
        {
            if set1.contains(s2[i])
            {
                n+=1
            }
        }
        
        return n
    }
    
    class func toLowerCase(_ str: String) -> String {
        return str.lowercased()
    }
    
    enum Direction: Character {
        typealias RawValue = Character
        
        case R = "R"
        case L = "L"
        case U = "U"
        case D = "D"
    }
    
    class func judgeCircle(_ moves: String) -> Bool {
        var x = 0
        var y = 0
        for (_, value) in moves.enumerated() {
            let direction = Direction.init(rawValue: value)!
            switch direction {
            case .R:
                x = x + 1
            case .L:
                x = x - 1
            case .U:
                y = y + 1
            case .D:
                y = y - 1
            }
        }
        return x == 0 && y == 0
    }
    
    class func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var dist = 0;
        var  val = x ^ y;
        
        // Count the number of bits set
        while (val != 0)
        {
            // A bit is set, so increment the count and clear the bit
            dist = dist + 1;
            val = val&( val - 1);
        }
        // Return the number of differing bits
        return dist;
    }
    

}
