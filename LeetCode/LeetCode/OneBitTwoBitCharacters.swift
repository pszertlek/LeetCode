//
//  OneBitTwoBitCharacters.swift
//  LeetCode
//
//  Created by apple on 2017/11/28.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

func isOneBitCharacter(_ bits: [Int]) -> Bool {
    guard let last = bits.last, last == 0 else {
        return false
    }
    let i = bits.count - 2
    if i < 0 {
        return true
    }
    if i == 0 && bits[i] == 1 {
        return false
    }
    func sss(_ i: Int) -> Bool {
        if i == 0  {
            return bits[i] == 0
        }
        if bits[i] == 1 && bits[i - 1] == 0 {
            return false
        } else if bits[i] == 1 && bits[i - 1] == 1 {
            if i >= 2 {
                return sss(i - 2)
            } else {
                return true
            }
        }  else {
            if i >= 2 {
                return sss(i - 1) || sss(i - 2)
            } else {
                return true
            }
        }
    }
    
    return sss(i)
}

class OneBitTwoBit {
    func isOneBitCharacter(_ bits: [Int]) -> Bool {
        if bits.last == 1 {
            return false
        }
        guard bits.last == 1 else {
            return false
        }
        let count = bits.count
        guard count % 2 == 1 else {
            return false
        }
        guard bits[count - 2] != 0 else {
            return true
        }
        return false
    }
    
}
