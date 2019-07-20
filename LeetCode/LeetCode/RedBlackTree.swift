//
//  RedBlackTree.swift
//  LeetCode
//
//  Created by apple on 2019/5/8.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

private enum RBTreeColor {
    case red
    case black
}


private enum RotationDirection {
    case left
    case right
}

public class RBTreeNode<T: Comparable>: Equatable {
    public typealias RBNode = RBTreeNode<T>
    fileprivate var color: RBTreeColor = .black
    fileprivate var key: T?
    var leftChild: RBNode?
    var rightChild: RBNode?
    fileprivate weak var parent: RBNode?
    
    public init(key: T?, leftChild: RBNode?, rightChild: RBNode?, parent: RBNode?) {
        self.key = key
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
        
        self.leftChild?.parent = self
        self.rightChild?.parent = self
    }
    
    public convenience init(key: T?) {
        self.init(key: key, leftChild:RBNode(), rightChild: RBNode(), parent:RBNode())
    }

    static public func == <T>(lhs: RBTreeNode<T>, rhs: RBTreeNode<T>) -> Bool {
        return lhs.key == rhs.key
    }

    public convenience init() {
        self.init(key: nil, leftChild: nil, rightChild: nil, parent:nil)
        self.color = .black
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return rightChild == nil && leftChild == nil
    }
    
    var isNullLeaf: Bool {
        return key == nil && isLeaf && color == .black
    }
    
    var isLeftChild: Bool {
        return parent?.leftChild == self
    }
    
    var isRightChild: Bool {
        return parent?.rightChild == self
    }
    
    var grandparent: RBNode? {
        return parent?.parent
    }
    
    var sibling: RBNode? {
        if isLeftChild {
            return parent?.rightChild
        } else {
            return parent?.leftChild
        }
    }
    
    var uncle: RBNode? {
        return parent?.sibling
    }

}


public class RedBlackTree<T: Comparable> {
    public typealias RBNode = RBTreeNode<T>
    
    fileprivate(set) var root: RBNode
    fileprivate(set) var size = 0
    fileprivate let nullLeaf = RBNode()
    
    public init() {
        root = nullLeaf
    }
}

//MARK: - Finding a nodes successor

extension RBTreeNode {
    public func getSuccessor() -> RBNode? {
        if let rightChild = self.rightChild {
            if !rightChild.isNullLeaf {
                return rightChild.minimum()
            }
        }
        var currentNode = self
        var parent = currentNode.parent
        while currentNode.isRightChild {
            if let parent = parent {
                currentNode = parent
            }
            parent = currentNode.parent
        }
        return parent
    }
}

//MARK: - Searching

extension RBTreeNode {
    public func minimum() -> RBNode? {
        if let leftChild = self.leftChild {
            if !leftChild.isNullLeaf {
                return leftChild.minimum()
            }
            return self
        }
        return self
    }
    
    public func maximum() -> RBNode? {
        if let rightChild = rightChild {
            if !rightChild.isNullLeaf {
                return rightChild.maximum()
            }
            return self
        }
        return self
    }
}

extension RedBlackTree {
    fileprivate func search(key: T, node: RBNode?) -> RBNode? {
        guard let node = node else {
            return nil
        }
        if !node.isNullLeaf {
            if let nodeKey = node.key {
                if key == nodeKey {
                    return node
                } else if key < nodeKey {
                    return search(key: key, node: node.leftChild)
                } else {
                    return search(key: key, node: node.rightChild)
                }
            }
        }
        return nil
    }
    
    public func search(input: T) -> RBNode? {
        return search(key: input, node: self.root)
    }
}

// MARK: - Finding maximum and minumum

extension RedBlackTree {
    public func minValue() -> T? {
        guard let minNode = root.minimum() else {
            return nil
        }
        return minNode.key
    }
    
    public func maxValue() -> T? {
        guard let maxNode = root.maximum() else {
            return nil
        }
        return maxNode.key
    }
}

// MARK: - Inserting new nodes

extension RedBlackTree {
    public func insert(key: T) {
        if root.isNullLeaf {
            root = RBNode(key: key)
        } else {
            
        }
        size += 1
    }
    
    private func insert(input: RBNode, node: RBNode) {
        guard let inputKey = input.key, let nodeKey = node.key else {
            return
        }
        if inputKey < nodeKey {
            guard let child = node.leftChild else {
                addAsLeftChild(child: input,  parent: node)
                return
            }
            if child.isNullLeaf {
                addAsLeftChild(child: input,  parent: node)
            } else {
                insert(input: input, node: child)
            }
        } else {
            guard let child = node.rightChild else {
                addAsRightChild(child: input, parent: node)
                return
            }
            if child.isNullLeaf {
                addAsRightChild(child: input, parent: node)
            } else {
                insert(input: input, node: child)
            }
        }
    }
    
    private func addAsLeftChild(child: RBNode, parent: RBNode) {
        parent.leftChild = child
        child.parent = parent
        child.color = .red
        insertFixup(node: child)
    }
    
    private func addAsRightChild(child: RBNode, parent: RBNode) {
        parent.rightChild = child
        child.parent = parent
        child.color = .red
        insertFixup(node: child)
    }
    
    private func insertFixup(node z: RBNode) {
        if !z.isNullLeaf {
            guard let parentZ = z.parent else {
                return
            }
            if parentZ.color == .red {
                guard let uncle = z.uncle else {
                    return
                }
                if uncle.color == .red {
                    parentZ.color = .black
                    uncle.color = .black
                    if let grandparentZ = parentZ.parent {
                        grandparentZ.color = .red
                        insertFixup(node: grandparentZ)
                    }
                } else {
                    var zNew = z
                    if parentZ.isLeftChild && z.isRightChild {
                        zNew = parentZ
                        leftRotate(node: zNew)
                    } else if parentZ.isRightChild && z.isLeftChild {
                        zNew = parentZ
                        rightRotate(node: zNew)
                    }
                    zNew.parent?.color = .black
                    if let grandprentZnew = zNew.parent {
                        grandprentZnew.color = .red
                        if z.isLeftChild {
                            rightRotate(node: grandprentZnew)
                        } else {
                            leftRotate(node: grandprentZnew)
                        }
                    }
                }
            }
        }
        root.color = .black
    }
    
}

extension RedBlackTree {
    public func delete(key: T) {
        if size == 1 {
            root = nullLeaf
            size -= 1
        } else if let node = search(key: key, node: root) {
            if !node.isNullLeaf {
                delete(node: node)
                size -= 1
            }
        }
    }
    
    private func delete(node z: RBNode) {
        var nodeY = RBNode()
        var nodeX = RBNode()
        if let leftChild = z.leftChild, let rightChild = z.rightChild {
            if leftChild.isNullLeaf || rightChild.isNullLeaf {
                nodeY = z
            } else {
                if let successor = z.getSuccessor() {
                    nodeY = successor
                }
            }
        }
        if let leftChild = nodeY.leftChild {
            if !leftChild.isNullLeaf {
                nodeX = leftChild
            } else  if let rightChild = nodeY.rightChild {
                nodeX = rightChild
            }
        }
        nodeX.parent = nodeY.parent
        if let parentY = nodeY.parent {
            if parentY.isNullLeaf {
                root = nodeX
            } else {
                if nodeY.isLeftChild {
                    parentY.leftChild = nodeX
                } else {
                    parentY.rightChild = nodeX
                }
            }
        } else {
            root = nodeX
        }
        if nodeY != z {
            z.key = nodeY.key
        }
        if nodeY.color == .black {
            deleteFixup(node: nodeX)
        }
    }
    
    private func deleteFixup(node x: RBNode) {
        var xTmp = x
        if !x.isRoot && x.color == .black {
            guard var sibling = x.sibling else {
                return
            }
            // Case 1: Sibling of x is red
            if sibling.color == .red {
                // Recolor
                sibling.color = .black
                if let parentX = x.parent {
                    parentX.color = .red
                    // Rotation
                    if x.isLeftChild {
                        leftRotate(node: parentX)
                    } else {
                        rightRotate(node: parentX)
                    }
                    // Update sibling
                    if let sibl = x.sibling {
                        sibling = sibl
                    }
                }
            }
            // Case 2: Sibling is black with two black children
            if sibling.leftChild?.color == .black && sibling.rightChild?.color == .black {
                // Recolor
                sibling.color = .red
                // Move fake black unit upwards
                if let parentX = x.parent {
                    deleteFixup(node: parentX)
                }
                // We have a valid red-black-tree
            } else {
                // Case 3: a. Sibling black with one black child to the right
                if x.isLeftChild && sibling.rightChild?.color == .black {
                    // Recolor
                    sibling.leftChild?.color = .black
                    sibling.color = .red
                    // Rotate
                    rightRotate(node: sibling)
                    // Update sibling of x
                    if let sibl = x.sibling {
                        sibling = sibl
                    }
                }
                    // Still case 3: b. One black child to the left
                else if x.isRightChild && sibling.leftChild?.color == .black {
                    // Recolor
                    sibling.rightChild?.color = .black
                    sibling.color = .red
                    // Rotate
                    leftRotate(node: sibling)
                    // Update sibling of x
                    if let sibl = x.sibling {
                        sibling = sibl
                    }
                }
                // Case 4: Sibling is black with red right child
                // Recolor
                if let parentX = x.parent {
                    sibling.color = parentX.color
                    parentX.color = .black
                    // a. x left and sibling with red right child
                    if x.isLeftChild {
                        sibling.rightChild?.color = .black
                        // Rotate
                        leftRotate(node: parentX)
                    }
                        // b. x right and sibling with red left child
                    else {
                        sibling.leftChild?.color = .black
                        //Rotate
                        rightRotate(node: parentX)
                    }
                    // We have a valid red-black-tree
                    xTmp = root
                }
            }
        }
        xTmp.color = .black
    }
}

extension RedBlackTree {
    
    fileprivate func leftRotate(node x: RBNode) {
        rotate(node: x, direction: .left)
    }
    
    fileprivate func rightRotate(node x: RBNode) {
        rotate(node: x, direction: .right)
    }
    
    private func rotate(node x: RBNode, direction: RotationDirection) {
        var nodeY: RBNode? = RBNode()
        switch direction {
        case .left:
            nodeY = x.rightChild
            x.rightChild = nodeY?.leftChild
            x.rightChild?.parent = x
        case .right:
            nodeY = x.leftChild
            x.leftChild = nodeY?.rightChild
            x.leftChild?.parent = x
        }
        nodeY?.parent = x.parent
        if x.isRoot {
            if let node = nodeY {
                root = node
            }
        } else if x.isLeftChild {
            x.parent?.leftChild = nodeY
        } else if x.isRightChild {
            x.parent?.rightChild = nodeY
        }
        switch direction {
        case .left:
            nodeY?.leftChild = x
        case .right:
            nodeY?.rightChild = x
            
        }
        x.parent = nodeY
    }
}

// MARK: - Verify
extension RedBlackTree {
    public func verify() -> Bool {
        if root.isNullLeaf {
            print("the tree is empty")
            return true
        }
        return property2() && property4() && property5()
    }
    
    private func property2() -> Bool {
        if root.color == .red {
            return false
        }
        return true
    }
    // Property 3: Every nullLeaf is black -> fullfilled through initialising nullLeafs with color = black
    // Property 4: If a node is red, then both its children are black

    private func property4() -> Bool {
        return property4(node: root)
    }
    
    private func property4(node: RBNode) -> Bool {
        if node.isNullLeaf {
            return true
        }
        if let leftChild = node.leftChild , let rightChild = node.rightChild {
            if node.color == .red {
                if !leftChild.isNullLeaf && leftChild.color == .red {
                    return false
                }
                if !rightChild.isNullLeaf && rightChild.color == .red {
                    return false
                }
            }
            return property4(node: leftChild) && property4(node: rightChild)
        }
        return false
    }
    
    private func property5() -> Bool {
        if property5(node: root) == -1 {
            return false
        } else {
            return true
        }
    }
    
    private func property5(node: RBNode) -> Int {
        if node.isNullLeaf {
            return 0
        }
        guard let leftChild = node.leftChild,let rightChild = node.rightChild else {
            return -1
        }
        let left = property5(node: leftChild)
        let right = property5(node: rightChild)
        if left == -1 || right == -1 {
            return -1
        } else if left == right {
            let addedHeight = node.color == .black ? 1 : 0
            return left + addedHeight
        } else {
            return -1
        }
    }
}

// MARK: - Debugging

extension RBTreeNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        var s = ""
        if isNullLeaf {
            s = "nullLeaf"
        } else {
            if let key = key {
                s = "key: \(key)"
            } else {
                s = "key: nil"
            }
            if let parent = parent {
                s += ", parent: \(String(describing: parent.key))"
            }
            if let left = leftChild {
                s += ", left = [" + left.debugDescription + "]"
            }
            if let right = rightChild {
                s += ", right = [" + right.debugDescription + "]"
            }
            s += ", color = \(color)"
        }
        return s
    }
}

extension RedBlackTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        return root.debugDescription
    }
}

extension RBTreeNode: CustomStringConvertible {
    public var description: String {
        var s = ""
        if isNullLeaf {
            s += "nullLeaf"
        } else {
            if let left = leftChild {
                s += "(\(left.debugDescription)) <-"
            }
            if let key = key {
                s += "\(key)"
            } else {
                s += "nil"
            }
            s += ", \(color)"
            if let right = rightChild {
                s += "-> (\(right.description))"
            }
        }
        return s
    }
}

extension RedBlackTree: CustomStringConvertible {
    public var description: String {
        if root.isNullLeaf {
            return "[]"
        } else {
            return root.description
        }
    }
}















