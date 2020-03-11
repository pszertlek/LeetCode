//
//  LCStack.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

class SolutionSort {
    func allCellsDistOrder(_ R: Int, _ C: Int, _ r0: Int, _ c0: Int) -> [[Int]] {
        var i = 1, z = max(R, C)
        var array = [[Int]]()
        array.append([r0,c0])
        let count = R * C
        while array.count < count {
            var a = i
            while a > 0 && a < z {
                print(array)
                print("\(r0 + a),\(c0 + i - a)")
                print("\(r0 - a),\(c0 + i - a)")
                print("\(r0 + a),\(c0 - i + a)")
                print("\(r0 - a),\(c0 - i + a)")

                if r0 + a < R && c0 + i - a < C {
                    let x1 = i - a + c0
                    let x2 = a - i + c0
                    if x1 != x2 {

                    }
                    if c0 + i - a < C {
                        array.append([r0 + a, c0 + i - a])
                    }
                }
                if r0 - a > 0 && c0 + i - a < C {
                    array.append([r0 - a, c0 + i - a])
                }
                if r0 + a < R && c0 - i + a > 0 {
                    array.append([r0 + a, c0 - i + a])
                }
                if r0 - a > 0 && c0 - i + a > 0 {
                    array.append([r0 - a, c0 - i + a])
                }
                a = a - 1
            }
            i = i + 1
        }
        return array
    }
    
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        
        
        var leftStack = [Int](), rightStack = [Int]()
        var leftIndex = Int.max, rightIndex = -1
        for left in 0..<nums.count {
            while let last = leftStack.last, nums[last] > nums[left] {
                leftIndex = min(leftIndex, last)
                leftStack.removeLast()
            }
            leftStack.append(left)
            
        }
        for right in stride(from: nums.count - 1, through: 0, by: -1) {
            while let last = rightStack.last, nums[last] < nums[right] {
                rightIndex = max(rightIndex, last)
                rightStack.removeLast()
            }
            rightStack.append(right)
        }
        return rightIndex - leftIndex > 0 ? rightIndex - leftIndex + 1 : 0
    }
    
    func findUnsortedSubarray1(_ nums: [Int]) -> Int {
        let sorts = nums.sorted()
        var leftIndex = nums.count
        var rightIndex = -1
        for i in 0..<nums.count {
            if sorts[i] != nums[i] {
                leftIndex = min(leftIndex, i)
                rightIndex = max(rightIndex, i)
            }
        }
        return (rightIndex - leftIndex >= 0 ? rightIndex - leftIndex + 1 : 0)
    }
    
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        var flowerbed = flowerbed
        var n = n
        for i in 0..<flowerbed.count {
            if (i == 0 || flowerbed[i - 1] == 0) && (i == flowerbed.count - 1 || flowerbed[i + 1] == 0 )  && flowerbed[i] != 1 {
                flowerbed[i] = 1
                n -= 1
            }
        }
        return n <= 0
    }
    
    func maximumProduct(_ nums: [Int]) -> Int {
        var min1 = Int.max, min2 = Int.max
        var max1 = Int.min, max2 = Int.min, max3 = Int.min
        for i in nums {
            if i < min1 {
                min2 = min1
                min1 = i
            } else if i < min2 {
                min2 = i
            }
            if i > max1 {
                max3 = max2
                max2 = max1
                max1 = i
            } else if i > max2 {
                max3 = max2
                max2 = i
            } else if i > max3 {
                max3 = i
            }
        }
        return max(max3 * max2 * max1, min1 * min2 * max1)
    }
    
    func imageSmoother(_ M: [[Int]]) -> [[Int]] {
        let height = M.count
        let width = M[0].count
        var result = [[Int]].init(repeating: [Int].init(repeating: 0, count: width), count: height)
        for h in 0..<height {
            for w in 0..<width {
                var count = 1
                var sum = M[h][w]
                if w > 0 {
                    sum += M[h][w - 1]
                    count += 1
                }
                if w < width - 1 {
                    sum += M[h][w + 1]
                    count += 1
                }

                if h > 0 {
                    sum += M[h - 1][w]
                    count += 1
                    if w > 0 {
                        sum += M[h - 1][w - 1]
                        count += 1
                    }
                    if w < width - 1 {
                        sum += M[h - 1][w + 1]
                        count += 1
                    }
                }
                if h < height - 1 {
                    sum += M[h + 1][w]
                    count += 1
                    if w > 0 {
                        sum += M[h + 1][w - 1]
                        count += 1
                    }
                    if w < width - 1 {
                        sum += M[h + 1][w + 1]
                        count += 1
                    }
                }
                result[h][w] = sum / count
            }
        }
        return result
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        while a % b != 0 {
            let t = a % b
            a = b
            b = t
        }
        return b
    }
    
    func hasGroupsSizeX(_ deck: [Int]) -> Bool {
        var dict = [Int: Int]()
        for i in deck {
            dict[i, default: 0] += 1
        }
        var res = dict.values.first!
        for i in dict.values {
            res = gcd(i, res)
        }
        return res != 1
    }
    
    func convert(_ s: String, _ numRows: Int) -> String {
        let s = [Character].init(s)
        var res = ""
        let zCount = numRows * 2 - 2
        for i in 0..<numRows {
            var cur = i
            while cur < s.count {
                res.append(s[cur])
                if cur + numRows + numRows - i * 2 - 2 < s.count && i != 0 && i != numRows - 1 {
                    res.append(s[cur + numRows + numRows - i * 2 - 2 ])
                }
                cur += zCount
            }
        }
        return res
    }
    
    func intToRoman(_ num: Int) -> String {
        var n = num
        var res = ""
        let dict = [1000:"M",
                    500:"D",
                    100:"C",
                    50:"L",
                    10:"X",
                    5:"V",
                    1:"I"]
        let arr = [1,5,10,50,100,500,1000]
        var i = 6
        while n != 0 {
            if n + (i >= 2 ? arr[i - 2] + arr[i - 1] : 0) >= arr[i] {
                var count = n / (i >= 2 ? arr[i - 2] : 1)
                while count != 0 {
                    if count == 4 {
                        res.append("\(dict[arr[i - 2]]!)\(dict[arr[i - 1]]!)")
                        count = 0
                    } else if count == 9 {
                        res.append("\(dict[arr[i - 2]]!)\(dict[arr[i]]!)")
                        count = 0
                    } else if count >= 10 {
                        for _ in 0..<count/10 {
                            res.append("\(dict[arr[i]]!)")
                        }
                        count = count % 10
                    } else if count >= 5{
                        res.append("\(dict[arr[i - 1]]!)")
                        count -= 5
                    } else {
                        for _ in 0..<count {
                            res.append("\(i >= 2 ? dict[arr[i - 2]]! : "I")")
                        }
                        count = 0
                    }
                }
                n = n % (i >= 2 ? arr[i - 2] : 1)
            } else {
                i -= 2
            }
        }
        return res
    }
    
    func letterCombinations(_ digits: String) -> [String] {
        var res = [""]
        let dict = [2:"abc",3:"def",4:"ghi",5:"jkl",6:"mno",7:"pqrs",8:"tuv",9:"wxyz"]
        for str in digits {
            var next = [String]()

            for c in dict[str.hexDigitValue!]! {
                for s in res {
                    next.append("\(s)\(c)")
                }
            }
            res = next

        }
        return res
    }
    
    func nextPermutation(_ nums: inout [Int]) {
        var index = -1
        for i in stride(from: nums.count - 2, through: 0, by: -1) {
            if nums[i + 1] > nums[i] {
                index = i
                break
            }
        }
        if index >= 0 {
            var j = nums.count - 1
            while j >= 0 && nums[j] <= nums[index] {
                j -= 1
            }
            nums.swapAt(index, j)
        }
        
        var i = index + 1, j = nums.count - 1
        while i < j {
            nums.swapAt(i, j)
            i += 1
            j -= 1
        }
    }
    
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 0 else {
            return []
        }
        guard matrix[0].count > 0 else {
            return []
        }
        var r1 = 0, c1 = 0, c2 = matrix[0].count - 1, r2 = matrix.count - 1
        var res = [Int]()
        while r1 <= r2 && c1 <= c2 {
            var c = c1
            while c <= c2 {
                res.append(matrix[r1][c])
                c += 1
            }
            var r = r1 + 1
            while r <= r2 {
                res.append(matrix[r][c2])
                r += 1
            }
            if r1 < r2 && c1 < c2 {
                var c = c2 - 1
                while c > c1 {
                    res.append(matrix[r2][c])
                    c -= 1
                }
                var r = r2
                while r > r1 {
                    res.append(matrix[r][c1])
                    r -= 1
                }
            }
            r1 += 1 ;
            r2 -= 1
            c1 += 1
            c2 -= 1
        }
        return res
    }
    
    func convertToTitle(_ n: Int) -> String {
        var num = n - 1
        var result = [Character].init()
        let aCode = Character("A").asciiValue!
        while num >= 0 {
            let left = num % 26
            num = num / 26 - 1
            result.append(Character.init(Unicode.Scalar.init(left + Int(aCode))!))
        }
        return String(result.reversed())
    }
    
    func titleToNumber(_ s: String) -> Int {
        var res = 0
        let aCode = Character("A").asciiValue!
        for c in s {
            res = Int(c.asciiValue! - aCode + 1) + 26 * res
        }
        return res
    }
    
    func trailingZeroes(_ n: Int) -> Int {
        var i = 0
        var n = n
        while n != 0 {
            n = n / 5
            i = i + n
        }
        return i
    }
    
    func sumEvenAfterQueries(_ A: [Int], _ queries: [[Int]]) -> [Int] {
        var answers = [Int].init(repeating: 0, count: queries.count)
        var A = A
        var sum = A.reduce(0) { (r, i) -> Int in
            if i % 2 == 0 {
                return r + i
            } else {
                return r
            }
        }
        for (index,i) in queries.enumerated() {
            if A[i[1]] % 2 != 0 {
                if (i[0] + A[i[1]]) % 2 == 0 {
                    sum += i[0] + A[i[1]]
                }
            } else {
                if (i[0] + A[i[1]]) % 2 == 0 {
                    sum += i[0]
                } else {
                    sum -= A[i[1]]
                }
            }
            answers[index] = sum
            A[i[1]] = A[i[1]] + i[0]
        }
        return answers
    }
    
    func addToArrayForm(_ A: [Int], _ K: Int) -> [Int] {
        var j = 0
        var k = K
        var res = A
        var i = A.count - 1
        while i >= 0 || k != 0{
            let cur = k % 10 + j
            if i >= 0 {
                if A[i] + cur > 9 {
                    res[i] = (res[i] + cur) % 10
                    j = 1
                } else {
                    res[i] = res[i] + cur
                    j = 0
                }
            } else {
                if cur > 9 {
                    j = 1
                } else {
                    j = 0
                }
                res.insert(cur % 10, at: 0)
            }
            k /= 10
            i -= 1
        }
        if j == 1 {
            res.insert(1, at: 0)
        }
        return res
    }
    
    func majorityElement(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return -1
        }
        var res = nums[0]
        var num = 0
        for i in 0..<nums.count {
            if res == nums[i] {
                num += 1
            } else {
                num -= 1
            }
            if num < 0 {
                num = 0
                res = nums[i]
            }
        }
        num = 0
        for i in nums {
            if i == res {
                num += 1
            }
        }
        return num > nums.count / 2 ? num : -1
    }
    
    func merge(_ A: inout [Int], _ m: Int, _ B: [Int], _ n: Int) {
        var m = m
        var n = n
        while n > 0 {
            if A[m - 1] >= B[n - 1] {
                A[m + n - 1] = A[m - 1]
                m -= 1
            } else {
                A[m + n - 1] = B[n - 1]
                n -= 1
            }
        }
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        var res = nums[0]
        var sum = nums[0]
        for i in nums[1..<nums.count] {
            if sum + i > i {
                sum += i
            } else {
                sum = i
            }
            res = max(res, sum)
        }
        return res
    }
    
    func balancedStringSplit(_ s: String) -> Int {
        let R = Character("R")
        var value = 0
        var res = 0
        for c in s {
            if c == R {
                value += 1
            } else {
                value -= 1
            }
            if value == 0 {
                res += 1
            }
        }
        return res
    }
    
    func jump(_ nums: [Int]) -> Int {
        var i = 0
        var dp = [Int].init(repeating: Int.max, count: nums.count)
        dp[0] = 0
        var maxN = 0
        while i < nums.count {
            var j = maxN - i
            while j <= nums[i] {
                if i + j < nums.count {
                    dp[i + j] = min(dp[i] + 1, dp[i + j])
                } else {
                    break
                }
                j += 1
                maxN = max(maxN, i + j)
            }
            i += 1
        }
        return dp.last!
    }
    
    func jump1(_ nums: [Int]) -> Int {
        var steps = 0
        var maxPosition = 0
        var end = 0
        for i in 0..<nums.count-1 {
            maxPosition = max(maxPosition, nums[i] + i)
            if i == end {
                end = maxPosition
                steps += 1
            }
        }
        return steps
    }
    
    func candy(_ ratings: [Int]) -> Int {
        guard ratings.count > 1 else {
            return 1
        }
        var stack = [Int]()
        var res = [Int].init(repeating: 0, count: ratings.count)
        var total = 0
        for i in 0..<ratings.count {
            if let last = stack.last {
                if ratings[last] > ratings[i] {
                    stack.append(i)
                } else {
                    var c = 1
                    while let index = stack.popLast() {
                        if stack.count == 0 {
                            c = max(c,index >= 1 && ratings[index] > ratings[index - 1] ? res[index - 1] + 1 : c)
                        }
                        total += c
                        res[index] = c
                        c += 1
                    }

                    stack.append(i)
                }
            } else {
                stack.append(i)
            }
        }
        var c = 1
        while let index = stack.popLast() {
            if stack.count == 0 {
                c = max(c,index >= 1 && ratings[index] > ratings[index - 1] ? res[index - 1] + 1 : c)
            }
            total += c
            res[index] = c
            c += 1
        }
        return total
    }
    
    func candy1(_ ratings: [Int]) -> Int {
        var leftArr = [Int].init(repeating: 1, count: ratings.count)
        var rightArr = leftArr
        for i in 0..<ratings.count-1 {
            if ratings[i + 1] > ratings[i] {
                leftArr[i + 1] = leftArr[i] + 1
            }
        }
        
        for i in stride(from: ratings.count - 1, through: 1, by: -1) {
            if ratings[i] < ratings[i - 1] {
                rightArr[i - 1] = rightArr[i] + 1
            }
        }
        var sum = 0
        for i in 0..<ratings.count {
            sum += max(leftArr[i], rightArr[i])
        }
        return sum
    }
    
    func minSwapsCouples(_ row: [Int]) -> Int {
        var ans = 0
        var row = row
        for i in stride(from: 0, to: row.count, by: 2) {
            let x = row[i]
            if row[i + 1] == x ^ 1 {
                continue
            }
            ans += 1
            var j = i + 1
            while j < row.count {
                if row[j] == x ^ 1 {
                    row[j] = row[i + 1]
                    row[i + 1] = x ^ 1
                    break
                }
                j += 1
            }
            
        }
        return ans
    }
    
    func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
        var heap = Heap<Int>.init(sort: >)
        for i in arr {
            heap.insert(i)
            if heap.count > k {
                heap.remove()
            }
        }
        return heap.nodes
    }
    
//    func diffWaysToCompute(_ input: String) -> [Int] {
//        var nums = [Int]()
//        var symbols = [Character]()
//        var numStr = ""
//        let plus = Character("+")
//        let minus = Character("-")
//        let multiple = Character("*")
//        for c in input {
//            if c.isNumber {
//                numStr.append(c)
//            } else {
//                nums.append(Int(numStr)!)
//                symbols.append(c)
//            }
//        }
//        var result = [Int]()
//        func zzz(_ start: Int) -> [Int] {
//            if start > symbols.count {
//                return []
//            }
//        }
//    }
    
    func smallestK(_ arr: [Int], _ k: Int) -> [Int] {
        
        var heap = Heap<Int>.init(sort: >)
        var i = 0
        while i < k {
            heap.insert(arr[i])
            i += 1
        }
        while i < arr.count {
            if let peek = heap.peek(), peek > arr[i] {
                heap.insert(arr[i])
                heap.remove()
            }
            i += 1
        }
        return heap.sort()
    }
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0 else {
            return false
        }
        let width = matrix[0].count
        let height = matrix.count
        var i = 0
        var j = height - 1
        while i < width && j >= 0 {
            if matrix[j][i] == target {
                return true
            } else if matrix[j][i] < target {
                i += 1
            } else {
                j -= 1
            }
        }
        return false
    }
    
    func readBinaryWatch(_ num: Int) -> [String] {
        var result = [(Int, Int)]()
        func zz(_ n: Int, _ i: Int, _ hour: Int, _ minute: Int){
            var hour = hour
            var minute = minute
            if i + n > 10 {
                return
            }
            if n == 0 {
                result.append((hour,minute))
                return
            }
            zz(n, i + 1, hour, minute)

            if i == 0 {
                hour += 8
            } else if i == 1 {
                hour += 4
            } else if i == 2 {
                hour += 2
            } else if i == 3 {
                hour += 1
            } else if i == 4 {
                minute += 32
            } else if i == 5 {
                minute += 16
            } else if i == 6 {
                minute += 8
            } else if i == 7 {
                minute += 4
            } else if i == 8 {
                minute += 2
            } else if i == 9 {
                minute += 1
            }
            if hour > 11 || minute > 59 {
                return
            }
            zz(n - 1, i + 1, hour, minute)
        }
        zz(num, 0, 0, 0)
        var res = [String]()
        for time in result {
            res.append("\(time.0):\(time.1 > 9 ?"":"0")\(time.1)")
        }
        return res
    }
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        func zzz(_ i: Int, _ sum: Int,_ aa: [Int]) {
            if sum < target {
                var i = i
                while i < candidates.count {
                    var bb = aa
                    bb.append(candidates[i])
                    zzz(i, sum + candidates[i], bb)

                    i += 1
                }
            } else if sum == target {
                result.append(aa)
            }
        }
        zzz(0, 0, [])
        return result
    }
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        let arr = candidates.sorted()
        func zzz(_ i: Int, _ sum: Int, _ aa:[Int]) {
            if sum < target {
                var i = i + 1
                while i < arr.count {
                    var bb = aa
                    bb.append(arr[i])
                    zzz(i, sum + arr[i], bb)
                    i += 1
                }
            } else if sum == target {
                if let last = result.last {
                    if last != aa {
                        result.append(aa)
                    }
                } else {
                    result.append(aa)
                }
            }
        }
        zzz(-1, 0, [])
        return [[Int]].init(result)
    }
    
    func combinationSum22(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let sort = candidates.sorted(by: <)
        
        var res = [[Int]]()
        var path = [Int]()
        
        dfs(sort, target, 0, &path, &res)
        return res
    }
    
     func dfs(_ candidates: [Int],_ target: Int, _ start: Int, _ path: inout [Int],_ res: inout [[Int]]) {
        if target == 0 {
            res.append(path)
            return
        }
        
        for index in start..<candidates.count {
            let residue = target - candidates[index]
            if residue < 0 {
                break
            }
            if index > start && candidates[index - 1] == candidates[index] {
                continue
            }
            path.append(candidates[index])
            dfs(candidates, residue, index + 1, &path, &res)
            path.removeLast()
        }
    }

    func permute(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let n = nums.count
        func backtrack(_ first: Int, _ nums: [Int]) {
            if first == n {
                result.append(nums)
                return
            }
            for i in first..<n {
                var curNums = nums
                curNums.swapAt(first, i)
                backtrack(first + 1, curNums)
            }
        }
        backtrack(0, nums)
        return result
    }
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let n = nums.count
        func backtrack(_ first: Int, _ nums: [Int]) {
            if first == n {
                result.append(nums)
            }
            var used = Set<Int>()
            for i in first..<n {
                if i != first && nums[i] == nums[first] || used.contains(nums[i]) {
                    continue
                }
            
                var curNums = nums
                curNums.swapAt(first, i)
                used.insert(nums[i])
                backtrack(first + 1, curNums)

            }
        }
        backtrack(0, nums)
        return result
    }
    
    func permutation(_ S: String) -> [String] {
        var result = [String]()
        let ss = [Character](S)
        let n = S.count
        func backTrack(_ start: Int, _ str: [Character]) {
            if start == n {
                result.append(String(str))
                return
            }
            var set = Set<Character>()
            for i in start..<n {
                if i != start && ss[start] == ss[i] || set.contains(ss[i]){
                    continue
                }
                var curStr = str
                curStr.swapAt(i, start)
                set.insert(str[i])
                backTrack(start + 1, curStr)
            }
        }
        backTrack(0, ss)
        return result
    }
    
    func numTilePossibilities(_ tiles: String) -> Int {
        var counter = [Int].init(repeating: 0, count: 26)
        var tilesCount = 0
        for c in tiles {
            counter[Int(c.asciiValue! - Character("A").asciiValue!)] += 1
            tilesCount += 1
        }
        var total = 0
        var res = 0
        func dfs() -> Int {
            var res = 0
            for i in 0..<26 {
                if counter[i] == 0 {
                    continue
                }
                res += 1
                counter[i] -= 1
                res += dfs()
                counter[i] += 1
            }
            return res
        }

        
        return dfs()
    }
    
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        guard (19 - k) * k / 2 >= n else {
            return []
        }
        var result = [[Int]]()
        func backtrack(_ nums: [Int], _ nn: Int,_ kk: Int, _ start: Int) {
            if (kk > 0 && (start > nn || start > 9)) || ( kk == 0 && nn > 0) || nn < 0 {
                return
            }
            if nn == 0 && kk == 0 {
                result.append(nums)
                return
            }
            let zz = nn >= 9 ? 9 : nn

            for i in start...zz {
                var curNums = nums
                curNums.append(i)
                backtrack(curNums, nn - i, kk - 1, i + 1)
            }
            
        }
        backtrack([], n, k, 1)
        return result
    }
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var res = [[Int]]()
        func backtrack(_ start: Int, _ kk: Int, _ nums:[Int]) {
            if n - start + 1 < kk {
                return
            }
            if kk == 0 {
                res.append(nums)
                return
            }
            for i in start...n {
                var curNums = nums
                curNums.append(i)
                backtrack(i + 1, kk - 1, curNums)
            }
        }
        backtrack(1, k, [])
        return res
    }

    func subsets(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        var n = nums.count
        func backtrack(_ start: Int,_ kk:Int, _ arr: [Int]) {
            if n - start + 1 < kk {
                return
            }
            if kk == 0 {
                res.append(arr)
                return
            }
            for i in start..<n {
                var curNums = arr
                curNums.append(nums[i])
                backtrack(i + 1, kk - 1, curNums)
            }
        }
        for i in 0...n {
            backtrack(0, i, [])
        }
        return res
    }
    
    
    func partition(_ s: String) -> [[String]] {
        var s = [Character].init(s)
        var dict = [ClosedRange<Int>: Bool]()
        let N = s.count
        func ispalindrome(_ range: ClosedRange<Int>) -> Bool {
            
            if let palindrome = dict[range] {
                return palindrome
            } else {
                let lowerBound = range.lowerBound
                let upperBound = range.upperBound
                if lowerBound == upperBound {
                    dict[range] = true
                    return true
                } else if lowerBound + 1 == upperBound {
                    let palindrome = s[lowerBound] == s[upperBound]
                    dict[range] = palindrome
                    return palindrome
                } else {
                    let palindrome = s[lowerBound] == s[upperBound]
                    let supperPalindrome = ispalindrome(lowerBound+1...upperBound-1)
                    dict[range] = palindrome && supperPalindrome
                    return  palindrome && supperPalindrome
                }
            }
        }
        var result = [[String]]()
        func backtrack(_ start: Int, strs: [String]) {
            if start == N {
                result.append(strs)
            }
            for i in start..<N {
                if ispalindrome(start...i) {
                    var curStrs = strs
                    curStrs.append(String(s[start...i]))
                    backtrack(i + 1, strs: curStrs)
                }
            }
        }
        backtrack(0, strs: [])
        return result
    }
    
    func partition1(_ s: String) -> [[String]] {
        var s = [Character].init(s)
        let N = s.count
        var dp = [[Bool]].init(repeating: [Bool].init(repeating: false, count: N), count: N)
        for i in 0..<N {
            dp[i][i] = true
        }
        for i in 0..<N - 1 {
            dp[i][i + 1] = s[i] == s[i + 1]
        }
        var len = 3
        while len <= N {
            var i = 0
            while i <= N - len {
                let j = i + len - 1
                if s[i] == s[j] && dp[i + 1][j - 1] {
                    dp[i][j] = true
                }
                i += 1
            }
            len += 1
        }
        var result = [[String]]()
        func backtrack(_ start: Int, strs: [String]) {
            if start == N {
                result.append(strs)
            }
            for i in start..<N {
                if dp[start][i] {
                    var curStrs = strs
                    curStrs.append(String(s[start...i]))
                    backtrack(i + 1, strs: curStrs)
                }
            }
        }
        backtrack(0, strs: [])
        return result
    }

    
    func getMaximumGold(_ grid: [[Int]]) -> Int {
        var res = 0
        var i = 0
        let width = grid[0].count, height = grid.count
        
        func backtrack(_ x:Int, _ y: Int, _ used: inout [[Bool]], _ value: Int) {
            var end = true
            used[y][x] = true

            if x + 1 < width && grid[y][x + 1] != 0 && !used[y][x + 1]{
                backtrack(x + 1, y, &used, value + grid[y][x + 1])
                end = false
            }
            if x - 1 >= 0 && grid[y][x - 1] != 0 && !used[y][x - 1] {
                backtrack(x - 1, y, &used, value + grid[y][x - 1])
                end = false
            }
            if y + 1 < height && grid[y + 1][x] != 0 && !used[y + 1][x] {
                backtrack(x, y + 1, &used, value + grid[y + 1][x])
                end = false
            }
            if y - 1 >= 0 && grid[y - 1][x] != 0 && !used[y - 1][x] {
                backtrack(x, y - 1, &used, value + grid[y - 1][x])
                end = false

            }
            used[y][x] = false
            if end {
                res = max(value, res)
            }
        }
        var used = [[Bool]].init(repeating: [Bool].init(repeating: false, count: width), count: height)
        for y in 0..<height {
            for x in 0..<width {
                backtrack(x, y, &used, 0)
            }
        }
        return res
    }
    

    func shortestSubarray(_ A: [Int], _ K: Int) -> Int {
        var res = Int.max
        var left = 0, right = 0
        var sum = A[0]
        while right < A.count {
            if sum >= K {
                res = min(right - left + 1, res)
                sum -= A[left]
                left += 1
            } else {
                if sum > 0 {
                    right += 1
                    if right < A.count {
                        sum += A[right]
                    } else {
                        break
                    }
                } else {
                    right += 1
                    left = right
                    if right < A.count {
                        sum = A[right]
                    }
                }
            }
            while A[left] <= 0 {
                left += 1
            }
            if right < left {
                right = left
            }
        }
        
        return res > A.count ? -1 : res
    }
    
    func partition2(_ s: String) -> [[String]] {
        let ss = [Character].init(s)
        let N = s.count
        var dp = [[Bool]].init(repeating: [Bool].init(repeating: false, count: N), count: N)
        for i in 0..<N {
            for j in 0..<N {
                if i == 0 {
                    dp[j][j] = true
                } else if i == 1 && j + 1 < N {
                    dp[j][j + 1] = ss[j + 1] == ss[j]
                } else if j + i < N {
                    if ss[j] == ss[j + i] && dp[j + 1][j + i - 1] {
                        dp[j][j + i] = true
                    }
                }
            }
        }
        var res = [[String]]()
        func backtrack(_ start: Int, _ strs: [String]) {
            if start == N {
                res.append(strs)
                return
            }
            for i in start..<N {
                if dp[start][i] {
                    var newStrs = strs
                    newStrs.append(String(ss[start...i]))
                    backtrack(i + 1, newStrs)
                }
            }
        }
        backtrack(0, [])
        return res
    }
    
    func setZeroes(_ matrix: inout [[Int]]) {
        let width = matrix[0].count
        let height = matrix.count
        var rows = Set<Int>()
        var column = Set<Int>()
        for i in 0..<width {
            for j in 0..<height {
                if matrix[j][i] == 0 {
                    rows.insert(i)
                    column.insert(j)
                    
                }
            }
        }
        for i in 0..<width {
            for j in column {
                matrix[j][i] = 0
            }
        }
        for i in rows {
            for j in 0..<height {
                matrix[j][i] = 0
            }
        }
    }
    
    func setZeros1(_ matrix: inout [[Int]]) {
        var isCol = false
        var R = matrix.count
        var C = matrix[0].count
        for i in 0..<R {
            if matrix[i][0] == 0 {
                isCol = true
            }
            
            for j in 1..<C {
                if matrix[i][j] == 0 {
                    matrix[0][j] = 0
                    matrix[i][0] = 0
                }
            }
        }
        for i in 1..<R {
            for j in 1..<C {
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        if matrix[0][0] == 0 {
            for i in 0..<C {
                matrix[0][i] = 0
            }
        }
        if isCol {
            for i in 0..<R {
                 matrix[i][0] = 0
            }
        }
    }
    
    func searchMatrix1(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0 else {
            return false
        }
        let width = matrix[0].count
        let height = matrix.count
        var left = 0, right = height - 1, mid = (left + right) / 2
        while left < right {
            if target >= matrix[mid][0] && target <= matrix[mid][width - 1] {
                break
            } else if target < matrix[mid][0] {
                right = mid - 1
            } else {
                left = mid + 1
            }
            mid = (left + right) / 2
        }
        guard matrix[0].count > 0 else {
            return false
        }
        mid = (left + right) / 2
        left = 0
        right = width - 1
        var center = 0
        while left < right {
            if target == matrix[mid][center] {
                return true
            } else if target > matrix[mid][center] {
                left = center + 1
            } else {
                right = center - 1
            }
            center = (left + right) / 2
        }
        return target == matrix[mid][center]
    }
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard board.count > 0 && board[0].count > 0 else {
            return false
        }
        let wordword = [Character].init(word)
        let width = board[0].count
        let height = board.count
        let N = word.count
        var visited = [[Bool]].init(repeating: [Bool].init(repeating: false, count: width), count: height)
        func backtrack(_ x: Int, _ y: Int, _ n: Int) -> Bool {
            visited[y][x] = true
            if board[y][x] != wordword[n] {
                visited[y][x] = false
                return false
            } else if n == N - 1 {
                visited[y][x] = false
                return true
            }
            var res = false
            if x - 1 >= 0 && !visited[y][x - 1] {
                res = backtrack(x - 1, y, n + 1)
            }
            if !res && x + 1 < width && !visited[y][x + 1] {
                res = backtrack(x + 1, y, n + 1)
            }
            if !res && y + 1 < height && !visited[y + 1][x] {
                res = backtrack(x, y + 1, n + 1)
            }
            if !res && y - 1 >= 0 && !visited[y - 1][x] {
                res = backtrack(x, y - 1, n + 1)
            }
            visited[y][x] = false
            return res
        }
        for i in 0..<width {
            for j in 0..<height {
                if backtrack(i, j, 0) {
                    return true
                }
            }
        }
        return false
    }
    
    func search(_ nums: [Int], _ target: Int) -> Bool {
        guard nums.count > 0 else {
            return false
        }
        var left = 0
        let N = nums.count
        var right = N - 1
        var cur = nums[0]
        var index = 0
        for i in 1..<N {
            if cur > nums[i] {
                index = i
                break
            }
            cur = nums[i]
        }
        if nums[index] <= target && nums[N - 1] >= target {
            left = index
            right = N - 1
        } else {
            left = 0
            right = index - 1
        }
        while left <= right {
            let mid = (left + right) / 2
            if target == nums[mid] {
                return true
            } else if target > nums[mid] {
                left = mid + 1
            } else {
                right = mid - 1
            }

        }
        return false
    }
    
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var res: ListNode? = nil
        let start:ListNode? = ListNode(0)
        start?.next = head
        var node = start
        while node != nil {
            var next = node?.next
            if let theNext = next?.next, next!.val == theNext.val {
                let val = theNext.val
                next = theNext.next
                while let theNext = next , theNext.val == val {
                    next = theNext.next
                }
                node?.next = next
            } else if res == nil {
                res = node
            } else {
                node = node?.next
            }
        }
        
        return start!.next
    }
    
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var dict = [Int: Int]()
        for i in nums {
            dict[i, default: 0] += 1
        }
        var allNum = dict.keys.sorted()
        var res = [[Int]]()
        res.append([])
        let N = allNum.count
        func backtrack(_ start: Int, _ numbers: [Int]) {
            if start == N {
                return
            }
            if dict[allNum[start], default: 0] > 0 {
                var newNumbers = numbers
                newNumbers.append(allNum[start])
                dict[allNum[start], default: 0] -= 1
                res.append(newNumbers)
                backtrack(start,newNumbers)
                dict[allNum[start], default: 0] += 1
            }
            backtrack(start + 1, numbers)
        }
        backtrack(0, [])
        return res
    }
    

    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) {
        var stop = false
        var left = head
        
        func reverseAndReverse(_ right: ListNode?, _ m: Int, _ n: Int) {
            guard n > 1 else {
                return
            }
            let r = right?.next
            if m > 1 {
                left = left?.next
            }
            reverseAndReverse(r, m - 1, n - 1)
            if left === r || r?.next === left {
                stop = true
            }
            if !stop {
                let val = left!.val
                left!.val = r!.val
                r!.val = val
                left = left?.next
            }
        }
        reverseAndReverse(head, m, n)
    }
    
//    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
//        var L = beginWord.count
//        var allComboDict = [String:[String]]()
//        wordList.forEach { (word) in
//            for i in 0..<L {
//                _ = String(word[0..<i]) + "*" + String(word[i+1..<L])
//
//             }
//        }
//     }
    
    func solve(_ board: inout [[Character]]) {
        let H = board.count
        guard H > 0 && board[0].count > 0 else {
            return
        }
        let W = board[0].count
        guard W >= 3 && H >= 3 else {
            return
        }
        let X = Character("X")
        var visited = [Bool].init(repeating: false, count: W * H)
        var needChange = true
        var array = [(Int, Int)]()
        func travel(_ i: Int, _ j: Int) {
            let index = i * W + j
            visited[index] = true
            print("\(i) ,\(j)")
            if board[i][j] != X {
                array.append((i,j))
                var x = i + 1
                var y = j
                
                if x < H - 1  {
                    if !visited[x * W + y] {
                        travel(x, y)
                    }
                } else {
                    if board[x][y] != X {
                        needChange = false
                    }
                }
                x = i - 1
                if x > 0  {
                    if !visited[x * W + y] {
                        travel(x, y)
                    }
                } else {
                    if board[x][y] != X {
                        needChange = false
                    }
                }
                x = i
                y = j + 1
                if y < W - 1 {
                    if !visited[x * W + y] {
                        travel(x, y)
                    }
                } else {
                    if board[x][y] != X {
                        needChange = false
                    }
                }
                y = j - 1
                if y > 0 {
                    if !visited[x * W + y] {
                        travel(x, y)
                    }
                } else {
                    if board[x][y] != X {
                        needChange = false
                    }
                }
            }
        }
        for i in 1..<H-1 {
            for j in 1..<W-1 {
                let index = i * W + j
                if i == 3 && j == 3 {
                    print(i)
                }
                if !visited[index] {
                    travel(i, j)
                    if needChange {
                        for p in array {
                            board[p.0][p.1] = X
                        }
                    }
                    array.removeAll()
                }
                needChange = true
            }
        }
    }
    
    
    func maxSumDivThree(_ nums: [Int]) -> Int {
        var dp: [[Int]] = [[Int]].init(repeating: [Int].init(repeating: 0, count: 3), count: nums.count + 1)
        dp[0][1] = Int.min
        dp[0][2] = Int.min
        for i in 1...nums.count {
            let y = nums[i - 1] % 3
            if y == 0 {
                            dp[i][0] = max(dp[i - 1][0], dp[i - 1][0] + nums[i - 1]);
                            dp[i][1] = max(dp[i - 1][1], dp[i - 1][1] + nums[i - 1]);
                            dp[i][2] = max(dp[i - 1][2], dp[i - 1][2] + nums[i - 1]);
            } else if y == 1 {
                            dp[i][0] = max(dp[i - 1][0], dp[i - 1][2] + nums[i - 1]);
                            dp[i][1] = max(dp[i - 1][1], dp[i - 1][0] + nums[i - 1]);
                            dp[i][2] = max(dp[i - 1][2], dp[i - 1][1] + nums[i - 1])


            } else {
                            dp[i][0] = max(dp[i - 1][0], dp[i - 1][1] + nums[i - 1]);
                            dp[i][1] = max(dp[i - 1][1], dp[i - 1][2] + nums[i - 1]);
                            dp[i][2] = max(dp[i - 1][2], dp[i - 1][0] + nums[i - 1]);

     
            }
        }
        return dp[nums.count][0]
        
        
    }
    
    func quickSort(_ arr: inout [Int], _ low: Int, _ high: Int) {
        
        func partation(_ low: Int, _high: Int) {
            var tmp = arr[low]
            var low = low, high = high
            while low < high {
                while low < high && arr[high] >= tmp {
                    high -= 1
                }
                arr[low] = arr[high]
                while low < high && arr[low] <= tmp {
                    
                }
            }
        }
        if low < high {
            
        }
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        let N = prices.count
        var dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: 3), count: N )
        dp[0][0] = 0//不持股
        dp[0][1] = -1000000//持股
        dp[0][2] = 0//冷冻期
        for i in 1..<N {
            dp[i][0] = max(dp[i - 1][0], dp[i - 1][1] + prices[i])
            dp[i][1] = max(dp[i - 1][1], dp[i - 1][2] - prices[i])
            dp[i][2] = dp[i - 1][0]
        }
        return max(dp[N - 1][0], dp[N - 1][2])
    }
}

