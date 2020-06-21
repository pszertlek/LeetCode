//
//  Stack.swift
//  DataStructure
//
//  Created by Apple on 2020/6/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

public struct stack<T> {
    var data: [T] = []
    
    public mutating func pop() -> T? {
        return data.popLast()
    }
    
    public mutating func push(_ i: T) {
        data.append(i)
    }
}
