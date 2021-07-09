//
//  MatrixSolution.swift
//  LeetCode
//
//  Created by Apple on 2020/7/29.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

/// LCP 13
struct TreasureHunt {
    enum SiteType: Int {
        case start, treasure, stone, wall, free, trigger
        init(_ site: Character) {
            switch site {
            case Character("S"):
                self = .start
            case Character("T"):
                self = .treasure
            case Character("O"):
                self = .stone
            case Character("#"):
                self = .wall
            case Character("M"):
                self = .trigger
            default:
                self = .free
            }
        }
    }
    
    struct Point {
        var x: Int
        var y: Int
    }
    
}

struct MatrixSolution {
    func regionsBySlashes(_ grid: [String]) -> Int {
        let N = grid.count
        var box = [[Bool]].init(repeating: [Bool].init(repeating: false, count: 3 * N), count: 3 * N)
        var visited = box
        for (y,row) in grid.enumerated() {
            for (x, c) in row.enumerated() {
                if c == "\\" {
                    box[y * 3][x * 3] = true
                    box[y * 3 + 1][x * 3 + 1] = true
                    box[y * 3 + 2][x * 3 + 2] = true
                } else if c == "/" {
                    box[y * 3][x * 3 + 2] = true
                    box[y * 3 + 1][x * 3 + 1] = true
                    box[y * 3 + 2][x * 3] = true
                }
            }
        }
        func backtrace(_ x: Int, _ y: Int) {
            guard x >= 0 && x < 3 * N && y >= 0 && y < 3 * N && !visited[y][x] && !box[y][x] else {
                return
            }
            visited[y][x] = true
            backtrace(x, y + 1)
            backtrace(x, y - 1)
            backtrace(x - 1, y)
            backtrace(x + 1, y)
        }
        var res = 0
        for y in 0..<N*3 {
            for x in 0..<N*3 {
                if !visited[y][x] && !box[y][x] {
                    backtrace(x, y)
                    res += 1
                }
            }
        }
        return res
    }
}

class SubrectangleQueries {

    var board: [[Int]]
    var cache: [(row1: Int, col1: Int, row2: Int, col2: Int, newValue: Int)] = []
    
    init(_ rectangle: [[Int]]) {
        board = rectangle
    }
    
    func updateSubrectangle(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int, _ newValue: Int) {
        cache.append((row1: row1, col1: col1, row2: row2, col2: col2, newValue: newValue))
    }
    
    func getValue(_ row: Int, _ col: Int) -> Int {
        for i in stride(from: cache.count - 1, through: 0, by: -1) {
            if cache[i].col1 <= row &&
                cache[i].col1 <= col &&
                cache[i].row2 >= row &&
                cache[i].row2 >= row {
                    return cache[i].newValue
                }
        }
        return board[row][col]
    }
}

