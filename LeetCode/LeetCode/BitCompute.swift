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
class Solution {
    func maxSatisfaction(_ satisfaction: [Int]) -> Int {
        let sa = satisfaction.sorted(by: >)
        var presum = 0, ans = 0
        for i in sa {
            if presum + i > 0 {
                presum += i
                ans += presum
            } else {
                break
            }
        }
        return ans
    }
    
    func solveSudoku(_ board: inout [[Character]]) {
        /*
         1.以集合形式存储每行列和方格的数字
         2.使用堆排序，按照集合中元素的个数递减排列每个方格
         */
        
        let empty = Character(".")
        struct Point: Hashable {
            let x: Int
            let y: Int
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(x)
                hasher.combine(y)
            }
        }
        var gridSets = [Int].init(repeating: 0, count: 9)
        var rowSets = [Int].init(repeating: 0, count: 9)
        var columnSets = [Int].init(repeating: 0, count: 9)
        
        func bitNumber(_ c: Character) -> Int {
            return 1 << (c.hexDigitValue! - 1)
        }
        var arr = Set<Point>()

        for y in 0..<9 {
            for x in 0..<9 {
                if board[y][x] != empty {
                    gridSets[(y / 3) * 3 + x / 3] |= bitNumber(board[y][x])
                    rowSets[y] |= bitNumber(board[y][x])
                    columnSets[x] |= bitNumber(board[y][x])
                    let z = (gridSets[y / 3 + x / 3] | rowSets[y] | columnSets[x])
                    if z.nonzeroBitCount == 9 {
                        fatalError()
                    }
                } else {
                    arr.insert(Point(x: x, y: y))
                }
            }
        }
        
        let sortedArr = arr.sorted(by: { p1, p2 in
            let set1 = gridSets[p1.x / 3 + (p1.y / 3) * 3] | rowSets[p1.y] | columnSets[p1.x]
            let set2 = gridSets[p2.x / 3 + (p2.y / 3) * 3] | rowSets[p2.y] | columnSets[p2.x]
            var count1 = 0
            var count2 = 0
            
            for i in 0..<9 {
                if 1 << i & set1 != 0 {
                    count1 += 1
                }
                if 1 << i & set2 != 0 {
                    count2 += 1
                }
            }
            return count1 > count2
        })

        var isFinished = false
        func dfs(_ index: Int) {
            if index == arr.count {
                isFinished = true
                return
            }
            let x = sortedArr[index].x
            let y = sortedArr[index].y
            
            if board[y][x] == empty {
                let set = gridSets[x / 3 + (y / 3) * 3] | rowSets[y] | columnSets[x]
                var count = 0
                for i in 0..<9 where set & 1 << i == 0 {
                    count += 1
                    if !isFinished {
                        
                        board[y][x] = Character("\(i + 1)")
                        rowSets[y] |= 1 << i
                        columnSets[x] |= 1 << i
                        gridSets[(y / 3) * 3 + x / 3] |= 1 << i
                        dfs(index + 1)
                        if isFinished {
                            return
                        }
                        board[y][x] = empty
                        rowSets[y] &= 0xffff - 1 << i
                        columnSets[x] &= 0xffff - 1 << i
                        gridSets[(y / 3) * 3 + x / 3] &= 0xffff - 1 << i
                    }
                }
//                if count == 0 && board[y][x] != empty {
//                    dfs(index + 1)
//                }
            }
        }
        dfs(0)
    }
    
    func myPow(_ x: Double, _ n: Int) -> Double {
        var res: Double = 1.0
        var n = n
        if n < 0 {
            n = -n
        }
        var x = x
        while n != 0 {
            if n & 1 == 1 {
                res *= x
            }
            n >>= 1
            x *= x
        }
        return res
        
    }
    
    func findContinuousSequence(_ target: Int) -> [[Int]] {
        var res = [[Int]]()
        var i = 2
        while i < target {
            let sum = target + target
            if sum % i == 0 {
                let j = target / i
                let start = j - i / 2
                let end = start + i - 1
                if start > 0 && start + end == sum / i {
                    res.append([Int].init(start...end))
                } else if start + end + 2 == sum / i {
                    res.append([Int].init(start+1...end+1))
                }
            }
            i += 1
            if target / i - i / 2 < 0 {
                break
            }
        }
        return res
    }
    
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        var queue = [Int]()
        func enqueue(_ i: Int) {
            while let lastIndex = queue.last {
                if nums[lastIndex] >= nums[i] {
                    break
                } else {
                    queue.removeLast()
                }
            }
            queue.append(i)
        }
        var res: [Int] = []
        for i in 0..<nums.count {
            if i < k - 1 {
                enqueue(i)
            } else {
                enqueue(i)
                res.append(nums[queue.first!])
                if queue.first! == i - k + 1 {
                    queue.removeFirst()
                }
            }
        }
        return res
    }
    
    func constructArr(_ a: [Int]) -> [Int] {
        var res = [Int].init(repeating: 1, count: a.count)
        var left = 1
        for i in 0..<a.count {
            res[i] = left
            left = left * a[i]
        }
        var right = 1
        for i in stride(from: a.count - 1, through: 0, by: -1)  {
            res[i] *= right
            right *= a[i]
        }
        return res
    }
    
    func search(_ nums: [Int], _ target: Int) -> Int {

        enum ComparisonResult {
            case orderedSame, orderedDescending, orderedAscending
        }
        func binarySearch(_ left: Int, _ right: Int, _ comparator: (Int, Int) -> ComparisonResult) -> Int {
            var left = left, right = right
            while left < right {
                let mid = (left + right) / 2
                let compareResult = comparator(mid, target)
                switch compareResult {
                    case .orderedAscending:
                    left = mid + 1
                    case .orderedDescending:
                    right = mid - 1
                    case .orderedSame:
                    return mid
                }
            }
            return nums[left] == target ?  left : -1
        }
        let leftIndex = binarySearch(0, nums.count - 1) { (mid, target) -> ComparisonResult in
            if target == nums[mid] {
                if mid > 0 {
                    if target == nums[mid - 1] {
                        return .orderedDescending
                    } else {
                        return .orderedSame
                    }
                } else {
                    return .orderedSame
                }
            } else if target > nums[mid] {
                return .orderedAscending
            } else {
                return .orderedDescending
            }
        }
        guard leftIndex != -1 else {
            return 0
        }
        let rightIndex = binarySearch(leftIndex, nums.count - 1) { (mid, target) -> ComparisonResult in
            if target == nums[mid] {
                if mid < nums.count - 1 {
                    if target == nums[mid + 1] {
                        return .orderedAscending
                    } else {
                        return .orderedSame
                    }
                } else {
                    return .orderedSame
                }
            } else if target > nums[mid] {
                return .orderedAscending
            } else {
                return .orderedDescending
            }
        }
        return rightIndex - leftIndex  + 1
    }
    
    func replaceSpaces(_ S: String, _ length: Int) -> String {
        return String(S.prefix(length).replacingOccurrences(of: " ", with: "%20"))
    }
    
    func reverseWords(_ s: String) -> String {
        return s.components(separatedBy: " ").reversed().filter { return $0.count > 0 }.joined(separator: " ")
    }
    
    func missingNumber(_ nums: [Int]) -> Int {
        let N = nums.count
        var res = 0
        for i in 0...N {
            res ^= i
        }
        for i in nums {
            res ^= i
        }
        return res
    }
    
    func strToInt(_ str: String) -> Int {
        let set = Set<Character>("+-0123456789")
        var res = 0
        var sign = 0
        func zz() -> Int {
            if sign == 1 {
                return res > Int(Int32.max) ? Int(Int32.max) : res
            } else if sign == -1 {
                return res * sign < Int(Int32.min) ? Int(Int32.min) : res * sign
            }
            return 0
        }
        for c in str {
            if res > Int(Int32.max) {
                return zz()
            } else if !set.contains(c) {
                if (c == Character(" ") && sign == 0)  {
                                        
                } else {
                    return zz()
                }
            } else if c == Character("+") || c == Character("-") {
                if sign == 0 && res == 0 {
                    sign = c == Character("-") ? -1 : 1
 
                } else {
                    return zz()
                }
            }  else {
                sign = sign == 0 ? 1 : sign
                res = res * 10 + c.hexDigitValue!
            }
        }
        
        return zz()
    }
    
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        let length = words[0].count
        var start = 0
        let str = [Character].init(s)
        var all = [String: Int]()
        for word in words {
            all[word, default: 0] += 1
        }
        var cur = all
        var res = [Int]()
        while start + words.count * length <= s.count {
            for i in 0..<words.count {
                let curWord = String(str[start+(i * length)..<start+(i + 1)*length])
                if let count = cur[curWord] {
                    cur[curWord] = count - 1 == 0 ? nil : count - 1
                } else {
                    break
                }
                if cur.count == 0 {
                    res.append(start)
                }
            }
            start += 1
            cur = all
        }
        return res
    }
    
    func longestValidParentheses(_ s: String) -> Int {
        var stack = [Bool]()
        let left = Character("("), right = Character(")")
        var str = [Character].init(s)
        var count = 0
        for i in 0..<s.count {
            if str[i] == left {
                stack.append(true)
            } else {
                stack.append(false)
            }
            
        }
    }
}
