//
//  MaxAreaOfIsland.swift
//  LeetCode
//
//  Created by apple on 2017/11/29.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

class MaxAreaOfIsland {
//    func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
//        grid[0][0]
//        let column = grid.count;
//        let row = grid.first!.count;
//        func ssss(x: Int,y: Int) -> Bool {
//            var set = Set<Int>()
//            set.insert(x * row + column)
//        }
////        func top(x: Int,y: Int) -> 
//        
//    }
    

}

 

class AllOne {
    var buckets = [Bucket]()
//    var hashmap: [String: [Bucket]]
    var head: Bucket?
    var tail: Bucket?
    var maxKey: String?
    var minKey: String?
    var maxVal: Int {
        if let maxKey = self.maxKey {
            return dict[maxKey] ?? Int.min
        } else {
            return Int.min
        }
    }
    var minVal: Int {
        if let minKey = self.minKey {
            return dict[minKey] ?? Int.max
        } else {
            return Int.max
        }
    }
    class Bucket {
        var val: Int = 1
        var keys: Set<String> = Set<String>()
    }
    
    var dict = [String: Int]()
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Inserts a new key <Key> with value 1. Or increments an existing key by 1. */
    func inc(_ key: String) {
        let value = (dict[key] ?? 0) + 1
        dict[key] = value
        if value > 1 {
            buckets[value - 2].keys.remove(key)
        }
        
        if buckets.count < value  {
            let b = Bucket()
            b.val = value
            buckets.append(b)
        }
        buckets[value - 1].keys.insert(key)
        
        if let maxKey = maxKey {
            let maxVal = dict[maxKey]!
            self.maxKey = maxVal >= value ? maxKey : key
        } else {
            maxKey = key
        }
        
        if value > maxVal {
            maxKey = value != 0 ? key : nil
        }
        if value < minVal {
            minKey = value != 0 ? key : nil
        }
    }
    
    /** Decrements an existing key by 1. If Key's value is 1, remove it from the data structure. */
    func dec(_ key: String) {
        let value = (dict[key] ?? 0) - 1
        if value < 0 {
            return
        }
        if value < 1 {
            buckets[0].keys.remove(key)
            dict[key] = nil
        } else {
            buckets[value - 1].keys.insert(key)
            buckets[value].keys.remove(key)
            dict[key] = value
        }
        
        if value > maxVal {
            maxKey = key
        }
        if value < minVal {
            minKey = key
        }
    }
    
    /** Returns one of the keys with maximal value. */
    func getMaxKey() -> String {
        return maxKey ?? ""
    }
    
    /** Returns one of the keys with Minimal value. */
    func getMinKey() -> String {
        return minKey ?? ""
    }
}
