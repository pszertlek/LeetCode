//
//  SystemDesign.swift
//  LeetCode
//
//  Created by Apple on 2021/2/7.
//  Copyright © 2021 Pszertlek. All rights reserved.
//

import Foundation

class WordsFrequency {
    var dict = [String: Int]()
    
    init(_ books: [String]) {
        books.forEach { (c) in
            dict[c, default: 0] += 1
        }
    }
    
    func get(_ word: String) -> Int {
        return dict[word, default: 0]
    }
}

class CombinationIterator {

    var characters: [Character]
    var combinationLength: Int
    var numbers: [Int]
    var baseNumber: Int
    var visited: [Bool]
    var finished = false
    
    init(_ characters: String, _ combinationLength: Int) {
        self.characters = [Character](characters)
        self.combinationLength = combinationLength
        self.baseNumber = self.characters.count
        self.numbers = [Int].init(repeating: 0, count: combinationLength)
        self.visited = [Bool].init(repeating: false, count: baseNumber)
        for i in 0..<combinationLength {
            self.numbers[i] = i
            visited[i] = true
        }
    }
    
    func next() -> String {
        guard !hasNext() else {
            return ""
        }
        var s = ""
        for i in numbers {
            s.append(characters[i])
        }
        var i = combinationLength - 1
        while i >= 0 && i < combinationLength {
            if self.numbers[i] == -1 {
                for index in 0..<baseNumber {
                    if !visited[index] {
                        numbers[i] = index
                        visited[index] = true
                        break
                    }
                }
                i += 1
            } else if self.numbers[i] + 1 < self.baseNumber {
                visited[self.numbers[i]] = false
                var hasNumber = false
                for index in self.numbers[i] + 1..<baseNumber {
                    if !visited[index] {
                        visited[index] = true
                        numbers[i] = index
                        hasNumber = true
                        break
                    }
                }
                if hasNumber {
                    i += 1
                } else {
                    self.numbers[i] = -1
                    i -= 1
                }
            } else {
                visited[numbers[i]] = false
                numbers[i] = -1
                i -= 1
            }
        }
        self.finished = i == -1
        return s
    }
    
    func hasNext() -> Bool {
        return self.finished
    }
}
class CombinationIterator111 {

    var characters: [Character]
    var combinationLength: Int
    var numbers: [Int]
    var baseNumber: Int
    var finished = false
    
    init(_ characters: String, _ combinationLength: Int) {
        self.characters = [Character](characters)
        self.combinationLength = combinationLength
        self.baseNumber = self.characters.count
        self.numbers = [Int].init(repeating: 0, count: combinationLength)
        for i in 0..<combinationLength {
            self.numbers[i] = i
        }
    }
    
    func next() -> String {
        guard hasNext() else {
            return ""
        }
        var s = ""
        for i in numbers {
            s.append(characters[i])
        }
        var i = combinationLength - 1

        while i >= 0 && i < combinationLength {

            if self.numbers[i] == -1 {
                self.numbers[i] = self.numbers[i - 1] + 1
                i += 1
            } else {
                self.numbers[i] = self.numbers[i] + 1
                if self.numbers[i] + (combinationLength - i) <= self.baseNumber {
                    i += 1
                } else {
                    numbers[i] = -1
                    i -= 1
                }
            }
        }
        self.finished = i == -1
        return s
    }
    
    func hasNext() -> Bool {
        return self.numbers[0] != -1
    }
}

class BrowswerHistory {
    var home: String
    
    var visits: [String]
    
    var index = -1
    
    var maxCount = 0
    
    init(_ homepage: String) {
        self.home = homepage
        self.visits = [String].init(repeating: "", count: 100)
    }
    
    func visit(_ url: String) {
        self.visits[index + 1] = url
        index += 1
        maxCount = index + 1
    }
    
    func back(_ steps: Int) -> String {
        index -= steps
        index = index >= 0 ? index : -1
        return index == -1 ? home : visits[index]
    }
    
    func forward(_ steps: Int) -> String {
        if index + steps < maxCount {
            index += steps
        } else {
            index = maxCount - 1
        }
        return index == -1 ? home : visits[index]
    }
}

class SortedStack {
    
    var stack: [Int] = []
    init() {
        
    }
    
    func push(_ val: Int) {

        var stackTemp: [Int] = []

        while let i = stack.last, i < val {
            let _ = stack.popLast()
            stackTemp.append(i)
        }
        stack.append(val)
        while let i = stackTemp.popLast() {
            stack.append(i)
        }
        print("push")
        print(stack)
    }
    
    func pop() {
        let _ = stack.popLast()
    }
    
    func peek() -> Int {
        stack.last ?? -1
    }
    
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
}

class Cashier {
    
    var n: Int
    var dict = [Int: Int]()
    var discount: Int
    var curCount = 0
    
    init(_ n: Int, _ discount: Int, _ products: [Int], _ prices: [Int]) {
        self.n = n
        self.discount = 100 - discount
        for i in 0..<products.count {
            dict[products[i]] = prices[i]
        }
    }
    
    func getBill(_ product: [Int], _ amount: [Int]) -> Double {
        curCount += 1
        var totalPrice = 0
        for i in 0..<product.count {
            totalPrice += dict[product[i],default: 0] * amount[i]
        }
        curCount %= n
        return curCount == 0 ? Double(discount) / 100 * Double(totalPrice) : Double(totalPrice)
    }
}

class FrontMiddleBackQueue: CustomStringConvertible {

    var frontQueue = DoublyLinkedList<Int>()
    var backQueue = DoublyLinkedList<Int>()
    
    init() {

    }
    
    var description: String {
        var s = ""
        var item = frontQueue.head
        while item != nil {
            s = s + "  \(item!.v)"
            item = item?.next
        }
        item = backQueue.head
        s += "\n"
        while item != nil {
            s = s + "  \(item!.v)"
            item = item?.next
        }
        return s
    }
    
    func balance() {
        if frontQueue.count > backQueue.count {
            if let item = frontQueue.removeTail() {
                backQueue.insertHead(item)
            }
        } else if frontQueue.count + 1 < backQueue.count {
            if let item = backQueue.removeHead() {
                frontQueue.append(item)
            }
        }
    }
    
    func pushFront(_ val: Int) {
        frontQueue.insertHead(val)
        balance()
    }
    
    func pushMiddle(_ val: Int) {
        backQueue.insertHead(val)
        balance()
    }
    
    func pushBack(_ val: Int) {
        backQueue.append(val)
        balance()
    }
    
    func popFront() -> Int {
        var item: DoublyLinkedNode<Int>?
        if frontQueue.count == 0 {
            item = backQueue.removeHead()
        } else {
            item = frontQueue.removeHead()
        }
        
        balance()
        return item?.v ?? -1
    }
    
    func popMiddle() -> Int {
        var item: DoublyLinkedNode<Int>?
        if frontQueue.count == backQueue.count {
            item = frontQueue.removeTail()
        } else {
            item = backQueue.removeHead()
        }
        balance()
        return item?.v ?? -1
    }
    
    func popBack() -> Int {
        let item = backQueue.removeTail()
        balance()
        return item?.v ?? -1
    }
}

class MyCircularDeque {

    /** Initialize your data structure here. Set the size of the deque to be k. */
    var frontIndex: Int = 0
    var capacity: Int
    var data: [Int]
    var count = 0
    
    init(_ k: Int) {
        capacity = k
        data = [Int].init(repeating: 0, count: k)
    }
    
    @inline(__always) private func nextIndex(_ index: Int) -> Int {
        return (index + 1) % capacity
    }
    
    @inline(__always) private func preIndex(_ index: Int) -> Int {
        return index - 1 >= 0 ? index - 1 : (index - 1 + capacity)
    }
    
    /** Adds an item at the front of Deque. Return true if the operation is successful. */
    func insertFront(_ value: Int) -> Bool {
        guard count < capacity else {
            return false
        }
        let insertPosition = preIndex(frontIndex)
        data[insertPosition] = value
        frontIndex = insertPosition
        count += 1
        return true
    }
    
    /** Adds an item at the rear of Deque. Return true if the operation is successful. */
    func insertLast(_ value: Int) -> Bool {
        guard count < capacity else {
            return false
        }
        
        let insertPosition = (count + frontIndex) % capacity
        data[insertPosition] = value
        count += 1
        return true

    }
    
    /** Deletes an item from the front of Deque. Return true if the operation is successful. */
    func deleteFront() -> Bool {
        guard count > 0 else {
            return false
        }
        
        let next = nextIndex(frontIndex)
        frontIndex = next
        count -= 1
        return true
    }
    
    /** Deletes an item from the rear of Deque. Return true if the operation is successful. */
    func deleteLast() -> Bool {
        guard count > 0 else {
            return false
        }
        count -= 1
        
        return true
    }
    
    /** Get the front item from the deque. */
    func getFront() -> Int {
        guard count > 0 else {
            return -1
        }
        return data[frontIndex]
    }
    
    /** Get the last item from the deque. */
    func getRear() -> Int {
        guard count > 0 else {
            return -1
        }
        return data[(frontIndex + count - 1) % self.capacity]
    }
    
    /** Checks whether the circular deque is empty or not. */
    func isEmpty() -> Bool {
        return count == 0
    }
    
    /** Checks whether the circular deque is full or not. */
    func isFull() -> Bool {
        return count == capacity
    }
}

class TweetCounts {
    var user = [String: [Int]]()
    
    func recordTweet(_ tweetName: String, _ time: Int) {
        user[tweetName,default:[]].append(time)
    }
    
    func getTweetCountsPerFrequency(_ freq: String, _ tweetName: String, _ startTime: Int, _ endTime: Int) -> [Int] {
        let endTime = endTime + 1
        var length = 0
        if freq == "minute" {
            length = 60
        } else if freq == "hour" {
            length = 60 * 60
        
        } else {
            length = 60 * 60 * 24
        }
        var ans = [Int](repeating: 0, count: (endTime - startTime - 1) / (length + 1))
        for time in user[tweetName] ?? [] {
            if time >= startTime && time < endTime {
                if time >= startTime && time < endTime {
                    ans[(time - startTime) / length] += 1
                }
            }
        }
        return ans
    }
}

class UndergroundSystem {
    class Customer {
        var id: Int
        var start: String?
        var end: String?
        var startTime: Int = -1
        var endTime: Int = -1

        func cost() -> Int {
            guard startTime >= 0 else {
                return 0
            }
            guard endTime >= 0 else {
                return 0
            }
            return endTime - startTime
        }

        init(_ id: Int) {
            self.id = id
        }
    }

    class SumAmount {
        var sum = 0
        var amount = 0
        func average() -> Double {
            return Double(sum) / Double(amount)
        }
    }

    var cache = [Int: Customer]()
    var cache1 = [[String]: (Int, Int)]()

    init() {

    }
    
    func checkIn(_ id: Int, _ stationName: String, _ t: Int) {
        let c = Customer(id)
        c.start = stationName
        c.startTime = t
        cache[id] = c
    }
    
    func checkOut(_ id: Int, _ stationName: String, _ t: Int) {
        guard let c = cache[id] else {
            return
        }
        c.end = stationName
        c.endTime = t
        let arr = [c.start!,c.end!]
        var s = cache1[arr, default: (0,0)]
        s.0 += c.endTime - c.startTime
        s.1 += 1
        cache1[arr] = s

    }
    
    func getAverageTime(_ startStation: String, _ endStation: String) -> Double {
        if let s = cache1[[startStation, endStation]] {
            return Double(s.0) / Double(s.1)
        }
        return 0
    }
}

class SeatManager {

    var heap: Heap<Int>

    init(_ n: Int) {
        heap = Heap<Int>(sort: <)
        for i in 1...n {
            heap.insert(i)
        }
    }
    
    func reserve() -> Int {
        return heap.remove() ?? 0
    }
    
    func unreserve(_ seatNumber: Int) {
        heap.insert(seatNumber)
    }
}

class AuthenticationManager {

    var timeToLive: Int

    var dict: [String: Int] = [:]

    init(_ timeToLive: Int) {
        self.timeToLive = timeToLive
    }
    
    func generate(_ tokenId: String, _ currentTime: Int) {
        dict[tokenId] = currentTime + timeToLive
    }
    
    func renew(_ tokenId: String, _ currentTime: Int) {
        if let time = dict[tokenId], time >= currentTime {
            dict[tokenId] = currentTime + timeToLive
        }
        
    }
    
    func countUnexpiredTokens(_ currentTime: Int) -> Int {
        var res = 0
        for (key, value) in dict {
            if value >= currentTime {
                res += 1
            }
        }
        return res
    }
}
