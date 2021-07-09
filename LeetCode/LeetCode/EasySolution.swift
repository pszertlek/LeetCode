//
//  EasySolution.swift
//  LeetCode
//
//  Created by Apple on 2020/11/5.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

class EasySolution {
    func reverseBits(_ num: Int) -> Int {
        var n = num
        var left = 0, right = 0, res = 0
        while n != 0 {
            if n & 1 == 1 {
                left += 1
            } else {
                right = left + 1
                left = 0
            }
            res = max(left + right, res)

            n >>= 1
            
        }
        return res
    }
    
    func paintingPlan(_ n: Int, _ k: Int) -> Int {
        guard k > 0 else {
            return 1
        }
        guard k >= n else {
            return 0
        }
        guard k != n * n else {
            return 1
        }
        var res = 0
        for i in 0..<n {
            for j in 0..<n {
                if k + (n - i) * (n - j) == n * n {
                    res += combation(n, i) * combation(n, j)
                }
            }
        }
        return res
    }
    
    func combation(_ n: Int, _ m: Int) -> Int {
        var res = 1
        for p in stride(from: n, to: n - m, by: -1) {
            res *= p
        }
        for q in stride(from: m, to: 0, by: -1) {
            res /= q
        }
        return res
    }
    
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var nums = nums
        let n = nums.count
        for i in nums {
            nums[(i - 1) % n] += n
        }
        var res = [Int]()
        for i in 1...n {
            if nums[i] < n {
                res.append(nums[i])
            }
        }
        return res
    }
    
    func countNegatives(_ grid: [[Int]]) -> Int {
        let h = grid.count
        let w = grid[0].count
        var y = h - 1
        var x = 0
        var total = 0
        while y >= 0 && y < h {
            while x < w && grid[y][x] >= 0 {
                x += 1
            }
            total += x
            y -= 1
        }
        return h * w - total
        /**
         4 3 2 -1
         3 2 1 -1
         1 1 -1 -2
         -1 -1 -2 -3
         */
        
    }
}

class MyQueue {
    
    var stack1: [Int] = []
    var stack2: [Int] = []
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        stack1.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        if stack2.count != 0 {
            return stack2.removeLast()
        }
        while let i = stack1.popLast() {
            stack2.append(i)
        }
        return stack2.popLast() ?? 0
    }
    
    /** Get the front element. */
    func peek() -> Int {
        if stack2.count == 0 {
            resend()
        }
        return stack2.last ?? 0
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return stack1.isEmpty && stack2.isEmpty
    }
    
    func resend() {
        while let i = stack1.popLast() {
            stack2.append(i)
        }
    }
}

class AnimalShelf {

    var cats: [[Int]] = []
    var dogs: [[Int]] = []

    init() {

    }
    
    func enqueue(_ animal: [Int]) {
        if animal[0] == 0 {
            cats.append(animal)
        } else {
            dogs.append(animal)
        }
    }
    
    func dequeueAny() -> [Int] {
        guard cats.count != 0 else {
            return dequeueDog()
        }
        guard dogs.count != 0 else {
            return dequeueCat()
        }
        return cats[0][0] < dogs[0][0] ? cats.removeFirst() : dogs.removeFirst()
    }
    
    func dequeueDog() -> [Int] {
        guard dogs.count != 0 else {
            return [-1,-1]
        }
        return dogs.removeFirst()
    }
    
    func dequeueCat() -> [Int] {
        guard cats.count != 0 else {
            return [-1, -1]
        }
        return cats.removeFirst()
    }
}

class MinStack {

    /** initialize your data structure here. */
    var decreaseStack = [Int]()
    var stack = [Int]()
    
    init() {

    }
    
    func push(_ x: Int) {
        stack.append(x)
        if decreaseStack.count == 0 || decreaseStack.last! >= x {
            decreaseStack.append(x)
        }
    }
    
    func pop() {
        guard let i = stack.popLast(), let j = decreaseStack.last else {
            return
        }
        if i == j {
            let _ = decreaseStack.popLast()
        }
    }
    
    func top() -> Int {
        return stack.last ?? 0
    }
    
    func getMin() -> Int {
        return decreaseStack.last ?? 0
    }
}

class TripleInOne {
    
    var queue: [Int]
    var indexs: [Int]
    var stackSize: Int
    
    let size = 3
    
    init(_ stackSize: Int) {
        queue = [Int].init(repeating: 0, count: size * stackSize)
        indexs = [Int].init(repeating: -1, count: size)
        self.stackSize = stackSize
        
    }
    
    func push(_ stackNum: Int, _ value: Int) {
        guard indexs[stackNum] + 1 < stackSize else {
            return
        }
        indexs[stackNum] += 1
        queue[stackNum * stackSize + indexs[stackNum]] = value
    }
    
    func pop(_ stackNum: Int) -> Int {
        guard stackNum < size else {
            return -1
        }
        guard indexs[stackNum] >= 0 else {
            return -1
        }
        let result = queue[stackNum * stackSize + indexs[stackNum]]
        indexs[stackNum] -= 1
        return result
    }
    
    func peek(_ stackNum: Int) -> Int {
        guard indexs[stackNum] >= 0 else { return -1 }
        return queue[stackNum * stackSize + indexs[stackNum]]
    }
    
    func isEmpty(_ stackNum: Int) -> Bool {
        return indexs[stackNum] == -1
    }
}

class TTTT {
    //超时了
    func reverseLeftWords(_ s: String, _ n: Int) -> String {
        func gcd(_ a: Int, _ b: Int) -> Int {
            var a = a
            var b = b
            while a % b != 0 {
                let t = a % b
                a = b
                b = t
            }
            return b
        }
        var ss = [Character](s)
        let pubicDiv = gcd(s.count, n)
        let div = s.count / pubicDiv
        var j = 0
        for i in 0..<pubicDiv {
            var index = i
            var val = ss[index]
            var nextIndex = s.count - n + i

            for _ in 0..<div {
                let nextVal = ss[nextIndex]
                ss[nextIndex] = val
                index = nextIndex
                val = nextVal
                nextIndex -= n
                if nextIndex < 0 {
                    nextIndex += s.count
                }
                j += 1
            }
        }

        return String(ss)
    }

    func reverseLeftWords11(_ s: String, _ n: Int) -> String {
        let ss = [Character](s)
        return String(ss[n..<s.count]) + String(ss[0..<n])
    }
    
    func singleNumber(_ nums: [Int]) -> Int {
        var counts = [Int].init(repeating: 0, count: 31)
        for num in nums {
            var n = num
            for j in 0..<31 {
                if n & 1 == 1 {
                    counts[j] += 1
                }
                n >>= 1
            }
        }
        var res = 0
        for i in stride(from: 30, through: 0, by: -1) {
            res <<= 1
            res |= counts[i] % 3
        }
        return res
    }
    

    func singleNumbers(_ nums: [Int]) -> [Int] {
        var ret = 0
        for i in nums {
            ret ^= i
        }
        var div = 1
        while ret & div == 0 {
            div <<= 1
        }
        var a = 0, b = 0
        for i in nums {
            if div & i != 0 {
                a ^= i
            } else {
                b ^= i
            }
        }
        return [a,b]
    }
    
    func minNumber(_ nums: [Int]) -> String {
        let sorted = nums.sorted { (i, j) -> Bool in
            var i = i , j = j
            var ii = [Int](), jj = [Int]()
            while i > 0 {
                ii.append(i % 10)
                i /= 10
            }
            while j > 0 {
                jj.append(j % 10)
                j /= 10
            }
            while ii.count > 0 || jj.count > 0{
                i = ii.popLast() ?? i
                j = jj.popLast() ?? j
                if i > j {
                    return false
                } else if i < j {
                    return true
                }
            }
            return true
        }
        var s = ""
        for i in sorted {
            if s.count != 0 || i != 0 {
                s.append("\(i)")
            }
        }
        return s
    }
    
    func pivotIndex(_ nums: [Int]) -> Int {
        let sum = nums.reduce(0, +)
        var lSum = 0, res = -1
        for i in 0..<nums.count {
            if sum - nums[i] == 2 * lSum {
                res = 0
                break
            } else {
                lSum += nums[i]
            }
        }
        return res
    }
    
    func permutation(_ s: String) -> [String] {
        
        var ss = [Character](s)
        var res = [String]()
        func dfs(_ x: Int) {
            guard x < s.count else {
                res.append(String(ss))
                return
            }
            var set = Set<Character>()
            for i in x..<s.count {
                if set.contains(ss[i]) { continue }
                set.insert(ss[i])
                ss.swapAt(i, x)
                dfs(x + 1)
                ss.swapAt(i, x)
            }
        }
        dfs(0)
        return res
    }
    
    func twoSum(_ n: Int) -> [Double] {
        var total = 6.0
        var res = [Double]()
        var dp = [[Int]].init(repeating: [], count: n + 1)
        for _ in 0...6 {
            dp[1].append(1)
        }
        for i in 2...n {
            dp[i] = [Int].init(repeating: 0, count: 6 * i + 1)
            for j in i...6 * i {
                for cur in 1...6 {
                    if j > cur && j - cur <= (6 * (i - 1)) {
                        dp[i][j] += dp[i - 1][j - cur]
                    }
                    
                }
            }
            total *= 6.0
        }
        for i in n...6 * n {
            res.append(Double(dp[n][i]) * 1.0 / total)
        }
         
        return res
    }
    /** b {
            c {
                c { f i }
                z { i }
            
        
     
     */
    func translateNum(_ num: Int) -> Int {
        var hit = [Int: Int]()
        func dfs(_ n: Int) -> Int {
            if let c = hit[n] {
                return c
            }
            guard n > 0 else {
                return 1
            }
            let i = n % 10
            let left = n / 10
            var count = dfs(left)
            hit[left] = count
            let j = left % 10
            if j > 0 && j * 10 + i < 26 {
                let res1 = dfs(left / 10)
                hit[left / 10] = res1
                count += res1
            }
            return count
        }
        return dfs(num)
    }
    
    func verifyPostorder(_ postorder: [Int]) -> Bool {
        guard postorder.count > 0 else {
            return true
        }
        var stack = [Int]()
        var root = Int.max
        for i in stride(from: postorder.count - 1, through: 0, by: -1) {
            if postorder[i] > root {
                return false
            }
            while let peek = stack.last, peek > postorder[i] {
                root = stack.popLast() ?? 0
            }
            stack.append(postorder[i])
        }
        return true
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 0 else {
            return 0
        }
        let unicode = s.unicodeScalars.map { Int($0.value) }
        var dict = [Int:Int]()
        var ans = 0
        var start = -1
        for i in 0..<s.count {
            start = max(dict[unicode[i], default: 0], start)
            dict[unicode[i]] = i
            ans = max(i - start, ans)
        }
        return ans
    }
    
    func findClosest(_ words: [String], _ word1: String, _ word2: String) -> Int {
        var index1 = -1, index2 = -1, ans = Int.max
        for (index,word) in words.enumerated() {
            if word == word1 {
                index1 = index
                ans = index2 != -1 ? min(ans, index1 - index2) : ans
            } else if word == word2 {
                index2 = index
                ans = index1 != -1 ? min(ans, index2 - index1) : ans
            }
        }
        return ans
    }
//    func minimumEffortPath(_ heights: [[Int]]) -> Int {
//        let H = heights.count, W = heights[0].count
//        var dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: W), count: H)
//
//        for y in 0..<H {
//            for x in 0..<W {
//                if y > 1
//                dp[y][x] = min(dp[y - 1], <#T##y: Comparable##Comparable#>)
//            }
//        }
//    }
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        var pre: ListNode? = nil
        var tail: ListNode? = nil
        var p = pre, t = tail
        var node = head
        while let n = node {
            let next = n.next
            if n.val < x {
                if pre == nil {
                    pre = n
                    p = pre
                } else {
                    pre?.next = n
                    pre = n
                }
                pre?.next = nil
            } else {
                if tail == nil {
                    tail = n
                    t = tail
                } else {
                    tail?.next = n
                    tail = n
                }
                tail?.next = nil
            }
            node = next
        }
        pre?.next = t
        if pre == nil {
            return t
        }
        return p
    }
    
    func numberOfSubarrays(_ nums: [Int], _ k: Int) -> Int {
        var leftCount = 0, rightCount = 0
        var total = 0
        var oddIndexs = [-1]
        for i in 0..<nums.count {
            if nums[i] & 1 == 1 {
                oddIndexs.append(i)
            }
        }
        oddIndexs.append(nums.count)
        var i = 1
        while i + k < oddIndexs.count {
            leftCount = oddIndexs[i] - oddIndexs[i - 1]
            rightCount = oddIndexs[i + k] - oddIndexs[i + k - 1]
            total += leftCount * rightCount
            i += 1
        }
        return total
    }
    
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        guard s.count > 0 else {
            return 0
        }
        let s = [Character](s)
        var left = 0, maxCount = 1
        var dict = [s[0]: 1]
        for i in 1..<s.count {
            dict[s[i], default: 0] += 1
            maxCount = max(dict[s[i], default: 0], maxCount)
            if i - left + 1 > maxCount + k {
                dict[s[left], default: 0] -= 1
                left += 1
            }
        }
        return s.count - left
    }
    
    func countParis(_ deliciousness: [Int]) -> Int {
        let mod = 1000000007
        var dict = [Int:Int]()
        var arr = [Int]()
        for i in 0...21 {
            arr.append(1 << i)
        }
        
        var count = 0
        for i in deliciousness {
            dict[i, default: 0] += 1
        }
        for (k,v) in dict {
            for j in arr {
                if k == j - k {
                    count += (v - 1) * v / 2
                } else {
                    count += dict[j - k,default:0] * v
                }
                dict[k] = nil
                count %= mod
            }
        }
        return count
        
    }
    
    func threeSumMulti(_ arr: [Int], _ target: Int) -> Int {
        var dict = [Int].init(repeating: 0, count: 101)
        let mod = 1_000_000_007
        for i in arr {
            dict[i] += 1
        }
        func twoSum(_ target: Int, _ x: Int, _ xCount: Int) -> Int {
            var dict = dict
            var count = 0
            for y in x...100 {
                let yCount = dict[y]
                let z = target - y
                if z < 0 || z > 100 {
                    continue
                }
                let zCount = dict[z]
                if zCount > 0 {
                    if x == y && y == z {
                        count += (zCount * (zCount - 1) * (zCount - 2)) / 6
                    } else if x == y {
                        count += (xCount - 1) * xCount / 2 * zCount
                    } else if y == z {
                        count += xCount * (zCount - 1) * zCount / 2
                    } else if x == z {
                        count += xCount * (xCount - 1) * yCount / 2
                    } else {
                        count += xCount * yCount * zCount
                    }
                }
                dict[y] = 0
                count %= mod
            }
            return count
        }
        var count = 0
        for x in 0...100 {
            count += twoSum(target - x, x, dict[x])
            count %= mod
            dict[x] = 0
        }
        return count
    }
    
    func pushDominoes(_ dominoes: String) -> String {
        var s = [Character](dominoes)
        var i = 0, left = 0, right = 0
        while i < s.count {
            if s[i] == "."{
                left = i
                right = i
                while left >= 0 && s[left] == "." { left -= 1 }
                while right < s.count && s[right] == "." { right += 1 }
                i = right + 1
                while left + 1 < right {
                    let c = right - left
                    if left >= 0 && s[left] == "R" {
                        s[left + 1] = "R"
                        left += 1
                    }
                    if right < s.count && s[right] == "L" {
                        s[right - 1] = s[right - 1] == "." ? "L" : "."
                        right -= 1
                    }
                    if c == right - left {
                        break
                    }
                }
                
            } else {
                i += 1
            }
            
        }
        return String(s)
    }
    
    func numSubarrayWithSum(_ A: [Int], _ S: Int) -> Int {
        let N = A.count
        var p = [-1]
        var t = 0, ans = 0
        for i in 0..<N {
            if A[i] == 1 {
                p.append(i)
                t += 1
            }
        }
        p.append(N)
        if S == 0 {
            for i in 0..<p.count - 1 {
                let w = p[i + 1] - p[i] - 1
                ans += w * (w + 1) / 2
            }
            return ans
        }
        var i = 1, j = S
        while j < p.count - 1 {
            ans += (p[i] - p[i - 1]) * (p[j + 1] - p[j])
            i += 1
            j += 1
        }
        return ans
    }
    
    func longestMountain(_ arr: [Int]) -> Int {
        guard arr.count >= 3 else {
            return 0
        }
        var ans = 0, i = 1
        while i < arr.count - 1 {
            if arr[i] > arr[i - 1] && arr[i] > arr[i + 1] {
                var leftCount = 1
                var rightCount = 1
                while i - leftCount > 0 && arr[i - leftCount] > arr[i - leftCount - 1] {
                    leftCount += 1
                }
                while i + rightCount < arr.count - 1
                && arr[i + rightCount] > arr[i + rightCount + 1] {
                    rightCount += 1
                }
                ans = max(ans, rightCount + leftCount + 1)
                i += rightCount + 1
            } else {
                i += 1
            }
        }
        
        return ans
    }
    
    func balancedString(_ s: String) -> Int {
        let s = [Character](s)
        var dict: [Character: Int] = [:]
        let m = s.count / 4
        for c in s {
            dict[c, default: 0] += 1
        }
        var ans = s.count
        var left = 0, right = 0
        while right < s.count {
            dict[s[right], default: 0] -= 1
            while left < s.count
                    && dict.reduce(true, { $0 && $1.1 <= m }) {
                ans = min(ans, right - left + 1)
                dict[s[left], default: 0] += 1
                left += 1
            }
            
            right += 1
        }
        return ans
    }
    
    func balancedStringForce(_ s: String) -> Int {
        let s = [Character](s)
        var dict: [Character: Int] = [:]
        let keys : [Character] = ["Q","W","E","R"]
        let m = s.count / 4
        for c in s {
            dict[c, default: 0] += 1
        }
        var ans = s.count
        if dict.reduce(true, { $0 && $1.value == m } ) {
            return 0
        }
        
        for right in 0..<s.count {
            var cur = dict
            for left in stride(from: right, through: 0, by: -1) {
                cur[s[left], default: 0] -= 1
                if cur.reduce(true, { $0 && $1.value <= m } ) {
                    ans = min(ans, right - left + 1)
                }
            }
            
        }
        return ans
    }
    
    
    func circularArrayLoop(_ nums: [Int]) -> Bool {
        var set = Set<Int>()
        var tempSet = Set<Int>()
        let N = nums.count
        func dfs(_ i: Int, _ pre: Int) -> Bool {
            if i == pre {
                return false
            }
            if pre != -1 && nums[i] * nums[pre] < 0 {
                return false
            }
            if tempSet.contains(i) {
                return true
            }
            set.insert(i)
            tempSet.insert(i)
            return dfs((i + nums[i] + N * 1000) % N, i)
        }
        for i in 0..<nums.count {
            if !set.contains(i) && dfs(i, -1) {
                return true
            }
            tempSet.removeAll()
        }
        return false
    }
    //4 2 1
    //5 3 3 1
    //3 4 2 3
    func checkPossibility(_ nums: [Int]) -> Bool {
        var decelerateCount = 0
        var cur = nums[0]
        for i in 0..<nums.count - 1 {
            if cur > nums[i + 1] {
                cur = i > 0 && nums[i + 1] < nums[i - 1] ? nums[i] : nums[i + 1]
                decelerateCount += 1
                if decelerateCount > 1 {
                    return false
                }
            } else {
                cur = nums[i + 1]
            }
        }
        return true
    }
    
    func checkPerctNumber(_ num: Int) -> Bool {
        func pn(_ p: Int) -> Int {
            return (1 << (p - 1)) * ((1 << p) - 1)
        }
        let primes = [2,3,5,7,13,17,19,31]
        for p in primes {
            if pn(p) == num {
                return true
            }
        }
        return false
    }
    
    func sortString(_ s: String) -> String {
        var result = ""
        var dict = [Character: Int]()
        for c in s {
            dict[c, default: 0] += 1
        }
        let sorted = dict.keys.sorted()
        var minIndex = 0, maxIndex = sorted.count - 1
        var curMin = minIndex, curMax = maxIndex
        while dict.count > 0 {
            while minIndex < sorted.count && dict[sorted[minIndex]] == 0 {
                dict[sorted[minIndex]] = nil
                minIndex += 1
            }
            while maxIndex >= 0 && dict[sorted[maxIndex]] == 0 {
                dict[sorted[maxIndex]] = nil
                maxIndex -= 1
            }
            curMin = minIndex
            
            while curMin <= maxIndex {
                let c = sorted[curMin]
                if dict[c, default: 0] > 0 {
                    dict[c ,default: 0] -= 1
                    result.append(c)

                }
                curMin += 1
            }
            curMax = maxIndex
            while curMax >= minIndex {
                let c = sorted[curMax]
                if dict[c, default: 0] > 0 {
                    dict[c, default: 0] -= 1
                    result.append(c)
                }

                curMax -= 1
            }
        }
        return result
    }

    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        var start = 0
        var students = students
        for i in sandwiches {
            let n = students.count
            while students[start] != i {
                if start == n {
                    return students.count - n
                }
                students.append(students[start])
                start += 1
            }
            start += 1
        }
        return 0
    }



    func breakfastNumber(_ staple: [Int], _ drinks: [Int], _ x: Int) -> Int {
        
        var dict1 = [Int: Int]()
        for i in staple {
            dict1[i, default: 0] += 1
        }
        let drinkSorted = drinks.sorted()
        
        func binarySearch(_ target: Int, _ arr: [Int]) -> Int {
            var left = 0, right = arr.count - 1
            while left < right {
                let mid = (left + right) / 2
                if arr[mid]  <= target {
                    left = mid + 1
                } else {
                    right = mid
                }
            }
            return left + (arr[left] <= target ? 1 : 0)
        }
        let mod = 1_000_000_007
        var total = 0
        for (key, value) in dict1 {
            if key < x {
                total += binarySearch(x - key,drinkSorted) * value
                total %= mod
            }
        }
        return total
    }
    func canThreePartsEqualSum(_ arr: [Int]) -> Bool {
        var nums = arr
        let N = arr.count
        for i in 1..<nums.count {
            nums[i] = nums[i] + nums[i - 1]
        }
        if nums[N - 1] % 3 != 0 {
            return false
        }
        let s = nums[N - 1] / 3
        var true1 = false
        var true2 = false
        for i in 0..<N-1 {
            if !true1 && nums[i] == s {
                true1 = true
            } else if true1 && !true2 && nums[i] == 2 * s {
                true2 = true
            }
        }
        return true1 && true2
        
    }
    func licenseKeyFormatting(_ S: String, _ K: Int) -> String {
        var pCount = 0
        for c in S {
            if c == "-" {
                pCount += 1
            }
        }
        let firstCount = (S.count - pCount) % K
        let unitCount = (S.count - pCount) / K
        var res = ""
        let s = [Character](S.replacingOccurrences(of: "-", with: ""))
        for i in 0..<firstCount {
            res.append(s[i])
        }
        if firstCount != 0 {
            res.append("-")
        }
        
        var i = firstCount
        for _ in 0..<unitCount {
            for _ in 0..<K {
                res.append(s[i].uppercased())
                i += 1
            }
            if i < s.count {
                res.append("-")
            }
        }
        return String(res)
    }

    func containsPattern(_ arr: [Int], _ m: Int, _ k: Int) -> Bool {
        var i = 0, patternCount = 0, pattern = [Int](), h = 0
        while i < arr.count && patternCount < k {
            h = i
            if pattern.count == 0  {
                if arr.count - h < m * k {
                    return false
                } else {
                    for j in 0..<m {
                        pattern.append(arr[h + j])
                    }
                    h += m
                    patternCount += 1
                }
            
            }
            if patternCount > 0 && patternCount < k {
                for j in 0..<m*k {
                    if arr[h + j] != pattern[j % m] {
                        pattern.removeAll()
                        patternCount = 0
                        break
                    }
                    if j % m == m - 1 {
                        patternCount += 1
                    }
                    if patternCount == k {
                        break
                    }
                }
            }
            i += 1
        }
        return patternCount == k
    }

    func isPalindrome(_ head: ListNode?) -> Bool {
        guard let head = head else {
            return true
        }
        var fast: ListNode? = head
        var slow: ListNode? = head
        while let fastNext = fast?.next?.next, let slowNext = slow?.next {
            fast = fastNext
            slow = slowNext
        }
        
        func reverse(_ head: ListNode?) -> ListNode? {
            var node: ListNode? = nil, next = node
            while let n = next, let nextNode = next?.next {
                n.next = node
                node = n
                next = nextNode
            }
            return node
        }
        var end = reverse(slow)
        var front: ListNode? = head
        var result = true
        while !result && end != nil {
            if let v1 = front?.val, let v2 = end?.val {
                result = false
            }
            end = end?.next
            front = front?.next
        }
        return result
    }
    
    func dayBetweenDates(_ date1: String, _ date2: String) -> Int {

        func leapyear(_ year: Int) -> Bool {
            return year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)
        }
        func dateToInt(_ date: String) -> Int {
            let ds = date.components(separatedBy: "-").map { Int($0)! }
            let monthDay = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            var year = ds[0], month = ds[1], day = ds[2]
            var ans = day - 1

            while month != 0 {
                month -= 1
                ans += monthDay[month]
                if month == 2 && leapyear(year) {
                    ans += 1
                }
            }
            ans += 365 * (year - 1971)

            ans += (year - 1) / 4 - 1971 / 4
            ans -= (year - 1) / 100 - 1971 / 100
            ans += (year - 1) / 400 - 1971 / 400
            return ans
        }
        return abs(dateToInt(date1) - dateToInt(date2))
    }
    
    func sechondHighest(_ s: String) -> Int {
        var max1 = Int.min, max2 = Int.min
        var numStr = ""
        for c in s {
            if c.isNumber {
                numStr.append(c)
            } else if numStr.count > 0 {
                let n = Int(numStr)!
                if n > max1 {
                    max2 = max1
                    max1 = n
                } else if n > max2 {
                    max2 = n
                }
                numStr = ""
            }
        }
        
        if numStr.count > 0 {
            let n = Int(numStr)!
            if n > max1 {
                max2 = max1
                max1 = n
            } else if n > max2 {
                max2 = n
            }
            numStr = ""
        }
        return max2
    }
    
    func convertToBase7(_ num: Int) -> String {
        guard num != 0 else {
            return "0"
        }
        var left = num, res = ""
        while left > 0 {
            res.append("\(left % 7)")
            left /= 7
        }
        return String(res.reversed())
    }
    //out of time
    func orchestraLayout(_ num: Int, _ xPos: Int, _ yPos: Int) -> Int {
        var up = 0, down = num - 1, left = 0, right = num - 1
        let speeds = [(1,0),(0,1),(-1,0),(0,-1)]
        var si = 0
        var x = 0, y = 0, i = 1
        while x != yPos || y != xPos {
            if x + speeds[si].0 <= right &&
            y + speeds[si].1 <= down &&
            x + speeds[si].0 >= left &&
            y + speeds[si].1 >= up {
                x = x + speeds[si].0
                y = y + speeds[si].1
                i += 1
                if i > 9 {
                    i = 1
                }
            } else {
                if si == 0 {
                    up += 1
                } else if si == 1 {
                    right -= 1
                } else if si == 2 {
                    down -= 1
                } else {
                    left += 1
                }
                si += 1
                if si > 3 {
                    si = 0
                }
            }
        }
        return i
    }
    //
    func arrayRankTransform(_ arr: [Int]) -> [Int] {
        var dict = [Int: Int]()
        
        let N = arr.count
        
        let sortedArr = [Int](Set<Int>(arr)).sorted()
        
        
        var res = [Int]()
        for i in 1...sortedArr.count {
            dict[sortedArr[i - 1]] = i
        }
        for i in 0..<N {
            if let index = dict[arr[i]] {
                res.append(index)
            }
        }
        return res
    }
    
//    func rotateString(_ A: String, _ B: String) -> Bool {
//        guard A.count == B.count else {
//            return false
//        }
//        guard A.count > 0 else {
//            return true
//        }
//        let N = A.count
//        let A = [Character](A), B = [Character](B)
//        var shifts = [Int](repeating: 1, count: N + 1)
//        var left = -1
//        for right in 0..<N {
//            while left >= 0 && B[left] != B[right] {
//                left -= shifts[left]
//            }
//            shifts[right + 1] = right - left
//            left += 1
//        }
//    }
    func prefixesDivBy5(_ A: [Int]) -> [Bool] {
        var val = 0
        var res = [Bool]()
        for i in 0..<A.count {
            val = val * 2 + A[i]
            res.append(val % 5 == 0)
        }
        
        return res
    }
    
    func numDifferentIntegers(_ word: String) -> Int {
        let set = Set<Character>("abcdefghijklmnopqrstuvwxyz")
        var n = "", numSet = Set<String>()
        for c in word {
            if set.contains(c) {
                if n.count > 0 {
                    numSet.insert(n)
                    n = ""
                }
            } else {
                if n == "0" {
                    n = ""
                }
                n.append(c)
            }
        }

        return numSet.count
    }
    
    func sumBase(_ n: Int, _ k: Int) -> Int {
        var i = n, res = 0
        while i > 0 {
            res += i % k
            i /= k
        }
        return res
    }
    
    func numSpecialEquivGroups(_ A: [String]) -> Int {
        var set = Set<[Set<Character>]>()
        for s in A {
            
            var odd = Set<Character>(), even = Set<Character>()
            for (index,c) in s.enumerated() {
                if index & 1 == 0 {
                    odd.insert(c)
                } else {
                    even.insert(c)
                }
            }
            set.insert([odd,even])
        }
        return set.count
    }
    
    func longestStrChain(_ words: [String]) -> Int {
        let words = words.sorted { $0.count < $1.count }
        let ws = words.map { [Character]($0) }
        let N = words.count
        var set = Set<String>()
        func increaseWord(_ s1: [Character], _ s2: [Character]) -> Bool {
            guard s1.count + 1 == s2.count else {
                return false
            }
            var s1Index = 0, s2Index = 0
            while s1Index < s1.count && s2Index < s2.count {
                if s1[s1Index] == s2[s2Index] {
                    s1Index += 1
                    s2Index += 1
                } else {
                    s2Index += 1
                }
                if s1Index + 1 < s2Index {
                    return false
                }
            }
            return true
        }
        var res = 1
        func dfs(_ count: Int, _ pre: Int,_ next: Int) {
            res = max(count,res)

            if pre >= N || next >= N {
                return
            }
            
            if !set.contains(words[next]) && increaseWord(ws[pre], ws[next]) {
                set.insert(words[next])
                dfs(count + 1, next,next + 1)
            }
            dfs(count, pre, next + 1)
            
        }
        
        for i in 0..<N-1 {
            set.insert(words[i])
            dfs(1, i, i + 1)
        }
        return res
    }

}
