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
    

}
