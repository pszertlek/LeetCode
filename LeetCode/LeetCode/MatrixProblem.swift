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
