//
//  Selector.swift
//  isPalindrome
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

struct SelectorEventSet: OptionSet, Equatable {
    typealias RawValue = UInt8
    let rawValue: RawValue
    
    static let _none = SelectorEventSet(rawValue: 0)
    static let reset = SelectorEventSet(rawValue: 1)
    static let readEOF = SelectorEventSet(rawValue: 1 << 1)
    static let read = SelectorEventSet(rawValue: 1 << 2)
    static let write = SelectorEventSet(rawValue: 1 << 3)
    
    init(rawValue: SelectorEventSet.RawValue) {
        self.rawValue = rawValue
    }
}

private struct KQueueEventFilterSet: OptionSet, Equatable {
    typealias RawValue = UInt8
    let rawValue: RawValue
    
    static let _none = KQueueEventFilterSet(rawValue: 0)
    static let except = KQueueEventFilterSet(rawValue: 1 << 1)
    static let read = KQueueEventFilterSet(rawValue: 1 << 2)
    static let write = KQueueEventFilterSet(rawValue: 1 << 3)
    
    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

private struct EpollFilterSet: OptionSet, Equatable {
    typealias RawValue = UInt8
    
    let rawValue: RawValue
    
    static let _none = EpollFilterSet(rawValue: 0)
    static let hangup = EpollFilterSet(rawValue: 1 << 0)
    static let readHangup = EpollFilterSet(rawValue: 1 << 1)
    static let input = EpollFilterSet(rawValue: 1 << 2)
    static let output = EpollFilterSet(rawValue: 1 << 3)
    static let error = EpollFilterSet(rawValue: 1 << 4)
    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension KQueueEventFilterSet {
    init(selectorEventSet: SelectorEventSet) {
        var kqueueFilterSet: KQueueEventFilterSet = .init(rawValue: 0)
        if selectorEventSet.contains(.read) {
            kqueueFilterSet.formUnion(.read)
        }
        
        if selectorEventSet.contains(.write) {
            kqueueFilterSet.formUnion(.write)
        }
        
        if selectorEventSet.contains(.readEOF) {
            kqueueFilterSet.formUnion(.except)
        }
        self = kqueueFilterSet
    }
    
    func calculateKQueueFilterSetChanges(previousKqueueFilterSet: KQueueEventFilterSet,
                                         fileDescriptor: CInt,
                                         _ body: (UnsafeMutableBufferPointer<kevent>) throws -> Void) rethrows {
        var keventHopefullyOnStack = (kevent(), kevent(), kevent())
        try withUnsafeMutableBytes(of: &keventHopefullyOnStack, { rawPtr in assert(MemoryLayout<kevent>.size * 3 == rawPtr.count)
            let keventBuffer = rawPtr.baseAddress!.bindMemory(to: kevent.self, capacity: 3)
            
//            let differences = previousKqueueFilterSet.symmetricDifference(<#T##other: KQueueEventFilterSet##KQueueEventFilterSet#>)
            
        })
    }
}
