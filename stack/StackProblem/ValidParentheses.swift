//
//  ValidParentheses.swift
//  Tests
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 Swift Algorithm Club. All rights reserved.
//

import Foundation


func ValidParentheses(_ s: String) -> Bool {
    var stack = Stack<Character>()
    for c in s {
        if c == "("{
            stack.push(c)
        } else if c == "[" {
            stack.push(c)
        } else if c == ")" {
            if stack.top == "(" {
                stack.pop()
            } else {
                return false
            }
        } else if c == "]" {
            if stack.top == "[" {
                stack.pop()
            } else {
                return false
            }
        } else if c == "{" {
            stack.push(c)
        } else if c == "}" {
            if stack.top == "{" {
                stack.pop()
            } else {
                return false
            }
        }
    }
    return stack.isEmpty
}
