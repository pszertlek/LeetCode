//
//  EasySolution.swift
//  DynamicPlaning
//
//  Created by apple on 2019/7/24.
//  Copyright © 2019 Pszertlek.com.cn. All rights reserved.
//

import Foundation

class EasySolution {
    
    /*
     爱丽丝和鲍勃一起玩游戏，他们轮流行动。爱丽丝先手开局。
     
     最初，黑板上有一个数字 N 。在每个玩家的回合，玩家需要执行以下操作：
     
     选出任一 x，满足 0 < x < N 且 N % x == 0 。
     用 N - x 替换黑板上的数字 N 。
     如果玩家无法执行这些操作，就会输掉游戏。
     
     只有在爱丽丝在游戏中取得胜利时才返回 True，否则返回 false。假设两个玩家都以最佳状态参与游戏。
     */
    func divisorGame(_ N: Int) -> Bool {
        if N < 2 {
            return false
        }
        var dp = [Bool].init(repeating: false, count: N+1)
        for i in 2...N {
            for j in 1..<i {
                if dp[i - j] && i % j == 0 {
                    dp[i] = true
                    break
                }
            }
        }
        return dp[N]
    }
    
    
    func maxSubArray(_ nums: [Int]) -> Int {
        var dp = [Int]()
        var maxNum = nums[0]
        dp.append(maxNum)
        for i in 1..<nums.count {
            let cur = max(dp[i - 1] + nums[i],nums[i])
            if cur < 0 {
                dp.append(0)
            } else {
                dp.append(cur)
            }
            maxNum = max(maxNum, cur)
        }
        return maxNum
    }
    
    func maxSubArrayF(_ nums: [Int]) -> Int {
        
        func maxSubAll(left: Int, mid: Int, right: Int) -> Int  {
            var leftSum = Int.min
            var sum = 0
            for i in stride(from: mid, through: left, by: -1) {
                sum += nums[i]
                if sum > leftSum {
                    leftSum = sum
                }
            }
            sum = 0
            var rightSum = Int.min
            for i in mid + 1...right {
                sum += nums[i]
                if sum > rightSum {
                    rightSum = sum
                }
            }
            return leftSum + rightSum
        }
        
        func maxSubF(_ left: Int, _ right: Int) -> Int {
            if left == right {
                return nums[left]
            } else {
                let maxLeft = maxSubF(left,(left + right) / 2)
                let maxRight = maxSubF((left + right) / 2 + 1, right)
                return max(maxLeft, maxRight, maxSubAll(left: left, mid: (left + right) / 2, right: right))
            }
        }
        return maxSubF(0, nums.count - 1)
    }
    
    //分发饼干
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        let g = g.sorted()
        let s = s.sorted()
        var gi = 0, si = 0
        while gi < g.count && si < s.count {
            if g[gi] <= s[si] {
                gi += 1
            }
            si += 1
        }
        return gi
    }
    
    func lemonadeChange(_ bills: [Int]) -> Bool {
        var fiveCount = 0
        var tenCount = 0
        for i in bills {
            if i == 5 {
                fiveCount += 1
            } else if i == 10 {
                if fiveCount > 0 {
                    fiveCount -= 1
                } else {
                    return false
                }
                tenCount += 1
            } else {
                if tenCount > 0 && fiveCount > 0 {
                    tenCount -= 1
                    fiveCount -= 1
                } else if fiveCount >= 3 {
                    fiveCount -= 3
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    func robotSim(_ commands: [Int], _ obstacles: [[Int]]) -> Int {
        var x = 0
        var y = 0
        var direction = 0
        var ans = 0
        var set = Set<[Int]>(obstacles)
        func find(_ x: Int, _ y: Int) -> Bool {
            return set.contains([x,y])
        }
        
        for i in commands {
            if i == -1 {
                direction = (direction + 1) % 4
            } else if i == -2 {
                direction = (direction + 3) % 4
            } else {
                for _ in 0..<i {
                    switch direction {
                    case 0:
                        if !find(x, y + 1) {
                            y += 1
                        }
                        
                    case 1:
                        if !find(x + 1, y) {
                            x += 1
                        }
                    case 2:
                        if !find(x, y - 1) {
                            y -= 1
                        }
                    case 3:
                        if !find(x - 1, y) {
                            x -= 1
                        }
                        
                    default:
                        print("error")
                    }
                    ans = max(ans, x * x + y * y)
                }
            }
        }
        return ans
    }
    
    func largestSumAfterKNegations(_ A: [Int], _ K: Int) -> Int {
        var A = A.sorted()
        var sum = 0
        var rotateCount = 0
        var i = 0
        while i < A.count {
            if rotateCount < K {
                if A[i] < 0 {
                    rotateCount += 1
                    A[i] = -A[i]
                    i += 1
                } else {
                    if i != 0 {
                        A.sort()
                    }
                    break
                }
            } else {
                sum = A.reduce(0, +)
                return sum
            }
        }
        if (K - rotateCount) % 2 == 0 {
            sum = A.reduce(0, +)
        } else {
            sum = A.reduce(0, +) - A[0] * 2
        }
        return sum
    }
    
    func twoCitySchedCost(_ costs: [[Int]]) -> Int {
        let a = costs.sorted(by: { return $0[0] - $0[1] < $1[0] - $1[1]})
        let n = costs.count / 2
        var sum = 0
        for i in 0..<n {
            sum += a[i][0]
            sum += a[i + n][1]
        }
        return sum
    }
    
    func lastStoneWeight(_ stones: [Int]) -> Int {
        var stones = stones.sorted()
        while stones.count > 1 {
            let y = stones.removeLast()
            let x = stones.removeLast()
            if y - x > 0 {
                let cur = y - x
                var ifInsert = false
                for i in 0..<stones.count {
                    if stones[i] >= cur {
                        stones.insert(cur, at: i)
                        ifInsert = true
                        break
                    }
                }
                if !ifInsert {
                    stones.append(cur)
                }
            }
        }
        return stones.count == 1 ? stones[0] : 0
    }
    
    func minCostToMoveChips(_ chips: [Int]) -> Int {
        let odd = chips.filter( { $0 % 2 == 1 }).count
        let even = chips.filter( {$0 % 2 == 0 }).count

        return min(odd, even)
    }
    
    func fixedPoint(_ A: [Int]) -> Int {
        var left = 0
        var right = A.count - 1
        var result = -1
        while left < right {
            let mid = (right + left) / 2
            if A[mid] == mid {
                right = mid
                result = mid
            } else if A[mid] > mid {
                right = mid
            } else {
                left = mid + 1
            }
        }
        return result
    }
    
}

/*
 给定一个整数数组  nums，求出数组从索引 i 到 j  (i ≤ j) 范围内元素的总和，包含 i,  j 两点。
 
 示例：
 
 给定 nums = [-2, 0, 3, -5, 2, -1]，求和函数为 sumRange()
 
 sumRange(0, 2) -> 1
 sumRange(2, 5) -> -1
 sumRange(0, 5) -> -3
 说明:
 
 你可以假设数组不可变。
 会多次调用 sumRange 方法。

 */



class NumArray {
    
    var myNums: [Int]
    init(_ nums: [Int]) {
        myNums = [Int].init(repeating: 0, count: nums.count + 1)
        for i in 1...nums.count {
            myNums[i] = (myNums[i - 1] + nums[i - 1])
        }
    }
    
    func sumRange(_ i: Int, _ j: Int) -> Int {
        return myNums[j + 1] - myNums[i]
    }
}

