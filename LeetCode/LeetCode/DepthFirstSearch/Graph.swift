//
//  Graph.swift
//  LeetCode
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation
import Utility

open class Edge: Equatable {
    open var neighbor: Node
    
    public init(neighbor: Node) {
        self.neighbor = neighbor
    }
}

public func == (lhs: Edge, rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}

public class Node: CustomStringConvertible, Equatable {
    open var neighbors: [Edge]
    
    open fileprivate(set) var label: String
    open var distance: Int?
    open var visited: Bool
    
    public init(label: String) {
        self.label = label
        neighbors = []
        visited = false
    }
    
    open var description: String {
        if let distance = distance {
            return "Node(label: \(label), distance: \(distance)"
        }
        return "Node(label: \(label), distance: infinity"
    }
    
    open var hasDistance: Bool {
        return distance != nil
    }
    
    open func remove(_ edge: Edge) {
//        neighbors.remove(at: neighbors.firstIndex(where: {$0 == edge})!)
    }
}

public func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
}

open class Graph: CustomStringConvertible, Equatable {
    open fileprivate(set) var nodes: [Node]
    
    public init() {
        self.nodes = []
    }
    
    open func addNode(_ label: String) -> Node {
        let node = Node(label: label)
        nodes.append(node)
        return node
    }
    
    open func addEdge(_ source: Node, neighbor: Node) {
        let edge = Edge(neighbor: neighbor)
        source.neighbors.append(edge)
    }
    
    open var description: String {
        var description = ""
        
        for node in nodes {
            if !node.neighbors.isEmpty {
                description += "[node: \(node.label) edges: \(node.neighbors.map { $0.neighbor.label})]"

            }
        }
        return description
    }
    
    open func findNodeWithLabel(_ label: String) -> Node {
        return nodes.filter({ (node) -> Bool in
            node.label == label
        }).first!
    }
    
    open func duplicate() -> Graph {
        let duplicated = Graph()
        for node in nodes {
            _ = duplicated.addNode(node.label)
        }
        
        for node in nodes {
            for edge in node.neighbors {
                let source = duplicated.findNodeWithLabel(node.label)
                let neighbour = duplicated.findNodeWithLabel(edge.neighbor.label)
                duplicated.addEdge(source, neighbor: neighbour)
            }
        }
        
        return duplicated
    }
}


public func == (lhs: Graph, rhs: Graph) -> Bool {
    return lhs.nodes == rhs.nodes
}

func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
    var nodesExplored = [source.label]
    for edge in source.neighbors {
        if !edge.neighbor.visited {
            nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
        }
    }
    return nodesExplored
}

class BFSSolution {
    func landderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        var allComboDict = [String: [String]]()
        wordList.forEach { (word) in
            let start = word.startIndex
            let end = word.endIndex
            var i = start
            
            while i < end {
                let newword = String(word[start..<i] + "*" + word[word.index(after: i)..<end])
                allComboDict[newword, default: []].append(word)
                i = word.index(after: i)
            }
        }
        var queue = [(String,Int)]()
        queue.append((beginWord,1))
        var visited = [String: Bool]()
        visited[beginWord] = true
        while !queue.isEmpty {
            let node = queue.removeLast()
            let word = node.0
            let level = node.1
            let start = word.startIndex
            let end = word.endIndex
            var i = start
            while i < end {
                let newword = String(word[start..<i] + "*" + word[word.index(after: i)..<end])
                for adjacentWord in allComboDict[newword, default:[]] {
                    if adjacentWord == endWord {
                        return level + 1
                    }
                    if nil == visited[adjacentWord] {
                        visited[adjacentWord] = true
                        queue.append((adjacentWord, level + 1))
                    }
                }
                i = word.index(after: i)
            }
        }
        return 0
    }
    
    class Node {
        var val: Int
        var neighbors: [Node?]
        init(_ val: Int, _ neighbors: [Node] = []) {
            self.val = val
            self.neighbors = neighbors
        }
    }
    
    func clone(_ node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        var queue: [(Node?,[Node?])] = [(nil,[node])]
        var res: Node?
        var dict: [Int: Node] = [:]
        var visited = Set<Int>()
        while queue.count > 0 {
            var newQueue = [(Node?, [Node?])]()
            while let pair = queue.popLast() {
                let pre = pair.0
                if let i = pre?.val {
                    if visited.contains(i) {
                        continue
                    } else {
                        visited.insert(i)
                    }
                }
                for n in pair.1  {
                    var newNode: Node!
                    if let theNode = dict[n!.val] {
                        newNode = theNode
                    } else {
                        newNode = Node(n!.val)
                        dict[n!.val] = newNode
                    }
                    if res == nil {
                        res = newNode
                    }
                    newQueue.append((newNode,n!.neighbors))
                    pre?.neighbors.append(newNode)
                }


            }
            queue = newQueue
        }
        return res
    }
    
    public func singleNumber(_ nums: [Int]) -> Int {
        var seenOnce = 0, seenTwice = 0
        for num in nums {
            seenOnce = ~seenTwice & (seenOnce ^ num)
            seenTwice = ~seenOnce & (seenTwice ^ num)
        }
        return seenOnce
    }
    
    public func canReach(_ arr: [Int], _ start: Int) -> Bool {
        var queue = [start]
        let N = arr.count
        var visited = [Bool].init(repeating: false, count: arr.count)
        while queue.count > 0 {
            var newQueue = [Int]()
            for i in queue {
                if arr[i] == 0 {
                    return true
                }
                let left = i - arr[i]
                let right = i + arr[i]
                if left >= 0 && !visited[left] {
                    newQueue.append(left)
                    visited[left] = true
                }
                if right <= N - 1 && !visited[right] {
                    newQueue.append(right)
                    visited[right] = true
                }
            }
            queue = newQueue
        }
        return false
    }
    
    public func maxDistance(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 else {
            return -1
        }
        guard grid[0].count > 0 else {
            return -1
        }
        let height = grid.count
        let width = grid[0].count
        var visited = [[Bool]].init(repeating: [Bool].init(repeating: false, count: width), count: height)
        for h in 0..<height {
            for w in 0..<width {
                if grid[h][w] == 0 {
                    visited[h][w] = true
                }
            }
        }
        return 0
    }
    
    //174.地下城
    func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        guard dungeon.count > 0 else {
            return 0
        }
        guard dungeon[0].count > 0 else {
            return 0
        }
        let H = dungeon.count, W = dungeon[0].count
        var dp = [[Int]].init(repeating: [Int].init(repeating: 1, count: W), count: H)
        dp[H - 1][W - 1] = dungeon[H - 1][W - 1] >= 0 ? 1 : 1 - dungeon[H - 1][W - 1]
        if H > 1 {
            for y in stride(from: H - 2, through: 0, by: -1) {
                dp[y][W - 1] = dp[y + 1][W - 1] - dungeon[y][W - 1] > 0 ? dp[y + 1][W - 1] - dungeon[y][W - 1] : 1
            }
        }
        if W > 1 {
            for x in stride(from: W - 2, through: 0, by: -1) {
                dp[H - 1][x] = dp[H - 1][x + 1] - dungeon[H - 1][x] > 0 ? dp[H - 1][x + 1] - dungeon[H - 1][x] : 1
            }
        }
        if H > 1 && W > 1 {
            for y in stride(from: H - 2, through: 0, by: -1) {
                for x in stride(from: W - 2, through: 0, by: -1) {
                    let right = dp[y][x + 1]
                    let down = dp[y + 1][x]
                    let rightMin = right - dungeon[y][x] > 0 ? right - dungeon[y][x] : 1
                    let downMin = down - dungeon[y][x] > 0 ? down - dungeon[y][x] : 1
                    dp[y][x] = min(rightMin, downMin)
                }
            }
        }
        return dp[0][0]
    }
    
    //dfs方法
    func calculateMinimumHP1(_ dungeon: [[Int]]) -> Int {
        
        guard dungeon.count > 0 else {
            return 0
        }
        guard dungeon[0].count > 0 else {
            return 0
        }
        let H = dungeon.count, W = dungeon[0].count
        var memory = [[Int]].init(repeating: [Int].init(repeating: -1, count: W), count: H)
        func dfs(_ x: Int, _ y: Int) -> Int {
            if y == H - 1 && x == W - 1 {
                if dungeon[y][x] > 0 {
                    memory[y][x] = 1
                    return 1
                } else {
                    memory[y][x] = 1 - dungeon[y][x]
                    return 1 - dungeon[y][x]
                }
            }
            if memory[y][x] != -1 {
                return memory[y][x]
            }
            if y == H - 1 {
                let right = dfs(x + 1, y)
                let res = right - dungeon[y][x] > 0 ? right - dungeon[y][x] : 1
                memory[y][x] = res
                return res
            } else if x == W - 1 {
                let down = dfs(x, y + 1)
                let res = down - dungeon[y][x] > 0 ? down - dungeon[y][x] : 1
                memory[y][x] = res
                return res
            } else {
                let right = dfs(x + 1, y)
                let down = dfs(x, y + 1)
                let rightMin = right - dungeon[y][x] > 0 ? right - dungeon[y][x] : 1
                let downMin = down - dungeon[y][x] > 0 ? down - dungeon[y][x] : 1
                let res = min(rightMin, downMin)
                memory[y][x] = res
                return res
            }
        }
        return dfs(0, 0)
    }

}

class WordDictionary {

    /** Initialize your data structure here. */
    var root: AlphaTree = AlphaTree(".")

    init() {

    }
    
    func addWord(_ word: String) {
        var node = root
        for c in word {
            if let n = node.search(c) {
                node = n
            } else {
                let n = AlphaTree(c)
                node.add(n)
                node = n
            }
        }
        node.isWord = true
        
    }
    
    func search(_ word: String) -> Bool {
        var nodes = [root]
        for c in word {
            var newNodes = [AlphaTree]()
            for n in nodes {
                if c == "." {
                    newNodes.append(contentsOf: [AlphaTree](n.next.values))
                } else {
                    if let node = n.search(c) {
                        newNodes.append(node)
                    }
                }
            }
            nodes = newNodes
        }
        for n in nodes {
            if n.isWord {
                return true
            }
        }
        return false
    }
    
    
    
    
}

class AlphaTree {
    let c: Character
    var next: [Character:AlphaTree] = [:]
    var isWord = false
    init(_ c: Character) {
        self.c = c
    }

    func search(_ c: Character) -> AlphaTree?  {
        return next[c]
    }
    
    func add(_ node: AlphaTree) {
        
        next[node.c] = node
    }
}

class DFSSolution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var visited = [Bool].init(repeating: false, count: numCourses)
        var dict = [Int: Set<Int>]()
        for prerequist in prerequisites {
            dict[prerequist[0],default: Set<Int>()].insert(prerequist[1])
        }
        var curSet = Set<Int>()
        func dfs(_ i: Int) -> Bool {
            guard !visited[i] else {
                return true
            }
            if curSet.contains(i) {
                return false
            }
            curSet.insert(i)
            if let set = dict[i] {
                for num in set {
                    if !dfs(num) {
                        return false
                    }
                }
            }
            visited[i] = true
            curSet.remove(i)
            return true
        }
        for i in dict.keys {
            if !dfs(i) {
                return false
            }
        }
        return true
    }
    
    func totalNQueues(_ N: Int) -> Int {
        guard N > 3 else {
            return 0
        }
        var totalCount = 0
        var curArr = [(Int,Int)]()
        
        func compatable(_ x: Int, _ y: Int) -> Bool {
            for p in curArr {
                if p.0 - x == p.1 - y || p.0 == x || p.1 == y || p.0 - x == y - p.1 {
                    return false
                }
            }
            return true
        }
        func dfs(_ x: Int, _ y: Int) {
            guard y < N else {
                return
            }
            guard compatable(x, y) else {
                return
            }
            curArr.append((x,y))
            guard curArr.count < N else {
                totalCount += 1
                curArr.removeLast()
                return
            }
            for i in 0..<N where i !=  x - 1 && i != x + 1{
                dfs(i, y + 1)
            }
            curArr.removeLast()
        }
    

        for i in 0..<N/2 {
            dfs(i, 0)
        }
        totalCount *= 2
        if N % 2 != 0 {
            dfs(N / 2, 0)
        }
        return totalCount
    }
    
    func solveNQueens(_ N: Int) -> [[String]] {
        guard N > 0 else {
            return []
        }
        guard N > 1 else {
            return [["Q"]]
        }
        var totalCount = 0
        var curArr = [(Int,Int)]()
        var res = [[String]]()

        func compatable(_ x: Int, _ y: Int) -> Bool {
            for p in curArr {
                if p.0 - x == p.1 - y || p.0 == x || p.1 == y || p.0 - x == y - p.1 {
                    return false
                }
            }
            return true
        }
        func dfs(_ x: Int, _ y: Int) {
            guard y < N else {
                return
            }
            guard compatable(x, y) else {
                return
            }
            curArr.append((x,y))
            guard curArr.count < N else {
                totalCount += 1
                var cur = [String]()
                var s = ""
                for p in curArr {
                    for x in 0..<N {
                        if p.0 == x {
                            s += "Q"
                        } else {
                            s += "."
                        }
                    }
                    cur.append(s)
                    s = ""
                }
                res.append(cur)
                curArr.removeLast()
                return
            }
            for i in 0..<N where i !=  x - 1 && i != x + 1{
                dfs(i, y + 1)
            }
            curArr.removeLast()
        }
        for i in 0..<N {
            dfs(i, 0)
        }
        return res
    }
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard board.count > 0 else {
            return word.count == 0
        }
        guard board[0].count > 0 else {
            return word.count == 0
        }
        let W = board[0].count
        let H = board.count
        let word = [Character].init(word)
        var visited = [[Bool]].init(repeating: [Bool].init(repeating: false, count: W), count: H)
        func dfs(_ x: Int, _ y: Int, _ index: Int) -> Bool {
            guard index < word.count else {
                return true
            }

            guard x >= 0 && y >= 0 && x < W && y < H && !visited[y][x] && word[index] == board[y][x] else {
                return false
            }

            visited[y][x] = true
            var res = dfs(x + 1, y, index + 1)
            if !res {
                res = dfs(x - 1, y, index + 1)
            }
            if !res {
                res = dfs(x, y + 1, index + 1)
            }
            if !res {
                res = dfs(x, y - 1, index + 1)
            }
            visited[y][x] = false
            return res
        }
        for y in 0..<H {
            for x in 0..<W {
                if dfs(x, y, 0) {
                    return true
                }
            }
        }
        return false
    }
    
    func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int {
        var movingSet = Set<Int>()
        
        func unitSum(_ x: Int) -> Int {
            var res = 0
            var x = x
            while x > 0 {
                res += x % 10
                x /= 10
            }
            return res
        }
        
        func dfs(_ x: Int, _ y: Int) -> Int {
            guard x >= 0 && y >= 0 && x < m && y < n && !movingSet.contains(x + y * 100) else {
                return 0
            }
            movingSet.insert(x + y * 100)
            let sum = unitSum(x) + unitSum(y)
            var res = 0
            if sum <= k {
                res = dfs(x + 1, y)
                res += dfs(x - 1, y)
                res += dfs(x, y + 1)
                res += dfs(x, y - 1)
                res += 1
            }
            return res
        }
        
        return dfs(0, 0)
    }
    
    func cuttingRope(_ n: Int) -> Int {
        func pow(_ x: Int, _ y: Int) -> Int {
            var res = 1
            var y = y
            while y > 0 {
                res *= x
                res %= 1000000007
                y -= 1
            }
            return res
        }
        if (n < 4) {return n - 1 };
        let a = n / 3
        let b = n % 3
        if (b == 0) {
            return pow(3, a) % 1000000007

        }
        if (b == 1) {
            return pow(3, a-1) * 4 % 1000000007

        }
        if (b == 2) {
            return pow(3, a) * 2 % 1000000007

        }
        return a;
    }
    
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        let H = image.count
        guard H > 0 else {
            return image
        }
        let W = image[0].count
        guard W > 0 else {
            return image
        }
        var res = image
        var visited = [[Bool]].init(repeating: [Bool].init(repeating: true, count: W), count: H)
        let y = sr, x = sc, orignalColor = image[y][x]

        var queue = [(y,x)]
        while queue.count > 0 {
            var newQueue = [(Int,Int)]()
            for p in queue {
                res[p.0][p.1] = newColor
                visited[p.0][p.1] = false
                if p.0 + 1 < H && visited[p.0 + 1][p.1] && res[p.0 + 1][p.1] == orignalColor {
                    newQueue.append((p.0 + 1, p.1))
                }
                if p.1 + 1 < W && visited[p.0][p.1 + 1] && res[p.0][p.1 + 1] == orignalColor {
                    newQueue.append((p.0, p.1 + 1))
                }
                if p.0 - 1 >= 0 && visited[p.0 - 1][p.1] && res[p.0 - 1][p.1] == orignalColor {
                    newQueue.append((p.0 - 1, p.1))
                }
                if p.1 - 1 >= 0 && visited[p.0][p.1 - 1] && res[p.0][p.1 - 1] == orignalColor {
                    newQueue.append((p.0, p.1 - 1))
                }
            }
            queue = newQueue
        }
        return res
    }

    func generateParenthesis(_ n: Int) -> [String] {
        var res = [String]()
        func backtrack(_ s: String, _ left: Int, _ right: Int) {
            guard s.count < n + n else {
                res.append(s)
                return
            }
            if left < n {
                backtrack(s + "(", left + 1, right)
            }
            if right < left {
                backtrack(s + ")", left, right + 1)
            }
        }
        backtrack("", 0, 0)
        return res
    }
    
    func updateBoard(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
        var newBoard = board
        let H = board.count, W = board[0].count
        var visited = [[Bool]].init(repeating: [Bool].init(repeating: false, count: W), count: H)

        
        func bombCount(_ x: Int, _ y: Int) -> Int {
            let xFrom = max(0, x - 1)
            let xTo = min(x + 1, W - 1)
            let yFrom = max(0, y - 1)
            let yTo = min(y + 1, H - 1)
            var count = 0
            for y in yFrom...yTo {
                for x in xFrom...xTo {
                    if board[y][x] == "M" {
                        count += 1
                    }
                }
            }
            return count
        }
        
        func update(_ x: Int, _ y: Int) {
            guard !visited[y][x] else {
                return
            }
            visited[y][x] = true
            if board[y][x] == "M" {
                newBoard[y][x] = "X"
                return 
            }
            let bombNum = bombCount(x, y)
            if bombNum == 0 {
                newBoard[y][x] = "B"
                let xFrom = max(0, x - 1)
                let xTo = min(x + 1, W - 1)
                let yFrom = max(0, y - 1)
                let yTo = min(y + 1, H - 1)
                for y in yFrom...yTo {
                    for x in xFrom...xTo {
                        update(x, y)
                    }
                }
            } else {
                newBoard[y][x] = Character("\(bombNum)")
            }
            

        }
        update(click[1], click[0])
        return newBoard
    }
    
    func splitIntoFibonacci(_ S: String) -> [Int] {
        let N = S.count
        let s = [Character](S)
        var finish = false
        var res = [Int]()
        func dfs(_ index: Int, _ arr: [Int]) {
            guard index < S.count && !finish else {
                if !finish {
                    finish = arr.count > 2
                    res = arr.count > 2 ? arr : []
                }

                return
            }
            var number = 0
            for i in 0..<N-index {
                number = number * 10 + (s[index + i].hexDigitValue ?? 0)
                let arrCount = arr.count
                if number >= 2 << 31 {
                    break
                }
                if arrCount == 0 {
                    dfs(index + i + 1, [number])
                } else if arrCount == 1 {
                    dfs(index + i + 1, arr + [number])
                } else {
                    if arr[arrCount - 1] + arr[arrCount - 2] == number {
                        dfs(index + i + 1, arr + [number])
                    }
                }
                if number == 0 && (s[index + i].hexDigitValue ?? 0) == 0 {
                    break
                }
            }
        }
        dfs(0, [])
        return res
    }
    
    func getHappyString(_ n: Int, _ k: Int) -> String {
         let cs = [Character]("abc")
         var i = 0, res = ""
         func dfs(_ str: [Character]) {
             guard str.count < n && i < k else {
                i += 1
                if k == i {
                    res = String(str)
                }
                 

                 return
             }
             for index in 0..<3 {
                 if let last = str.last {
                    if last != cs[index] && i < k {
                        dfs(str + [cs[index]])
                    }
                     
                 } else {
                     dfs([cs[index]])
                 }
             }
         }
         dfs([])
         return res
     }
    
    func permutation(_ S: String) -> [String] {
        var dict = [Int8].init(repeating: 0, count: 128)
        
        for c in S.utf8CString {
            dict[Int(c)] += 1
        }
        
        let ss = UnsafeMutablePointer<CChar>.allocate(capacity: S.count + 1)
        let N = S.count
        var res = [String]()
        func dfs(_ index: Int) {
            guard index < N else {
                (ss + index).initialize(to: 0)
                res.append(String.init(cString: ss))
                return
            }
            for key in 65...122 {
                let count = dict[key]
                var i = 1
                while i <= count  {
                    dict[key] -= 1
                    (ss + index).initialize(to: CChar(key))
                    dfs(index + 1)
                    i += 1
                }
                dict[key] = count

            }
        }
        dfs(0)
        return res
    }
    
    func sequentialDigits(_ low: Int, _ high: Int) -> [Int] {
        var j = 0, i = low
        while i > 0 {
            i /= 10
            j += 1
        }
        var res = [Int]()
        var curNum = [Int]()
    
        for i in 1...j {
            curNum.append(i)
        }
        func dfs(_ curNum: [Int]) {
            let i = curNum.reduce(0) { $0 * 10 + $1 }
            if  i <= high {
                if i >= low {
                    res.append(i)
                }
                
                
                if curNum[curNum.count - 1] < 9 {
                    var newNum = curNum
                    for i in 0..<curNum.count {
                        newNum[i] = newNum[i] + 1
                    }
                    dfs(newNum)
                } else {
                    if curNum.count < 9 {
                        var nums = [Int]()
                        for i in 1...curNum.count+1 {
                            nums.append(i)
                        }
                        dfs(nums)
                    }
                }
            }
        }
        dfs(curNum)
        return res
    }
    
    func countVowelStrings(_ n: Int) -> Int {
        var count = [1,1,1,1,1]
        func dfs(_ i: Int) {
            guard i < n else {
                return
            }
            for j in 0..<5 {
                count[j] *= 5 - j
            }
            dfs(i + 1)
        }
        dfs(1)
        return count.reduce(0, +)
    }
    
    func countArrangement(_ n: Int) -> Int {
        var arr = [Int]()
        for i in 1...n {
            arr.append(i)
        }
        var res = 0
        func dfs(_ i: Int) {
            guard i < n else {
                res += 1
                return
            }
            for j in i..<n {
                arr.swapAt(i,j)
                if (i + 1) % arr[i] == 0 || arr[i] % (i + 1) == 0 {
                    dfs(i + 1)
                }
                arr.swapAt(i,j)

            }

        }
        dfs(0)
        return res
    }
    
    func constructDistancedSequence(_ n: Int) -> [Int] {
        var arr = [Int](repeating: 0, count: 2 * n - 1)
        let N = arr.count
        var visited = [Bool](repeating: false, count: n)
        var count = 0
        func dfs(_ i: Int) -> Bool {
            guard i < 2 * n - 1 && count < n else {
                return true
            }
            guard arr[i] == 0 else {
                return dfs(i + 1)
            }
            for j in stride(from: n, through: 1, by: -1) {
                if !visited[j - 1]  {
                    visited[j - 1] = true
                    if j == 1 {
                        arr[i] = 1
                        count += 1
                        if dfs(i + 1) {
                            return true
                        }
                        count -= 1
                        arr[i] = 0
                    } else if j + i < N && arr[j + i] == 0 {
                        arr[i] = j
                        arr[j + i] = j
                        count += 1
                        if dfs(i + 1) {
                            return true
                        }
                        count -= 1
                        arr[i] = 0
                        arr[j + i] = 0
                    }
                    visited[j - 1] = false
                }
                
            }
            return false
        }
        
        dfs(0)
        return arr
    }
}
