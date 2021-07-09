//
//  HardSolution.swift
//  LeetCode
//
//  Created by Apple on 2020/8/29.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation
import BinaryTree

struct HardSolution {
    
    func isMatch(_ s: String, _ p: String) -> Bool {
        let s = [Character](s), p = [Character](p)
        let n = s.count, m = p.count
        var f = [[Bool]].init(repeating: [Bool].init(repeating: false, count: m + 1), count: n + 1)
        f[0][0] = true
        guard m > 0 else {
            return n == 0
        }
        for i in 1...m {
            if p[i - 1] == Character("*") {
                f[0][i] = true
            } else {
                break
            }
        }
        guard n > 0 else {
            return f[n][m]
        }
        for i in 1...n {
            for j in 1...m {
                if p[j - 1] == Character("*") {
                    f[i][j] = f[i][j - 1] || f[i - 1][j]
                } else {
                    if s[i - 1] == p[j - 1] || p[j - 1] == Character("?") {
                        f[i][j] = f[i - 1][j - 1]
                    }
                }

            }
        }
        return f[n][m]
    }

    func minWindow(_ s: String, _ t: String) -> String {
        
        var dict = [Character: Int]()
        for c in t {
            dict[c, default: 0] += 1
        }
        let s = [Character](s)
        var curWord = [Character: Int]()
        var left = 0, right = 0
        
        func matches() -> Bool {
            for (c, value) in dict {
                if curWord[c, default: 0] < value {
                    return false
                }
            }
            return true
        }
        while left < s.count {
            if nil == dict[s[left]] {
                curWord[s[left]] = 1
                left += 1
            } else {
                break
            }
        }
        right = left
        while right < s.count {
            if matches() {
                break
            } else {
                if dict[s[right]] != nil {
                    curWord[s[right], default: 0] += 1
                }
            }
            right += 1
        }
        if matches() {
            while true {
                if dict[s[left]] == nil {
                    left += 1
                } else if let count = dict[s[left]],
                          let curCount = curWord[s[left]],
                          curCount > count {
                    curWord[s[left], default: 0] -= 1
                    left += 1
                } else {
                    break
                }
            }
        } else {
            return ""
        }
        
        var res = right - left
        var minLeft = left, minRight = right - 1
        while right < s.count {
            if dict[s[right]] != nil  {
                curWord[s[right], default: 0] += 1
            }
            while true {
                if dict[s[left]] == nil {
                    left += 1
                } else if let count = dict[s[left]],
                          let curCount = curWord[s[left]],
                          curCount > count {
                    curWord[s[left], default: 0] -= 1
                    left += 1
                } else {
                    break
                }
            }
            if res > right - left + 1 {
                res = right - left + 1
                minLeft = left
                minRight = right
            }
            
            right += 1
            
        }
        

        return String(s[minLeft...minRight])
    }
    
    func uniquePathsIII(_ grid: [[Int]]) -> Int {
        let W = grid[0].count, H = grid.count
        var start: (Int, Int)!
        var total = 2
        for y in 0..<H {
            for x in 0..<W {
                if grid[y][x] == 1 {
                    start = (x,y)
                } else if grid[y][x] == 0 {
                    total += 1
                }
            }
        }
        var res = 0
        var visited = [[Bool]].init(repeating: [Bool].init(repeating: false, count: W), count: H)
        
        var curRouteTotal = 0
        
        func dfs(_ x: Int, _ y: Int) {
            guard x >= 0 && x < W && y >= 0 && y < H && grid[y][x] != -1 && !visited[y][x] else {
                return
            }
            curRouteTotal += 1
            visited[y][x] = true
            if grid[y][x] == 2 {
                if total == curRouteTotal {
                    res += 1
                }
            } else {
                dfs(x + 1, y)
                dfs(x - 1, y)
                dfs(x, y + 1)
                dfs(x, y - 1)
            }
            curRouteTotal -= 1
            visited[y][x] = false
        }
        dfs(start.0, start.1)
        return res
    }
}

class SlidingPuzzle {
    struct Node {
        let board: [[Int]]
        let x: Int
        let y: Int
        let d: Int
        let s: Int
        
        init(_ board: [[Int]], _ x: Int, _ y: Int, _ d: Int, _ s: Int) {
            self.board = board
            self.x = x
            self.y = y
            self.d = d
            self.s = s
        }
    }
    
    func slidingPuzzle(_ board: [[Int]]) -> Int {
        let directions = [(-1, 0),(1,0),(0,-1),(0,1)]
        let H = board.count, W = board[0].count
        var start = (0,0)
        for x in 0..<W {
            for y in 0..<H {
                if board[y][x] == 0 {
                    start = (x,y)
                }
            }
        }
        let resultNumber = board.reduce(0) { $0 * 1000 + $1.reduce(0) { $0 * 10 + $1 } }
        var cache = Set<Int>.init(arrayLiteral: resultNumber)
        var queue = [Node(board, start.0, start.1, 0, resultNumber)]
        while queue.count > 0 {
            var newQueue = [Node]()
            for node in queue {
                if node.s == 123450 {
                    return node.d
                }
                if node.d == 4 {
                    print("sdsf")
                }
                for direction in directions {
                    let x = node.x + direction.0
                    let y = node.y + direction.1
                    if abs(x - node.x) + abs(y - node.y) != 1 ||
                        x < 0 || x >= W || y < 0 || y >= H {
                        continue
                    }
                    var newboard = node.board
                    newboard[y][x] = 0
                    newboard[node.y][node.x] = node.board[y][x]
                    let newResult = newboard.reduce(0) { $0 * 1000 + $1.reduce(0) { $0 * 10 + $1 } }

                    if !cache.contains(newResult) {
                        newQueue.append(Node(newboard, x, y, node.d + 1, newResult))
                        cache.insert(newResult)
                    }
                }
            }
            queue = newQueue
        }
        
        return -1
    }
    
}

struct RecoverTree {
    func recoverTree(_ root: TreeNode<Int>?) {
        var x, y, pre: TreeNode<Int>?
        
        func inorder(_ root: TreeNode<Int>?) {
            guard let root = root else {
                return
            }
            inorder(root.left)
            if pre != nil && pre!.val > root.val {
                y = root
                if x == nil {
                    x = pre
                }
            }
            pre = root
            inorder(root.right)
        }
        inorder(root)
        let tmp = y!.val
        y?.val = x!.val
        x?.val = tmp
    }
}

struct MinfallingPathSum {
    func minFallingPathSum(_ arr: [[Int]]) -> Int {
        let N = arr.count
        var first = 0, firstPos = -1, second = 0
        for i in 0..<N {
            var fs = Int.max, fp = -1, ss = Int.max
            for j in 0..<N {
                let curSum = (firstPos != j ? first : second) + arr[i][j]
                if curSum < fs {
                    ss = fs
                    fs = curSum
                    fp = j
                } else if curSum < ss {
                    ss = curSum
                }
            }
            second = ss
            first = fs
            firstPos = fp
        }
        return first
    }
}

struct Solution57 {
    
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        guard intervals.count > 0 else {
            return [newInterval]
        }
        var upper = intervals[0][0] - 1
        var result = [[Int]]()
        var inserted = false
        for interval in intervals {
            if upper >= interval[0] {
                if interval[1] > upper {
                    upper = interval[1]
                    var cur = result.removeLast()
                    cur[1] = interval[1]
                    result.append(cur)
                }
            } else {
                if inserted {
                    result.append(interval)
                } else if newInterval[0] >= interval[0] && newInterval[0] <= interval[1] {
                    if interval[1] > newInterval[1] {
                        upper = interval[1]
                        result.append([interval[0],interval[1]])
                    } else {
                        upper = newInterval[1]
                        result.append([interval[0],newInterval[1]])
                    }
                    inserted = true
                } else if newInterval[1] >= interval[0] && newInterval[1] <= interval[1] {
                    upper = interval[1]
                    result.append([newInterval[0],interval[1]])
                    inserted = true
                } else if newInterval[0] < interval[0] && newInterval[1] > interval[1] {
                    upper = newInterval[1]
                    result.append(newInterval)
                    inserted = true
                } else if newInterval[1] < interval[0] {
                    upper = interval[1]
                    result.append(newInterval)
                    result.append(interval)
                    inserted = true
                } else {
                    result.append(interval)
                }
            }
        }
        
        if !inserted {
            result.append(newInterval)
        }
        return result
    }
}

struct Solution65 {
    enum State {
        case integerSign, integer, integerComplete, fraction,fractionComplete, exponentSign, exponent, exponentComplete
    }
    func isNumber(_ s: String) -> Bool {
        let s = [Character](s)
        var i = s.count - 1
        
        while i >= 0 && s[i].isWhitespace {
            i -= 1
        }
        var j = 0
        while j < s.count && (s[j].isWhitespace) {
            j += 1
        }
        var index = j
        guard j <= i else {
            return false
        }
        var state = State.integerSign
        
        let integerSet = Set<Character>("0123456789")
        while index <= i && index >= j {
            switch state {
            case .integerSign:
                if !integerSet.contains(s[index]) {
                    if s[index] == "+" || s[index] == "-" {
                        state = .integer
                    } else if s[index] == "." {
                        state = .fraction
                    } else {
                        return false
                    }
                } else {
                    state = .integerComplete
                }
            case .integer:
                if !integerSet.contains(s[index]) {
                    if s[index] == "." {
                        state = .fraction
                    } else {
                        return false
                    }
                } else {
                    state = .integerComplete
                }
            case .integerComplete:
                if !integerSet.contains(s[index]) {
                    if s[index] == "." {
                        state = .fractionComplete
                    } else if s[index] == "e" {
                        state = .exponentSign
                    } else {
                        return false
                    }
                }
            case .fraction:
                if !integerSet.contains(s[index]) {
                    return false
                } else {
                    state = .fractionComplete
                }
            case .fractionComplete:
                if !integerSet.contains(s[index]) {
                    if s[index] == "e" {
                        state = .exponentSign
                    } else {
                        return false
                    }
                }
            case .exponentSign:
                if !integerSet.contains(s[index]) {
                    if s[index] != "+" && s[index] != "-" {
                        return false
                    } else {
                        state = .exponent
                    }
                } else {
                    state = .exponentComplete
                }
            case .exponent, .exponentComplete:
                if !integerSet.contains(s[index]) {
                    return false
                }
                state = .exponentComplete
            }
            index += 1
        }
        return  ![State.exponent,State.exponentSign,State.integerSign,State.integer,State.fraction].contains(state)
    }
}

struct Solution85 {
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        let W = matrix[0].count, H = matrix.count
        func maxHeight(_ x: Int, _ y: Int, _ width: Int) -> Int {
            var height = 0
            while y + height < H {
                for i in x..<x+width {
                    if matrix[y + height][i] == "0" {
                        return height
                    }
                }
                height += 1
            }
            
            return height
        }
        var res = 0
        for y in 0..<H {
            for x in 0..<W {
                var width = 1
                while x + width <= W {
                    let height = maxHeight(x, y, width)
                    if height == 0 {
                        break
                    }
                    res = max(height * width,res)
                    width += 1
                }
            }
        }
        return res
    }
    
//    func leetcode84(_ heights: [Int]) -> Int {
//        var stack = [-1]
//        var maxarea = 0
//        for i in 0..<heights.count {
//            while let peek = stack.last, peek != -1, heights[peek] >= heights[i] {
//                maxarea = max(maxarea, heights[stack.removeLast()] * (i - peek - 1))
//            }
//            stack.append(i)
//        }
//        
//    }
}

class Solution84 {
    func largestRectangleArea(_ heights: [Int]) -> Int {
        var res = 0
        for left in 0..<heights.count {
            var minHeight = heights[left]
            for right in left..<heights.count {
                minHeight = min(heights[right], minHeight)
                res = max(minHeight * (right - left + 1), res)
            }
        }
        return res
    }
    

}


/// df
class Solution312 {
    func maxCoins(_ nums: [Int]) -> Int {
        let N = nums.count
        var rec = [[Int]].init(repeating: [Int].init(repeating: -1, count: N + 2), count: N + 2)
        var vals = [Int].init(repeating: 1, count: N + 2)
        for i in 1...N {
            vals[i] = nums[i - 1]
        }
        
        func solve(_ i: Int, _ j: Int) -> Int {
            if i >= j {
                return 0
            }
            if rec[i][j] != -1 {
                return rec[i][j]
            }
            for k in i + 1 ..< j {
                var sum = vals[i] * vals[k] * vals[j]
                sum += solve(i, k) + solve(k, j)
                rec[i][j] = max(sum, rec[i][j])
            }
            return rec[i][j]
        }
        return solve(0, N + 1)
    }
    //dp
    func maxCoinsDp(_ nums: [Int]) -> Int {
        let N = nums.count
        var rec = [[Int]].init(repeating: [Int].init(repeating: 0, count: N + 2), count: N + 2)
        var vals = [Int].init(repeating: 1, count: N + 2)
        for i in 1...N {
            vals[i] = nums[i - 1]
        }
        for i in stride(from: N - 1, through: 0, by: -1) {
            for j in i + 2 ... N + 1 {
                for k in i + 1 ..< j {
                    var sum = vals[i] * vals[k] * vals[j]
                    sum += rec[i][k] + rec[k][j]
                    rec[i][j] = max(sum, rec[i][j])
                }
            }
        }
        return rec[0][N + 1]
    }
}

class Solution1255 {
    func maxScoreWords(_ words: [String], _ letters: [Character], _ score: [Int]) -> Int {
        var letterCounts = [Int].init(repeating: 0, count: 26)
        let baseValue = Character("a").asciiValue!
        for c in letters {
            letterCounts[Int(c.asciiValue! - baseValue)] += 1
        }
        var wordLetterCounts = [[Int]]()
        var wordScore = [Int]()
        for word in words {
            var counts = [Int].init(repeating: 0, count: 26)
            for c in word {
                counts[Int(c.asciiValue! - baseValue)] += 1
            }
            wordLetterCounts.append(counts)
            var s = 0
            for i in 0...25 {
                s += score[i] * counts[i]
            }
            wordScore.append(s)
            
        }
        
        func match(_ i: Int) -> Bool {
            for j in 0...25 {
                if letterCounts[j] < wordLetterCounts[i][j] {
                    return false
                }
            }
            return true
        }
        
        func add(_ i: Int) {
            for j in 0...25 {
                letterCounts[j] += wordLetterCounts[i][j]
            }
        }
        
        func minus(_ i: Int) {
            for j in 0...25 {
                letterCounts[j] -= wordLetterCounts[i][j]
            }
        }
        
        var res = 0
        func dfs(_ i: Int, _ curScore: Int) {
            guard i < words.count else {
                res = max(curScore, res)
                return
            }
            if match(i) {
                minus(i)
                dfs(i + 1, curScore + wordScore[i])
                add(i)
            }
            dfs(i + 1, curScore)
            

        }
        dfs(0, 0)
        return res
    }
}


class Solution1665 {
    func minimuEffort(_ tasks: [[Int]]) -> Int {
        let sorted = tasks.sorted {
            return $0[0] - $0[1] <= $1[0] - $1[1]
        }
        var res = 0
        var sum = 0
        for i in sorted {
            res = max(res, sum + i[1])
            sum += i[0]
        }
        return res
    }
}

class MedianFinder {
    var maxHeap = Heap<Int>.init(sort: >)
    
    var minHeap = Heap<Int>.init(sort: <)
    
    init() {
        
    }
    
    func addNum(_ num: Int) {
        if let i = maxHeap.remove() {
            minHeap.insert(i)
            minHeap.insert(num)
            maxHeap.insert(minHeap.remove() ?? 0)
        } else {
            minHeap.insert(num)
        }
        
        if minHeap.count > maxHeap.count {
            maxHeap.insert(minHeap.remove() ?? 0)
        }
    }
    
    func findMedian() -> Double {
        if maxHeap.count == minHeap.count {
            return (Double(minHeap.peek() ?? 0) + Double(maxHeap.peek() ?? 0)) / 2
        } else {
            return Double(maxHeap.peek() ?? 0)
        }
    }
}

class MedianFinderDelay {
    //
    var maxHeap = Heap<Int>(sort: >)
    var minHeap = Heap<Int>(sort: <)
    var dict = [Int: Int]()
    var k: Int
    var smallSize = 0, largeSize = 0
    
    init(_ k: Int) {
        self.k = k
    }
    
    func prune(_ small: Bool) {
        while let i = (small ? minHeap : maxHeap).peek() {
            if dict[i, default: 0] > 0 {
                dict[i, default: 0] -= 1
                if dict[i, default: 0] == 0 {
                    dict[i] = nil
                }
                if small {
                    minHeap.remove()
                } else {
                    maxHeap.remove()
                }
            }
        }
    }
    
    func makeBalance() {
        if smallSize > largeSize + 1 {
            maxHeap.insert(minHeap.remove() ?? 0)
            smallSize -= 1
            largeSize += 1
            prune(true)
        } else if smallSize < largeSize {
            minHeap.insert(maxHeap.remove() ?? 0)
            smallSize += 1
            largeSize -= 1
            prune(false)
        }
    }
    
    func addNum(_ num: Int) {
        if minHeap.isEmpty || minHeap.peek()!  >= num {
            minHeap.insert(num)
            smallSize += 1
        } else {
            maxHeap.insert(num)
            largeSize += 1
        }
        makeBalance()
    }
    
    func remove(_ num: Int) {
        dict[num, default: 0] += 1
        if let i = minHeap.peek(), num <= i {
            smallSize -= 1
            if num == i {
                prune(true)
            }
        } else {
            largeSize -= 1
            if let i = maxHeap.peek(), i == num {
                prune(false)
            }
        }
        makeBalance()
    }
    
    func findMedian() -> Double {
        return k ^ 1 == 1 ? Double(minHeap.peek() ?? 0) : Double((minHeap.peek() ?? 0) + (maxHeap.peek() ?? 0)) / 2
    }
    
    func medianSlidingWindow(_ nums: [Int], _ k: Int) -> [Double] {
        guard k > 1 else {
            return nums.map { Double($0) }
        }
        
        guard k > 2 else {
            var res = [Double]()
            for i in 0..<nums.count - 1 {
                res.append((Double(nums[i]) + Double(nums[i + 1])) / 2)
            }
            return res
        }
        var res = [Double]()
        let finder = MedianFinderDelay(k)
        for i in 0..<k - 1 {
            finder.addNum(nums[i])
        }
        for i in k - 1..<nums.count {
            finder.addNum(nums[i])
            finder.remove(nums[i - k + 1])
            res.append(finder.findMedian())
        }
        return res
    }
    
    func countOfAtoms(_ formula: String) -> String {
        let s = [Character](formula), N = formula.count

        func dfs(_ i: Int) -> ([String: Int], Int) {
            var elementName = "", count = ""
            var dict = [String: Int]()
            var internalDict = [String: Int]()
            var j = i
            while j < N {
                let c = s[j]
                if c.isLowercase {
                    elementName.append(c)
                } else if c.isUppercase {
                    if elementName.count > 0 {
                        let number = count.count == 0 ? 1 : Int(count)!
                        dict[elementName, default: 0] += number
                    } else if internalDict.count > 0 {
                        let number = count.count == 0 ? 1 : Int(count)!
                        for (e, n) in internalDict {
                            dict[e,default: 0] += number * n
                        }
                    }
                    elementName = String(c)
                    count = ""
                } else if c == "(" {
                    if elementName.count > 0 {
                        let number = count.count == 0 ? 1 : Int(count)!
                        dict[elementName, default: 0] += number
                    } else if internalDict.count > 0 {
                        let number = count.count == 0 ? 1 : Int(count)!
                        for (e, n) in internalDict {
                            dict[e,default: 0] += number * n
                        }
                    }
                    elementName = ""
                    count = ""

                    let z = dfs(j + 1)
                    j = z.1
                    internalDict = z.0
                    
                } else if c == ")" {
                    if elementName.count > 0 {
                        let number = count.count == 0 ? 1 : Int(count)!
                        dict[elementName, default: 0] += number
                    } else if internalDict.count > 0 {
                        let number = count.count == 0 ? 1 : Int(count)!
                        for (e, n) in internalDict {
                            dict[e,default: 0] += number * n
                        }
                    }
                    return (dict, j)
                } else {
                    count.append(c)
                }
                
                j += 1
            }
            if elementName.count > 0 {
                let number = count.count == 0 ? 1 : Int(count)!
                dict[elementName, default: 0] += number
            } else if internalDict.count > 0 {
                let number = count.count == 0 ? 1 : Int(count)!
                for (e, n) in internalDict {
                    dict[e,default: 0] += number * n
                }
            }
            return (dict, N)
        }
        let res = dfs(0).0
        var resString = ""
        for (e, n) in res.sorted(by: { $0.key < $1.key }) {
            resString.append("\(e)")
            if n > 1 {
                resString.append("\(n)")
            }
        }
        return resString
    }
    

}

class Solution124 {
    func maxPathSum(_ root: TreeNode<Int>?) -> Int {
        var res = Int.min
        func pathSum(_ n: TreeNode<Int>?) -> Int {
            guard let node = n else {
                return 0
            }
            let left = max(pathSum(node.left),0)
            let right = max(pathSum(node.right), 0)
            let priceNewPath = node.val + left + right
            res = max(res, priceNewPath)
            return max(left, right) + node.val
        }
        let _ = pathSum(root)
        return res
    }
}

class Solution1723 {
//    func minimumTimeRequired(_ jobs: [Int], _ k: Int) -> Int {
//        var res = Int.max
//        for
//    }
}

class Solution765 {
    
    class UnionFind {
        var parent: [Int]
        var count: Int
        
        init(_ n: Int) {
            count = n
            parent = [Int]()
            for i in 0..<n {
                parent.append(i)
            }
        }
        
        func find(_ x: Int) -> Int {
            while x != parent[x] {
                parent[x] = parent[parent[x]]
            }
            return x
        }
        
        func union(_ x: Int, _ y: Int) {
            let rootX = find(x)
            let rootY = find(y)
            if rootX == rootY {
                return
            }
            parent[rootX] = rootY
            count -= 1
        }
    }
    
    func minSwapCouples(_ row: [Int]) -> Int {
        let len = row.count
        let N = len / 2
        let unionFind = UnionFind(N)
        for i in stride(from: 0, to: len, by: 2) {
            unionFind.union(row[i] / 2, row[i + 1] / 2)
        }
        return N - unionFind.count
    }
}
