//
//  MediumSolution.swift
//  DynamicPlaning
//
//  Created by apple on 2019/7/24.
//  Copyright © 2019 Pszertlek.com.cn. All rights reserved.
//

import Foundation

public class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

class Xielv:Hashable {
    var y: Int
    var x: Int
    init(_ x: Int, _ y: Int) {
        var a = x, b = y
        while b != 0 {
            let temp = a % b
            a = b
            b = temp
        }
        
        
        let zzz = a
        self.x = x / zzz
        self.y = y / zzz
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        while b != 0 {
            let temp = a % b
            a = b
            b = temp
        }
        return a
    }
    static func == (lhs: Xielv, rhs: Xielv) -> Bool {
        return lhs.y * rhs.x == lhs.x * rhs.y
    }
    
    var hashValue: Int {
        return self.x * self.y
    }

    func hash(into hasher: inout Hasher) {
        
    }

    
}

class Solution {
    func isMajorityElement(_ nums: [Int], _ target: Int) -> Bool {
        guard nums.count > 1 else {
            return nums[0] == target
        }
        guard nums.count > 2 else {
            return nums[0] == nums[1]
        }
        var left = 0
        var right = nums.count / 2 - 1
        var mid = 0
        if nums[nums.count / 2] != target  || nums[nums.count / 2 - 1] != target {
            return false
        }
        while left < right {
            mid = (left + right) / 2
            if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid
            }
        }
        let i = nums[right] == target ? right : right - 1
        left = nums.count / 2
        right = nums.count - 1

        while left < right {
            mid = (left + right) / 2
            if nums[mid] > target {
                right = mid
            } else {
                left = mid + 1
            }
        }
        let j = nums[right] == target ? right : right - 1
        return (j - i + 1) > nums.count / 2
    }
    
    func function1(_ x: Int, _ y: Int) -> Int {
        return x + y
    }
    func function2(_ x: Int, _ y: Int) -> Int {
        return x * y
    }
    
    
    func findSolution(_ z: Int,_ function: (Int,Int) -> Int) -> [[Int]] {
        var result = [[Int]]()
        var maxX = 1
        var maxY = 1
        while function(maxX,1) <= z {
            maxX += 1
        }
        maxX -= 1
        while function(1,maxY) <= z {
            maxY += 1
        }
        maxY -= 1
        var maxRight = maxY
        for x in 1...maxX {
            var left = 1
            var right = maxRight
            while left <= right {
                let mid = (left + right) / 2
                let r = function(x,mid)
                if r == z {
                    result.append([x, mid])
                    maxRight = mid - 1
                    break
                } else if r < z {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }
        return result
    }
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        guard nums.count >= 4 else {
            return []
        }
        let nums = nums.sorted()
        var result = [[Int]]()
        var dict = [Int: Int]()
        for i in nums {
            dict[i] = (dict[i] ?? 0) + 1
        }
        func twoSum(_ target: Int, _ start: Int) -> [[Int]] {
            var i = start
            var result = [[Int]]()
            var duplicate = Set<Int>()
            while i < nums.count {
                if duplicate.contains(nums[i]) {
                    i += 1
                    continue
                }
                let curTarget = target - nums[i]
                if let count =  dict[curTarget],count >= 1 {
                    if curTarget == nums[i] {
                        if count >= 2 {
                            duplicate.insert(nums[i])

                            duplicate.insert(curTarget)
                            result.append([nums[i],curTarget])
                        }
                    } else {
                        duplicate.insert(nums[i])
                        duplicate.insert(curTarget)

                        result.append([nums[i],curTarget])
                    }
                }
                i += 1
            }
            return result
                
        }

        var duplicateFirst = Set<Int>()
        var duplicateSecond = Set<Int>()
        for i in 0...nums.count - 4 {
            dict[nums[i]] = dict[nums[i]]! - 1
            if duplicateFirst.contains(nums[i]) {
                continue
            }
            duplicateFirst.insert(nums[i])
            var j = i + 1
            duplicateSecond.removeAll()
            while j <= nums.count - 3 {
                dict[nums[j]] = dict[nums[j]]! - 1
                if duplicateSecond.contains(nums[j]) {
                    j += 1
                    continue
                }
                duplicateSecond.insert(nums[j])
                let arr = twoSum(target - nums[i] - nums[j], j + 1)
                for r in arr {
                    result.append([nums[i],nums[j],r[0],r[1]])
                }
                j += 1
            }
            j = i + 1
            while j <= nums.count - 3 {
                dict[nums[j]] = dict[nums[j]]! + 1
                j += 1
            }
            
        }
        return result
    }
    
    //时间复杂度过高
    func fourSumCount(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        var dictA = [Int: Int]()
        for i in A {
            dictA[i] = (dictA[i] ?? 0) + 1
        }
        let A = dictA.keys.sorted()
        var dictB = [Int: Int]()
        for i in B {
            dictB[i] = (dictB[i] ?? 0) + 1
        }
        let B = dictB.keys.sorted()
        var dictC = [Int: Int]()
        for i in C {
            dictC[i] = (dictC[i] ?? 0) + 1
        }
        let C = dictC.keys.sorted()
        var dictD = [Int: Int]()

        for i in D {
            dictD[i] = (dictD[i] ?? 0) + 1
        }
        let D = dictD.keys.sorted()
        func twoSum(_ target: Int) -> Int {
            var ci = 0
            var di = D.count - 1
            var count = 0
            while ci < C.count && di >= 0 {
                let sum = C[ci] + D[di]
                if sum == target {
                    count += dictC[C[ci]]! * dictD[D[di]]!
                    ci += 1
                    di -= 1
                } else if sum > target {
                    di -= 1
                } else {
                    ci += 1
                }
            }
            return count
        }
        var total = 0
        var totalB = 0
        for ai in 0..<A.count {
            totalB = 0
            for bi in 0..<B.count {
                totalB += twoSum(0 - A[ai] - B[bi]) * dictB[B[bi]]!
            }
            total += dictA[A[ai]]! * totalB
        }
        return total
    }
    
    func fourSumCount1(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        var dictA = [Int: Int]()
        for i in A {
            dictA[i] = (dictA[i] ?? 0) + 1
        }
        let A = dictA.keys
        var dictB = [Int: Int]()
        for i in B {
            dictB[i] = (dictB[i] ?? 0) + 1
        }
        let B = dictB.keys
        var dictC = [Int: Int]()
        for i in C {
            dictC[i] = (dictC[i] ?? 0) + 1
        }
        let C = dictC.keys
        var dictD = [Int: Int]()

        for i in D {
            dictD[i] = (dictD[i] ?? 0) + 1
        }
        let D = dictD.keys
        var dict = [Int: Int]()
        for i in A {
            for j in B {
                dict[i + j] = (dict[i + j] ?? 0) + dictA[i]! * dictB[j]!
            }
        }
        
        var total = 0
        for i in C {
            for j in D {
                if let count = dict[0 - i - j] {
                    total += dictC[i]! * dictD[j]! * count
                }
            }
        }
        return total
    }
    
    func groupAnagrams(_ strs: [String]) -> [[String]] {

        var dict = [[Character]: Int]()
        var result = [[String]]()
        for str in strs {
            let c = str.sorted()
            if let i = dict[c] {
                result[i].append(str)
            } else {
                dict[c] = result.count
                result.append([str])
            }
        }
        return result
        
    }
    
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        var count = 0
        for i in 0..<points.count {
            var j = 0
            var dict = [Int: Int]()
            while j < points.count {
                if i != j {
                    let distance = (points[j][0] - points[i][0]) * (points[j][0] - points[i][0]) +
                        (points[j][1] - points[i][1]) * (points[j][1] - points[i][1])
                    dict[distance] = dict[distance, default: 0] + 1
                }
                j += 1
            }
            for c in dict.values {
                count = c * (c - 1) + count
            }
        }
        return count
    }
    
    func abcdef(_ points: [[Int]]) -> Int {
        guard points.count > 2 else {
            return points.count
        }
        var i = 0
        var maxCount = 1
        while i < points.count - 1 {
            var j = i + 1
            var dict = [Xielv:Int]()
            var samePoint = 0
            var curMax = 1
            while j < points.count {
                if points[i] == points[j] {
                    samePoint += 1
                    j += 1
                    continue
                }
                let xielv = Xielv(points[i][1] - points[j][1], points[i][0] - points[j][0])
               
                dict[xielv] = dict[xielv, default: 1] + 1
                curMax = max(curMax, dict[xielv]!)
                j += 1
            }
            maxCount = max(maxCount, curMax + samePoint)
            if maxCount > points.count / 2 {
                return maxCount
            }
            i += 1
        }
        return maxCount
    }
    
//    func maxPoints(_ points: [[Int]]) -> Int {
//        guard points.count > 2 else {
//            return points.count
//        }
////        var dict = [[Int]: [Int]]()
//        var i = 0
//        var maxCount = 1
//
//        func gcd(_ a: Int, _ b: Int) -> Int {
//            var a = a, b = b
//            while b != 0 {
//                let temp = a % b
//                a = b
//                b = temp
//            }
//            return a
//        }
//        while i < points.count - 1 {
//            var j = i + 1
//            var dict = [[Int]:Int]()
//            var samePoint = 0
//            var curMax = 1
//            while j < points.count {
//                if points[i] == points[j] {
//                    samePoint += 1
//                    j += 1
//                    continue
//                }
//                if points[i][0] == points[j][0] {
//                    dict[[1,0,points[i][0],1]] = dict[[1,0,points[i][0],1], default: 1] + 1
//                } else if points[i][1] == points[j][1] {
//                    dict[[0,1,points[i][1]],1] = dict[[0,1,points[i][1],1], default: 1] + 1
//                } else {
//                    var a =
//                }
//                var xielv = Double(points[i][1] - points[j][1]) / Double(points[i][0] - points[j][0])
//                if xielv == -Double.infinity {
//                    xielv = Double.infinity
//                }
//                dict[xielv] = dict[xielv, default: 1] + 1
//                curMax = max(curMax, dict[xielv]!)
//                j += 1
//            }
//            maxCount = max(maxCount, curMax + samePoint)
//            if maxCount > points.count / 2 {
//                return maxCount
//            }
//            i += 1
//        }
//        return maxCount
//    }
    
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        var i = 0
        while i < nums.count {
            var j = 1
            while j <= k && i + j < nums.count {
                if abs(nums[j + i] - nums[i]) <= t {
                    return true
                }
                j += 1
            }
            i += 1
        }
        return false
    }
    
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var dict = [Int:Int]()
        for i in 0...(min(k,nums.count - 1)) {
            dict[nums[i]] = dict[nums[i], default: 0] + 1
            if let count = dict[nums[i]], count > 1 {
                return true
            }
        }
        guard nums.count > k else {
            return false
        }
        for i in k+1..<nums.count {
            dict[nums[i - k - 1]] = dict[nums[i - k - 1], default: 0] - 1
            dict[nums[i]] = dict[nums[i], default: 0] + 1
            if let count = dict[nums[i]], count > 1 {
                return true
            }
        }
        return false
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else {
            return nil
        }
        func bst(_ left: Int, _ right: Int) -> TreeNode? {
            guard left <= right else {
                return nil
            }
            let mid = (left + right) / 2
            let root = TreeNode(nums[mid])
            root.left = bst(left, mid - 1)
            root.right = bst(mid + 1, right)
            return root
        }
        return bst(0, nums.count - 1)
    }
    
    func rob(_ nums: [Int]) -> Int {
        var dp = [Int].init(repeating: 0, count: nums.count)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        var c = 0
        for i in 2..<nums.count {
            dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
        }
        return dp[nums.count - 1]
    }

    func countPrimes(_ n: Int) -> Int {
        guard n > 1 else {
            return 0
        }
        guard n > 2 else {
            return 1
        }
        
        var primes = [Bool].init(repeating: true, count: n + 1)
        primes[1] = false
        primes[2] = true
        var count = 0
        for i in 2...n {
            if primes[i] {
                var j = 2
                while true {
                    let r = j * i
                    if i * j <= n {
                        primes[r] = false
                        j += 1
                    } else {
                        break
                    }
                }
                count += 1
            }
        }
        return count
    }
    
}

class Shuffle {
    var initalArr: [Int]
    var curArr: [Int]
    init(_ nums: [Int]) {
        self.initalArr = nums
        self.curArr = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        curArr = initalArr
        return curArr
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        let count = curArr.count
        for i in 0..<count {
            let index = Int.random(in: 0..<(count - i))
            curArr.swapAt(index, count - i - 1)
        }
        return curArr
    }
}



class MediumSolution {
    /*
     给定一个包含非负整数的 m x n 网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。
     
     说明：每次只能向下或者向右移动一步。
     
     示例:
     
     输入:
     [
        [1,3,1],
        [1,5,1],
        [4,2,1]
     ]
     输出: 7
     解释: 因为路径 1→3→1→1→1 的总和最小。

     */
    
    func minPathSum(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 && grid[0].count > 0 else {
            return 0
        }
        let row = grid[0].count
        let col = grid.count
        var dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: row), count: col)
        dp[0][0] = grid[0][0]
        for i in 1..<col {
            dp[i][0] = grid[i][0] + dp[i - 1][0]
        }
        for i in 1..<row {
            dp[0][i] = grid[0][i] + dp[0][i - 1]
        }
        for i in 1..<row {
            for j in 1..<col {
                dp[j][i] = min(dp[j][i - 1] + grid[j][i],dp[j - 1][i] + grid[j][i] )
            }
        }
        return dp[col - 1][row - 1]
    }
    //n2的复杂度太高
    func canJump(_ nums: [Int]) -> Bool {
        var nums = nums
        var stack = [0]
        var i = 0
        while i < nums.count - 1 {
            while let lastIndex = stack.last, nums[lastIndex] <= 0 {
                stack.removeLast()
                if let lastLast = stack.last {
                    i -= nums[lastLast]
                    nums[lastLast] -= 1
                }
            }
            if let lastIndex = stack.last {
                let curIndex = min(nums[lastIndex] + i,nums.count - 1)
                if curIndex == nums.count - 1 {
                    i = curIndex
                } else if nums[curIndex] <= 0 {
                    nums[lastIndex] = curIndex - lastIndex - 1
                } else {
                    stack.append(curIndex)
                    i = curIndex
                }
            } else {
                return false
            }
        }
        return true
    }
    
    func canJump1(_ nums: [Int]) -> Bool {
        var maxJump = 0
        for i in 0..<nums.count {
            if i > maxJump {
                return false
            }
            maxJump = max(i + nums[i], maxJump)
        }
        return true
    }
    
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var sum = 0
        var sumIndex = -1
        var total = 0

        let N = gas.count
        for i in 0..<N {
            let left = gas[i] - cost[i]
            if left + sum >= 0 {
                sum += left
                if sumIndex == -1 {
                    sumIndex = i
                }
            } else {
                sum = 0
                sumIndex = -1
            }
            total += left
        }
        return total >= 0 ? sumIndex : -1
    }
    
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        var newPeople = people.sorted(by: {
            if $0[0] == $1[0] {
                return $0[1] < $1[1]
            } else {
                return $0[0] > $1[0]
            }
        })
        for i in 0..<newPeople.count {
            for value in (1...i).reversed() {
                if newPeople[value][1] < value {
                    newPeople.swapAt(value, value - 1)
                } else {
                    break
                }
            }
        }
        return newPeople
    }
    
    func isPossibleDivide(_ nums: [Int], _ k: Int) -> Bool {
        
        var dict = [Int: Int]()
        for i in nums {
            dict[i] = dict[i, default: 0] + 1
        }
        let arr = dict.keys.sorted()
        var i = 0
        while i < arr.count {
            if let count = dict[arr[i]], count > 0 {
                if i + k > arr.count {
                    return false
                }
                var j = i
                while j < i + k - 1 {
                    if let curCount = dict[arr[j + 1]], curCount >= count && arr[j] + 1 == arr[j + 1] {
                        dict[arr[j + 1]] = curCount - count
                    } else {
                        return false
                    }
                    j += 1
                }
            }
            i += 1
        }
        return true
    }
    
    func isPossibleDivide1(_ nums: [Int], _ k: Int) -> Bool {
        guard nums.count % k == 0 else {
            return false
        }
        var cnt = [Int].init(repeating: 0, count: k)
        let size = nums.count / k
        for i in nums {
            cnt[i % k] += 1
        }
        for i in 0..<k {
            if cnt[i] != size {
                return false
            }
        }
        return true
    }
    
    func groupThePeople(_ groupSizes: [Int]) -> [[Int]] {
        var dict = [Int: [Int]]()
        var res = [[Int]]()
        for (index,i) in groupSizes.enumerated() {
            if dict[i] != nil {
                dict[i]!.append(index)

            } else {
                dict[i] = [index]
            }
            if dict[i]!.count == i {
                res.append(dict[i]!)
                dict[i] = nil
            }
        }
        return res
    }
    
    func numOfBurgers(_ tomatoSlices: Int, _ cheeseSlices: Int) -> [Int] {
        let humberger = tomatoSlices - 2 * cheeseSlices
        let littleHum = 4 * cheeseSlices - tomatoSlices
        if humberger % 2 == 0 && littleHum % 2 == 0 && humberger > 0 && littleHum > 0 {
            return [humberger,littleHum]
        } else {
            return []
        }
        
    }
    
    func reconstructMatrix(_ upper: Int, _ lower: Int, _ colsum: [Int]) -> [[Int]] {
        var res = [[Int]].init(repeating: [Int].init(repeating: 0, count: colsum.count), count: 2)
        var upper = upper
        var lower = lower
        var borrows = Set<Int>()
        for (index,i) in colsum.enumerated() {
            if i == 2 {
                if upper > 0 {
                    res[0][index] = 1
                    upper -= 1
                } else if borrows.count > 0 {
                    let borrowIndex = borrows.first!
                    res[0][borrowIndex] = 0
                    res[1][borrowIndex] = 1

                    res[0][index] = 1
                    lower -= 1
                    borrows.remove(borrowIndex)
                } else {
                    return []
                }
                if lower > 0 {
                    lower -= 1
                    res[1][index] = 1
                } else {
                    return []
                }
            } else if i == 1 {
                if upper > 0 {
                    res[0][index] = 1
                    upper -= 1
                    if lower > 0 {
                        borrows.insert(index)
                    }
                } else if lower > 0{
                    res[1][index] = 1
                    lower -= 1
                } else if borrows.count > 0 && lower > 0 {
                    lower -= 1
                    let borrowIndex = borrows.first!
                    res[0][borrowIndex] = 0
                    res[1][borrowIndex] = 1
                    res[0][index] = 1
                    borrows.remove(borrowIndex)
                } else {
                    return []
                }
            }
        }
        return res
    }
    
//    func maxProfit(_ prices: [Int]) -> Int {
//        var dp = [Int].init(repeating: 0, count: prices.count)
//        dp[0] = 0
//        dp[1] = prices[1] - prices[0]
//        var minIndex = [Int]
//        for i in 1..<prices.count {
//            if minIndex == -1 {
//                minIndex = i
//            }
//            if prices[i] < prices[i - 1] {
//                minIndex = i
//            }
//            dp[i] = max(dp[i - 1], prices[i] - prices[minIndex] + (minIndex - 2 >= 0 ? dp[minIndex - 2] : 0))
//        }
//        return dp.last!
//    }
    
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        let row = grid.count
        let column = grid[0].count
        var res = 0
        for i in 0..<row {
            for j in 0..<column {
                var add = 0
                if grid[i][j] == 1 {
                    add = 4
                    if j != 0 && grid[i][j - 1] == 1 {
                        add -= 1
                        res -= 1
                    }
                    if i != 0 && grid[i - 1][j] == 1 {
                        add -= 1
                        res -= 1
                    }
                }
                res += add
            }
        }
        return res
    }
    
    func findLHS(_ nums: [Int]) -> Int {
        var dict = [Int: Int]()
        var maxCount = 0
        for i in nums {
            let cur = dict[i, default: 0] + 1
            dict[i, default: 0] = cur
            let pre = dict[i - 1,default: 0]
            let next = dict[i + 1, default: 0]
            maxCount = max(pre == 0 ? 0 : (pre + cur), next == 0 ? 0 : (next + cur), maxCount)
        }
        return maxCount
    }
    
    func findErrorNums(_ nums: [Int]) -> [Int] {
        var sum = nums.count * (1 + nums.count) / 2
        var set = Set<Int>()
        var res = [Int]()
        for i in nums {
            if set.contains(i) {
                res.append(i)
            } else {
                set.insert(i)
                sum -= i
            }
            res.append(sum)
        }
        return res
    }
    
    func longestWord(_ words: [String]) -> String {
        let sortedWords = words.sorted()
        var res = ""
        var maxCount = 0
        var set = Set<String>()
        for i in sortedWords {
            if i.count == 1 || set.contains(String(i.dropLast())) {
                set.insert(i)
                if i.count > maxCount {
                    res = i
                    maxCount = i.count
                }
            }
        }
        return res
    }
    
    func shortestCompletingWord(_ licensePlate: String, _ words: [String]) -> String {
        var dict = [String: Int]()
        for c in licensePlate {
            if c.isLetter {
                dict[c.lowercased(), default: 0] += 1
            }
        }
        var res = ""
        for word in words {
            var wordDict = [String: Int]()
            for c in word {
                if c.isLetter {
                    wordDict[c.lowercased(), default: 0] += 1
                }
            }
            var shortword = word
            for (key, value) in dict {
                if wordDict[key, default: 0] < value {
                    shortword = ""
                    break
                }
            }
            if res.count == 0 || (shortword.count > 0 && shortword.count < res.count) {
                res = shortword
            }
        }
        return res
    }
    
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        var indexDict = [Character: Int]()
        for (index,c) in order.enumerated() {
            indexDict[c] = index
        }
        var i = 1
        while i < words.count {
            let word1 = [Character].init(words[i])
            let word0 = [Character].init(words[i - 1])
            var j = 0
            while j < word1.count && j < word0.count {
                if indexDict[word1[j]]! < indexDict[word0[j]]! {
                    return false
                } else if indexDict[word1[j]]! == indexDict[word0[j]]! {
                    j += 1
                } else {
                    break
                }
            }
            if (j == word1.count || j == word0.count) && (word0.count > word1.count) {
                return false
            }
            i += 1
        }
        return true
    }
    
    func powerfulIntegers(_ x: Int, _ y: Int, _ bound: Int) -> [Int] {
        guard bound >= 2 else {
            return []
        }
        var xArr = [1]
        var yArr = [1]
        if x != 1 {
            while xArr.last! < bound {
                xArr.append(xArr.last! * x)
            }
        }
        if y != 1 {
            while yArr.last! < bound {
                yArr.append(yArr.last! * y)
            }
        }
        if x == 1 {
            let res = yArr.map { (i) -> Int in
                return i + 1
            }
            return res.filter { (i) -> Bool in
                return i <= bound
            }
        }
        if y == 1 {
            let res = xArr.map { (i) -> Int in
                return i + 1
            }
            return res.filter { (i) -> Bool in
                return i <= bound
            }
        }
        var set = Set<Int>()

        for xx in xArr {
            for yy in yArr {
                let sum = xx + yy
                if sum <= bound {
                    set.insert(sum)
                } else {
                    break
                }
            }
        }
        return [Int].init(set)
    }
    
    func findOcurrences(_ text: String, _ first: String, _ second: String) -> [String] {
        let words = text.components(separatedBy: " ")
        var res = [String]()
        var firstAppear = false
        var secondAppear = false
        for word in words {
            if secondAppear {
                res.append(word)
                if word != first {
                    firstAppear =  false
                }
                secondAppear = false
                
            } else if firstAppear && second == word {
                secondAppear = true
            } else if first == word {
                firstAppear = true
                secondAppear = false
            } else {
                firstAppear = false
                secondAppear = false
            }
        }
        return res
    }
    
    func maxNumberOfBalloons(_ text: String) -> Int {
        var balloon = [Character: Int]()
        for c in "balloon" {
            balloon[c, default: 0] += 1
        }
        var dict = [Character: Int]()
        for c in text {
            if balloon[c] != nil {
                dict[c, default: 0] += 1
            }
        }
        var res = Int.max
        for (c, value) in balloon {
            res = min(res, dict[c, default: 0] / value)
        }
        return res
    }
    
    func uniqueOccurrences(_ arr: [Int]) -> Bool {
        var dict = [Int: Int]()
        for i in arr {
            dict[i, default: 0] += 1
        }
        var set = Set<Int>()
        for value in dict.values {
            if set.contains(value) {
                return false
            }
            set.insert(value)
        }
        return true
    }
}

class MagicDictionary {

    var map: [Int: [[Character]]] = [:]
    var set: [String] = []
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Build a dictionary through a list of words */
    func buildDict(_ dict: [String]) {
        for word in dict {
            if map[word.count] != nil {
                map[word.count]!.append([Character].init(word))
            } else {
                map[word.count] = [[Character].init(word)]
            }
        }
    }
    
    /** Returns if there is any word in the trie that equals to the given word after modifying exactly one character */
    func search(_ word: String) -> Bool {
        guard let arr = map[word.count] else {
            return false
        }
        var ifFind = false
        for w in arr {
            var difCount = 0
            for (index,c) in word.enumerated() {
                if w[index] != c {
                    difCount += 1
                }
                if difCount > 2 {
                    break
                }
                if index == word.count - 1 && difCount == 1{
                    ifFind = true
                }
            }
        }
        return ifFind
    }
}
