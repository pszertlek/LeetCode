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
    
    func generateTrees(_ n: Int) -> [TreeNode?] {
        func generateTrees(_ start: Int, _ end: Int) {
            var allTrees = [TreeNode?]()
            if start > end {
                
            }
        }
        

    }
}
