//
//  MediumSolution.swift
//  LeetCode
//
//  Created by Apple on 2021/6/27.
//  Copyright © 2021 Pszertlek. All rights reserved.
//

import BinaryTree

class MediumSolution {
    /**
     139
    深度优先
     */
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let s = [Character](s)
        let countSet = Set(wordDict.map { $0.count })
        let wordSet = Set(wordDict)
        let n = s.count
        var visited = [Bool](repeating: false, count: s.count)
        
        func dfs(_ start: Int) -> Bool {
            
            guard start < n else {
                return true
            }
            guard !visited[start] else {
                return false
            }
            var res = false
            for i in countSet where start + i <= n {
                let word = String(s[start ..< start + i])
                if wordSet.contains(word) {
                    res = dfs(start + i) || res
                }
            }
            visited[start] = true
            return res
        }
        return dfs(0)
    }
    
    func wordBreakDp(_ s: String, _ wordDict: [String]) -> Bool {
        let n = s.count
        var dp = [Bool](repeating: false, count: n + 1)
        dp[n] = true
        let countSet = Set(wordDict.map({ $0.count }))
        let wordSet = Set(wordDict)
        let s = [Character](s)
        for i in stride(from: n, through: 0, by: -1) {
            if !dp[i] {
                continue
            }
            for j in countSet where i - j >= 0 && !dp[i - j]  {
                let word = String(s[i - j ..< i])
                if wordSet.contains(word) {
                    dp[i - j] = true
                }
            }
            
        }
        return dp[0]
    }
    
    /// 309 股票最佳买卖时机
    /// - Parameter prices: price
    /// - Returns: profit
    func maxProfit(_ prices: [Int]) -> Int {
        let n = prices.count
        //dp[i][0], 手上持有股票的最大收益
        //dp[i][1], 手上不持有股票，并且处于冷冻期的累积最大收益
        //dp[i][2], 手上不持有股票，并且不处于冷冻期的累积最大收益
        var dp = [[Int]](repeating: [0,0,0], count: n + 1)
        dp[0][0] = -prices[0]
        for i in 1...n {
            dp[i][0] = max(dp[i - 1][0], dp[i - 1][2] - prices[i])
            dp[i][1] = dp[i - 1][0] + prices[i]
            dp[i][2] = max(dp[i - 1][1], dp[i - 1][2])
        }
        return max(dp[n - 1][1], dp[n - 1][2])
    }
    
    /**
     
     */
    func snakesAndLadders(_ board: [[Int]]) -> Int {
        let N = board.count
        
        func number(_ x: Int, _ y: Int) -> Int {
            if y & 1 == 0 {
                return N * N - y * N - x
            } else {
                return N * N - (y + 1) * N + x + 1
            }
        }
        func point(from number: Int) -> (Int,Int) {
            let y = number / N
            var x = 0
            if y & 1 == 0 {
                x = N * N - y * N - number
            } else {
                x = number + (y + 1) * N - N * N - 1
            }
            return (x,y)
        }
        var queue = Set([1]), res = 0
        while queue.count > 0 {

        }
        return res
        
    }
    
    func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
        let H = mat.count, W = mat[0].count
        var dist = mat, seen = [[Bool]](repeating: [Bool](repeating: false, count: W), count: H)
        let directions = [(0,1),(0,-1),(-1,0),(1,0)]
        var queue = [(Int,Int)]()
        for i in 0..<H {
            for j in 0..<W {
                if mat[i][j] == 0 {
                    queue.append((i,j))
                    seen[i][j] = true
                }
                
            }
        }
        while !queue.isEmpty {
            var newQueue = [(Int,Int)]()
            for (i,j) in queue {
                for (x,y) in directions {
                    let ni = i + x
                    let nj = j + y
                    if ni < H && ni >= 0 && nj >= 0 && nj < W && !seen[ni][nj] {
                        seen[ni][nj] = true
                        dist[ni][nj] = dist[i][j] + 1
                        newQueue.append((ni,nj))
                    }
                }
            }
            queue = newQueue
        }

        return dist
    }
    
    func updateMatrixDp(_ mat: [[Int]]) -> [[Int]] {
        let H = mat.count, W = mat[0].count
        var dist = [[Int]](repeating: [Int](repeating: 1000_000_000, count: W), count: H)
        for i in 0..<H {
            for j in 0..<W {
                if mat[i][j] == 0 {
                    dist[i][j] = 0
                }
            }
        }
        for i in 0..<H {
            for j in 0..<W {
                if i - 1 >= 0 {
                    dist[i][j] = min(dist[i][j], dist[i - 1][j] + 1);
                }
                if j - 1 >= 0 {
                    dist[i][j] = min(dist[i][j], dist[i][j - 1] + 1)
                }
            }
        }
        for i in stride(from: H - 1, through: 0, by: -1) {
            for j in stride(from: W - 1, through: 0, by: -1) {
                if i + 1 < H {
                    dist[i][j] = min(dist[i][j], dist[i + 1][j] + 1)
                }
                if j + 1 < W {
                    dist[i][j] = min(dist[i][j], dist[i][j + 1] + 1);
                }
            }
        }
        return dist
    }
    

    func diffWaysToCompute(_ expression: String) -> [Int] {
        let solution = DiffWaysToCompute(expression)
        return solution.partionCompute(solution.range)
    }
    
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        let solution = LongestSubstring(k,s)
        return solution.partition(0..<s.count)
    }
    
    func constructFromPrePost(_ pre: [Int], _ post: [Int]) -> TreeNode<Int>? {
        var preDict = [Int: Int](), postDict = [Int: Int]()
        for i in 0..<pre.count {
            preDict[pre[i]] = i
            postDict[post[i]] = i
        }
        func build(_ preRange: Range<Int>, _ postRange: Range<Int>) -> TreeNode<Int>? {
            guard preRange.count > 0 else {
                return nil
            }
            let root = TreeNode(pre[preRange.lowerBound])
            guard preRange.count > 1 else {
                return root
            }
            let leftVal = pre[preRange.lowerBound + 1]
            let rightVal = post[postRange.upperBound - 2]
            if leftVal == rightVal {
                root.left = build(preRange.lowerBound + 1 ..< preRange.upperBound, postRange.lowerBound ..< postRange.upperBound - 1)
            } else {
                let leftPreIndex = preDict[leftVal, default: 0]
                let leftPostIndex = postDict[leftVal, default: 0]
                let rightPreIndex = preDict[rightVal, default: 0]
                let rightPostIndex = postDict[rightVal,default: 0]
                root.left = build(leftPreIndex ..< rightPreIndex,
                                  postRange.lowerBound ..< leftPostIndex + 1)
                
                root.right = build(rightPreIndex ..< preRange.upperBound,
                                   leftPostIndex + 1 ..< rightPostIndex + 1)
            }
            return root
        }
        return build(0..<pre.count, 0..<post.count)
    }
    ///1738
    func kthLargestValue(_ matrix: [[Int]], _ k: Int ) -> Int {
        let m = matrix.count, n = matrix[0].count
        var pre = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        var results = [Int]()
        for i in 1...m {
            for j in 1...n {
                pre[i][j] = pre[i - 1][j] ^ pre[i][j - 1] ^ pre[i - 1][j - 1] ^ matrix[i - 1][j - 1]
                results.append(pre[i][j])
            }
        }
        return quickSelect(&results, 0, results.count - 1, results.count - k)
    }
    
    func quickSelect(_ nums: inout [Int], _ left: Int, _ right: Int, _ index: Int) -> Int {
        
        func partition(_ nums: inout [Int], _ left: Int, _ right: Int) -> Int {
            let random = Int.random(in: left ..< right + 1)
            nums.swapAt(random, right)
            let x = nums[right]
            var i = left
            for j in left..<right {
                if nums[j] <= x {
                    nums.swapAt(i, j)
                    i += 1
                }
            }
            nums.swapAt(i, right)
            return i
        }
        
        let q = partition(&nums, left, right)
        if q == index {
            return nums[q]
        } else {
            return q > index ? quickSelect(&nums, left, q - 1, index) : quickSelect(&nums, q + 1, right, index)
        }
    }
    
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var arr = nums
        return quickSelect(&arr, 0, nums.count - 1, nums.count - k)
    }
}

class BeatifulArray {
    
    /// 利用奇偶行
    func beatifulArray1(_ N: Int) -> [Int] {
        var memo = [Int: [Int]]()
        func f(_ n: Int) -> [Int] {
            if let arr = memo[n] {
                return arr
            }
            var arr = [Int](repeating: 0, count: n)
            if n == 1 {
                arr[0] = 1
            } else {
                var j = 0
                for i in f((n + 1) / 2) {
                    arr[j] = i * 2 - 1
                    j += 1
                }
                for i in f(n / 2) {
                    arr[j] = i * 2
                    j += 1
                }
            }
            memo[n] = arr
            return arr
        }
        return f(N)
    }
    func beatifulArray(_ n: Int) -> [Int] {
        var ans = [Int].init(1...n)
        ans.sort { a, b in
            var i = 1
            while (a & i) == (b & i) {
                i <<= 1
            }
            return (a & i) < (b & i)
        }
        return ans
    }
    
    func balanceBST(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        var arr = [TreeNode<Int>]()
        func inorder(_ root: TreeNode<Int>?) {
            guard let root = root else {
                return
            }
            inorder(root.left)
            arr.append(root)
            inorder(root.right)
        }
        inorder(root)
        func build(_ left: Int, _ right: Int) -> TreeNode<Int>? {
            guard left <= right else {
                return nil
            }
            let mid = (left + right) / 2
            arr[mid].left = build(left, mid - 1)
            arr[mid].right = build(mid + 1, right)
            return arr[mid]
            
        }
        return build(0, arr.count - 1)
    }


}

class DiffWaysToCompute {
    var nums: [Int]
    var signs: [ComputeCommand]
    var dict: [Range<Int> : [Int]] = [:]
    var range: Range<Int> {
        return 0..<signs.count
    }
    init(_ s:String) {
        var nums = [Int]()
        var signs = [ComputeCommand]()
        var curNum = ""
        for c in s {
            if let sign = ComputeCommand(c) {
                nums.append(Int(curNum) ?? 0)
                curNum.removeAll()
                signs.append(sign)
            } else {
                curNum.append(c)
            }
        }
        nums.append(Int(curNum) ?? 0)
        self.nums = nums
        self.signs = signs
    }
    
    enum ComputeCommand {
        case plus, minus, multiple
        
        init?(_ c: Character) {
            switch c {
            case "+":
                self = .plus
            case "-":
                self = .minus
            case "*":
                self = .multiple
            default:
                return nil
            }
        }
        
        func compute(_ i: Int, _ j: Int) -> Int {
            var res = 0
            switch self {
            case .plus:
                res = i + j
            case .minus:
                res = i - j
            case .multiple:
                res = i * j
            }
            return res
        }
    }
    


    
    func partionCompute(_ range: Range<Int>) -> [Int] {
        if let result = dict[range] {
            return result
        }
        guard range.count != 0 else {
            return [nums[range.lowerBound]]
        }
        guard range.count != 1 else {
            let i = range.lowerBound
            return [signs[i].compute(nums[i], nums[i + 1])]
        }
        var result = [Int]()
        for i in range {
            let r1 = partionCompute(range.lowerBound ..< i)
            let r2 = partionCompute(i + 1 ..< range.upperBound)
            for i1 in r1 {
                for i2 in r2 {
                    result.append(signs[i].compute(i1, i2))
                }
            }
        }
        dict[range] = result
        return result
    }
}

class LongestSubstring {
    
    let k: Int
    let s: [Character]
    
    init(_ k: Int, _ s: String) {
        self.k = k
        self.s = [Character](s)
    }
    
    
    /// 分治法
    /// - Parameter range: 范围
    /// - Returns: 该范围最大的字符
    func partition(_ range: Range<Int>) -> Int {
        guard range.count >= k else {
            return 0
        }
        var dict = [Character: Int]()
        for i in range {
            dict[s[i], default: 0] += 1
        }
        var res: Character? = nil
        for (key,value) in dict {
            if value < k {
                res = key
                break
            }
        }
        guard let r = res else {
            return range.upperBound - range.lowerBound
        }
        var length = 0, left = range.lowerBound
        for i in range {
            if s[i] == r {
                length = max(length, partition(left..<i))
                left = i + 1
            } else if i == range.upperBound - 1 {
                length = max(length, partition(left..<range.upperBound))
            }
        }
        return length
    }
    
//    func slideWindow() {
//        let N = s.count
//        var ret = 0
//        for t in 1...26 {
//            var l = 0, r = 0
//            var dict = [Character: Int]()
//            var tot = 0, less = 0
//            while r < N {
//                dict[s[r], default: 0] += 1
//                if dict[s[r],default: 0] == 1 {
//                    tot += 1
//                    less += 1
//                }
//
//            }
//        }
//    }
}

/// No.373
///

class SuperPow {
    
    let a: Int
    
    let b: [Int]
    
    var map: [[Int]: Int] = [:]
    let mod: Int
    /// initialization
    /// - Parameters:
    ///   - a: 1 << a << 2^31 -1
    ///   - b: 0 << b[i] << 9
    init(_ a: Int, _ b: [Int], _ mod: Int) {
        self.a = a
        self.b = b
        self.mod = mod
    }

    /// partition method
    ///
    /// (a * b) % k = ((a % k) * (b % k)) % k
    /// a^123 = (a^3) * (a^12)^10
    /// - Returns: result
    func partition(_ index: Int) -> Int {
        guard index > 0 else {
            return 1
        }
        let last = b[index - 1]
        return (pow(a, last) * pow(partition(index - 1),10)) % mod
    }
    
    func pow(_ a: Int, _ k: Int) -> Int {
        if let res = map[[a,k]] {
            return res
        }
        var res = 1
        for _ in 0..<k {
            res *= a
            res %= mod
        }
        map[[a,k]] = res
        return res
    }
}

class PartitionSort {
    
    func sort() {
        
    }
    
}


class MergeSort {
    func mergeSort(_ nums: inout [Int], _ left: Int, _ right: Int) {
        guard left < right else {
            return
        }
        let mid = (left + right) / 2
        mergeSort(&nums, left, mid)
        mergeSort(&nums, mid + 1, right)
        var i = left, j = mid + 1, cnt = 0
        var temp = [Int](repeating: 0, count: right - left + 1)
        while i <= mid && j <= right {
            if nums[i] <= nums[j] {
                temp[cnt] = nums[i]
                i += 1
            } else {
                temp[cnt] = nums[j]
                j += 1
            }
            cnt += 1
        }
        for i in left...right {
            nums[i] = temp[i]
        }
    }
}
