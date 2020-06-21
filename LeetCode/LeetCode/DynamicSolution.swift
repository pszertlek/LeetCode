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
    

}
