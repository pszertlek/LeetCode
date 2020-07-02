//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

//print(DynamicSolution().maxProfit4(2, [2,4,1]))
//print(DynamicSolution().maxProfit4(2, [3,2,6,5,0,3]))
//print(DynamicSolution().maxProfit4(2, [2,1,2,0,1]))
//print(DynamicSolution().maxProfit4(2,
//[1,2,4,2,5,7,2,4,9,0]))
//print(DFSSolution().canFinish(2, [[1,0],[0,1]]))
//print(DFSSolution().canFinish(2, [[1,0]]))
//print(DFSSolution().canFinish(3, [[0,1],[1,2],[2,1]]))
//print(DFSSolution().findSquare([[1]]))

var board: [[Character]] = [
    [Character].init("53..7...."),
    [Character].init("6..195..."),
    [Character].init(".98....6."),
    [Character].init("8...6...3"),
    [Character].init("4..8.3..1"),
    [Character].init("7...2...6"),
    [Character].init(".6....28."),
    [Character].init("...419..5"),
    [Character].init("....8..79")





]
//board = [[".",".","9","7","4","8",".",".","."],["7",".",".",".",".",".",".",".","."],[".","2",".","1",".","9",".",".","."],[".",".","7",".",".",".","2","4","."],[".","6","4",".","1",".","5","9","."],[".","9","8",".",".",".","3",".","."],[".",".",".","8",".","3",".","2","."],[".",".",".",".",".",".",".",".","6"],[".",".",".","2","7","5","9",".","."]]
//board = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
Solution().solveSudoku(&board)
print(board)


