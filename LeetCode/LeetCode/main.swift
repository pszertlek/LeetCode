//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

public class TreeNode<Key: Comparable, Payload> {
    public typealias Node = TreeNode<Key, Payload>
    var payload: Payload?
    fileprivate var key: Key
    internal var leftChild: Node?
    internal var rightChild: Node?
    fileprivate var height: Int
    weak fileprivate var parent: Node?
    public init(key: Key, payload: Payload?, leftChild: Node?, rightChild: Node?, parent: Node?, height: Int) {
        self.key = key
        self.payload = payload
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
        self.height = height
        
        self.leftChild?.parent = self;
        self.rightChild?.parent = self;
    }
    public convenience init(key: Key,paylaod: Payload) {
        self.init(key: key, payload: nil, leftChild: nil, rightChild: nil, parent: nil, height: 1)
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
    
    var hasAnyChild: Bool {
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
    
    public func maxmum() -> TreeNode? {
        return rightChild?.maxmum() ?? self
    }
}

open class AVLTree<Key: Comparable, Payload> {
    public typealias Node = TreeNode<Key, Payload>
    fileprivate(set) var root: Node?
    fileprivate(set) var size = 0
    public init() {}
}

extension AVLTree {
    subscript(key: Key) -> Payload? {
        get { return search(input: key) }
        set { insert(key: Key, payload: newValue) }
    }
    
    public func search(input: Key) -> Payload? {
        return search(key: input, node: root)?.root
    }
    
    fileprivate func search(key: Key, node: Node?) -> Node? {
        if let node = node {
            if key == node.key {
                return node
            } else if key < node.key {
                return search(key: key, node: node.leftChild)
            } else {
                return search(key: key, node: node.rightChild)
            }
        }
        return nil
    }
}

extension AVLTree {
    public func insert(key: Key, payload: Payload? = nil) {
        if let root = root {
            insert(key: key, payload: payload, node: root)
        } else {
            root = Node(key: key, paylaod: payload)
        }
        size += 1
    }
    
    private func insert(input: Key, payload: Payload?, node: Node) {
        if input < node.key {
            if let child = node.leftChild {
                insert(input: input, payload: payload, node: child)
            } else {
                let child = Node(key: input, payload: payload, leftChild: nil, rightChild: nil, parent: node, height: 1)
                 node.leftChild = child
                balance(node: child)
            }
        } else {
            if let child = node.rightChild {
                insert(input: input, payload: payload, node: child)
            } else {
                let child = Node(key: input, payload: payload, leftChild: nil, rightChild: nil, parent: node, height: 1)
                node.rightChild = child
                balance(node: child)
            }
        }
    }
}

extension AVLTree {
    fileprivate func updateHeightUpward(node: Node?) {
        if let node = node {
            let lHeight = node.leftChild?.height ?? 0
            let rHeight = node.rightChild?.height ?? 0
            node.height = max(lHeight, rHeight) + 1
            updateHeightUpward(node: node.parent)
        }
    }
    
    fileprivate func lrDifference(node: Node?) -> Int {
        let lHeight = node?.leftChild?.height ?? 0
        let rHeight = node?.rightChild?.height ?? 0
        return lHeight - rHeight
    }
}

