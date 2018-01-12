//
//  MinStack.swift
//  StackProblem
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

class MinStack {
    var array = [Int]()
    var decreaseArray = [Int]()
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public func push(_ element: Int) {
        array.append(element)
        var i : Int = 0
        for (index,e) in decreaseArray.enumerated() {
            if e < element {
                decreaseArray.insert(element, at: index)
                return
            }
        }
        decreaseArray.append(element)
    }
    
    func pop(){
        let element = array.popLast()
        
        for (index,e) in decreaseArray.enumerated() {
            if e == element {
                decreaseArray.remove(at: index)
                break;
            }
        }
        
    }
    
    func getMin() -> Int? {
        return decreaseArray.last
    }
    public var top: Int? {
        return array.last
    }
}
