//
//  TreeNode.swift
//  BinaryTree
//
//  Created by Pszertlek on 2018/2/20.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

public class ListNode<T> {
    public var val: T
    public var next: ListNode?
    public init(_ val: T) {
        self.val = val
        self.next = nil
    }
    
}

public class TreeNode<T>: ExpressibleByArrayLiteral,CustomStringConvertible {
    public var description: String {
        let levelArray = levelOrder(self)
        var string = ""
        levelArray.forEach { (level) in
            string.append("\(level)\n")
        }
        return string
    }
    
    
    
    public typealias ArrayLiteralElement = T?
    
    public var val: T
    public var left: TreeNode?
    public var right: TreeNode?
    public var next: TreeNode?
    public init(_ val: T) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    public required init(arrayLiteral elements: T?...) {
        self.val = elements[0]!
        var levelArray = [TreeNode]()
        levelArray.append(self)
        var i = 1, height = 1
        while i < elements.count {
            let node = levelArray[0]
            var left: TreeNode? = nil , right:TreeNode? = nil
            if let leftVal = elements[i] {
                left = TreeNode(leftVal)
                node.left = left
                levelArray.append(left!)
            }
            if i + 1 < elements.count , let rightVal = elements[i+1] {
                right = TreeNode(rightVal)
                node.right = right
                levelArray.append(right!)
            }
            levelArray.removeFirst()
            i = i + 2
        }
    }
    
    
    
    func preorderTraversal(_ root: TreeNode?) -> [T] {
        var nums = [T]()
        var node: TreeNode? = root
        var nodeStack = [TreeNode]()
        while let theNode = node {
            nums.append(theNode.val)
            if theNode.left != nil {
                nodeStack.append(theNode)
                node = theNode.left
            } else if theNode.right != nil {
                node = theNode.right
            } else {
                if nodeStack.last == nil {
                    break
                }
                while let root = nodeStack.last {
                    if root.right != nil {
                        node = root.right
                        nodeStack.removeLast()
                        break;
                    } else {
                        nodeStack.removeLast()
                        if nodeStack.count == 0 {
                            return nums
                        }
                    }
                }
            }
        }
        return nums
    }
    
//    func inorderTravelsal(_ root:TreeNode?) -> [T] {
//        var stack = [TreeNode](), result = [T]()
//        var node = root
//        while let theNode = node {
//            if theNode.left != nil {
//                stack.append(theNode)
//                node = theNode.left
//            } else if theNode.right != nil {
//                result.append(theNode.val)
//                node = theNode.right
//            } else {
//                result.append(theNode.val)
//                node = nil
//                while let root = stack.popLast() {
//                    result.append(root.val)
//                    if root.right != nil {
//                        node = root.right
//                        break
//                    }
//                }
//            }
//        }
//    }
    
    func inorderTraversal(_ root: TreeNode?) -> [T] {
        var stack = [TreeNode](),result = [T]()
        var node = root
        while let theNode = node {
            if theNode.left != nil {
                stack.append(theNode)
                node = theNode.left
            } else if theNode.right != nil {
                result.append(theNode.val)
                node = theNode.right
            } else {
                result.append(theNode.val)
                node = nil
                while let root = stack.last {
                    result.append(root.val)
                    if root.right != nil {
                        stack.removeLast()
                        node = root.right
                        break;
                    } else {
                        stack.removeLast()
                        if stack.count == 0 {
                            node = nil
                        }
                    }
                }
            }
        }
        return result
    }
    
    func levelOrder(_ root: TreeNode?) -> [[T]] {
        var result = [[T]]()
        guard let node = root else {
            return result
        }
        var lastLevel = [node]
        while lastLevel.count != 0 {
            var levelArray = [T]()
            var newLevel = [TreeNode]()
            for n in lastLevel {
                levelArray.append(n.val)
                if let left = n.left {
                    newLevel.append(left)
                }
                if let right = n.right {
                    newLevel.append(right)
                }
            }
            result.append(levelArray)
            lastLevel = newLevel
        }
        return result
    }
}


//extension TreeNode: ExpressibleByArrayLiteral {
//    public typealias ArrayLiteralElement = T
//
//    public required convenience init(arrayLiteral elements: T...) {
//        assert(elements.count == 0)
//        var node = TreeNode(elements[0])
//        for i in 1..<elements.count {
//            let next = TreeNode(elements[i])
//
//        }
//    }
//}

extension TreeNode where T: Comparable {
    public func equal (_ lhs: TreeNode<T>?,_ rhs: TreeNode<T>?) -> Bool {
        if lhs == nil && rhs == nil {
            return true
        } else if let left = lhs, let right = rhs {
            return left.val == right.val
        } else {
            return false
        }
    }
    
    func preorderTraversal1(_ root: TreeNode<T>?) -> [T] {
        var result = [T]()
        var node = root
        
        func travel(_ root: TreeNode<T>?) {
            guard let node = root else {
                return
            }
            visit(node)
            travel(node.left)
            travel(node.right)
        }
        func visit(_ node: TreeNode<T>) {
            result.append(node.val)
        }
        travel(root)
        
        return result
    }
    
    func inorderTraversal1(_ root: TreeNode?) -> [T] {
        var result = [T]()
        var node = root
        
        func travel(_ root: TreeNode<T>?) {
            guard let node = root else {
                return
            }
            travel(node.left)
            visit(node)
            travel(node.right)
        }
        func visit(_ node: TreeNode<T>) {
            result.append(node.val)
        }
        travel(root)
        
        return result
    }
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let left = maxDepth(node.left)
        let right = maxDepth(node.right)
        return max(left, right) + 1
    }
    
    func inorderTraversal2(_ root: TreeNode?) -> [T] {
        var result = [T]()
        var node = root
        
        func travel(_ root: TreeNode<T>?) {
            guard let node = root else {
                return
            }
            travel(node.right)
            visit(node)
            travel(node.left)

        }
        func visit(_ node: TreeNode<T>) {
            result.append(node.val)
        }
        travel(root)
        
        return result
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        let left = root?.left, right = root?.right

        guard equal(left, right) else {
            return false
        }
        var lastLeftLevel = [left], lastRightLevel = [right]
        while  lastLeftLevel.count != 0 && lastRightLevel.count != 0 {
            var newLeftLevel = [TreeNode?](), newRightLevel = [TreeNode?]()
            if lastRightLevel.count != lastLeftLevel.count {
                return false
            }
            var nilCount = 0
            for i in 0..<lastRightLevel.count {
                
                let leftLeft = lastLeftLevel[i]?.left
                let rightRight = lastRightLevel[i]?.right
                guard equal(leftLeft,rightRight) else {
                    return false
                }
                let leftRight = lastLeftLevel[i]?.right
                let rightLeft = lastRightLevel[i]?.left
                guard equal(leftRight,rightLeft) else {
                    return false
                }
                if leftRight == nil {
                    nilCount = nilCount + 1
                }
                newLeftLevel.append(leftLeft)
                newLeftLevel.append(leftRight)
                newRightLevel.append(rightRight)
                newRightLevel.append(rightLeft)

            }
            if nilCount == lastRightLevel.count {
                return true
            }
            nilCount = 0
            lastLeftLevel = newLeftLevel
            lastRightLevel = newRightLevel
        }
        return true
    }
    
    func invertTree(_ root: TreeNode<T>?) -> TreeNode<T>? {
        func invert(_ root: TreeNode<T>?) {
            guard let root = root else {
                return
            }
            let left = root.left
            let right = root.right
            root.left = right
            root.right = left
            invert(left)
            invert(right)
        }
        invert(root)
        return root
        
    }

    func lowestCommonAncestor(_ root: TreeNode<T>, _ p: TreeNode<T>, _ q: TreeNode<T>) -> TreeNode<T> {
        if p.val > q.val && q.val > root.val {
            return lowestCommonAncestor(root.right!, p, q)
        } else if p.val < q.val && q.val < root.val {
            return lowestCommonAncestor(root.left!, p, q)
        } else {
            return root
        }
        
    }
    
    //先序遍历，先访问根节点
    func binaryTreePaths(_ root: TreeNode<T>?) -> [String] {
        guard let root = root else {
            return []
        }
        var result = [String]()
        func preOrder(_ root: TreeNode<T>?, _ s: String) {
            if let node = root {
                let sss = s + (s.count > 0 ? "->": "") + "\(node.val)"
                if node.left == nil && node.right == nil {
                    result.append(sss)
                }
                preOrder(node.left, sss)
                preOrder(node.right, sss)
            }
        }
        preOrder(root, "")
        return result
    }
    
    /*最接近的二叉搜索树
     利用二叉搜索树特性搜索最接近的值
     */
    func closestValue(_ root: TreeNode<Int>?, _ target: Double) -> Int {
        var result = root!.val
        var node = root
        while let theNode = node {
            if abs(Double(theNode.val) - target) < abs(Double(result) - target) {
                result = theNode.val
            } else {
                break
            }
            if Double(theNode.val) > target {
                node = theNode.left
            } else if Double(theNode.val) < target {
                node = theNode.right
            } else {
                break
            }
        }
        return result
    }
    
    //端点维护
    func closestValue1(_ root: TreeNode<Int>?, _ target: Double) -> Int {
        var l = root!.val
        var r = l
        var node = root
        while let theNode = node {
            if Double(theNode.val) > target {
                node = theNode.left
                r = theNode.val
            } else if Double(theNode.val) < target {
                node = theNode.right
                l = theNode.val
            } else {
                return theNode.val
            }
        }
        return abs(Double(l) - target) > abs(Double(r) - target) ? r : l
    }
    
    func sumOfLeftLeaves(_ root: TreeNode<Int>?) -> Int {
        var sum = 0
        func sumLeft(_ node: TreeNode<Int>?) {
            if let node = node {
                if let left = node.left , left.left == nil && left.right == nil {
                    sum += left.val
                }
                sumLeft(node.left)
                sumLeft(node.right)
            }
        }
        sumLeft(root)
        return sum
    }
    
    func pathSum(_ root: TreeNode<Int>?, _ sum: Int) -> Int {
        var result = 0
        func pathZum(_ node: TreeNode<Int>, _ sums: [Int]) {
            var curSums = [node.val]
            if node.val == sum {
                result += 1
            }
            for s in sums {
                let ss = s + node.val
                if ss == sum {
                    result += 1
                }
                curSums.append(ss)
            }
            if let left = node.left {
                pathZum(left, curSums)
            }
            if let right = node.right {
                pathZum(right, curSums)
            }
        }
        return result
    }
    
    func findMode(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {
            return []
        }
        var result = [Int]()
        var queue = [root]

        var maxCount = 0
        var dict = [Int: Int]()
        while queue.count > 0 {
            let node = queue.popLast()!
            dict[node.val] = 1 + (dict[node.val] ?? 0)
            maxCount = max(dict[node.val]!, maxCount)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        for (key,value) in dict {
            if value == maxCount {
                result.append(key)
            }
        }
        return result
    }
    
    func findMode1(_ root: TreeNode<Int>?) -> [Int] {
        var result = [Int]()
        var maxCount = 0
        func inorder(_ node: TreeNode<Int>?, _ pre: Int?) -> Int {
            if let node = node {
                if pre == node.val {
                    return inorder(node.left, pre) + inorder(node.right, pre) + 1
                } else {
                    let leftCount = inorder(node.left, node.val)
                    let rightCount = inorder(node.right, node.val)
                    if maxCount < leftCount + rightCount + 1 {
                        maxCount = leftCount + rightCount + 1
                        result.removeAll()
                        result.append(node.val)
                    } else if maxCount == leftCount + rightCount + 1 {
                        result.append(node.val)
                    }
                    return 0
                }
            }
            return 0
        }
        inorder(root, nil)
        return result
    }
    
    
    func getMinimumDifference(_ root: TreeNode<Int>?) -> Int {
        guard let root = root else {
            return 0
        }
        var minDifference = Int.max
        var queue = [root]
        while queue.count > 0 {
            let node = queue.popLast()!
            var left = node.left
            while left?.right != nil {
                left = left!.right
            }
            let leftDif = left != nil ? node.val - left!.val : Int.max

            var right = node.right
            while right?.left != nil {
                right = right?.left
            }
            let rightDif = right != nil ? right!.val - node.val : Int.max
            minDifference = min(leftDif, rightDif, minDifference)
            
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        return minDifference
    }
    
    func convvvv(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        var sum = 0
        func convert(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
            if let node = root {
                convert(node.right)
                sum += node.val
                node.val = sum
                convert(node.left)
            }
            return root
        }
        return convert(root)
    }
    
    func convertBST(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        var sum = 0
        func convert(_ root: TreeNode<Int>?) {
            if let node = root {
                convert(node.right)
                sum += node.val
                node.val = sum
                convert(node.left)
            }
        }
        return root
    }
    
    func convertBST1(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        var node = root
        var stack = [TreeNode<Int>]()
        var last = 0
        while let theNode = node {
            stack.append(theNode)
            if let right = theNode.right {
                node = right
            } else {
                while let popNode = stack.popLast() {
                    print(popNode.val)

                    popNode.val = last + popNode.val
                    last = popNode.val

                    if let left = popNode.left {
                        node = left
                        break
                    } else {
                        if stack.isEmpty {
                            node = nil
                        }
                    }
                }
            }
        }
        return root
    }
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var res = 0
        func height(_ root: TreeNode?) -> Int {
            if root != nil {
                let left = height(root?.left)
                let right = height(root?.right)
                res = max(res, left + right + 1)
                return max(height(root?.left),height(root?.right)) + 1
            } else {
                return 0
            }
        }
        return res
    }
    
    func findTilt(_ root: TreeNode<Int>?) -> Int {
        var tilt = 0
        func zzz(_ root: TreeNode<Int>?) -> Int {
            if root == nil {
                return 0
            }
            let left = zzz(root?.left)
            let right = zzz(root?.right)
            tilt += abs(left - right)
            return left + right + root!.val
        }
        zzz(root)
        return tilt
    }
    
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        if s == nil {
            return false
        }
        func isEqual(_ t1: TreeNode?, _ t2: TreeNode?) -> Bool {
            if t1 == nil && t2 == nil {
                return true
            }
            if t1 != nil && t2 != nil && t1!.val == t2!.val {
                return isEqual(t1?.left, t2?.left) && isEqual(t1?.right, t2?.right)
            }
            return false
        }
        return isEqual(s, t) || isSubtree(s?.left, t) || isSubtree(s?.right, t)
        
    }
    
    func tree2str(_ t: TreeNode<Int>?) -> String {
        guard let t = t else {
            return ""
        }
        var result = "\(t.val)"
        func preOrder(_ root: TreeNode<Int>?) {
            if let root = root {
                result += "(\(root.val)"
                preOrder(root.left)
                if root.left == nil && root.right != nil {
                    result += "()"
                }
                preOrder(root.right)
                result += ")"
            }            
        }
        
        preOrder(t.left)
        preOrder(t.right)
        return result
    }
    
    func mergeTrees(_ t1: TreeNode<Int>?, _ t2: TreeNode<Int>?) -> TreeNode<Int>? {
        guard let t1 = t1 else {
            return t2
        }
        guard let t2 = t2 else {
            return t1
        }
        
        let root = TreeNode<Int>(t1.val + t2.val)
        root.left = mergeTrees(t1.left, t2.left)
        root.right = mergeTrees(t1.right, t2.right)
        return root
    }
    
    func mergeTrees1(_ t1: TreeNode<Int>?, _ t2: TreeNode<Int>?) -> TreeNode<Int>? {
        guard let t1 = t1 else {
            return t2
        }
        guard let t2 = t2 else {
            return t1
        }
        var stack1: [TreeNode<Int>?] = [t1]
        var stack2: [TreeNode<Int>?] = [t2]
        while stack1.count > 0 {
            let s1 = stack1.popLast()!!
            let s2 = stack2.popLast()!
            if s2 == nil {
                continue
            }
            s1.val = s1.val + s2!.val
            if s1.left == nil {
                s1.left = s2?.left
            } else {
                stack1.append(s1.left)
                stack2.append(s2?.left)
            }
            if s1.right == nil {
                s1.right = s2?.right
            } else {
                stack1.append(s1.right)
                stack2.append(s2?.right)
            }
        }
        return t1
    }
    
    func averageOfLevels(_ root: TreeNode<Int>?) -> [Double] {
        guard let root = root else {
            return []
        }
        var queue = [root]
        var result = [Double]()
        while queue.count > 0 {
            let curQueue = queue
            queue.removeAll()
            var sum: Double = 0
            for t in curQueue {
                sum += Double(t.val)
                if let left = t.left {
                    queue.append(left)
                }
                if let right = t.right {
                    queue.append(right)
                }
            }
            result.append(sum / Double(curQueue.count))
        }
        return result
    }
    
    func averageOfLevels1(_ root: TreeNode<Int>?) -> [Double] {
        var countArr = [Int]()
        var sumArr = [Int]()
        func aver(_ root: TreeNode<Int>?, _ depth: Int) {
            guard let root = root else {
                return
            }
            if depth >= countArr.count {
                countArr.append(1)
                sumArr.append(root.val)
            } else {
                countArr[depth] = countArr[depth] + 1
                sumArr[depth] = sumArr[depth] + root.val
            }
            aver(root.left, depth + 1)
            aver(root.right, depth + 1)
        }
        aver(root, 0)
        var result = [Double]()
        for i in 0..<countArr.count {
            result.append(Double(sumArr[i]) / Double(countArr[i]))
        }
        return result
    }
    
    func findTarget(_ root: TreeNode<Int>?, _ k: Int) -> Bool {
        var set = Set<Int>()
        func find(_ root: TreeNode<Int>?) -> Bool {
            guard let root = root else {
                return false
            }
            if set.contains(k - root.val) {
                return true
            }
            set.insert(root.val)
            return find(root.left) || find(root.right)
        }
        return find(root)
    }
    
    func trimBST(_ root: TreeNode<Int>?, _ L: Int, _ R: Int) -> TreeNode<Int>? {
        guard let root = root else {
            return nil
        }
        if root.val < L {
            return trimBST(root.right, L, R)
        }
        if root.val > R {
            return trimBST(root.left, L, R)
        }
        root.left = trimBST(root.left, L, R)
        root.right = trimBST(root.right, L, R)
        return root
    }
    
    func findSecondMinimumValue(_ root: TreeNode<Int>?) -> Int {
        guard let root = root else {
            return -1
        }
        let minNum = root.val
        var queue = [root]
        var secondMin = Int.max
        while queue.count > 0 {
            let curQueue = queue
            queue.removeAll()
            for node in curQueue {
                if let left = node.left, let right = node.right {
                    queue.append(left)
                    queue.append(right)
                    if left.val > minNum {
                        secondMin = min(left.val, secondMin)
                    }
                    if right.val > minNum {
                        secondMin = min(right.val, secondMin)
                    }
                }
            }
        }
        return secondMin < Int.max ? secondMin : -1
        
    }
    
    func longestUnivaluePath(_ root: TreeNode<Int>?) -> Int {
        var maxLength = 0
        var result = 0
        func longest(_ root: TreeNode<Int>?) -> Int {
            guard let root = root else {
                return 0
            }
            var left = longest(root.left)
            var right = longest(root.right)
            var arrowLeft = 0
            var arrowRight = 0
            if root.left != nil && root.left!.val == root.val {
                arrowLeft = left + 1
            }
            if root.right != nil && root.right!.val == root.val {
                arrowRight = right + 1
            }
            result = max(result, arrowLeft + arrowRight)
            return max(arrowRight, arrowLeft)
        }
        longest(root)
        return result
    }
    
    func searchBST(_ root: TreeNode?, _ val: T) -> TreeNode? {
        if let root = root {
            if root.val == val {
                return root
            } else if root.val > val {
                return searchBST(root.left, val)
            } else {
                return searchBST(root.right, val)
            }
        }
        return nil
    }
    
    func minDiffInBST(_ root: TreeNode<Int>?) -> Int {
        var minDif = Int.max
        func zzz(_ root: TreeNode<Int>) {
            if let left = root.left {
                var right = left
                while right.right != nil {
                    right = right.right!
                }
                minDif = min(minDif, root.val - right.val)
                zzz(left)
            }
            if let right = root.right {
                var left = right
                while left.left != nil {
                    left = left.left!
                }
                minDif = min(minDif, left.val - root.val)
                zzz(right)
            }
        }
        zzz(root!)
        return minDif
    }
    
    func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        guard let root1 = root1 else {
            return root2 == nil
        }
        guard let root2 = root2 else {
            return false
        }
        var arr1 = [TreeNode]()
        var arr2 = [TreeNode]()
        func dfs(_ root: TreeNode,_ arr: inout [TreeNode]) {
            if root.left == nil && root.right == nil {
                arr.append(root)
            }
            if let left = root.left {
                dfs(left, &arr)
            }
            if let right = root.right {
                dfs(right, &arr)
            }
        }
        dfs(root1, &arr1)
        dfs(root2, &arr2)
        if arr1.count != arr2.count {
            return false
        }
        for i in 0..<arr1.count {
            if arr1[i].val != arr2[i].val {
                return false
            }
        }
        return true
    }
    
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        var arr = [TreeNode]()
        func inOrder(_ root: TreeNode?) {
            guard let root = root else {
                return
            }
            inOrder(root.left)
            arr.append(root)
            inOrder(root.right)
        }
        inOrder(root)
        var res = arr[0]
        for i in 1..<arr.count {
            res.left = nil
            res.right = arr[i]
            res = arr[i]
        }
        res.left = nil
        res.right = nil
        return arr[0]
    }
    
    func rangeSumBST(_ root: TreeNode<Int>?, _ L: Int, _ R: Int) -> Int {
        let node = trimBST(root, L, R)
        var result = 0
        func preOrder(_ root: TreeNode<Int>?) {
            guard let root = root else {
                return
            }
            result += root.val
            preOrder(root.left)
            preOrder(root.right)
        }
        preOrder(node)
        return result
    }
    
    func isUnivalTree(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        let val = root.val
        func travel(_ root: TreeNode?) -> Bool {
            guard let root = root else {
                return true
            }
            if val == root.val {
                return travel(root.left) && travel(root.right)
            } else {
                return false
            }
        }
        return travel(root)
    }
    
    func isCousins(_ root: TreeNode<Int>?, _ x: Int, _ y: Int) -> Bool {
        
        var queue = [((root?.left),(root?.right))]
        while queue.count > 0 {
            let curQueue = queue
            queue.removeAll()
            var xExist = false
            var yExist = false
            
            for i in curQueue {
                if let left = i.0, let right = i.1 {
                    if (left.val == x && right.val == y) || (left.val == y && right.val == x) {
                        return false
                    }
                }
                if i.0 != nil && (i.0?.left != nil || i.0?.right != nil) {
                    queue.append((i.0?.left, i.0?.right))
                }
                if i.1 != nil && (i.1?.left != nil || i.1?.right != nil) {
                    queue.append((i.1?.left, i.1?.right))
                }

                if !xExist && (i.0?.val == x || i.1?.val == x)  {
                    xExist = true
                }
                if !yExist && (i.0?.val == y || i.1?.val == y){
                    yExist = true
                }
                if xExist && yExist {
                    return true
                }
            }
        }
        return false
    }
    
    func isCousins1(_ root: TreeNode<Int>?, _ x: Int, _ y: Int) -> Bool {
        var queue = [root!]
        var parentDict = [Int: Int]()
        while queue.count > 0 {
            let curQ = queue
            queue.removeAll()
            var xExist = false
            var yExist = false
            for i in curQ {
                if let left = i.left {
                    parentDict[left.val] = i.val
                    queue.append(left)
                }
                if let right = i.right {
                    parentDict[right.val] = i.val
                    queue.append(right)
                }
                if i.val == x  {
                    xExist = true
                }
                if i.val == y {
                    yExist = true
                }
            }
            if xExist && yExist  {
                return !(parentDict[x] == parentDict[y])
            } else if xExist != yExist {
                return false
            }
        }
        return false
    }
    
    func sumRootToLeaf(_ root: TreeNode<Int>?) -> Int {
        var nums = [Int]()
        func pre(_ root: TreeNode<Int>?, _ val: Int) {
            guard let root = root else {
                return
            }
            if root.left == nil && root.right == nil {
                nums.append(val)
            }
            pre(root.left, val << 1 + root.val)
            pre(root.right, val << 1 + root.val)
        }
        pre(root, 0)
        var sum = 0
        for i in nums {
            sum += i
        }
        return sum
    }
    
    func zigzagLevelOrder(_ root: TreeNode<Int>?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var queue = [root]
        var order = true
        var result = [[Int]]()
        while queue.count > 0 {
            var newQueue = [TreeNode<Int>]()
            var r = [Int]()
            for i in stride(from: order ? 0 : queue.count - 1 , through: order ? queue.count - 1 : 0, by: order ? 1 : -1) {
                r.append(queue[i].val)
                if order {
                    if let left = queue[i].left {
                        newQueue.append(left)
                    }
                    if let right = queue[i].right {
                        newQueue.append(right)
                    }
                } else {
                    if let right = queue[i].right {
                        newQueue.append(right)
                    }
                    if let left = queue[i].left {
                        newQueue.append(left)
                    }
                }
            }
            queue = order ? newQueue : newQueue.reversed()

            order = !order
            result.append(r)

        }
        return result
    }
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode<Int>? {
        guard preorder.count > 0 else {
            return nil
        }
        //前序遍历的第一个是树的根节点
        //前序遍历先遍历左子树，再遍历右子树
        func build(_ left: Int, _ right: Int, _ inorderLeft: Int, _ inorderRight: Int) -> TreeNode<Int>? {
            if left > right {
                return nil
            }
            if left == right {
                return TreeNode<Int>(preorder[left])
            }
            let root = TreeNode<Int>(preorder[left])
            var inorderRootIndex = -1
            for i in inorderLeft...inorderRight {
                if inorder[i] == root.val {
                    inorderRootIndex = i
                }
            }
            root.left = build(left + 1,
                              left + inorderRootIndex - inorderLeft,
                              inorderLeft,
                              inorderRootIndex - 1)
            root.right = build(left + inorderRootIndex - inorderLeft + 1,
                               right,
                               inorderRootIndex + 1,
                               inorderRight)
            return root
        }
        return build(0, inorder.count - 1, 0, inorder.count - 1)
    }
    
    //中序遍历和后续遍历二叉树
    func buildTree1(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        var dict = [Int: Int]()
        for i in 0..<inorder.count {
            dict[inorder[i]] = i
        }
        func build(_ left: Int, _ right: Int, _ left1: Int, _ right1: Int) -> TreeNode<Int>? {
            guard left <= right else {
                return nil
            }
            guard left != right else {
                return TreeNode<Int>(postorder[right])
            }
            let root = TreeNode<Int>(postorder[right])
            let inorderIndex = dict[root.val]!
            let leftCount = inorderIndex - left1
            let rightCount = right1 - inorderIndex
            root.left = build(left, left + leftCount - 1,
                              left1,inorderIndex - 1)
            root.right = build(right - rightCount, right - 1,
                                inorderIndex + 1, right1)
            return root
        }
        return build(0, inorder.count - 1,0, inorder.count - 1) as! TreeNode<T>
    }
    
    func pathSum1(_ root: TreeNode<Int>?, _ sum: Int) -> [[Int]] {
        guard let root = root else {
            return [[]]
        }
        var result = [[Int]]()
        func sum1(_ root: TreeNode<Int>, _ target: Int, _ arr: [Int]) {
            print(target)
            if root.left == nil && root.right == nil {
                if target == sum {
                    var arr = arr
                    arr.append(root.val)

                    result.append(arr)
                }
            }
            if let left = root.left {
                var arr = arr
                arr.append(root.val)
                sum1(left, root.val + target, arr)
            }
            if let right = root.right {
                var arr = arr
                arr.append(root.val)
                sum1(right, root.val + target, arr)
            }
        }
        sum1(root, 0, [])
        return result
    }
    
    func flatten(_ root: TreeNode?) {
        guard let root = root else {
            return
        }
        var stack = [root]
        while stack.count > 0 {
            let pop = stack.removeLast()
            if let right = pop.right {
                stack.append(right)
            }
            if let left = pop.left {
                stack.append(left)
            }
            if pop.left != nil {
                pop.right = pop.left
                pop.left = nil
            } else if pop.right == nil {
                pop.right = stack.last
            }
        }
        
        func connect(_ root: TreeNode?) {
            guard let root = root else {
                return
            }
            var queue = [root]
            while queue.count > 0 {
                var newQueue = [TreeNode]()
                var i = 1
                while i < queue.count {
                    queue[i].next = queue[i]
                    i += 1
                }
                for node in queue {
                    if let right = node.right {
                        newQueue.append(right)
                    }
                    if let left = node.left {
                        newQueue.append(left)
                    }
                }
                queue = newQueue
            }
        }
    }
    
    func sumNumbers(_ root: TreeNode<Int>?) -> Int {
        guard let root = root else {
            return 0
        }
        var sum = 0
        func sumNum(_ root: TreeNode<Int>, _ total: Int) {
            if root.left == nil && root.right == nil {
                sum += total * 10 + root.val
            } else {
                if let left = root.left {
                    sumNum(left, total * 10 + root.val)

                }
                if let right = root.right {
                    sumNum(right, total * 10 + root.val)

                }
            }
        }
        sumNum(root, 0)
        return sum
    }
    
    func rightSideView(_ root: TreeNode?) -> [T] {
         var result = [T]()
        func preorder(_ root: TreeNode?, _ height: Int) {
            guard let root = root else {
                return
            }
            if result.count > height {
                result.append(root.val)
            }
            preorder(root.right, height + 1)
            preorder(root.left, height + 1)
        }
        preorder(root, 0)
        return result
     }
    
    func countNodes(_ root: TreeNode?) -> Int {
        func getDepth(_ root: TreeNode?) -> Int {
            var node = root
            var depth = 0
            while node != nil {
                depth += 1
                node = node?.left
            }
            return depth
        }
        var node = root
        let depth = getDepth(root)
        var ans = (1 << depth)

        for i in 1..<depth {
            if getDepth(node?.right) + i == depth {
                node = node?.right
            } else {
                node = node?.left
                ans -= (1 << (depth - i - 1))
            }
        }
        return ans
        
    }
    
    func kthSmallest(_ root: TreeNode<Int>?, _ k: Int) -> Int {
        var i = 0
        var result = -100000
        func inorder(_ root: TreeNode<Int>?) {
            guard let root = root else {
                return
            }
            if result != -100000 {
                return
            }
            inorder(root.left)
            i += 1

            if i == k {
                 result = root.val
            }
            inorder(root.right)
        }
        inorder(root)
        return result
    }
    
    func lowestCommonAncestor1(_ root: TreeNode, _ p: TreeNode, _ q: TreeNode) -> TreeNode? {

        var ancessor: TreeNode? = nil
        @discardableResult
        func zzz(_ root: TreeNode?) -> (Bool,Bool) {
            if ancessor != nil {
                return (false, false)
            }
            guard let root = root else {
                return (false, false)
            }
            let i = zzz(root.left)
            let j = zzz(root.right)
            var ppAppear = i.0 || j.0
            var qqAppear = i.1 || j.1
            if root.val == p.val {
                ppAppear = true
            } else if root.val == q.val {
                qqAppear = true
            }
            if ancessor == nil && ppAppear && qqAppear {
                ancessor = root
            }
            return (ppAppear, qqAppear)
            
            
        }
        zzz(root)
        return ancessor
    }
    
//    func deleteNode(_ root: TreeNode?, _ key: T) -> TreeNode? {
//        guard let root = root else {
//            return nil
//        }
//        var node: TreeNode? = root
//        var parentNode = root
//        if parentNode.val == key {
//            let left = root.left
//            var right = root.right
//            let leftRight = left?.right
//            if right == nil {
//                left?.right = right
//                if leftRight != nil {
//                    while right?.left != nil {
//                        right = right?.left
//                    }
//                    right?.left = leftRight
//                }
//            }
//            return left
//        }
//        while let theNode = node {
//            if theNode.val == key {
//                parentNode.left =
//
//            } else if
//        }
    
    func findFrequentTreeSum(_ root: TreeNode<Int>?) -> [Int] {
        var dict = [Int: Int]()
        var maxNums = Set<Int>()
        var maxCount = 0
        @discardableResult
        func sum(_ root: TreeNode<Int>?) -> Int {
            guard let root = root else {
                return 0
            }
            let leftSum = sum(root.left)
            let rightSum = sum(root.right)
            let subSum = leftSum + rightSum + root.val
            dict[subSum] = dict[subSum, default: 0] + 1
            if maxCount == dict[subSum]! {
                maxNums.insert(subSum)
            } else if maxCount < dict[subSum]! {
                maxCount = dict[subSum]!
                maxNums = Set.init(arrayLiteral: subSum)
            }


            return subSum
        }
        sum(root)
        return Array(maxNums)
    }
    
    func findBottomLeftValue(_ root: TreeNode<Int>?) -> Int {
        var result = (-1,-1)
        func postorder(_ root: TreeNode<Int>?, _ depth: Int) {
            guard let root = root else {
                return
            }
            postorder(root.left, depth + 1)
            postorder(root.right, depth + 1)
            if depth > result.0 {
                result = (depth, root.val)
            }
        }
        postorder(root, 0)
        return result.1
    }
    

    
    func largestValues(_ root: TreeNode?) -> [T] {
        let levelValues = levelOrder(root)
        var result = [T]()
        for arr in levelValues {
            var maxValue = arr[0]
            for i in arr {
                if i > maxValue {
                    maxValue = i
                }
            }
            result.append(maxValue)
        }
        return result
    }
    
    func addOneRow(_ root: TreeNode<Int>?, _ v: Int, _ d: Int) -> TreeNode<Int>? {
        func preorder(_ root: TreeNode<Int>?,_ depth: Int) {
            guard let root = root else {
                return
            }
            guard depth <= d else {
                return
            }
            if depth == d {
                let left = root.left
                let right = root.right
                root.left = TreeNode<Int>(v)
                root.right = TreeNode<Int>(v)
                root.left?.left = left
                root.right?.right = right
            }
            preorder(root.left, depth + 1)
            preorder(root.right, depth + 1)
        }
        preorder(root, 1)
        return root
    }
    
//    func findDuplicateSubtrees(_ root: TreeNode?) -> [TreeNode?] {
//        var subs = 1
//
//    }
    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode<Int>? {
        func constructMax(_ left: Int, _ right: Int) -> TreeNode<Int>? {
            guard left <= right else {
                return nil
            }
            var maxNum = Int.min
            var maxIndex = -1
            for i in left...right {
                if maxNum < nums[i] {
                    maxNum = nums[i]
                    maxIndex = i
                }
            }
            let root = TreeNode<Int>(nums[maxIndex])
            root.left = constructMax(left, maxIndex - 1)
            root.right = constructMax(maxIndex + 1, right)
            return root
        }
        return constructMax(0, nums.count - 1)
    }
//    result.append(theNode.val)
//    node = nil
//    while let root = stack.last {
//        result.append(root.val)
//        if root.right != nil {
//            stack.removeLast()
//            node = root.right
//            break;
//        } else {
//            stack.removeLast()
//            if stack.count == 0 {
//                node = nil
//            }
//        }
//    }
    func getAllElements(_ root1: TreeNode<Int>?, _ root2: TreeNode<Int>?) -> [Int] {
        var result = [Int]()
        var stack1 = [TreeNode<Int>]()
        var stack2 = [TreeNode<Int>]()
        var node1 = root1
        var node2 = root2
        var lastAppend = 0
        while stack1.count > 0 || node1 != nil || node2 != nil {
            if let node11 = node1, let node22 = node2 {
                if node11.val <= node22.val {
                    stack2.append(node22)
                    node2 = node22.left
                } else {
                    stack1.append(node11)
                    node1 = node11.left
                }
            } else if let node11 = node1 {
                stack1.append(node11)
                node1 = node11.left
            } else if let node22 = node2 {
                stack2.append(node22)
                node2 = node22.left
            } else {
                while stack1.count > 0 || stack2.count > 0 {
                    let n1 = stack1.last
                    let n2 = stack2.last
                    if n1 != nil && n2 != nil {
                        if n1!.val <= n2!.val {
                            result.append(n1!.val)
                            stack1.removeLast()
                            node1 = n1!.right
                        } else {
                            result.append(n2!.val)
                            stack2.removeLast()
                            node2 = n2!.right
                        }
                    } else if n1 != nil {
                        result.append(n1!.val)
                        stack1.removeLast()
                        node1 = n1!.right
                    } else if n2 != nil {
                        result.append(n2!.val)
                        stack2.removeLast()
                        node2 = n2!.right
                    }
                    if node1 != nil || node2 != nil {
                        break
                    }
                }
            }
        }

        
        
        return result
    }
    
    func getAllElements1(_ root1: TreeNode<Int>?, _ root2: TreeNode<Int>?) -> [Int] {
        
        func preorder(_ root: TreeNode<Int>?, _ arr: inout [Int]) {
            guard let root = root else {
                return
            }
            preorder(root.left, &arr)
            arr.append(root.val)
            preorder(root.right, &arr)
        }
        var arr1 = [Int]()
        var arr2 = [Int]()
        preorder(root1, &arr1)
        preorder(root2, &arr2)
        var result = [Int]()
        var i = 0, j = 0
        let count1 = arr1.count, count2 = arr2.count
        while i < count1 && j < count2 {
            if arr1[i] <= arr2[j] {
                result.append(arr1[i])
                i += 1
            } else {
                result.append(arr2[j])
                j += 1
            }
        }
        while i < count1 {
            result.append(arr1[i])
            i += 1
        }
        while j < count2 {
            result.append(arr2[j])
            j += 1
        }
        return result
    }
    
    func deepestLeavesSum(_ root: TreeNode<Int>?) -> Int {
        var sum = 0
        var curDepth = -1
        func ssssum(_ root: TreeNode<Int>?, _ depth: Int) {
            guard let root = root else {
                return
            }
            ssssum(root.left, depth + 1)
            ssssum(root.right, depth + 1)
            if curDepth == depth {
                sum += root.val
            } else if curDepth < depth {
                sum = root.val
                curDepth = depth
            }
        }

        ssssum(root, 0)
        return sum
    }
    
    func sumEvenGrandparent(_ root: TreeNode<Int>?) -> Int {
        var sum = 0
        func asdf(_ root: TreeNode<Int>?,_ g: Int) {
            guard let root = root else {
                return
            }
            var g = g
            if g & 2 != 0 {
                sum += root.val
            }
            if root.val & 1 == 0 {
                g = (g << 1 + 1) & 3
            } else {
                g = (g << 1) & 3
            }
            asdf(root.left, g)
            asdf(root.right, g)
        }
        asdf(root, 0)
        return sum
    }
    
    func btreeGameWinningMove(_ root: TreeNode<Int>?, _ n: Int, _ x: Int) -> Bool {
        var redLeft = 0, redRight = 0
        func dfs(_ root: TreeNode<Int>?) -> Int {
            guard let root = root else {
                return 0
            }
            let left = dfs(root.left)
            let right = dfs(root.right)
            if root.val == x {
                redLeft = left
                redRight = right
            }
            return left + right
        }
        dfs(root)
        let parent = n - redLeft - redRight
        for j in [parent, redLeft,redRight] {
            if j > n / 2 {
                return true
            }
        }
        return false
    }
}

class FindElements {

    var root: TreeNode<Int>?
    var set = Set<Int>()
    init(_ root: TreeNode<Int>?) {
        if let root = root {
            self.root = root
            self.repair(root, 0)

        }
    }
    
    func repair(_ root: TreeNode<Int>?, _ val: Int) {
        guard let root = root else {
            return
        }
        root.val = val
        set.insert(val)
        repair(root.left, 2 * val + 1)
        repair(root.right, 2 * val + 2)
    }
    
    func find(_ target: Int) -> Bool {
        return set.contains(target)
    }
}

class BSTIterator {
    
    var root: TreeNode<Int>?
    var stack: [TreeNode<Int>] = []
    init(_ root: TreeNode<Int>?) {
        self.root = root
        var left = self.root
        while let theLeft = left {
            stack.append(theLeft)
            left = left?.left
        }
        
    }
    
    /** @return the next smallest number */
    func next() -> Int {
        var node: TreeNode? = stack.removeLast()
        let res = node!.val
        node = node?.right
        while let theNode = node {
            stack.append(theNode)
            node = theNode.left
        }
        
        return res
    }
    
    /** @return whether we have a next smallest number */
    func hasNext() -> Bool {
        return stack.count > 0
    }
    
}

class Solution {
    func hasPathSum(_ root: TreeNode<Int>?, _ sum: Int) -> Bool {
        guard let root = root else {
            return sum == 0
        }
        var queue = [root]
        var sumQueue = [root.val]
        while !queue.isEmpty {
            let curQueue = queue
            let curSum = sumQueue
            queue = []
            sumQueue = []
            for (index,node) in curQueue.enumerated() {
                if node.left == nil && node.right == nil {
                    if curSum[index] == sum {
                        return true
                    }
                } else {
                    if let left = node.left {
                        let nodeSum = curSum[index] + left.val
                        if nodeSum == sum {
                            if left.left == nil && left.right == nil {
                                return true
                            }
                        }
                            queue.append(left)
                            sumQueue.append(nodeSum)
                        
                    }
                    if let right = node.right {
                        let nodeSum = curSum[index] + right.val
                        if nodeSum == sum {
                            if right.left == nil && right.right == nil {
                                return true
                            }
                        }
                        queue.append(right)
                        sumQueue.append(nodeSum)
                    }

                }
                
            }
        }
        return false
    }
    
    func treeToDoublyList(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        guard let root = root else {
            return nil
        }
        func rebuild(_ root: TreeNode<Int>?) -> (TreeNode<Int>?, TreeNode<Int>?) {
            guard let root = root else {
                return (nil,nil)
            }
            var reLeft = rebuild(root.left).1
            var reRight = rebuild(root.right).0
            reLeft?.right = root
            reRight?.left = root
            root.left = reLeft
            root.right = reRight
            var left: TreeNode<Int>? = root
            while left?.left != nil {
                left = left?.left
            }
            var right: TreeNode<Int>? = root
            while right?.right != nil {
                right = right?.right
            }
            return (left, right)
        }
        let i = rebuild(root)
        return nil
    }
}
