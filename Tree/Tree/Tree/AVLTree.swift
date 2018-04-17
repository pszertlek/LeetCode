//
//  AVLTree.swift
//  Tree
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation


open class AVLTree<Key: Comparable, Payload> {
    public typealias Node = TreeNode<Key, Payload>
    
    fileprivate(set) var root: Node?
    fileprivate(set) var size = 0
    public init() {}
    
}


extension AVLTree {
    subscript(key: Key) -> Payload? {
        get {
            return search(input: key)
        }
        set {
            insert(key: key, payload: newValue)
        }
    }
    
    public func insert(key: Key, payload: Payload? = nil) {
        if let root = root {
            insert(input: key, payload: payload, node: root)
        } else {
            root = Node(key: key, payload: payload)
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
        } else if input != node.key {
            if let child = node.rightChild {
                insert(input: input, payload: payload, node: child)
            } else {
                let child = Node(key: input, payload: payload, leftChild: nil, rightChild: nil, parent: node, height: 1)
                node.rightChild = child
                balance(node: child)
            }
        }
    }
    
    private func search(key: Key, node: Node?) -> Node? {
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
    
    public func search(input: Key) -> Payload? {
        return search(key: input, node: root)?.payload
    }
    
    func balance(node: Node) {
        
    }
}

extension AVLTree {
    fileprivate func updateHeightUpwards(node: Node?) {
        if let node = node {
            let lHeight = node.leftChild?.height ?? 0
            let rHeight = node.rightChild?.height ?? 0
            node.height = max(lHeight, rHeight) + 1
            updateHeightUpwards(node: node.parent)
        }
    }
    
    fileprivate func lrDifference(node: Node?) -> Int {
        let lHeight = node?.leftChild?.height ?? 0
        let rHeight = node?.rightChild?.height ?? 0
        return lHeight - rHeight
    }
    
    fileprivate func balance(node: Node?) {
        guard let node = node else {
            return
        }
        
        updateHeightUpwards(node: node.leftChild)
        updateHeightUpwards(node: node.rightChild)
        
        var nodes = [Node?](repeating: nil, count: 3)
        var subtrees = [Node?](repeating: nil, count: 4)
        let nodeParent = node.parent
        
        let lrFactor = lrDifference(node: node)
        if lrFactor > 1 {
            // left-left or left-right
            if lrDifference(node: node.leftChild) > 0 {
                // left-left
                nodes[0] = node
                nodes[2] = node.leftChild
                nodes[1] = nodes[2]?.leftChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[1]?.rightChild
                subtrees[2] = nodes[2]?.rightChild
                subtrees[3] = nodes[0]?.rightChild
            } else {
                // left-right
                nodes[0] = node
                nodes[1] = node.leftChild
                nodes[2] = nodes[1]?.rightChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[2]?.leftChild
                subtrees[2] = nodes[2]?.rightChild
                subtrees[3] = nodes[0]?.rightChild
            }
        } else if lrFactor < -1 {
            // right-left or right-right
            if lrDifference(node: node.rightChild) < 0 {
                // right-right
                nodes[1] = node
                nodes[2] = node.rightChild
                nodes[0] = nodes[2]?.rightChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[2]?.leftChild
                subtrees[2] = nodes[0]?.leftChild
                subtrees[3] = nodes[0]?.rightChild
            } else {
                // right-left
                nodes[1] = node
                nodes[0] = node.rightChild
                nodes[2] = nodes[0]?.leftChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[2]?.leftChild
                subtrees[2] = nodes[2]?.rightChild
                subtrees[3] = nodes[0]?.rightChild
            }
        } else {
            // Don't need to balance 'node', go for parent
            balance(node: node.parent)
            return
        }
        
        // nodes[2] is always the head
        
        if node.isRoot {
            root = nodes[2]
            root?.parent = nil
        } else if node.isLeftChild {
            nodeParent?.leftChild = nodes[2]
            nodes[2]?.parent = nodeParent
        } else if node.isRightChild {
            nodeParent?.rightChild = nodes[2]
            nodes[2]?.parent = nodeParent
        }
        
        nodes[2]?.leftChild = nodes[1]
        nodes[1]?.parent = nodes[2]
        nodes[2]?.rightChild = nodes[0]
        nodes[0]?.parent = nodes[2]
        
        nodes[1]?.leftChild = subtrees[0]
        subtrees[0]?.parent = nodes[1]
        nodes[1]?.rightChild = subtrees[1]
        subtrees[1]?.parent = nodes[1]
        
        nodes[0]?.leftChild = subtrees[2]
        subtrees[2]?.parent = nodes[0]
        nodes[0]?.rightChild = subtrees[3]
        subtrees[3]?.parent = nodes[0]
        
        updateHeightUpwards(node: nodes[1])    // Update height from left
        updateHeightUpwards(node: nodes[0])    // Update height from right
        
        balance(node: nodes[2]?.parent)
    }
}

extension AVLTree {
    public func delete(key: Key) {
        if size == 1 {
            root = nil
            size -= 1
        } else if let node = search(key: key, node: root) {
            delete(node: node)
            size -= 1
        }
    }
    
    private func delete(node: Node) {
        if node.isLeaf {
            if let parent = node.parent {
                guard node.isLeftChild || node.isRightChild else {
                    fatalError("Tree is invalid.")
                }
                if node.isLeftChild {
                    parent.leftChild = nil
                } else if node.isRightChild {
                    parent.rightChild = nil
                }
                balance(node: parent)
                
            } else {
                root = nil
            }

        } else {
            if let replacement = node.leftChild?.maximum(),
                replacement !== node {
                node.key = replacement.key
                node.payload = replacement.payload
                delete(node: replacement)
            } else if let replacement = node.rightChild?.minimum(), replacement !== node {
                node.key = replacement.key
                node.payload = replacement.payload
                delete(node: replacement)
            }
        }
    }
}

extension AVLTree {
    public func doInOrder(node: Node?, _ completion: (Node) -> Void) {
        if let node = node {
            doInOrder(node: node.leftChild, completion)
            completion(node)
            doInOrder(node: node.rightChild, completion)
        }
    }
    
    public func doInPreOrder(node: Node?, _ completion: (Node) -> Void) {
        if let node = node {
            completion(node)
            doInPreOrder(node: node.leftChild, completion)
            doInPreOrder(node: node.rightChild, completion)
        }
    
    }
    
    public func doInPostOrder(node: Node?, _ completion: (Node) -> Void) {
        if let node = node {
            doInPostOrder(node: node, completion)
            doInPostOrder(node: node, completion)
            completion(node)
        }
    }
}

extension AVLTree: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return root?.description ?? "[]"
    }
    
    public var debugDescription: String {
        return root?.debugDescription ?? "[]"
    }
}
