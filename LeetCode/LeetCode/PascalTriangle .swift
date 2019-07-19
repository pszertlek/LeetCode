//
//  PascalTriangle .swift
//  LeetCode
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

/*Given numRows, generate the first numRows of Pascal's triangle.
 
 For example, given numRows = 5,
 Return
 
 [
 [1],
 [1,1],
 [1,2,1],
 [1,3,3,1],
 [1,4,6,4,1]
 ]*/
func generatePascalTriangle(_ numRows: Int) -> [[Int]] {
    var result = [[Int]]()
    for i in 0..<numRows {
        var currentArray = [Int]()
        for j in 0...i {
            if j == 0 || j == i{
                currentArray.append(1)
            } else {
                currentArray.append(result[i - 1][j - 1] + result[i - 1][j])
            }
        }
        result.append(currentArray)
    }
    return result
}

/*Given an index k, return the kth row of the Pascal's triangle.
 
 For example, given k = 3,
 Return [1,3,3,1].
 
 Note:
 Could you optimize your algorithm to use only O(k) extra space?*/

func getRow(_ rowIndex: Int) -> [Int] {
    guard rowIndex != 0 else { return [1] }
    guard rowIndex != 1 else { return [1,1] }
    var result = Array<Int>(repeating: 1, count: rowIndex + 1),i = 1
    result[0] = 1
    result[rowIndex - 1] = 1
    while i <= (rowIndex + 1) / 2 {
        let j = result[i - 1] * (rowIndex - i + 1) / i
        result[i] = j
        result[rowIndex - i] = j
        i += 1
    }
    return result
}

func maxProfit(_ prices: [Int]) -> Int {
    if prices.count <= 1 {
        return 0
    }
    var buy = Int.max, sell = -1 , profit = 0, lastProfit = 0
    for (index,price) in prices.enumerated() {
        if sell == -1 {
            if price < buy {
                buy = price
                continue
            } else {
                lastProfit = price - buy
                sell = buy
                if index == prices.count - 1 {
                    profit = profit + lastProfit
                }
            }
        } else {
            if price - buy > lastProfit {
                sell = price
                lastProfit = price - buy
                if index == prices.count - 1 {
                    profit = profit + lastProfit

                }
            } else {
                buy = price
                sell = -1
                profit = profit + lastProfit

            }
        }
    }

    return profit
}

func maximalSquare(matrix: [[Character]]) -> Int {
    if matrix.isEmpty || matrix[0].isEmpty {
        return 0
    }
    let one = Character("1")
    var m = matrix.count, n = matrix[0].count, res = 0, pre = 0
    var dp = [Int].init(repeating: 0, count: m + 1)
    for j in 0..<n {
        for i in 1...m {
            let t = dp[i]
            if matrix[i - 1][j] == one {
                dp[i] = min(dp[i], min(dp[i - 1], pre)) + 1
                res = max(res, dp[i])
            } else {
                dp[i] = 0
            }
            pre = t
        }
    }
    return res * res
}
