//
//  TreeNode.swift
//  Tree
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

public class TreeNode<Key: Comparable, Payload> {
    public typealias Node = TreeNode<Key, Payload>
    
    var payload: Payload?
    
    internal var key: Key
    internal var leftChild: Node?
    internal var rightChild: Node?
    internal var height: Int
    weak internal var parent: Node?
    
    public init(key: Key, payload: Payload?, leftChild: Node?, rightChild: Node?, parent: Node?, height: Int) {
        self.key = key
        self.payload = payload
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
        self.height = height
        self.leftChild?.parent = self
        self.rightChild?.parent = self
    }
    
    public convenience init(key: Key, payload: Payload?) {
        self.init(key: key, payload: payload, leftChild: nil, rightChild: nil, parent: nil, height: 1)
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return rightChild == nil && leftChild == nil
    }
    
    var isLeftChild: Bool {
        return parent?.leftChild === self
    }
    
    var isRightChild: Bool {
        return parent?.rightChild === self
    }
    
    var hasLeftChild: Bool {
        return leftChild != nil
    }
    
    var hasRightChild: Bool {
        return leftChild != nil || rightChild != nil
    }
    
    var hasBothChildren: Bool {
        return leftChild != nil && rightChild != nil
    }
}

extension TreeNode {
    public func minimum() -> TreeNode? {
        return leftChild?.minimum() ?? self
    }
    
    public func maximum() -> TreeNode? {
        return rightChild?.maximum() ?? self
    }
}

extension TreeNode: CustomStringConvertible, CustomDebugStringConvertible {
    public var debugDescription: String {
        var s = "key: \(key), payload: \(String(describing: payload)), height: \(height)"
        if let parent = parent {
            s += ", parent: \(parent.key)"
        }
        if let left = leftChild {
            s += ", left = [" + left.debugDescription + "]"
        }
        if let right = rightChild {
            s += ", right = [" + right.debugDescription + "]"
        }
        return s
    }
    
    public var description: String {
        var s = ""
        if let left = leftChild {
            s += "(\(left.description)) <-"
        }
        s += "\(key)"
        if let right = rightChild {
            s += " -> (\(right.description))"
        }
        return s
    }
}
