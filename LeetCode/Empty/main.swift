//
//  main.swift
//  Empty
//
//  Created by Apple on 2021/5/3.
//  Copyright © 2021 Pszertlek. All rights reserved.
//

import Foundation

print("Hello, World!")

class Solution {
    func evaluate(_ s: String, _ knowledge: [[String]]) -> String {
        var dict = [String: String]()
        for ss in knowledge {
            dict[ss[0]] = ss[1]
        }
        var res = "", key = "", iskey = false
        for c in s {
            if c == "(" {
                iskey = true
                
            } else if c == ")" {
                iskey = false
                res.append(dict[key] ?? "?")
                key = ""
            } else {
                if iskey {
                    key.append(c)
                } else {
                    res.append(c)
                }
            }
        }
        return res
    }
    
    func displayTable(_ orders: [[String]]) -> [[String]] {
        var dict = [String: [String: Int]]()
        var nameSet = Set<String>()
        for order in orders {
            dict[order[1],default: [:]][order[2], default: 0] += 1
            nameSet.insert(order[2])
        }
        let names = nameSet.sorted()
        let keys = [String](dict.keys.sorted())
        var res = [[String]](), titles = ["Table"]
        titles.append(contentsOf: names)
        res.append(titles)
        for key in keys.sorted(by: { Int($0)! < Int($1)! }) {
            if let foods = dict[key] {
                var section = [key]
                for name in names {
                    section.append("\(foods[name] ?? 0)")
                }
                res.append(section)
            }
        }
        return res
    }
    
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        var n = numerator, res = ""
        var repeatDict = [Int:Int]()
        var decimalPart = ""
        var de = denominator
        if n < 0 {
            n = -n
        }
        if denominator < 0 {
            de = -denominator
        }
        if n > de || n == 0 {
            let quetient = n / de
            let reminder = n % de
            if numerator * denominator < 0  {
                res.append("-")
            }
            res.append("\(quetient)")
            if reminder == 0 {
                return res
            } else {
                res.append(".")
            }
            n = reminder
        } else {
            
            res.append("0.")
        }
        var i = 0
        while n != 0 && repeatDict[n] == nil  {
            repeatDict[n] = i
            n *= 10
            i += 1
            while n < de {
                n *= 10
                i += 1
                decimalPart.append("0")
            }
            let quetient = n / de
            let reminder = n % de
            repeatDict[numerator] = 0
            decimalPart.append("\(quetient)")
            n = reminder
        }
        if n == 0 {
            res.append(decimalPart)
        } else if let i = repeatDict[n] {
            
            for (index, c) in decimalPart.enumerated() {
                if index == i {
                    res.append("(")
                }
                res.append(c)
                if index == decimalPart.count - 1 {
                    res.append(")")
                }
            }
        }
        return res
    }
    
    func deleteAndEarn(_ nums: [Int]) -> Int {
        var dict = [Int: Int]()
        for i in nums {
            dict[i, default: 0] += 1
        }
        let keys = ([Int](dict.keys)).sorted()
        
        var dp = [Int](repeating: 0, count: keys.count)
        dp[0] = keys[0] * dict[keys[0],default: 0]
        guard nums.count > 1 else {
            return dp[0]
        }

        if keys[1] == keys[0] + 1 {
            dp[1] = max(keys[1] * dict[keys[1], default: 0], dp[0])
        } else {
            dp[1] = keys[1] * dict[keys[1], default: 0] + dp[0]
        }
        guard nums.count > 2 else {
            return dp[1]
        }
        var i = 2
        while i < keys.count {
            if keys[i] == keys[i - 1] + 1 {
                dp[i] = max(keys[i] * dict[keys[i], default: 0] + dp[i - 2], dp[i - 1])
            } else {
                dp[i] = keys[i] * dict[keys[i], default: 0] + dp[i - 1]
            }
            i += 1
        }
        return dp.last!
    }
    
    func replaceDigits(_ s: String) -> String {
        let alpha = [Character]("abcdefghijklmnopqrstuvwxyz")
        var dict = [Character: Int]()
        for (i,c) in alpha.enumerated() {
            dict[c] = i
        }
        func shift(_ c: Character, _ x: Int) -> Character {
            return alpha[dict[c]! + x]
        }
        
        var res = ""
        var cur: Character!
        for (i, c) in s.enumerated() {
            if i & 1 == 0 {
                cur = c
                res.append(c)
            } else {
                res.append(shift(cur, c.hexDigitValue!))
            }
        }
        return res
    }
    
    func truncateSentence(_ s: String, _ k: Int) -> String {
        return s.components(separatedBy: " ")[0..<k].joined(separator: " ")
    }
    
    func findRelativeRanks(_ score: [Int]) -> [String] {
        var dict = [Int: Int]()
        for i in 0..<score.count {
            dict[score[i]] = i
        }
        let sortScore = score.sorted(by: >)
        var res = [String](repeating: "", count: score.count)
        for (rank,i) in sortScore.enumerated() {
            if let index = dict[i] {
                if rank == 0 {
                    res[index] = "Gold Medal"
                } else if rank == 1 {
                    res[index] = "Silver Medal"
                } else if rank == 2 {
                    res[index] = "Bronze Medal"
                } else {
                    res[index] = "\(rank + 1)"
                }
            }
        }
        return res

    }
    
    func duplicateZeros(_ arr: inout [Int]) {
        var i = 0, j = 0
        while i + j < arr.count {
            if arr[i] == 0 {
                j += 1
            }
            i += 1
        }
        if i + j > arr.count && arr[i - 1] == 0{
            arr[i - 1 + j - 1] = 0
            i -= 1
            j -= 1
        }
        while j > 0 {
            if arr[i - 1] == 0 {
                arr[i - 1 + j] = 0
                arr[i - 1 + j - 1] = 0
                j -= 1
            } else {
                arr[i - 1 + j] = arr[i - 1]
            }
            i -= 1
        }
    }
    
    func storeWater(_ bucket: [Int], _ vat: [Int]) -> Int {
        let N = bucket.count
        guard let maxk = vat.max() else {
            return 0
        }
        var ans = Int.max
        for k in 1...maxk {
            var cur = k
            for i in 0..<N {
                let least = vat[i] / k + (vat[i] % k != 0 ? 1 : 0)
                cur += max(least - bucket[i], 0)
            }
            ans = min(ans, cur)
        }
        return ans
    }
    
    func longestBeautifulSubstring(_ word: String) -> Int {
        let arr = [Character]("aeiou")
        let dict: [Character: Int] = ["a":0,"e":1,"i":2,"o":3,"u":4]
        var ci = -1, res = 0,count = 0
        for (index,c) in word.enumerated() {
            if let i = dict[c] {
                if i == ci || ci + 1 == i {
                    ci = i
                    count += 1
                    if ci == 4 {
                        res = max(res, count)
                    }
                } else if i == 0 {
                    ci = 0
                    count = 1
                } else {
                    count = 0
                }
            } else {
                count += 1
                if ci == 4 {
                    res = max(res, count)
                }
            }
            if res == 4 {
                print("aa")
            }
        }
        return res
    }
    func totalFruit(_ tree: [Int]) -> Int {
         var left = 0, right = 0
         var n1 = 0, n2 = 0, fruit1 = tree[0], fruit2 = -1
         var res = 1
         while right < tree.count {
             if fruit1 == tree[right] {
                 n1 += 1
                 right += 1
                 res = max(res,right - left)
             } else if tree[right] == fruit2 {
                 n2 += 1
                 right += 1
                 res = max(res,right - left)
             } else if fruit2 == -1 {
                 n2 += 1
                 fruit2 = tree[right]
                 right += 1
                 res = max(res,right - left)
             } else {
                 while n1 > 0 && n2 > 0 {
                     if tree[left] == fruit1 {
                         n1 -= 1
                     } else {
                         n2 -= 1
                     }
                     left += 1
                 }
                if n2 > 0 {
                    n1 = n2
                    n2 = 0
                    fruit1 = fruit2
                    fruit2 = tree[right]
                } else {
                    fruit2 = tree[right]
                }

             }
         }
         return res
    }

    func minimumLength(_ s: String) -> Int {
        var left = 0, right = s.count - 1
        let ss = [Character](s)
        while left < right {
            var lc = 0, rc = 0
            let letter = ss[left]
            while left + lc <= right - rc && (ss[left + lc] == letter || ss[right - rc] == letter) {
                lc += ss[left + lc] == letter ? 1 : 0
                rc += ss[right - rc] == letter ? 1 : 0
                
            }
            if lc > 0 && rc > 0 {
                left += lc
                right -= rc
            } else {
                break
            }
            
        }
        return right - left + 1
    }
    
    func minOperations(_ nums: [Int], _ x: Int) -> Int {
        var left = 0, right = 0
        let target = nums.reduce(0, +) - x
        var res = -1, sum = 0, has = false
        while right < nums.count {
            sum += nums[right]

            
            right += 1
            while left < right && sum > target {
                sum -= nums[left]
                left += 1
            }
            if sum == target {
                has = true
                res = max(res, right - left)
            }
        }
        return has ? nums.count - res : -1
    }
    
    func removeDuplicateLetters(_ s: String) -> String {
        var visited = [Bool](repeating: false, count: 26)
        var num = [Int](repeating: 0, count: 26)
        for c in s {
            num[c.alphaValue] += 1
        }
        var stk = [Character]()
        for c in s {
            if !visited[c.alphaValue] {
                while let last = stk.last, last > c {
                    if num[last.alphaValue] > 0 {
                        visited[last.alphaValue] = false
                        stk.removeLast()
                    } else {
                        break
                    }
                }
                visited[c.alphaValue] = true
                stk.append(c)
            }
            num[c.alphaValue] -= 1
        }
        return String(stk)
    }
    
    func sortSentence(_ s: String) -> String {
        let arr = s.components(separatedBy: " ")
        
        let res = arr.sorted { s1, s2 in
            return s1.last!.asciiValue! < s2.last!.asciiValue!
        }
        return res.map {
            return $0.prefix($0.count - 1)
        }.joined(separator: " ")
    }
    
//    func longestSubstring(_ s: String, _ k: Int) -> Int {
//        var ss = [Character](s)
//        var dict = [Character: Int]()
//        for c in s {
//            dict[c, default: 0] += 1
//        }
//        var i = 0
//        for (key, value) in dict {
//            if value < k {
//
//            }
//        }
//    }
    func leastBricks(_ wall: [[Int]]) -> Int {
        var dict = [Int:Int]()
        for row in wall {
            var sum = 0
            for width in row[0..<row.count-1] {
                sum += width
                dict[sum, default: 0] += 1
            }
        }
        var res = 0
        for (_, v) in dict {
            res = max(res, v)
        }
        return wall.count - res
    }
    
    func canReorderDoubled(_ arr: [Int]) -> Bool {
        var dict = [Int: Int]()
        for i in arr {
            dict[i, default: 0] += 1
        }
        for key in dict.keys.sorted() {
            if let i = dict[key], i > 0 {
                var l = i
                if let j = dict[key * 2], j > 0 {
                    l = i - j >= 0 ? i - j : 0
                    dict[key] = l
                    dict[2 * key] = j - i >= 0 ? j - i : 0
                }
                if key % 2 == 0 {
                    let k = dict[key / 2, default: 0]
                    dict[key / 2] = k - l >= 0 ? k - l : 0
                    l = l - k >= 0 ? l - k : 0
                    dict[key] = l
                }
                if l > 0 {
                    return false
                }
            }
        }
        return true
    }
}

class StackOfPlates {

    var stacks: [[Int]] = []
    var cap: Int

    init(_ cap: Int) {
        self.cap = cap
    }
    
    func push(_ val: Int) {
        if let lastStack = stacks.last, lastStack.count < cap {
            stacks[stacks.count - 1].append(val)
        } else {
            stacks.append([val])
        }
    }
    
    func pop() -> Int {
        guard let last = stacks.last else {
            return -1
        }
        if last.count == 1 {
            stacks.removeLast()
            return last[0]
        } else {
            return stacks[stacks.count - 1].popLast() ?? -1
        }
    }
    
    func popAt(_ index: Int) -> Int {
        if index >= stacks.count {
            return -1
        } else if index == stacks.count - 1 {
            return pop()
        }
        if stacks[index].count == 0 {
            let z = stacks[index][0]
            stacks.remove(at: index)
            return z
        }
        return stacks[index].popLast() ?? -1
    }
    
    func findMaxLength(_ nums: [Int]) -> Int {
        var a = [Int](repeating: 0, count: nums.count + 1)
        var dict = [Int: Int]()
        for i in 1...nums.count {
            a[i] = a[i - 1] + (nums[i - 1] == 0 ? -1: 1)
        }
        var res = 0
        for i in 0...nums.count {
            if let j = dict[a[i]] {
                res = max(res, i - j)
            } else {
                dict[a[i]] = i
            }
        }
        return res

        
    }
}

extension Character {
    var alphaValue: Int {
        return Int(self.asciiValue! - 97)
    }
}

class FindSumPairs {
    
    var nums1: [Int]
    
    var nums2: [Int]
    
    var dict1: [Int: Int] = [:]
    var dict2: [Int: Int] = [:]
    init(_ nums1: [Int], _ nums2: [Int]) {
        self.nums1 = nums1
        self.nums2 = nums2
        for i in nums2 {
            dict2[i, default: 0] += 1
        }
        
        for i in nums1 {
            dict1[i, default: 0] += 1
        }
    }
    
    func add(_ index: Int, _ val: Int) {
        let cur = nums2[index]
        nums2[index] += val
        dict2[cur, default: 0] -= 1
        dict2[cur + val, default: 0] += 1
    }
    
    func count(_ tot: Int) -> Int {
        var res = 0
        for (key,value) in dict1 {
            if let count = dict2[tot - key] {
                res += count * value
            }
        }
        return res
    }
}

print(Solution().canReorderDoubled([1,2,1,-8,8,-4,4,-4,2,-2]))
