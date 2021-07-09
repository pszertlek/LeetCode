//
//  DynamicSolution.swift
//  LeetCode
//
//  Created by Apple on 2020/6/20.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

class DynamicSolution {
    
    //188.股票IV
    func maxProfit4(_ k: Int, _ prices: [Int]) -> Int {
        guard k < prices.count / 2 else {
            return maxProfit(prices)
        }
        let n = prices.count
        var dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: k + 1)
        for i in 1..<k+1 {
            var maxDiff = -prices[0];
            for j in 1..<n {
                maxDiff = max(maxDiff, dp[i - 1][j - 1] - prices[j])
                dp[i][j] = max(dp[i][j - 1], prices[j] + maxDiff)
            }
        }
        return dp[k][n - 1]
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else {
            return 0
        }
        var sum = 0
        
        for i in 1..<prices.count {
            if prices[i] > prices[i - 1] {
                sum += prices[i] - prices[i - 1]
            }
        }
        return sum
    }
    
    func findSquare(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 0 else {
            return []
        }
        let N = matrix.count
        func calculate(_ c: Int, _ r: Int, _ size: Int, _ actualSize: Int) -> Int {

            if size == 0 {
                if matrix[r][c] == 0 {
                    return calculate(c, r, 1, 1)
                } else {
                    return 0
                }
            }

            if r + size >= N || c + size >= N {
                return actualSize
            }
            if matrix[r + size][c] != 0 {
                return actualSize
            }
            if matrix[r][c + size] != 0 {
                return actualSize
            }


            var sizeTrue = matrix[r + size][c + size] == 0
            guard sizeTrue else {
                return calculate(c, r, size + 1, actualSize)
            }
            for i in 1..<size {
                if matrix[i + r][c + size] != 0 {
                    sizeTrue = false
                    break
                }
            }
            for i in 1..<size {
                if matrix[r + size][i + c] != 0 {
                    sizeTrue = false
                    break
                }
            }
            return calculate(c, r, size + 1, sizeTrue ? size + 1 : actualSize)
            
        }
        var res = (0,0,0)
        for i in 0..<N {
            for j in 0..<N {
                let curRes = calculate(j, i, 0, 0)
                if curRes > res.2 {
                    res = (i,j,curRes)
                }
                if N - j - 1 <= curRes {
                    break
                }
            }
            if N - i - 1 <= res.2 {
                break
            }
        }
        return res.2 == 0 ? [] : [res.0,res.1,res.2]
    }
    
    func findSquare1(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 0 else {
            return []
        }
        let N = matrix.count
        var rowCache = [[Int]].init(repeating: [Int].init(repeating: -1, count: N), count: N)
        var columnCache = [[Int]].init(repeating: [Int].init(repeating: -1, count: N), count: N)
        var rowSize = 0
        var columnSize = 0
        for i in stride(from: N - 1, through: 0, by: -1) {
            for j in stride(from: N - 1, through: 0, by: -1) {
                if matrix[i][j] == 0 {
                    columnSize += 1
                } else {
                    columnSize = 0
                }
                columnCache[i][j] = columnSize
            }
            columnSize = 0
            for j in stride(from: N - 1, through: 0, by: -1) {
                if matrix[j][i] == 0 {
                    rowSize += 1
                } else {
                    rowSize = 0
                }
                rowCache[j][i] = rowSize
            }
            rowSize = 0
        }
        var res = (-1,-1,-1)
        for j in 0..<N {
            for i in 0..<N {
                var size = min(rowCache[i][j],columnCache[i][j])
                while size > 0 {
                    if rowCache[i][j + size - 1] < size ||
                        columnCache[i + size - 1][j] < size {
                        size -= 1
                    } else {
                        if res.2 < size{
                            res = (i,j,size)
                        }
                        break
                    }
                }
            }
        }
        return res.2 == -1 ? [] : [res.0,res.1,res.2]
    }
    
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let word1 = [Character](word1), word2 = [Character](word2)
        let n = word1.count, m = word2.count
        
        if n == 0 || m == 0 {
            return n + m
        }
        var dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: m + 1), count: n + 1)
        for i in 1..<n+1 {
            dp[i][0] = i
        }
        for i in 1..<m+1 {
            dp[0][i] = i
        }
        for i in 1..<n+1 {
            for j in 1..<m+1 {
                dp[i][j] = min(dp[i - 1][j] + 1, dp[i][j - 1] + 1, dp[i - 1][j - 1] + (word2[j - 1] != word1[i - 1] ? 1 : 0))
            }
        }
        return dp[n][m]
    }

    ///376
    func wiggleMaxLength(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return 1
        }
        var up = 1, down = 1
        for i in 1..<nums.count {
            if nums[i] > nums[i - 1] {
                up = max(up, down + 1)
            } else {
                down = max(down, up + 1)
            }
        }
        return max(up,down)
    }
    
    ///377
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var dp = [Int](repeating: 0, count: target + 1)
        dp[0] = 1
        for i in 1...target{
            for num in nums {
                if num <= i {
                    dp[i] += dp[i - num]
                }
            }
        }
        return dp[target]
    }
    
    ///396
    func maxRotateFunction(_ nums: [Int]) -> Int {
        let N = nums.count
        var dp = [Int](repeating: 0, count: N)
        dp[0] = nums.enumerated().reduce(0) { r, i in
            return r + i.element * i.offset
        }
        let sum = nums.reduce(0, +)
        var res = dp[0]
        for i in 1..<N {
            dp[i] = dp[i - 1] + sum - nums[N - i] * N
            res = max(res, dp[i])
        }
        return res
    }
    
    ///397
    func integerReplacement(_ n: Int) -> Int {
        var dict = [Int: Int]()
        
        func replace(_ n: Int) -> Int {
            guard n > 1 else {
                return 0
            }
            if let i = dict[n] {
                return i
            }
            if n & 1 == 0 {
                let i = integerReplacement(n / 2) + 1
                dict[n] = i
                return i
            } else {
                let i = min(integerReplacement(n - 1), integerReplacement(n + 1)) + 1
                dict[n] = i
                return i
            }
        }
        return replace(n)
    }
    
    ///397
    func integerReplacement1(_ n: Int) -> Int {
        var q = [n], visited = Set<Int>()
        visited.insert(n)
        var depth = 0
        while q.count > 0 {
            var newQueue = [Int]()
            for i in q {
                if i == 1 {
                    return depth
                }
                if i & 1 == 0 {
                    if !visited.contains(i / 2) {
                        newQueue.append(i / 2)
                        visited.insert(i / 2)
                    }
                } else {
                    if !visited.contains(i + 1) {
                        newQueue.append(i + 1)
                        visited.insert(i + 1)
                    }
                    if !visited.contains(i - 1) {
                        newQueue.append(i - 1)
                        visited.insert(i - 1)
                    }
                }
            }
            q = newQueue
            depth += 1
        }
        return depth
    }

    
    func numberOfArithmeticSlices(_ nums: [Int]) -> Int {
        guard nums.count > 2 else {
            return 0
        }
        let n = nums.count
        var diff = 0, count = 1, res = 0
        for i in 1..<n {
            if nums[i] - nums[i - 1] == diff {
                count += 1
            } else {
                res += (1 + count - 2) * (count - 2) / 2
                diff = nums[i] - nums[i - 1]
                count = 2
            }
        }
        res += (1 + count - 2) * (count - 2) / 2
        return res
    }
}



