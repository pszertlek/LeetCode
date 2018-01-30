//
//  ToeplitzMatrix.swift
//  LeetCode
//
//  Created by apple on 2018/1/26.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation
/*A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same element.
 
 Now given an M x N matrix, return True if and only if the matrix is Toeplitz.
 
 
 Example 1:
 
 Input: matrix = [[1,2,3,4],[5,1,2,3],[9,5,1,2]]
 Output: True
 Explanation:
 1234
 5123
 9512
 
 In the above grid, the diagonals are "[9]", "[5, 5]", "[1, 1, 1]", "[2, 2, 2]", "[3, 3]", "[4]", and in each diagonal all elements are the same, so the answer is True.
 Example 2:
 
 Input: matrix = [[1,2],[2,2]]
 Output: False
 Explanation:
 The diagonal "[1, 2]" has different elements.
 Note:
 
 matrix will be a 2D array of integers.
 matrix will have a number of rows and columns in range [1, 20].
 matrix[i][j] will be integers in range [0, 99].*/

func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
    let row = matrix.count
    let column = matrix[0].count
    var currentY = row - 1
    var currentX = 0
    var x = 0, y = 0
    while currentY - 1 > 0 || currentX + 1 < column  {
        if currentY - 1 >= 0 {
            currentY = currentY - 1
        } else if currentX + 1 < column {
            currentX = currentX + 1
        }
        x = currentX
        y = currentY
        let currentVar = matrix[y][x]
        while y + 1 < row && x + 1 < column  {
            if y + 1 < row {
                y = y + 1
            }
            if x + 1 < column {
                x = x + 1
            }
            if currentVar != matrix[y][x] {
                return false
            }
        }
    }
    return true
}
