//
//  LCStack.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

class SolutionSort {
    func allCellsDistOrder(_ R: Int, _ C: Int, _ r0: Int, _ c0: Int) -> [[Int]] {
        var i = 1, z = max(R, C)
        var array = [[Int]]()
        array.append([r0,c0])
        let count = R * C
        while array.count < count {
            var a = i
            while a > 0 && a < z {
                print(array)
                print("\(r0 + a),\(c0 + i - a)")
                print("\(r0 - a),\(c0 + i - a)")
                print("\(r0 + a),\(c0 - i + a)")
                print("\(r0 - a),\(c0 - i + a)")

                if r0 + a < R && c0 + i - a < C {
                    let x1 = i - a + c0
                    let x2 = a - i + c0
                    if x1 != x2 {

                    }
                    if c0 + i - a < C {
                        array.append([r0 + a, c0 + i - a])
                    }
                }
                if r0 - a > 0 && c0 + i - a < C {
                    array.append([r0 - a, c0 + i - a])
                }
                if r0 + a < R && c0 - i + a > 0 {
                    array.append([r0 + a, c0 - i + a])
                }
                if r0 - a > 0 && c0 - i + a > 0 {
                    array.append([r0 - a, c0 - i + a])
                }
                a = a - 1
            }
            i = i + 1
        }
        return array
    }
}
