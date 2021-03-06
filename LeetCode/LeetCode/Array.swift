//
//  Array.swift
//  LeetCode
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation
import DataStructure


class ArraySolution {
    //给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。
    func rotate(_ nums: inout [Int], _ k: Int) {
        var cache = [Int]()
        let k = k % nums.count
        for index in 0..<nums.count {
            let toIndex = (index + k) % nums.count
            if cache.count == k {
                cache.append(nums[toIndex])
                nums[toIndex] = cache.first!
                cache.removeFirst()
            } else {
                cache.append(nums[toIndex])
                nums[toIndex] = nums[index]
            }
        }
    }
    
    func rotate1(_ nums: inout [Int], _ k: Int) {
        var cur = nums[0], count = 0, start = 0
        var index = 0
        while count < nums.count {
            index = (index + k) % nums.count
            let t = nums[index]
            nums[index] = cur
            if index == start {
                start = start + 1
                index = index + 1
                cur = nums[index]
            } else {
                cur = t
            }
            count = count + 1
            print(nums)
        }
    }
    
    func rotate2(_ nums: inout [Int], _ k: Int) {
        let k = k % nums.count
        func reverse(_ from: Int, _ to: Int) {
            for i in 0..<(to - from + 1)/2 {
                nums.swapAt(from + i, to - i)
            }
        }
        reverse(0 , nums.count - k - 1)
        reverse(nums.count - k, nums.count - 1)
        reverse(0, nums.count - 1)
    }

    
    func plusOne(_ digits: [Int]) -> [Int] {
        var digits = digits
        var cc = digits.count - 1
        while cc >= 0 {
            if digits[cc] + 1 > 9 {
                digits[cc] = 0
                cc = cc - 1
            } else {
                digits[cc] = digits[cc] + 1
                break
            }
        }
        
        if cc >= 0{
            return digits
        } else {
            digits.insert(1, at: 0)
            return digits
        }
    }
    
    
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        let a = Array<Character>.init(S)
        let b = Array<Character>.init(T)
        var sn = a.count - 1, bn = b.count - 1
        var skip = 0
        while sn >= 0 || bn >= 0 {
            while sn >= 0 {
                if (a[sn] == "#") {
                    sn = sn - 1
                    skip = skip + 1
                } else if (skip > 0) {
                    sn = sn - 1
                    skip = skip - 1
                } else {
                    break
                }
            }
            skip = 0
            while bn >= 0 {
                if (b[bn] == "#") {
                    bn = bn - 1
                    skip = skip + 1
                } else if (skip > 0) {
                    bn = bn - 1
                    skip = skip - 1
                } else {
                    break
                }
            }
            if (sn >= 0 && bn >= 0 && a[sn] != b[bn]) {
                return false
            }
            if ((sn >= 0) != (bn >= 0)) {
                return false
            }
            sn = sn - 1
            bn = bn - 1
        }
        return sn == bn
    }
    
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        let name = Array<Character>.init(name)
        let typed = Array<Character>.init(typed)
        var i = name.count - 1, ti = typed.count - 1
        var lastCount = 0,usedCount = 0
        var last = typed[ti]
        while i >= 0 {
            if lastCount > 0 && usedCount < lastCount {
                if last == name[i] {
                    usedCount = usedCount + 1
                    i = i - 1
                } else if lastCount > 0 && usedCount == 0  {
                    return false
                } else {
                   usedCount = 0
                    lastCount = 0
                }
            } else if ti >= 0 {
                last = typed[ti]
                while ti >= 0 && last == typed[ti] {
                    lastCount = lastCount + 1
                    ti = ti - 1
                }
            } else {
                break
            }
        }
        return i == ti
    }
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let hay = Array(haystack)
        let dle = Array(needle)

        
        var i = 0, ti = 0
        while i < hay.count && ti < dle.count {
            if hay[i] == dle[ti] {
                i = i + 1
                ti = ti + 1
            } else {
                if ti == 0 {
                    i = i + 1
                } else {
                    i = i - ti + 1
                }
                ti = 0
            }
        }
        return ti == dle.count ? i - dle.count : -1
    }
    
    /*
     13     while (i < t.length && j < p.length) {
     15        if (j == -1 || t[i] == p[j]) { // 当j为-1时，要移动的是i，当然j也要归0
     17            i++;
     19            j++;
     21        } else {
     23            // i不需要回溯了
     25            // i = i - j + 1;
     27            j = next[j]; // j回到指定位置
     29        }
     31     }
     33     if (j == p.length) {
     35        return i - j;
     37     } else {
        return -1;
     41     }
     42
     */
    
    func getNext(p: inout [Character]) -> [Int] {
         var next = Array<Int>.init(repeating: 0, count: p.count)
         next[0] = -1;
         var j = 0;
         var k = -1;
         while (j < p.count - 1) {
            if (k == -1 || p[j] == p[k]) {
                j = j + 1
                k = k + 1
                if p[j] == p[k] {
                    next[j] = next[k]
                } else {
                    next[j] = k
                }
            } else {
                k = next[k];
            }
         }
         return next;
     }
    
    func kmpStr(_ s: String, _ needle: String) -> Int {
        var hay = Array(s)
        let dle = Array(needle)
        var next = getNext(p: &hay)
        next[0] = -1
        var j = 0, i = 0
        while i < s.count && j < dle.count {
            if j == -1 || hay[i] == dle[j] {
                j = j + 1
                i = i + 1
//                next[j] = k
            } else {
                j = next[j]
//                k = next[k]
            }
        }
        if j == dle.count {
            return i - j
        } else {
            return -1
        }
    }
    
    func partitionLabels(_ S: String) -> [Int] {
        let string = Array(S)//ababcbacadefegdehijhklij
        var dict = [Character:(Int,Int)]()
        var result = [Int]()
        var start = 0
        for (index,c) in string.enumerated() {
            if let i = dict[c] {
                dict[c] = (i.0, index)
            } else {
                dict[c] = (index,index)
            }
        }
        while start < string.count {
            var location = dict[string[start]]!
            var i = location.0
            while i < location.1 {
                let inLocation = dict[string[i]]!
                if inLocation.1 > location.1 {
                    location = (location.0,inLocation.1)
                }
                i = i + 1
            }
            result.append(location.1 - location.0 + 1)
            start = location.1 + 1
        }
        return result
    }
    
    public class Interval: CustomStringConvertible {
        public var start: Int
        public var end: Int
        public init(_ start: Int, _ end: Int) {
            self.start = start
            self.end = end
        }
        
        public var description: String {
            return "[\(start),\(end)]"
        }
    }
    
    func intervalIntersection(_ A: [Interval], _ B: [Interval]) -> [Interval] {
        var ai = 0
        var bi = 0
        var result = [Interval]()
        while ai < A.count && bi < B.count {
            if A[ai].start > B[bi].end {
                bi = bi + 1
            } else if A[ai].end < B[bi].start {
                ai = ai + 1
            } else {
                result.append(Interval(max(A[ai].start, B[bi].start),min(A[ai].end, B[bi].end)))
                if A[ai].end > B[bi].end {
                    bi = bi + 1
                } else if A[ai].end == B[bi].end {
                    ai = ai + 1
                    bi = bi + 1
                } else {
                    ai = ai + 1
                }
            }
        }
        return result
    }
    
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard intervals.count > 0 else {
            return intervals
        }
        var result = [[Int]]()

        let intervals = intervals.sorted { (f, s) -> Bool in
            return f[0] < s[0]
        }
        var currenArray = intervals[0]

        for elements in intervals {
            if (elements[0] >= currenArray[0] && elements[0] <= currenArray[1]) ||
                (elements[1] >= currenArray[0] && elements[1] <= currenArray[1]) {
                currenArray[0] = min(elements[0], currenArray[0])
                currenArray[1] = max(elements[1], currenArray[1])
            } else {
                result.append(currenArray)
                currenArray = elements
            }
        }
        result.append(currenArray)
        return result
    }
//    var citations = [0,1,3,5,6]
    func hIndex(_ citations: [Int]) -> Int {
        let citations = citations.sorted()
        var h = 0
        for (index,i) in citations.enumerated() {
            if h <= citations.count - index {
                h =  max(h,min(i,citations.count - index))
            }
        }
        return h
    }
    
    func largestNumber(_ nums: [Int]) -> String {
        guard nums.count > 0 else {
            return "0"
        }
        var total = nums
        total.sort { (f, s) -> Bool in
            return ss(f, s)
        }
        var result = ""
        if total[0] == 0 {
            return "0"
        }
        for i in total {
            result.append("\(i)")
        }
        return result
    }
    
    func ss(_ num1: Int,_ num2: Int) -> Bool {
        let s1 = "\(num1)\(num2)"
        let s2 = "\(num2)\(num1)"
        return s1 > s2
    }
    /*给定一个无序的数组 nums，将它重新排列成 nums[0] < nums[1] > nums[2] < nums[3]... 的顺序。
     
     示例 1:1,1,1,4,5,6
     1,4,1,1,5,6
     1,4,1,5,1,6
     输入: nums = [1, 5, 1, 1, 6, 4]
     输出: 一个可能的答案是 [1, 4, 1, 5, 1, 6]
     示例 2:
     1,1,1,1,1.3,2,2,3,4
     1,2,1,1,2,3,4,
     
     
    1,1,2,2,3,3,4,4
     1,3,2,2,1,3,4,4
     1,3,1,2,2,3,4,4
     
     1,2,1,2,3,3
     1,2,1,3,2,3
     输入: nums = [1, 3, 2, 2, 3, 1]
     输出: 一个可能的答案是 [2, 3, 1, 3, 1, 2]*/
    
    func wiggleSort(_ nums: inout [Int]) {
        guard nums.count >= 2 else {
            return
        }
        
        for i in stride(from: 1, to: nums.count, by: 2) {
            let idx = getLargest(nums, i - 1, i , i + 1)
            (nums[i], nums[idx]) = (nums[idx], nums[i])
        }
    }
    
    private func getLargest(_ nums: [Int], _ x: Int, _ y: Int, _ z: Int) -> Int {
        let len = nums.count
        
        let xVal = x >= 0 && x < len ? nums[x] : Int.min
        let yVal = y >= 0 && y < len ? nums[y] : Int.min
        let zVal = z >= 0 && z < len ? nums[z] : Int.min
        let maxVal = max(xVal, yVal, zVal)
        
        if maxVal == xVal {
            return x
        } else if maxVal == yVal {
            return y
        } else {
            return z
        }
    }
    
    
    /*
     给定一个整数数组，判断数组中是否有两个不同的索引 i 和 j，使得 nums [i] 和 nums [j] 的差的绝对值最大为 t，并且 i 和 j 之间的差的绝对值最大为 ķ。
     
     示例 1:
     
     输入: nums = [1,2,3,1], k = 3, t = 0
     输出: true
     示例 2:
     
     输入: nums = [1,0,1,1], k = 1, t = 2
     输出: true
     示例 3:
     
     输入: nums = [1,5,9,1,5,9], k = 2, t = 3
     输出: false
     */
    
//    class SSS {
//        var val: Int
//        var indexs = [Int]()
//        init(_ val: Int) {
//            self.val = val
//        }
//    }
//
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        var dict = [Int: Int]()
        for i in 1...k {
            dict[nums[i]] = (dict[nums[i]] ?? 0) + 1
        }
        
        for j in 0..<nums.count - 1 {
            for x in stride(from: 0-t, through: t, by: 1) {
                if let count = dict[nums[j] + x] ,count > 0{
                    return true
                }
            }
            dict[nums[j + 1]] = dict[nums[j + 1]]! - 1
            if j + k + 1 < nums.count {
                dict[nums[j + k + 1]] = (dict[nums[j + k + 1]] ?? 0) + 1
            }
            
        }
        return false
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let sortedNums = nums.sorted()
        var x = 0, result = [[Int]]()
        while x < nums.count - 2 {
            var y = x + 1
            var z = nums.count - 1
            while y < z {
                let sum = sortedNums[x] + sortedNums[y] + sortedNums[z]
                if sum == 0 {
                    while y < z && nums[y] == nums[y + 1] {
                        y += 1;
                    }
                    while y < z && nums[z] == nums[z - 1] {
                        z -= 1;
                    }
                    
                    result.append([sortedNums[x],sortedNums[y],sortedNums[z]])
                    z = z - 1
                    y = y + 1
                } else if sum > 0{
                    z = z - 1
                } else {
                    y = y + 1
                }
            }
            x = x + 1
        }
        return result
    }
    
    func trap(_ height: [Int]) -> Int {
        var lefts = [Int].init(repeating: 0, count: height.count)
        var leftMax = 0
        for (index,i) in height.reversed().enumerated() {
            lefts[height.count - index - 1] = leftMax
            leftMax = max(i, leftMax)
        }
        var sum = 0
        var right = 0
        for (index,i) in height.enumerated() {
            let cur = min(right, lefts[index]) - i
            sum = (cur > 0 ? cur : 0) + sum
            right = max(right, i)
        }
        return sum
    }
//    "123" 1
//    "132" 2
//    "213" 3
//    "231" 4
//    "312" 5
//    "321" 6
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var result = ""
        var sss = 1
        var array = [Int]()
        for i in 1...n {
            sss *= i
            array.append(i)
        }
        var i = n, j = k
        while j >= 0 && i > 0 {
            sss = sss / i
            let z = max((j - 1) / sss,0)
            result.append("\(array[z])")
            j = j - z * sss
            array.remove(at: z)
            i = i - 1
        }

        return result
    }
    
    
    /*
    
     朋友圈
     班上有 N 名学生。其中有些人是朋友，有些则不是。他们的友谊具有是传递性。如果已知 A 是 B 的朋友，B 是 C 的朋友，那么我们可以认为 A 也是 C 的朋友。所谓的朋友圈，是指所有朋友的集合。
     
     给定一个 N * N 的矩阵 M，表示班级中学生之间的朋友关系。如果M[i][j] = 1，表示已知第 i 个和 j 个学生互为朋友关系，否则为不知道。你必须输出所有学生中的已知的朋友圈总数。
     这道题让我们求朋友圈的个数，题目中对于朋友圈的定义是可以传递的，比如A和B是好友，B和C是好友，那么即使A和C不是好友，那么他们三人也属于一个朋友圈。那么比较直接的解法就是DFS搜索，对于某个人，遍历其好友，然后再遍历其好友的好友，那么我们就能把属于同一个朋友圈的人都遍历一遍，我们同时标记出已经遍历过的人，然后累积朋友圈的个数，再去对于没有遍历到的人在找其朋友圈的人，这样就能求出个数。其实这道题的本质是之前那道题Number of Connected Components in an Undirected Graph，其实许多题目的本质都是一样的，就是看我们有没有一双慧眼能把它们识别出来：
     */
    func findCircleNum(_ M: [[Int]]) -> Int {
        var count = 0
        var visits = [Bool].init(repeating: false, count: M.count)
        for i in 0..<M.count {
            if visits[i] {
                continue
            }
            helper(M, &visits, i)
            count += 1
        }
        return count
    }
    
    func helper(_ M:[[Int]], _ visits: inout [Bool], _ k: Int) {
        visits[k] = true
        for i in 0..<M.count {
            print("\(k) \(i) : \(M[k][i]) \(visits[k])")
            if M[k][i] == 1 && !visits[i] {
                helper(M, &visits, i)
            }
        }
    }
    
    
    func longestConsecutive(_ nums: [Int]) -> Int {
        let set = Set(nums)
        var setttt = Set<Int>()
        var longest = 0
        for i in set {
            if !setttt.contains(i) {
                setttt.insert(i)
                var j = i + 1
                var long = 1
                while set.contains(j) {
                    setttt.insert(j)
                    long = long + 1
                    j = j + 1
                }
                var k = i - 1
                while set.contains(k) {
                    setttt.insert(k)
                    long = long + 1
                    k = k - 1
                }
                longest = max(long, longest)
            }
            if longest > set.count / 2 {
                break
            }
        }
        return longest;
    }
    
    func findLengthOfLCIS(_ nums: [Int]) -> Int {
        var cur = Int.min, length = 0, maxLength = 0
        for i in nums {
            if i > cur {
                cur = i
                length = length + 1
            } else {
                cur = i
                maxLength = max(length, maxLength)
                length = 1
            }
        }
        maxLength = max(length, maxLength)
        return maxLength
    }
    
    /*给定一些标记了宽度和高度的信封，宽度和高度以整数对形式 (w, h) 出现。当另一个信封的宽度和高度都比这个信封大的时候，这个信封就可以放进另一个信封里，如同俄罗斯套娃一样。
     
     请计算最多能有多少个信封能组成一组“俄罗斯套娃”信封（即可以把一个信封放到另一个信封里面）。
     
     说明:
     不允许旋转信封。
     
     示例:
     
     输入: envelopes = [[5,4],[6,4],[6,7],[2,3]]
     输出: 3
     解释: 最多信封的个数为 3, 组合为: [2,3] => [5,4] => [6,7]。*/
//    func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
//        let sorted = envelopes.sorted { (f, s) -> Bool in
//            if f[0] == s[0] {
//                return f[1] < s[1]
//            } else {
//                return f[0] < s[0]
//            }
//        }
//    }
    //1,2,5,[1,2]
    //2,3,4,[0,0]
    func numMovesStones(_ a: Int, _ b: Int, _ c: Int) -> [Int] {
        let array = [a,b,c].sorted()
        let high = array[2] - array[1], low = array[1] - array[0]
        var min = 0
        if high > 1 && low > 1 {
            if high > 2 && low > 2 {
                min = 2
            } else {
                min = 1
            }
        } else if high == 1 && low == 1 {
            min = 1
        } else {
            min = 1
        }
        let max = array[2] - array[0] - 2
        return [min,max]
    }
    
    func majorityElement(_ nums: [Int]) -> Int {
        var major = nums[0],count = 0
        for i in nums {
            if major == i {
                count += 1
            } else {
                count -= 1
            }
            if count == 0 {
                count = 1
                major = i
            }
        }
        return major
    }
    
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count != 0 && matrix[0].count != 0 else {
            return false
        }
        func search(point: (Int,Int)) -> (Int,Int)? {
            if matrix[point.0][point.1] == target {
                return point
            } else if matrix[point.0][point.1] > target {
                return nil
            } else if point.0 + 1 < matrix.count && point.1 + 1 < matrix[0].count {
                if matrix[point.0 + 1][point.1] <= target || matrix[point.0][point.1 + 1] <= target {
                    if let p = search(point: (point.0 ,point.1 + 1)) {
                        return p
                    } else {
                        return search(point: (point.0 + 1, point.1))
                    }
                } else {
                    return nil
                }
            } else if point.0 + 1 < matrix.count {
                return search(point: (point.0 + 1, point.1))
            } else if point.1 + 1 < matrix[0].count {
                return search(point: (point.0 , point.1 + 1))
            } else {
                return nil
            }
        }
        
        if let _ = search(point: (0,0)) {
            return true
        } else {
            return false
        }
    }
    
    func searchMatrixB(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.count == 0 || matrix[0].count == 0 {
            return false
        }
        for i in matrix {
            if i.first! <= target && i.last! >= target {
                if searchCol(i, target) {
                    return true
                }
            } else if i.first! > target {
                break
            }
        }
        return false
        
    }
    
    private func searchRow(_ matrix: [[Int]], _ target: Int) -> Int {
        var left = 0, right = matrix.count - 1
        
        while left + 1 < right {
            let mid = (right - left) / 2 + left
            if matrix[mid][0] == target {
                return mid
            } else if matrix[mid][0] < target {
                left = mid
            } else {
                right = mid
            }
        }
        
        return matrix[right][0] <= target ? right : left
    }
    
    private func searchCol(_ nums: [Int], _ target: Int) -> Bool {
        var left = 0, right = nums.count - 1
        
        while left <= right {
            let mid = (right - left) / 2 + left
            if nums[mid] == target {
                return true
            } else if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        
        return false
    }
    
    func searchMatrixZZ(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0 else {
            return false
        }
        
        var row = 0, col = matrix[0].count - 1
        
        while row < matrix.count && col >= 0 {
            if matrix[row][col] == target {
                return true
            } else if matrix[row][col] < target {
                row += 1
            } else {
                col -= 1
            }
        }
        
        return false
    }
    
    /*
     给定一个包含了一些 0 和 1的非空二维数组 grid , 一个 岛屿 是由四个方向 (水平或垂直) 的 1 (代表土地) 构成的组合。你可以假设二维矩阵的四个边缘都被水包围着。
     
     找到给定的二维数组中最大的岛屿面积。(如果没有岛屿，则返回面积为0。)
     
     示例 1:
     
     [[0,0,1,0,0,0,0,1,0,0,0,0,0],
     [0,0,0,0,0,0,0,1,1,1,0,0,0],
     [0,1,1,0,1,0,0,0,0,0,0,0,0],
     [0,1,0,0,1,1,0,0,1,0,1,0,0],
     [0,1,0,0,1,1,0,0,1,1,1,0,0],
     [0,0,0,0,0,0,0,0,0,0,1,0,0],
     [0,0,0,0,0,0,0,1,1,1,0,0,0],
     [0,0,0,0,0,0,0,1,1,0,0,0,0]]
     对于上面这个给定矩阵应返回 6。注意答案不应该是11，因为岛屿只能包含水平或垂直的四个方向的‘1’。
     
     示例 2:
     
     [[0,0,0,0,0,0,0,0]]
     对于上面这个给定的矩阵, 返回 0。
     
     注意: 给定的矩阵grid 的长度和宽度都不超过 50。
     1 1 0
     1 1 1
     0 1 1
     */
    //利用深度遍历查找一个岛的面积
    func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
        let row = [Bool].init(repeating: false, count: grid[0].count)
        let rowCount = grid[0].count
        let columnCount = grid.count
        var visits = [[Bool]].init(repeating: row, count: grid.count)

        
        func areavisit(_ i: Int, _ j: Int, count: Int) -> Int {
            
            print("[i,j]:[\(i),\(j)], value:\(grid[i][j]) count:\(count)")
            if grid[i][j] == 0 || visits[i][j] {
                visits[i][j] = true
                return count
            }
            visits[i][j] = true
            var myCount = count + 1
            if i < columnCount - 1 && !visits[i + 1][j]  {
                myCount = areavisit(i + 1, j, count: 0) + myCount
                print("count \(myCount)")
            }
            if j > 0 && !visits[i][j - 1] {
                myCount = areavisit(i, j - 1, count: 0) + myCount
                print("count \(myCount)")

            }
            if j < rowCount - 1 && !visits[i][j + 1] {
                myCount = areavisit(i, j + 1, count: 0) + myCount
                print("count \(myCount)")

            }
            if i > 0 && !visits[i - 1][j] {
                myCount = areavisit(i - 1, j, count: 0) + myCount
                print("count \(myCount)")

            }
            return myCount
        }
        var maxArea = 0
        for i in 0..<columnCount {
            for j in 0..<rowCount {
                if !visits[i][j] {
                    maxArea = max(areavisit(i, j, count: 0),maxArea)
                }
            }
        }
        return maxArea
        
    }
    //MARK:深度优先算法maxarea
    func maxAreaOfIslandDFS(_ grid: [[Int]]) -> Int {
        if grid.isEmpty {
            return 0
        }

        
        let row = [Bool].init(repeating: false, count: grid[0].count)
        let rowCount = grid[0].count
        let columnCount = grid.count
        var visits = [[Bool]].init(repeating: row, count: grid.count)
        func dfs(_ x: Int, _ y: Int) -> Int {
            if x >= columnCount || y >= rowCount || x < 0 || y < 0 {
                return 0
            }
            if visits[x][y] {
                return 0
            }
            if grid[x][y] == 0 { return 0 }
            visits[x][y] = true
            return 1 + dfs(x + 1, y) + dfs(x - 1, y) + dfs(x, y + 1) + dfs(x, y - 1)
        }
        var count = 0
        for i in 0..<columnCount {
            for j in 0..<rowCount {
                if visits[i][j] == true {
                    continue
                }
                count = max(count, dfs(i, j))
            }
        }
        return count
    }
    
    func maxAreaOfIslandBFS(_ grid: [[Int]]) -> Int {
        if grid.isEmpty {
            return 0
        }
        let row = [Bool].init(repeating: false, count: grid[0].count)
        let mostLeft = grid[0].count
        let mostDeep = grid.count
        var visits = [[Bool]].init(repeating: row, count: grid.count)
        var count = 0
        for i in 0..<mostDeep {
            for j in 0..<mostLeft {
                if visits[i][j] {
                    continue
                }
                if grid[i][j] == 0 {
                    continue
                }
                var itempArea = 0
                var stackTemp = [(Int,Int)]()
                stackTemp.append((i,j))
                visits[i][j] = true
                while !stackTemp.isEmpty {
                    itempArea += 1
                    let curPoint = stackTemp.removeLast()
                    let x = curPoint.0
                    let y = curPoint.1
                    if x - 1 > 0 && grid[x - 1][y] == 1 && visits[x - 1][y] == false {
                        stackTemp.append((x - 1, y))
                        visits[x - 1][y] = true
                    }
                    if x + 1 < mostDeep && grid[x + 1][y] == 1 && visits[x - 1][y] == false {
                        stackTemp.append((x + 1, y))
                        visits[x + 1][y] = true
                    }
                    if y - 1 > 0 && grid[x][y - 1] == 1 && visits[x][y - 1] == false {
                        stackTemp.append((x, y - 1))
                        visits[x][y - 1] = true
                    }
                    if y + 1 < mostLeft && grid[x][y + 1] == 1 && visits[x][y + 1] == false {
                        stackTemp.append((x, y + 1))
                        visits[x][y + 1] = true
                    }
                }
                count = max(count, itempArea)
            }
        }
        return count
    }
    
//    func superEggDrop(_ K: Int, _ N: Int) -> Int {
//
//    }
//    func partition(_ s: String) -> [[String]] {
//        var array = []
//        for i in s {
//            
//        }
//    }
    func hasGroupsSizeX(_ deck: [Int]) -> Bool {
        guard deck.count > 1 else {
            return false
        }
        var dict = [Int:Int]()
        for i in deck {
            dict[i, default: 0] += 1
        }
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
        let arr = [Int].init(dict.values)
        var greatest = arr[0]
        for i in arr[1..<arr.count]{
            greatest = gcd(greatest,i)
        }
        return greatest > 1
    }
    
    func trap1(_ heights: [Int]) -> Int {
        var leftMax = 0,rightMax = 0
        var i = 0, j = heights.count - 1
        var res = 0
        while i <= j {
            if leftMax > rightMax {
                res += min(0,rightMax - heights[i])
                leftMax = max(leftMax, heights[i])
                i += 1
            } else {
                res += min(0,leftMax - heights[i])
                rightMax = max(rightMax, heights[i])
                j -= 1
            }
        }
        return res
    }
    
    
    func firstUniqChar(_ s: String) -> Int {
        var index = [Int].init(repeating: -2, count: 26)
        let ss = [Character](s)
        let aAsicii = Character("a").asciiValue!
        for i in 0..<s.count {
            if index[Int(ss[i].asciiValue! - aAsicii)] == -2 {
                index[Int(ss[i].asciiValue! - aAsicii)] = i
            } else {
                index[Int(ss[i].asciiValue! - aAsicii)] = -1
            }
        }
        var res = s.count
        for i in index {
            if i >= 0 {
                res = min(i, res)
            }
        }
        return res == s.count ? -1 : res
    }

    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        let aAsicii = Character("a").asciiValue!
        var arr1 = [Int].init(repeating: 0, count: 26), arr2 = [Int].init(repeating: 0, count: 26)
        let s = [Character](s), t = [Character](s)
        for c in s {
            arr1[Int(c.asciiValue! - aAsicii)] += 1
        }
        
        for c in t {
            arr2[Int(c.asciiValue! - aAsicii)] += 1
        }
        return arr1 == arr2
    }
    
    func basicCalculatorIV(_ expression: String, _ evalvars: [String], _ evalints: [Int]) -> [String] {
        var dict = [Character: Int]()
        for i in 0..<evalints.count {
            dict[Character(evalvars[i])] = evalints[i]
        }
        var stack = [String]()
        enum ComputeSign: String {
            typealias RawValue = String
            
            case left = "("
            case right = ")"
            case mul = "*"
            case plus = "+"
            case minus = "-"
        
        }
        var s = ""
        for c in expression {
            if c == Character(ComputeSign.left.rawValue) {
                stack.append(s)
                
            }
        }
        return []
    }
    
//    func find132pattern(_ nums: [Int]) -> Bool {
//        guard nums.count >= 3 else {
//            return false
//        }
//        var stack = [Int]()
//        var minum = [Int].init(repeating: 0, count: nums.count)
//        minum[0] = nums[0]
//        for i in 1..<nums.count {
//            minum[i] = min(minum[i - 1],nums[i])
//        }
//        for j in stride(from: nums.count - 1, through: 0, by: -1) {
//            if nums[j] > minum[j] {
//                while !stack.isEmpty  && stack.last! <= minum[j] {
//                    stack.removeLast()
//                }
//            }
//        }
//    }
    
//    func minWindow(_ s: String, _ t: String) -> String {
//        var targetDict = [Character: Int]()
//        for c in t {
//            targetDict[c,default: 0] += 1
//        }
//        var curDict = [Character: [Int]]()
//        var ss = [Character](s)
//        var i = 0
//        while i < s.count {
//            if targetDict[ss[i]] != nil {
//                break
//            }
//            i += 1
//        }
//        while i < s.count {
//
//        }
//    }
    
    func gameOfLife(_ board: inout [[Int]]) {
        guard board.count > 0 && board[0].count > 0 else {
            return
        }
        let m = board.count
        let n = board[0].count
        
        
        func liveCount(_ x: Int, _ y: Int) -> Int {
            var count = 0
            for i in -1...1 {
                for j in -1...1 {
                    let yy = y + i, xx = x + j
                    count += (xx < 0 || yy >= m || xx >= n || yy < 0) ? 0 : board[yy][xx]
                }
            }
            return count - board[y][x]
        }
        
        func backTrack(_ x: Int, _ y: Int) {
            guard y < m else {
                return
            }
            var toBe = board[y][x]
            let count = liveCount(x, y)
            if board[y][x] == 1 {
                if count > 3 || count < 2 {
                    toBe = 0
                }
            } else {
                if count == 3 {
                    toBe = 1
                }
            }
            let nextX = (x + 1) == n ? 0 : x + 1
            let nextY = nextX == 0 ? y + 1 : y
            backTrack(nextX, nextY)
            board[y][x] = toBe
        }
        backTrack(0, 0)
    }
    
    func calculate(_ s: String) -> Int {

        
        let set = CharacterSet(charactersIn: "+-*/ ")
        let numberSet = CharacterSet(charactersIn: "1234567890 ")

        var values = s.components(separatedBy: set)
            .filter { $0.count > 0 }
            .map { Int($0) ?? 0 }
        var operators = s.components(separatedBy: numberSet).filter({ $0.count > 0})
        if operators.count == values.count {
            if operators.first == "-" {
                values[0] = -values[0]
            }
            operators.removeFirst()
        }

        var numArr = [values[0]]
        var o = [String]()
        for i in 0..<operators.count {
            if operators[i] == "+" || operators[i] == "-"{
                numArr.append(values[i + 1])
                o.append(operators[i])
            } else {
                if operators[i] == "*" {
                    numArr[numArr.count - 1] = numArr[numArr.count - 1] * values[i + 1]
                } else {
                    numArr[numArr.count - 1] = numArr[numArr.count - 1] / values[i + 1]
                }
            }
        }
        var res = numArr[0]
        for i in 0..<o.count {
            if o[i] == "+" {
                res += numArr[i + 1]
            } else {
                res -= numArr[i + 1]
            }
        }
        return res
    }
    
    func numTeams(_ rating: [Int]) -> Int {
        var i = 0, j = 0, k = 0, assending = true, res = 0
        while i < rating.count {
            j = i + 1
            while j < rating.count {
                if rating[i] < rating[j] {
                    assending = true
                } else if rating[i] > rating[j] {
                    assending = false
                } else {
                    j += 1
                    continue
                }
                k = j + 1
                while k < rating.count {
                    if assending == (rating[j] < rating[k]) {
                        res += 1
                    }
                    k += 1
                }
                j += 1
            }
            i += 1
        }
        return res
    }
    
    func numTeams_middle(_ nums: [Int]) -> Int {
        let N = nums.count
        var i = 0, j = 1, k = 0
        var iLess = 0, iMore = 0, kLess = 0, kMore = 0
        var res = 0
        while j < N - 1 {
            i = 0
            iLess = 0
            iMore = 0
            kLess = 0
            kMore = 0
            while i < j {
                if nums[j] > nums[i] {
                    iLess += 1
                } else if nums[j] < nums[i] {
                    iMore += 1
                }
                i += 1
            }
            k = j + 1
            while k < N {
                if nums[j] > nums[k] {
                    kLess += 1
                } else if nums[j] < nums[k] {
                    kMore += 1
                }
                k += 1
            }
            res += iLess * kMore + iMore * kLess
            j += 1
        }
        return res
    }
}

class LongestValidParentheses {
    //stack
    func longestValidParentheses(_ s: String) -> Int {
        var stack = [-1]
        var res = 0
        for (index,c) in s.enumerated() {
            if c == "(" {
                stack.append(index)
            } else {
                _ = stack.popLast()
                if let last = stack.last {
                    res = max(index - last, res)
                } else {
                    stack.append(index)
                }
            }
        }
        return res
    }
    
    func longestValidParentheses1(_ s: String) -> Int {
        var left = 0, right = 0
        var res = 0
        for c in s {
            if c == "(" {
                left += 1
            } else {
                right += 1
            }
            if right > left {
                left = 0
                right = 0
            } else if right == left {
                res = max(left + right, res)
            }
        }
        left = 0
        right = 0
        for c in s.reversed() {
            if c == "(" {
                left += 1
            } else {
                right += 1
            }
            if left > right {
                left = 0
                right = 0
            } else if right == left {
                res = max(left + right, res)
            }
        }
        return res
    }
    
    func longestValidParentheses_dp(_ s: String) -> Int {
        var dp = [Int].init(repeating: 0, count: s.count)
        let s = [Character](s)
        var res = 0
        for i in 1..<s.count {
            if s[i] == ")" {
                if s[i - 1] == "(" {
                    dp[i] = (i >= 2 ? dp[i - 2] : 0) + 2
                } else if i - dp[i - 1] > 0 && s[i - dp[i - 1] - 1] == "(" {
                    dp[i] = dp[i - 1] + ((i - dp[i - 1]) >= 2 ? dp[i - dp[i - 1] - 2] : 0) + 2
                }
            }
            res = max(res, dp[i])
        }
        return res
    }
    

}

class Judge24Point {

    func judge24Point(_ nums: [Int]) -> Bool {
        var floatNums = [Float]()
        for i in nums {
            floatNums.append(Float(i))
        }
        return compute(floatNums)
    }
    
    func compute(_ nums: [Float]) -> Bool {
        guard nums.count != 1 else {
            return abs(24 - nums[0]) <= 0.001
        }

        var i = 0
        while i < nums.count - 1 {
            var j = i + 1
            while j < nums.count {
                var leftNums = [Float]()
                var k = 0
                while k < i {
                    leftNums.append(nums[k])
                    k += 1
                }
                k = i + 1
                while k < j {
                    leftNums.append(nums[k])
                    k += 1
                }
                k = j + 1
                while k < nums.count {
                    leftNums.append(nums[k])
                    k += 1
                }
                let mul = nums[i] * nums[j]
                leftNums.append(mul)
                guard !compute(leftNums) else {
                    return true
                }
                leftNums.removeLast()
                if nums[j] != 0 {
                    let divide = nums[i] / nums[j]
                    leftNums.append(divide)
                    guard !compute(leftNums) else {
                        return true
                    }
                    leftNums.removeLast()
                }
                if nums[i] != 0 {
                    
                    let divide1 = nums[j] / nums[i]
                    leftNums.append(divide1)
                    guard !compute(leftNums) else {
                        return true
                    }
                    leftNums.removeLast()
                }
                let plus = nums[i] + nums[j]
                leftNums.append(plus)
                guard !compute(leftNums) else {
                    return true
                }
                leftNums.removeLast()
                let minus = nums[i] - nums[j]
                leftNums.append(minus)
                guard !compute(leftNums) else {
                    return true
                }
                leftNums.removeLast()
                let minus1 = nums[j] - nums[i]
                leftNums.append(minus1)
                guard !compute(leftNums) else {
                    return true
                }
                leftNums.removeLast()
                j += 1
            }
            i += 1
        }
        return false
    }
}
