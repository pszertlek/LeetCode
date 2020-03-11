//
//  Stack.swift
//  StackProblem
//
//  Created by Pszertlek on 2020/1/23.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


class StackProblem {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack = [Int]()
        var dict = [Int: Int]()
        for i in 0..<nums2.count {
            while stack.count > 0 && nums2[i] > stack.last! {
                dict[stack.removeLast()] = nums2[i]
            }
            stack.append(nums2[i])
        }
        while stack.count > 0 {
            dict[stack.removeLast()] = -1
        }
        var nums1 = nums1
        for i in 0..<nums1.count {
            nums1[i] = dict[nums1[i]]!
        }
        return nums1
    }
    
    func calPoints(_ ops: [String]) -> Int {
        var stack = [Int]()
        var sum = 0
        for str in ops {
            switch str {
            case "C":
                let point = stack.popLast()
                sum -= point ?? 0
            case "D":
                var points = 0
                if stack.count > 0 {
                    points += stack.last!
                }

                stack.append(points * 2)
                sum += points * 2
            case "+":
                var points = 0
                if stack.count > 0 {
                    points += stack.last!
                }
                if stack.count > 1 {
                    points += stack[stack.count - 2]
                }
                stack.append(points)
                sum += points
            default:
                let points = Int(str)!
                stack.append(points)
                sum += points
            }
        }
        return sum
    }
    
    func removeOuterParentheses(_ S: String) -> String {
        var result = "", tmp = ""
        var num = 0
        for c in S {
            if c == "(" && num == 0 {
                num += 1
                continue
            } else if c == "(" {
                num += 1
                tmp += "(";
            } else if c == ")" {
                num -= 1
                if num == 0 {
                    result += tmp
                    tmp.removeAll()
                    continue
                }
                tmp += ")"
            }
        }
        return result
    }
    
    func removeDuplicates(_ S: String) -> String {
        var stack = [Character]()
        for c in S {
            if let last = stack.last, last == c {
                stack.removeLast()
            } else {
                stack.append(c)
            }
        }
        return String(stack)
    }
    
    func isValidSerialization(_ preorder: String) -> Bool {
        var stack = [String]()
        let preorder = preorder.components(separatedBy: ",")
        let well = "#"
        for c in preorder {
            switch c {
            case well:
                stack.append(well)
                while stack.count >= 3 &&
                    stack[stack.count - 1] == well &&
                    stack[stack.count - 2] == well &&
                    stack[stack.count - 3] != well  {
                        stack.removeLast(3)
                        stack.append(well)
                }
            default:
                stack.append(c)
            }
        }
        return stack.count == 1 && stack.first == well
    }
    
    func deserialize(_ s: String) -> NestedInteger {
        var stack = [NestedInteger]()
//        let result = NestedInteger()
//        stack.append(result)
        var num = ""
        var stackIndexs = [Int]()
        for c in s {
            if c == Character("[") {
                stack.append(NestedInteger())
                stackIndexs.append(0)
            } else if c == Character("]") {
                if num.count != 0 {
                    let n = Int(num)!
                    let nested = NestedInteger()
                    nested.setInteger(value: n)
                    if let last = stack.last {
                        last.add(elem: nested)
                    }
                }
                if stack.count > 1 {
                    let last = stack.popLast()!
                    let lastLast = stack.last!
                    lastLast.add(elem: last)
                }
                num.removeAll()
            } else if c == Character(",") {
                if num.count != 0 {
                    let n = Int(num)!
                    let nested = NestedInteger()
                    nested.setInteger(value: n)
                    if let last = stack.last {
                        last.add(elem: nested)
                    }
                }
                num.removeAll()
            } else {
                num.append(c)
            }
        }
        if num.count > 0 {
            let n = NestedInteger()
            n.setInteger(value: Int(num)!)
            return n
        }
        return stack.last!
    }
    
    func removeKdigits(_ num: String, _ k: Int) -> String {
        var stack = [Character]()
        var count = k
        var jump = 0
        for c in num {
            let cNum = c.hexDigitValue!
            while let last = stack.last?.hexDigitValue, last > cNum && count > 0 {
                stack.popLast()
                count -= 1
            }
            if stack.count == 0 && cNum == 0 {
                jump += 1
            } else {
                stack.append(c)
            }
        }
        if count > 0 {
            stack.removeLast(count - jump)
        }
        if stack.count == 0 {
            return "0"
        }
        return String(stack)
    }
    
//    func find132pattern(_ nums: [Int]) -> Bool {
//        var stack = [Int]()
//        for i in nums {
//            while let last = stack.last , last < i {
//
//            }
//        }
//    }
    
    func exclusiveTime(_ n: Int, _ logs: [String]) -> [Int] {
        var stack = [(Int,Int)]()
        var map = [Int: Int]()
        var costStack = [Int]()
        func deal(_ log: String) -> (Int,Int) {
            let funcAndTime = log.components(separatedBy: ":")
            let funcId = Int(funcAndTime[0])!
            
            let time = Int(funcAndTime[2])!
            if funcAndTime[1] == "start" {
                return (funcId, time)
            } else {
                return (funcId, -time)
            }
        }
        for log in logs {
            let dealInfo = deal(log)
            if let last = stack.last,
                dealInfo.0 == last.0 && dealInfo.1 <= 0 {
                let lastCost = costStack.popLast()!

                map[dealInfo.0] = map[dealInfo.0, default: 0] + 1 - dealInfo.1 - last.1 - lastCost
                if costStack.count > 0 {
                    costStack[costStack.count - 1] = 1 - dealInfo.1 - last.1 + costStack[costStack.count - 1]
                }
                stack.removeLast()
                
            } else {
                costStack.append(0)
                stack.append(dealInfo)
            }
        }
        var result = [Int]()
        for i in 0..<n {
            result.append(map[i]!)
        }
        return result
    }
    
    func decodeAtIndex(_ S: String, _ K: Int) -> String {
        var result = [[Character]]()
        var stack = [(Int,Int)]()
        var count = 0
        
        var cur = [Character]()
        var start = 0
        for (index,c) in S.enumerated() {
            if c.isNumber {
                stack.append((count,start))
                count = count * c.hexDigitValue!
                result.append(cur)
                cur = [Character]()
                start = count
            } else {
                count += 1
                cur.append(c)
            }
            if count >= K && (index != S.count - 1 || stack.count == 0) && !c.isNumber {
                return String(c)
            } else if count >= K {
                result.append(cur)
                var i = K - 1
                var arrIndex = stack.count - 1
                if let lastCount = stack.last {
                    i = i % lastCount.0
                }
                
                while arrIndex >= 0 {
                    let start = stack[arrIndex].1
                    if i > stack[arrIndex].1  {
                        i = i % stack[arrIndex].0
                    }
                    if start <= i {
                        return String(result[arrIndex][i - start])
                    } else {
                        arrIndex -= 1
                    }
                }
            }
        }
        return ""
    }
    
    func longestWPI(_ hours: [Int]) -> Int {
        var result = 0
        var stack = [Int]()
        var sum = 0
        var sumVector = [Int]()
        for (index, i) in hours.enumerated() {
            sum += i > 8 ? 1 : -1
            sumVector.append(sum)
            if sum < sumVector.last! {
                stack.append(index)
            }
        }
        for i in stride(from: hours.count - 1, through: 0, by: -1) {
            if sumVector[i] > 0 {
                result = max(result, i + 1)
                break
            }
            if sumVector[i] > sumVector.last! {
                result = max(result, i - stack.last!)
                if stack.count == 0 {
                    break
                } else {
                    continue
                }
            }
        }
        return result
    }
//    3,1,1,1
//    1,1,2,4
//    (i,j)
    func sumSubarrayMins(_ A: [Int]) -> Int {
        
        let mod = 1000000007
        let N = A.count
        var stack = [Int]()
        var prev = [Int].init(repeating: 0, count: N)
        for i in 0..<N {
            while let last = stack.last, A[i] <= A[last] {
                stack.removeLast()
            }
            prev[i] = stack.last ?? -1
            stack.append(i)

        }
        stack.removeAll()
        var next = [Int].init(repeating: 0, count: N)
        for i in stride(from: N - 1, through: 0, by: -1) {
            while let last = stack.last, A[i] < A[last] {
                stack.removeLast()
            }
            next[i] = stack.last ?? N
            stack.append(i)
        }
        var ans = 0
        for i in 0..<N {
            ans += (i - prev[i]) * (next[i] - i) % mod
            ans %= mod
        }
        return ans
    }
    
    func minAddToMakeValid(_ S: String) -> Int {
//        var stack = [Character]()
        var count = 0
        let left = Character("(")
        let right = Character(")")
        var res = 0
        for c in S {
            if c == left {
                count += 1
            } else {
                if count > 0 {
                    count -= 1
                } else {
                    res += 1
                }
            }
        }
        return res + count
    }
    
//    func scoreOfParentheses(_ S: String) -> Int {
//        var stack = [Int]()
//        var stack111 = [Int]()
//        var sum = 0
//        var rightCount = 0
//        var leftCount = 0
//        let left = Character("(")
//        let right = Character(")")
//        let S = [Character].init(S)
//        var i = 0
//        while i < S.count {
//            if S[i] == left {
//                stack.append(0)
//                rightCount += 1
//                leftCount = 0
//            }
//            while S[i] == right {
//                leftCount += 1
//                i += 1
//            }
//            if leftCount == 1 {
//                stack[stack.count - 1] = 1
//            } else {
//                stack[stack.count - 1] =
//            }
//            i += 1
//        }
//        func mctFromLeafValues(_ arr: [Int]) -> Int {
//            let count = arr.count - 1
//            func create(_ left: Int, _ right: Int) {
//                if left == right {
//                    return arr[left]
//                } else {
//
//                }
//            }
//        }
    
    func isValid(_ S: String) -> Bool {
        var stack = [Int]()
        for c in S {
            let cur = stack.last ?? 0
            if cur == 2 && c == Character("c") {
                stack.removeLast()
            } else if cur == 1 && c == Character("b") {
                stack[stack.count - 1] = 2
            } else if cur == 0 && c == Character("a") {
                stack.append(1)
            } else if c == Character("a") {
                stack.append(1)
            } else {
                return false
            }
        }
        return stack.count == 0
    }
    
    func nextLargerNodes(_ head: ListNode?) -> [Int] {
        var stack = [(Int,Int)]()
        var node = head
        var index = 0
        var result = [Int]()
        while let n = node {
            while let last = stack.last, last.0 < n.val {
                    stack.removeLast()
                    result[last.1] = n.val
            }
            stack.append((n.val,index))
            index += 1
            result.append(0)
            node = n.next
        }
        return result
    }
    
    func minRemoveToMakeValid(_ s: String) -> String {
        var count = 0
        let left = Character("(")
        let right = Character(")")
        let s = [Character].init(s)
        var rights = Set<Int>()
        var lefts = Set<Int>()
        for i in 0..<s.count {
            if s[i] == left {
                lefts.insert(i)
            } else if s[i] == right {
                if lefts.count > 0 {
                    lefts.removeFirst()
                } else {
                    rights.insert(i)
                }
            }
        }
        var result = ""
        for i in 0..<s.count {
            if lefts.contains(i) {
                count -= 1
                continue
            } else if rights.contains(i) {
                continue
            } else {
                result.append(s[i])
            }
        }
        return result
    }
    
    func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
        var stack = [Int]()
        var i = 0
        for sh in pushed {
            stack.append(sh)
            while let last = stack.last, last == popped[i] {
                stack.popLast()
                i += 1
            }

        }
        return stack.count == 0
    }
    
    func removeDuplicates(_ s: String, _ k: Int) -> String {
        var stack = [(Character, Int)]()
        for (index,c) in s.enumerated() {
            if let last = stack.last {
                if last.0 == c {
                    if last.1 + 1 == k {
                        stack.popLast()
                    } else {
                        stack[stack.count - 1] = (c, last.1 + 1)
                    }
                } else {
                    stack.append((c,1))
                }
            } else {
                stack.append((c,1))
            }
        }
        var res = ""
        
        for i in stack {
            res.append(String.init(repeating: i.0, count: i.1))
        }
        return res
    }
    
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        var stack = [Int]()
        var result = [Int]()
        var loopNext = [Int]()
        for i in 0..<nums.count {
            while let last = stack.last, nums[last] < nums[i] {
                result[last] = nums[i]
                stack.popLast()
            }
            result.append(-1)
            stack.append(i)
            let more = loopNext.last ?? Int.min
            if more < nums[i] {
                loopNext.append(nums[i])
            }
            
        }
        for i in loopNext  {
            while let last = stack.last, nums[last] < i {
                result[last] = i
                stack.popLast()
            }
        }
        return result
    }
    
    func reverseParentheses(_ s: String) -> String {
        let left = Character("(")
        let right = Character(")")
        var stack = [String]()
        stack.append("")
        var cur = ""
        for c in s {
            if c == left {
                stack.append(cur)
                cur.removeAll()
            } else if c == right {
                var last = stack.popLast() ?? ""
                last.append(contentsOf: cur.reversed())
                cur = last
            } else {
                cur.append(c)
            }
        }
        return cur
    }
    
    func asteroidCollision(_ asteroids: [Int]) -> [Int] {
        var stack = [asteroids[0]]
        var curPush: Int? = nil
        for i in 1..<asteroids.count {
            let absI = abs(asteroids[i])
            curPush = asteroids[i]
            while let last = stack.last, last > 0 && asteroids[i] < 0 {
                let absLast = abs(last)
                stack.removeLast()
                if absLast == absI {
                    curPush = nil
                    break
                } else if absLast < absI {
                    curPush = asteroids[i]
                } else {
                    curPush = last
                    break
                }
            }
            if curPush != nil {
                stack.append(curPush!)
            }
        }
        return stack
    }

}

class StockSpanner {

    var stack: [(Int,Int)] = []
    init() {
        
    }
      
    func next(_ price: Int) -> Int {
//        if let last = stack.last, last.0 == price {
//            stack[stack.count - 1] = (price,last.1 + 1)
//            return last.1 + 1
//        }
        var cur = 1
        while let last = stack.last, last.0 <= price {
            stack.removeLast()
            cur = last.1 + cur
        }
        stack.append((price,cur))
        return cur
    }
}

class NestedInteger {
     // Return true if this NestedInteger holds a single integer, rather than a nested list.
    var i: Int?
    var arr: [NestedInteger]?
    public func isInteger() -> Bool {
        return i != nil
    }

     // Return the single integer that this NestedInteger holds, if it holds a single integer
     // The result is undefined if this NestedInteger holds a nested list
    public func getInteger() -> Int {
        return i!
    }

     // Set this NestedInteger to hold a single integer.
    public func setInteger(value: Int) {
         i = value
    }

     // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    public func add(elem: NestedInteger) {
        if arr == nil {
            arr = [NestedInteger]()
        }
        arr!.append(elem)
    }

     // Return the nested list that this NestedInteger holds, if it holds a nested list
     // The result is undefined if this NestedInteger holds a single integer
    public func getList() -> [NestedInteger] {
        return arr!
    }
 }

class NestedIterator {

    var stack = [NestedInteger]()
//    var nestedList: [NestedInteger]
    var indexStack = 0
    init(_ nestedList: [NestedInteger]) {
        self.stack = nestedList.reversed()
    }
    
    func next() -> Int {
        while let last = stack.last, !last.isInteger() {
            let n = last.getList()
            stack.removeLast()
            stack.append(contentsOf: n)
        }
        let i = stack.removeLast()
        return i.getInteger()
    }
    
    func hasNext() -> Bool {
        return stack.count > 0
    }
    

}
