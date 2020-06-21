//
//  Heap.swift
//  LeetCode
//
//  Created by apple on 2019/2/25.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

public struct Heap<T> {
    public var nodes = [T]()
    private var orderCriteria: (T, T) -> Bool
    
    public init(sort: @escaping (T, T) -> Bool) {
        orderCriteria = sort
    }
    
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    public var count: Int {
        return nodes.count
    }
    
    public mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: nodes.count / 2 - 1, through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    public mutating func reset() {
        for i in stride(from: nodes.count / 2 - 1, through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    @inline(__always) internal func parentIndex(ofIndex index: Int) -> Int {
        return (index - 1) / 2
    }
    
    @inline(__always) internal func leftChildIndex(ofIndex index: Int) -> Int {
        return index * 2 + 1
    }
    
    @inline(__always) internal func rightChildIndex(ofIndex index: Int) -> Int {
        return index * 2 + 2
    }
    
    public func peek() -> T? {
        return nodes.first
    }
    
    internal mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: index)
        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        nodes[childIndex] = child
    }
    
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = self.rightChildIndex(ofIndex: index)
        
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        if first == index {
            return
        }
        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
    
    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }
    
    public mutating func insert<S: Sequence>(_ sequence:S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }
    
    public mutating func replace(index i: Int, value: T) {
        guard i < nodes.count else {
            return
        }
        remove(at: i)
        insert(value)
    }
    
    @discardableResult
    public mutating func remove() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil}
        let size = nodes.count - 1
        if index != size {
            nodes.swapAt(index, size)
            shiftDown(from: index,  until: size)
            shiftUp(index)
        }
        return nodes.removeLast()
    }
    
    @discardableResult
    public mutating func sort() -> [T] {
        for i in stride(from: self.nodes.count - 1, to: 0, by: -1) {
            nodes.swapAt(0, i)
            shiftDown(from: 0, until: i)
        }
        return nodes
    }

}

public func heapSort<T>(_ a:[T], _ sort: @escaping (T,T) -> Bool) -> [T] {
    var heap = Heap(array: a, sort: sort)
    return heap.sort()
}

public extension Heap where T: Equatable {
    /** Get the index of a node in the heap. Performance: O(n). */
    func index(of node: T) -> Int? {
        return nodes.firstIndex(where: { $0 == node })
    }
    
    /** Removes the first occurrence of a node from the heap. Performance: O(n log n). */
    @discardableResult mutating func remove(node: T) -> T? {
        if let index = index(of: node) {
            return remove(at: index)
        }
        return nil
    }
}



public struct PriorityQueue<T> where T: Comparable {
    private var heap: Heap<T>
    
    init(sort: @escaping (T,T) -> Bool) {
        heap = Heap<T>(sort: sort)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public var count: Int {
        return heap.count
    }
    
    public func peek() -> T? {
        return heap.peek()
    }
    
    public mutating func enqueue(element: T) {
        heap.insert(element)
    }
    
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    
    public mutating func changePriority(index i: Int, value: T) {
        return heap.replace(index: i, value: value)
    }
}

extension PriorityQueue where T: Equatable {
    public func index(of element: T) -> Int? {
        return heap.index(of: element)
    }
}



class KthLargest {
    var array: [Int]
    let k: Int
    init(_ k: Int, _ nums: [Int]) {
        array = nums.sorted().reversed()
        self.k = k
    }
    
    func add(_ val: Int) -> Int {
        guard array.count > 1 else {
            array.insert(val, at: val > array.first! ? 0 : 1)
            return array[k - 1]
        }
        var left = 0, right = array.count - 1
        while left < right {
            let mid = (left + right) / 2
            if array[mid] >= val {
                left = mid + 1
            } else {
                right = mid
            }
        }
        array.insert(val, at: left)
        print(array)
        return array[k - 1]
    }
}

class KthLargest1 {
    var heap: Heap<Int>
    let k: Int
    init(_ k: Int, _ nums: [Int]) {
        let array = nums.sorted()
        heap = Heap(array:Array(array.suffix(k)),sort: <)
        self.k = k
    }
    
    func add(_ val: Int) -> Int {
        heap.insert(val)
        heap.remove()
        print(heap.nodes)
        return heap.peek()!
    }
}


//func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
//
//}

public class HeapSolution {
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        guard nums1.count != 0 && nums2.count != 0 else {
            return []
        }
        var k = k
        if k > nums1.count * nums2.count {
            k = nums1.count * nums2.count
        }
        var steps = Array<Int>.init(repeating: 0, count: nums1.count)
        var result = [[Int]]()
        for _ in 0..<k {
            var min = Int.max
            var minStepIndex = 0
            for j in 0..<nums1.count {
                if steps[j] < nums2.count && nums2[steps[j]] + nums1[j] < min {
                    min = nums2[steps[j]] + nums1[j]
                    minStepIndex = j
                }
            }
            result.append([nums1[minStepIndex],nums2[steps[minStepIndex]]])
            steps[minStepIndex] = steps[minStepIndex] + 1
        }
        return result
    }
    
    
    func reorganizeString(_ S: String) -> String {
        var dict = [Character: Int]()
        for c in S {
            dict[c] = (dict[c] ?? 0) + 1
        }
        var heap = Heap<(key:Character, value: Int)>.init { return $0.value < $1.value }
        for keyValue in dict {
            heap.insert(keyValue)
            //        print("key:\(keyValue.key),value: \(keyValue.value)")
        }
        
        var result = ""
        var count = 0,rightUsed = 0
        let sort = heap.sort()
        
        count = 0
        var left = sort[0].key,leftUsed = 0
        var rightIndex = 0, leftIndex = 0
        var right = sort[rightIndex].key
        if (S.count + 1) / 2 < sort[0].value {
            return ""
        }
        for _ in 0..<(S.count+1)/2 {
            rightUsed = rightUsed + 1
            if rightUsed == sort[rightIndex].value {
                rightUsed = 0
                rightIndex = rightIndex + 1
                right = sort[rightIndex].key
            }
        }
        while count < (S.count / 2) {
            if left == right {
                result.append(left)
                result = String(right) + result
            } else {
                result.append(left)
                result.append(right)
            }
            
            leftUsed = leftUsed + 1
            rightUsed = rightUsed + 1
            
            if leftUsed == sort[leftIndex].value && leftIndex + 1 < sort.count {
                leftIndex = leftIndex + 1
                leftUsed = 0
                left = sort[leftIndex].key
            }
            if rightUsed == sort[rightIndex].value && rightIndex < sort.count - 1 {
                rightUsed = 0
                rightIndex = rightIndex + 1
                right = sort[rightIndex].key
            }
            count = count + 1
        }
        if result.count != S.count {
            if result.last! != left {
                result.append(left)
            } else {
                result = String(left) + result
            }
        }
        return result
    }

    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        var heap = Heap<Int>.init(sort: >)
        for i in matrix {
            for j in i {
                heap.insert(j)
                if heap.count > k {
                    heap.remove()
                }
            }
        }
        return heap.peek()!
    }
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var heap = Heap<(Int, Int)>.init { (f, s) -> Bool in
            return f.1 < s.1
        }
        var dict = [Int: Int]()
        for i in nums {
            dict[i] = (dict[i] ?? 0) + 1
        }
        
        for i in dict {
            heap.insert(i)
            if heap.count > k {
                heap.remove()
            }
        }
        var array = [Int]()
        while heap.count > 0 {
            array.append(heap.peek()!.0)
            heap.remove()
        }
        return array.reversed()
    }
    
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var heap = Heap<(String, Int)>.init { (f, s) -> Bool in
            if ( f.1 < s.1 ) {
                return true
            } else if f.1 == s.1 {
                return f.0 > s.0
            } else {
                return false
            }
        }
        var dict = [String: Int]()
        for i in words {
            dict[i] = (dict[i] ?? 0) + 1
        }
        
        for i in dict {
            heap.insert(i)
            if heap.count > k {
                heap.remove()
            }
        }
        var array = [String]()
        while heap.count > 0 {
            array.append(heap.peek()!.0)
            heap.remove()
        }
        return array.reversed()
    }

    
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        var heap = Heap<[Int]>.init { (first, second) -> Bool in
             return (first[0] * first[0] + first[1] * first[1]) > ( second[0] * second[0] + second[1] * second[1])
        }
        for element in points {
            heap.insert(element)
            if heap.count > K {
                heap.remove()
            }
        }
        return heap.nodes
    }
    
    func nthUglyNumber(_ n: Int) -> Int {
        var uglys = [1]
        var a = 2, b = 3, c = 5
        var idx = [0,0,0]
        for _ in 0..<n {
            let next = min(a, min(b, c))
            
            uglys.append(next)
            if a == next {
                
                idx[0] = idx[0] + 1
                a = 2 * uglys[idx[0]]
            }
            if b == next {
                
                idx[1] = idx[1] + 1
                b = 3 * uglys[idx[1]]
            }
            if c == next {
                
                idx[2] = idx[2] + 1
                c = 5 * uglys[idx[2]]
                
            }
        }
        return uglys[n - 1]
    }

}

let recentCount = 10

class Twitter {
    
    /** Initialize your data structure here. */
    lazy var dict: [Int:User] = [Int: User]()
    public var time = 0
    class User {
        var userId: Int
        lazy var tweets: [Tweet] = [Tweet]()
        lazy var follows: Set<Int> = Set<Int>()
        init(_ userId: Int) {
            self.userId = userId
            self.follows.insert(userId)
        }
        
        func postTweet(_ tweetId: Int, _ time: Int) {
            let t = Tweet(tweetId, time)
            self.tweets.append(t)
        }
        
        func follow(_ followeeId: Int) {
            self.follows.insert(followeeId)
        }
        
        func unfollow(_ followeeId: Int) {
            self.follows.remove(followeeId)
        }
        
        func allFollowee() -> Set<Int> {
            return self.follows
        }
        
        func recentTweets() -> [Tweet] {
            if tweets.count > recentCount {
                return Array(tweets[(tweets.count - recentCount)..<(tweets.count)])
            } else {
                return tweets
            }
        }
    }
    
    class Tweet {
        var tweedId: Int
        var createTime: Int
        init(_ tweetId: Int, _ time: Int) {
            self.tweedId = tweetId
            self.createTime = time
        }
    }
    
    init() {

    }

    /** Compose a new tweet. */
    func postTweet(_ userId: Int, _ tweetId: Int) {
        let user: User = self.getUser(userId)
        time = time + 1
        user.postTweet(tweetId, time)
    }
    
    /** Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent. */
    func getNewsFeed(_ userId: Int) -> [Int] {
        guard let follower = dict[userId] else {
            return []
        }
        let followees = follower.allFollowee()
        guard followees.count != 0 else {
            return []
        }
        var results = Heap<Tweet>.init(sort: {
            return $0.createTime < $1.createTime
        })
        for i in followees {
            let curUser = dict[i]!
            let rencentTweets = curUser.recentTweets()
            for j in stride(from: rencentTweets.count - 1, through: 0, by: -1) {
                let tweet = rencentTweets[j]
                if results.count == 10 {
                    if tweet.createTime < results.peek()!.createTime {
                        break
                    } else {
                        results.insert(tweet)
                    }
                } else {
                    results.insert(tweet)
                }
                if results.count > 10 {
                    results.remove()
                }
            }
        }
        var resultArray = [Int]()
        for i in results.sort() {
            resultArray.append(i.tweedId)
        }
        return resultArray
    }
    
    /** Follower follows a followee. If the operation is invalid, it should be a no-op. */
    func follow(_ followerId: Int, _ followeeId: Int) {
        guard followeeId != followerId else {
            return
        }
        let follower = self.getUser(followerId)
        let _ = self.getUser(followeeId)
        follower.follow(followeeId)
    }
    
    /** Follower unfollows a followee. If the operation is invalid, it should be a no-op. */
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        guard followeeId != followerId else {
            return
        }
        let follower = self.getUser(followerId)
        let _ = self.getUser(followeeId)
        follower.unfollow(followeeId)
    }
    
    func getUser(_ userId: Int) -> User {
        if self.dict[userId] == nil {
            self.dict[userId] = User(userId)
        }
        return self.dict[userId]!
    }
}


//编写一段程序来查找第 n 个超级丑数。
//
//超级丑数是指其所有质因数都是长度为 k 的质数列表 primes 中的正整数。
//
//示例:
//
//输入: n = 12, primes = [2,7,13,19]
//输出: 32
//解释: 给定长度为 4 的质数列表 primes = [2,7,13,19]，前 12 个超级丑数序列为：[1,2,4,7,8,13,14,16,19,26,28,32] 。
//说明:
//
//1 是任何给定 primes 的超级丑数。
//给定 primes 中的数字以升序排列。
//0 < k ≤ 100, 0 < n ≤ 106, 0 < primes[i] < 1000 。
//第 n 个超级丑数确保在 32 位有符整数范围内。

//func nthSuperUglyNumber(_ n: Int, _ primes: [Int]) -> Int {
//
//}


//int nthUglyNumber(int n) {
//    vector<int> ugly(n, 1), idx(3, 0);
//    for (int i = 1; i < n; ++i){
//        int a = ugly[idx[0]]*2, b = ugly[idx[1]]*3, c = ugly[idx[2]]*5;
//        int next = std::min(a, std::min(b, c));
//        if (next == a){
//            ++idx[0];
//        }
//        if (next == b){
//            ++idx[1];
//        }
//        if (next == c){
//            ++idx[2];
//        }
//        ugly[i] = next;
//    }
//    return ugly.back();
//}

//func nthSuperUglyNumber(_ n: Int, _ primes: [Int]) -> Int {
//    var superUglys = [1]
//    var idx = Array<(Int,Int)>.init()
//    for (index,i) in primes.enumerated() {
//        idx.append((i,0))
//    }
//    var heap = Heap<Int>.init(array: primes, sort: <)
//    var cur = primes.first!
//    for _ in 0..<n {
//        let next = heap.peek()!
//
//        superUglys.append(next)
//
//
//        for (index,i) in idx.enumerated() {
//            if i.0 == next {
//
//                idx[index] = idx[index] + 1
//                heap.insert(primes[index] * superUglys[idx[index]])
//            }
//        }
//        heap.remove()
//    }
//    return superUglys.last!
//}


func nthUglyNumber(_ n: Int) -> Int {
    var uglys = [1]
    var a = 2, b = 3, c = 5
    var idx = [0,0,0]
    for _ in 0..<n {
        let next = min(a, min(b, c))

        uglys.append(next)
        if a == next {

            idx[0] = idx[0] + 1
            a = 2 * uglys[idx[0]]
        }
        if b == next {

            idx[1] = idx[1] + 1
            b = 3 * uglys[idx[1]]
        }
        if c == next {

            idx[2] = idx[2] + 1
            c = 5 * uglys[idx[2]]

        }
    }
    return uglys[n - 1]
}
