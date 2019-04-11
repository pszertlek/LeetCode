//
//  Array.swift
//  LeetCode
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class ArraySolution {
    //给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。
    func rotate(_ nums: inout [Int], _ k: Int) {
        var cache = [Int]()
        let k = k % nums.count
        for index in 0..<nums.count {
            let toIndex = (index + k) % nums.count
            if cache.count == k {
                cache.append(nums[toIndex])
                nums[toIndex] = cache.first!
                cache.removeFirst()
            } else {
                cache.append(nums[toIndex])
                nums[toIndex] = nums[index]
            }
        }
    }
    
    func rotate1(_ nums: inout [Int], _ k: Int) {
        var cur = nums[0], count = 0, start = 0
        var index = 0
        while count < nums.count {
            index = (index + k) % nums.count
            let t = nums[index]
            nums[index] = cur
            if index == start {
                start = start + 1
                index = index + 1
                cur = nums[index]
            } else {
                cur = t
            }
            count = count + 1
            print(nums)
        }
    }
    
    func rotate2(_ nums: inout [Int], _ k: Int) {
        let k = k % nums.count
        func reverse(_ from: Int, _ to: Int) {
            for i in 0..<(to - from + 1)/2 {
                nums.swapAt(from + i, to - i)
            }
        }
        reverse(0 , nums.count - k - 1)
        reverse(nums.count - k, nums.count - 1)
        reverse(0, nums.count - 1)
    }

    
    func plusOne(_ digits: [Int]) -> [Int] {
        var digits = digits
        var cc = digits.count - 1
        while cc >= 0 {
            if digits[cc] + 1 > 9 {
                digits[cc] = 0
                cc = cc - 1
            } else {
                digits[cc] = digits[cc] + 1
                break
            }
        }
        
        if cc >= 0{
            return digits
        } else {
            digits.insert(1, at: 0)
            return digits
        }
    }
    
    func rotate(_ matrix: inout [[Int]]) {
        var i = 0, j = 0
        let n = matrix.count
        func toChange(_ i: Int, _ j: Int) -> (Int,Int) {
            if i < n / 2 && j < n / 2 {
                return (n - j,n / 2 + i)
            } else  if i < n / 2 && j >= n / 2 {
                return (n - j, n - i)
            } else if i > n / 2 && j > n / 2 {
                return (j,i)
            } else {
                return (j,n - i)
            }
        }
        for i in 0..<n/2 {
            for j in 0..<n/2 {
                for _ in 0..<4 {
                    
                }
            }
        }
    }
    
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        let a = Array<Character>.init(S)
        let b = Array<Character>.init(T)
        var sn = a.count - 1, bn = b.count - 1
        var skip = 0
        while sn >= 0 || bn >= 0 {
            while sn >= 0 {
                if (a[sn] == "#") {
                    sn = sn - 1
                    skip = skip + 1
                } else if (skip > 0) {
                    sn = sn - 1
                    skip = skip - 1
                } else {
                    break
                }
            }
            skip = 0
            while bn >= 0 {
                if (b[bn] == "#") {
                    bn = bn - 1
                    skip = skip + 1
                } else if (skip > 0) {
                    bn = bn - 1
                    skip = skip - 1
                } else {
                    break
                }
            }
            if (sn >= 0 && bn >= 0 && a[sn] != b[bn]) {
                return false
            }
            if ((sn >= 0) != (bn >= 0)) {
                return false
            }
            sn = sn - 1
            bn = bn - 1
        }
        return sn == bn
    }
    
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        let name = Array<Character>.init(name)
        let typed = Array<Character>.init(typed)
        var i = name.count - 1, ti = typed.count - 1
        var lastCount = 0,usedCount = 0
        var last = typed[ti]
        while i >= 0 {
            if lastCount > 0 && usedCount < lastCount {
                if last == name[i] {
                    usedCount = usedCount + 1
                    i = i - 1
                } else if lastCount > 0 && usedCount == 0  {
                    return false
                } else {
                   usedCount = 0
                    lastCount = 0
                }
            } else if ti >= 0 {
                last = typed[ti]
                while ti >= 0 && last == typed[ti] {
                    lastCount = lastCount + 1
                    ti = ti - 1
                }
            } else {
                break
            }
        }
        return i == ti
    }
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let hay = Array(haystack)
        let dle = Array(needle)

        
        var i = 0, ti = 0
        while i < hay.count && ti < dle.count {
            if hay[i] == dle[ti] {
                i = i + 1
                ti = ti + 1
            } else {
                if ti == 0 {
                    i = i + 1
                } else {
                    i = i - ti + 1
                }
                ti = 0
            }
        }
        return ti == dle.count ? i - dle.count : -1
    }
    
    /*
     13     while (i < t.length && j < p.length) {
     15        if (j == -1 || t[i] == p[j]) { // 当j为-1时，要移动的是i，当然j也要归0
     17            i++;
     19            j++;
     21        } else {
     23            // i不需要回溯了
     25            // i = i - j + 1;
     27            j = next[j]; // j回到指定位置
     29        }
     31     }
     33     if (j == p.length) {
     35        return i - j;
     37     } else {
        return -1;
     41     }
     42
     */
    
    func getNext(p: inout [Character]) -> [Int] {
         var next = Array<Int>.init(repeating: 0, count: p.count)
         next[0] = -1;
         var j = 0;
         var k = -1;
         while (j < p.count - 1) {
            if (k == -1 || p[j] == p[k]) {
                j = j + 1
                k = k + 1
                if p[j] == p[k] {
                    next[j] = next[k]
                } else {
                    next[j] = k
                }
            } else {
                k = next[k];
            }
         }
         return next;
     }
    
    func kmpStr(_ s: String, _ needle: String) -> Int {
        var hay = Array(s)
        let dle = Array(needle)
        var next = getNext(p: &hay)
        next[0] = -1
        var j = 0, i = 0
        while i < s.count && j < dle.count {
            if j == -1 || hay[i] == dle[j] {
                j = j + 1
                i = i + 1
//                next[j] = k
            } else {
                j = next[j]
//                k = next[k]
            }
        }
        if j == dle.count {
            return i - j
        } else {
            return -1
        }
    }
    
    func partitionLabels(_ S: String) -> [Int] {
        let string = Array(S)//ababcbacadefegdehijhklij
        var dict = [Character:(Int,Int)]()
        var result = [Int]()
        var start = 0
        for (index,c) in string.enumerated() {
            if let i = dict[c] {
                dict[c] = (i.0, index)
            } else {
                dict[c] = (index,index)
            }
        }
        while start < string.count {
            var location = dict[string[start]]!
            var i = location.0
            while i < location.1 {
                let inLocation = dict[string[i]]!
                if inLocation.1 > location.1 {
                    location = (location.0,inLocation.1)
                }
                i = i + 1
            }
            result.append(location.1 - location.0 + 1)
            start = location.1 + 1
        }
        return result
    }
    
    public class Interval: CustomStringConvertible {
        public var start: Int
        public var end: Int
        public init(_ start: Int, _ end: Int) {
            self.start = start
            self.end = end
        }
        
        public var description: String {
            return "[\(start),\(end)]"
        }
    }
    
    func intervalIntersection(_ A: [Interval], _ B: [Interval]) -> [Interval] {
        var ai = 0
        var bi = 0
        var result = [Interval]()
        while ai < A.count && bi < B.count {
            if A[ai].start > B[bi].end {
                bi = bi + 1
            } else if A[ai].end < B[bi].start {
                ai = ai + 1
            } else {
                result.append(Interval(max(A[ai].start, B[bi].start),min(A[ai].end, B[bi].end)))
                if A[ai].end > B[bi].end {
                    bi = bi + 1
                } else if A[ai].end == B[bi].end {
                    ai = ai + 1
                    bi = bi + 1
                } else {
                    ai = ai + 1
                }
            }
        }
        return result
    }
    
}
