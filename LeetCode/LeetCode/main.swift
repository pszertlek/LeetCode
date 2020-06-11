//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

let cache = LRUCache(2)
cache.put(1, 1);
cache.put(2, 2);
print(cache.get(1));       // 返回  1
cache.put(3, 3);    // 该操作会使得关键字 2 作废
print(cache.get(2));       // 返回  -1
cache.put(4, 4);    // 该操作会使得关键字 1 作废
print(cache.get(1));       // 返回 -1 (未找到)
print(cache.get(3));    // 返回  3
print(cache.get(4));       // 返回  4
print(BitComputeSolution().rangeBitwiseAnd(5, 7))
