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
    
    func singleNumber(_ nums: [Int]) -> [Int] {
        var result = [0,0]
        var xor = 0
        for i in nums {
            xor ^= i
        }
        let mark = xor & (0 - xor)
        for i in nums {
            if (mark & i ) == 0 {
                result[0] ^= i
            } else if (mark & i) == mark {
                result[1] ^= i
            }
        }
        return result
    }
    
    func rangeBitwiseAnd(_ m: Int, _ n: Int) -> Int {
        var shift = 0
        var m = m , n = n
        while m < n {
            m >>= 1
            n >>= 1
            shift += 1
        }
        return m << shift
    }
    
    func computeArea(_ A: Int, _ B: Int, _ C: Int, _ D: Int, _ E: Int, _ F: Int, _ G: Int, _ H: Int) -> Int {
        if A > E {
            return self.computeArea(E, F, G, H, A, B, C, D)
        }
        if B >= H || D <= F || C <= E {
            return abs(A - C) * abs(B - D) + abs(E - G) * abs(F - H)
        }
        let down = max(A, E)
        let up = min(C, G)
        let left = max(B, F)
        let right = min(D, H)
        return abs(A - C) * abs(B - D) + abs(E - G) * abs(F - H) - abs(up - down) * abs(left - right)
    }
    
    func summaryRanges(_ nums: [Int]) -> [String] {
        var result = [String]()
        var start: Int? = nil, end: Int? = nil
        for i in nums {
            if start == nil {
                start = i
                end = i
            } else if let e = end, e + 1 == i {
                end = i
            } else {
                if start != end {
                    result.append("\(start!)->\(end!)")
                } else {
                    result.append("\(start!)")
                }
                start = i
                end = i
            }
        }
        if start != end && start != nil {
            result.append("\(start!)->\(end!)")
        } else if start != nil {
            result.append("\(start!)")
        }
        return result
    }
    
    func majorityElement(_ nums: [Int]) -> [Int] {
        guard nums.count > 0 else {
            return []
        }
        var res = [Int]()
        var cand1 = 0, cand2 = 0
        var cnt1 = 0, cnt2 = 0
        for num in nums {
            if num == cand1 {
                cnt1 += 1
            } else if num == cand2 {
                cnt2 += 1
            } else if cnt1 == 0 {
                cand1 = num
                cnt1 += 1
            } else if cnt2 == 0 {
                cand2 = num
                cnt2 += 1
            } else {
                cnt1 -= 1
                cnt2 -= 1
            }
        }
        cnt1 = 0
        cnt2 = 0
        for num in nums {
            if num == cand1 {
                cnt1 += 1
            } else if num == cand2 {
                cnt2 += 1
            }
        }
        if cnt1 > nums.count / 3 {
            res.append(cand1)
        }
        if cnt2 > nums.count / 3 {
            res.append(cand2)
        }
        return res
    }
    
    func hIndex(_ citations: [Int]) -> Int {
        guard citations.count > 0 else {
            return 0
        }
        let N = citations.count
        var res = 0
        var left = 0
        var right = N - 1
        while left <= right {
            let mid = (left + right) / 2
            if citations[mid] >= N - mid {
                res = min(citations[mid], N - mid)
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        
//        while i >= 0 {
//            if res + 1 > citations[i] {
//                return res
//            } else {
//                res = min(res + 1,citations[i])
//            }
//            i -= 1
//        }
        return res
    }
}
class MinStack {
    class Element {
        var index: Int
        var val: Int
        init(_ index: Int, _ val: Int) {
            self.index = index
            self.val = val
        }
    }
    var datas: [Element] = []
    var sorteds: [Element] = []
    /** initialize your data structure here. */
    init() {
        
    }
    
    func push(_ x: Int) {
        datas.append(Element(datas.count,x))
        var index = 0
        for i in sorteds {
            if x > i.val {
                index += 1
            } else {
                break
            }
        }
        sorteds.insert(datas[datas.count - 1], at: index)
    }
    
    func pop() {
        let element = datas.removeLast()
        
        for (index, i) in sorteds.enumerated() {
            if element.val == i.val {
                sorteds.remove(at: index)
                break
            }
        }
    }
    
    func top() -> Int {
        return datas.last?.val ?? -1
    }
    
    func getMin() -> Int {
        guard sorteds.count > 0 else {
            return -1
        }
        
        return sorteds[0].val
    }
    

}


class PeekingIterator {
    var data: [Int]
    
    init(_ arr: IndexingIterator<Array<Int>>) {
        self.data = [Int](arr)
    }
    
    func next() -> Int {
        if hasNext() {
            return 0
        } else {
            return self.data.remove(at: 0)
        }
    }
    
    func peek() -> Int {
        if hasNext() {
            return 0
        } else {
            return self.data[0]
        }
        
    }
    
    func hasNext() -> Bool {
        return self.data.count > 0
    }
}
