//
//  main.swift
//  ProtocolExtension
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

print("Hello, World!")

struct Literal: ExpressibleByArrayLiteral {
    var i: ArrayLiteralElement
    init(arrayLiteral elements: Int...) {
        i = elements.first!
    }
    
    typealias ArrayLiteralElement = Int
    

}

struct KQueueEventFilterSet: OptionSet, Equatable {
    typealias RawValue = UInt8
    
    let rawValue: RawValue
    
    static let _none = KQueueEventFilterSet(rawValue: 0)
    // skipping `1 << 0` because kqueue doesn't have a direct match for `.reset` (`EPOLLHUP` for epoll)
    static let except = KQueueEventFilterSet(rawValue: 1 << 1)
    static let read = KQueueEventFilterSet(rawValue: 1 << 2)
    static let write = KQueueEventFilterSet(rawValue: 1 << 3)
    
    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

let queue1 = KQueueEventFilterSet(rawValue: 1)
let queue2 = KQueueEventFilterSet(rawValue: 2)
//let queue3 = KQueueEventFilterSet(rawValue: [1,2,3,4,5,6,7])

print(queue1.contains(queue2))
