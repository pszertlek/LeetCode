//
//  Solution.swift
//  isPalindrome
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 {
            return ""
        }
        let start = strs.first!.startIndex
        let count = strs.first!.count
        var index = strs.first!.startIndex
        var num = 0

        for i in 0..<count {
            let current = strs[0][index]
            for j in 0..<strs.count {
                if strs[j].count > i {
                    let s = strs[j][index];
                    if current != s {
                        return strs[0].substring(to: strs[0].index(start, offsetBy: num))
                    }
                } else {
                    return strs[0].substring(to: strs[0].index(start, offsetBy: num))
                }

            }
            index = strs[0].index(after: index)
            num = num + 1
        }
        return strs[0].substring(to: strs[0].index(start, offsetBy: num))
    }
    
    func reverse(_ x: Int) -> Int {
        var result = 0,current = x
        var min = Int32.min / 10, max = Int32.max / 10
        while current != 0 {
            if result < min && current != 0 {
                return 0
            } else if result > max && current != 0 {
                return 0
            }
            result = result * 10 + (current % 10)
            current = current / 10
        }
        return result
    }
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        guard let result = haystack.range(of: needle)?.lowerBound else {
            return -1
        }
        return result.hashValue

    }
    
    func lengthOfLastWord(_ s: String) -> Int {
        var i = 0
        for (_,c) in s.enumerated().reversed() {
            if i > 0 && c == " " {
                break;
            } else if c != " " {
                i = i + 1
            }
        }
        return i
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
        if a.count == 0 || b.count == 0 {
            return a.count == 0 ? b : a
        }
        var aa = Array.init(a)
        var bb = Array.init(b)
        let aCount = aa.count
        let bCount = bb.count
        let count = aCount > bCount ? aCount: bCount
        var result = Array<Character>.init(repeating: "0", count: count + 1 )
        for i in 0..<count + 1 {
            let m = (i >= aCount) ? 0 :( aa[aCount - i - 1] == "0" ? 0 : 1)
            let n = (i >= bCount) ? 0 :( bb[bCount - i - 1] == "0" ? 0 : 1)
            let r = result[count - i] == "0" ? 0 : 1
            if m + n + r == 1 {
                result[count - i] = "1"
            } else if m + n + r == 2 {
                result[count - i] = "0"
                result[count - i - 1] = "1"
            } else if m + n + r == 3 {
                result[count - i] = "1"
                result[count - i - 1] = "1"
            }
        }
        if result.first == "0" {
            result.removeFirst()
        }
        return String.init(result)
    }
    
    func mySqrt(_ x: Int) -> Int {
        return Int(sqrt(Double(x)))
    }
    
    func combination(_ n: Int,_ m: Int) -> Int {
        let i = m > (n / 2) ? (n - m) : m
        var x = i, result = 1
        while x != 0 {
            result = result * (n - (i - x)) / (i - x + 1)
            x = x - 1
        }
        return result
    }
    
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }

        var current = n / 2, result = 0
        while current >= 0 {
            result = combination(n - current, current) + result
            current = current - 1
        }
        
        return result
    }
    
    func climbStairs1(_ n: Int) -> Int {
        if n <= 3 {
            return n
        }
        return climbStairs1(n - 1) + climbStairs1(n - 2)
    }
    
    func countAndSay(_ n: Int) -> String {
        
        var result = n
        var s = ""
        for c in count(n) {
            s.append("\(c)")
        }
        return s
        
    }
    
    func count(_ n: Int) -> [Int] {
        if n == 1 {
            return [1]
        }
        let s = count(n - 1)
        var i = 1, result = [Int](), currentNum = s[0] , currentCount = 1
        
        repeat {
            if s.count == i {
                result.append(contentsOf: [currentCount,currentNum])
                break;
            }
            let currentEqual = currentNum == s[i]
            if !currentEqual && currentCount != 0 {
                result.append(contentsOf: [currentCount,currentNum])
                currentNum = s[i]
                currentCount = 1
            } else if currentEqual {
                currentCount = currentCount + 1
            } else if !currentEqual {
                result.append(contentsOf: [1,currentNum])
                currentNum = s[i]
                currentCount = 1
            }
            i = i + 1
        } while s.count >= i
        return result
    }
}
