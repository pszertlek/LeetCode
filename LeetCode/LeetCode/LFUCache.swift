//
//  LFUCache.swift
//  LeetCode
//
//  Created by Apple on 2020/9/12.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

class LFUColum<Element>: Comparable {
    static func < (lhs: LFUColum<Element>, rhs: LFUColum<Element>) -> Bool {
        return lhs.times < rhs.times
    }
    
    static func == (lhs: LFUColum<Element>, rhs: LFUColum<Element>) -> Bool {
        return lhs.times == rhs.times
    }
    
    var times: Int = 1
    var linkedList = LinkedList<LFUItem<Element>>()
    
    init(_ times: Int) {
        self.times = times
    }
    
    
    
}

class LFUItem<Element> {
    
    var value: Element
    var times: Int = 1
    
    init(_ value: Element) {
        self.value = value
    }
}


//class LFUCache<Element: Equatable, Key: Hashable> {
//    
//    var columnList = LinkedList<LFUColum<Element>>()
//        
//    var dict: [Key: LinkedListNode<LFUItem<Element>>] = [:]
//    
//    var timesDict: [Int: LinkedListNode<LFUColum<Element>>] = [:]
//    
//    var capacity: Int
//    
//    init(_ capacity: Int) {
//        self.capacity = capacity
//    }
//    
////    @inlinable subscript(key: Key) -> Element? {
////        get {
////            return dict[key]?.value
////        }
////        set {
////
////        }
////    }
//    
//    func put(_ value: Element, _ key: Key) {
//        if let _ = dict[key] {
//            // 如果key 存在，删除当前元素
//            self.remove()
//            
//        }
//        
//        // 如果key 不再在，重新创建元素，次数为1
//        
//        let item = LFUItem<Element>(value)
//
//        if dict.count > capacity {
//
//        }
//    }
//    
//    func get(_ key: Key) -> Element? {
//        guard let item = dict[key] else {
//            return nil
//        }
//        /*存在时，当前次数列删除元素
//        然后+1次数的列首元素设置为元素
//         之后判断当前次数的列是否为空，为空则删除
// 
//         */
//        return item.value.value
//    }
//    
//    private func remove() {
//        
//    }
//    
//
//
//}
