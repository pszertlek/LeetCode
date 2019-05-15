//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation




//print(StringSolution().restoreIpAddresses("25525511135"))
//print(StringSolution().restoreIpAddresses("010010"))
//["LRUCache","put","put","get","put","get","put","get","get","get"]
//[[2],       [1,1],[2,2],[1],  [3,3],[2],  [4,4], [1],  [3],  [4]]
let cache = LRUCache(2)

for i in [[1,1],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]] {
    if i.count == 1 {
        print(cache)
        print("key:\(i[0]) value:\(cache.get(i[0]))")
    } else {
        cache.put(i[0], i[1])
    }

}


