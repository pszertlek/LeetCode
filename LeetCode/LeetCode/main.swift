//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation
import BinaryTree



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

func calculate(_ s: String) -> Int {

    
    let set = CharacterSet(charactersIn: "+-*/ ")
    let numberSet = CharacterSet(charactersIn: "1234567890 ")

    var values = s.components(separatedBy: set)
        .filter { $0.count > 0 }
        .map { Int($0) ?? 0 }
    var operators = s.components(separatedBy: numberSet).filter({ $0.count > 0})
    if operators.count == values.count {
        if operators.first == "-" {
            values[0] = -values[0]
        }
        operators.removeFirst()
    }

    var numArr = [values[0]]
    var o = [String]()
    for i in 0..<operators.count {
        if operators[i] == "+" || operators[i] == "-"{
            numArr.append(values[i + 1])
            o.append(operators[i])
        } else {
            if operators[i] == "*" {
                numArr[numArr.count - 1] = numArr[numArr.count - 1] * values[i + 1]
            } else {
                numArr[numArr.count - 1] = numArr[numArr.count - 1] / values[i + 1]
            }
        }
    }
    var res = numArr[0]
    for i in 0..<o.count {
        if o[i] == "+" {
            res += numArr[i + 1]
        } else {
            res -= numArr[i + 1]
        }
    }
    return res
}
let set = CharacterSet(charactersIn: "+-*/ ")

print("3+5 / 2 ".components(separatedBy: set))
print(calculate("0+0"))
