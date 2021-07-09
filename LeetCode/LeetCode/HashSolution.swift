//
//  HashSolution.swift
//  LeetCode
//
//  Created by apple on 2019/5/5.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class HashSolution {
    ///423
    func originalDigits(_ s: String) -> String {
        /**
         zero one two three four five six seven eight nine
         z: zero
         o: zero one two four
         r: zero three four
         e: zero one three five seven eight nine
         t: two three eight
         w: two
         f: four five
         u: four
         v: five seven
         s: six seven
         i: six eight five
         x: six
         n: seven nine
         g: eight
         h: eight three
         
         */
        var dict = [Character: Int]()
        for c in s {
            dict[c, default: 0] += 1
        }
        var res = [Int](repeating: 0, count: 10)
        res[0] = dict["z", default: 0]
        res[2] = dict["w", default: 0]
        res[4] = dict["u", default: 0]
        res[6] = dict["x", default: 0]
        res[8] = dict["g", default: 0]
        res[3] = dict["h", default: 0] - res[8]
        res[5] = dict["f", default: 0] - res[4]
        res[7] = dict["s", default: 0] - res[6]
        res[9] = dict["i", default: 0] - res[5] - res[6] - res[8]
        res[1] = dict["n", default: 0] - res[7] - 2 * res[9]
        var ans = ""
        for i in 0...9 {
            for _ in 0..<res[i] {
                ans.append("\(i)")
            }
        }
        return ans
    }
    
    func repeatedNTimes(_ A: [Int]) -> Int {
        var set = Set<Int>()
        for i in A {
            if !set.contains(i) {
                set.insert(i)
            } else {
                return i
            }
        }
        return -1
    }
    
    func repeatedNTimes1(_ A: [Int]) -> Int {
        for i in stride(from: 0, through: A.count - 2, by: 1) {
            if A[i] == A[i+1] {
                return A[i]
            }
        }
        return A[0] == A[2] ? A[0] : A[A.count - 1]
    }
    
    func commonChars(_ A: [String]) -> [String] {//TODO:How to solve multi number in dict
        var dictArray = [[Character: Int]]()

        for i in A {
            var dict = [Character: Int]()
            for c in i {
                dict[c] = (dict[c] ?? 0) + 1
            }
            dictArray.append(dict)
        }
        var result = [String]()
        var resultDict = dictArray[0]
        for i in resultDict.keys {
            for dict in dictArray {
                if let count = dict[i], let countA = resultDict[i] {
                    resultDict[i] = countA <= count ? countA : count
                } else {
                    resultDict[i] = nil
                }
            }
        }
        for (key,value) in resultDict {
            for _ in 0..<value {
                result.append(String(key))
            }
        }
        return result
    }
    
    func subdomainVisits(_ cpdomains: [String]) -> [String] {
        var dict: [String: Int] = [:]
        func sss(_ s: [String],_ index: Int) -> String {
            var i = index
            var result = ""
            while i < s.count {
                result.append(s[i])
                if i < s.count - 1 {
                    result.append(".")
                }
                i = i + 1
            }
            return result
        }
        
        for i in cpdomains {
            let array = i.components(separatedBy: " ")
            let count = Int(array[0])!
            let domains = array[1].components(separatedBy: ".")
            
            for (index,_) in domains.enumerated() {
                let domain = sss(domains, index)
                dict[domain] = (dict[domain] ?? 0) + count
            }
        }
        var result = [String]()
        for (key,value) in dict {
            result.append("\(value) \(key)")
        }
        return result
    }
    
    func replaceWords(_ dict: [String], _ sentence: String) -> String {
        var minLength = Int.max
        var lengthDict = [Int: Set<String>]()
        for word in dict {
            if word.count < minLength {
                minLength = word.count
            }
            lengthDict[word.count, default: Set<String>()].insert(word)
        }
        var curStr = ""
        var curFinish = false
        let kong = Character(" ")
        var res = ""
        for c in sentence {
            if c == kong {
                if !curFinish {
                    res.append(curStr)
                }
                curStr.removeAll()
                curFinish = false
                res.append(kong)
            } else {
                if curFinish {
                    continue
                }
                curStr.append(c)
                
                if let curDict = lengthDict[curStr.count], curDict.contains(curStr) {
                    res.append(curStr)
                    curFinish = true
                }
            }
        }
        if !curFinish {
            res.append(curStr)
        }
        return res
    }
    public class TrieNode {
        var children: [TrieNode?]
        var word: String?
        init() {
            children = [TrieNode?].init(repeating: nil, count: 26)
        }
    }
    
    func replaceWords1(_ dict: [String], _ sentence: String) -> String {
        let trie = TrieNode()
        let aAsc = Character("a").asciiValue!
        for word in dict {
            var cur = trie
            for c in word {
                if cur.children[Int(c.asciiValue! - aAsc)] == nil {
                    cur.children[Int(c.asciiValue! - aAsc)] = TrieNode()
                }
                cur = cur.children[Int(c.asciiValue! - aAsc)]!
            }
            cur.word = word
        }
        var res = ""
        for word in sentence.components(separatedBy: " ") {
            if res.count > 0 {
                res.append(" ")
            }
            var cur: TrieNode? = trie
            for letter in word {
                if cur?.children[Int(letter.asciiValue! - aAsc)] == nil || cur?.word != nil {
                    break
                }
                cur = cur?.children[Int(letter.asciiValue! - aAsc)]
            }
            res.append(cur?.word != nil ? cur!.word! : word)
        }
        return res
    }
    
    
    func numRabbits(_ answers: [Int]) -> Int {
        var dict = [Int: Int]()
        var result = 0
        for i in answers {
            if dict[i] == nil {
                result = result + i + 1
                dict[i] = i == 0 ? nil : i
            } else {
                dict[i]! -= 1
                if dict[i] == 0 {
                    dict[i] = nil
                }
            }
        }
        return result
    }
    
    func findLength(_ A: [Int], _ B: [Int]) -> Int {
        let aCount = A.count
        let bCount = B.count
        var dp = [Int].init(repeating: 0, count: A.count * B.count)
        var res = 0
        for i in 0..<aCount {
            for j in 0..<bCount {
                if A[i] == B[j] {
                    dp[i * bCount + j] = (i > 0 && j > 0 ? dp[(i - 1) * bCount + j - 1] : 0) + 1
                    res = max(dp[i * bCount + j], res)
                }
            }
        }
        return res
    }
    
    func findRepeatedDnaSequences(_ s: String) -> [String] {
        let fourArr = [1,4,16,64,256,1024,4096,16384,65536,262144,1048576]
        var set = Set<Int>()
        var number = 0
        let A = Character("A"), C = Character("C"), G = Character("G"), T = Character("T")
        func toNumber(_ c: Character) -> Int {
            var curNum = 0

            if c == C {
                curNum = 1
            } else if c == G {
                curNum = 2
            } else if c == T {
                curNum = 3
            }
            return curNum
        }
        
        func toCharacter(_ i: Int) -> Character {
            if i == 0 {
                return A
            } else if i == 1 {
                return C
            } else if i == 2 {
                return G
            }
            return T
        }
        
        func toString(_ i: Int) -> String {
            var count = 9
            var res = ""
            var cur = i
            while count >= 0 {
                let number = cur / fourArr[count]
                res.append(toCharacter(number))
                cur = cur % fourArr[count]
                count -= 1
            }
            return res
        }
        let s = [Character].init(s)
        var res = Set<Int>()
        for i in 0..<s.count {
            let curNum = toNumber(s[i])
            number = number * 4 + curNum
            if i >= 9 {
                print(toString(number))
                if set.contains(number) {
                    res.insert(number)
                }
                set.insert(number)
                number = number - toNumber(s[i - 9]) * fourArr[9]
            }
        }
        
        var resArr = [String]()
        for i in res {
            resArr.append(toString(i))
        }
        return resArr
    }
    
    func largestValsFromLabels(_ values: [Int], _ labels: [Int], _ num_wanted: Int, _ use_limit: Int) -> Int {
        var data = [(Int,Int)]()
        var ml = 0
        for i in 0..<values.count {
            data.append((values[i],labels[i]))
            ml = max(ml, labels[i])
        }
        data.sort { (one, two) -> Bool in
            return one.0 > two.0
        }
        var num = 0
        var sum = 0
        var bucket = [Int].init(repeating: 0, count: ml + 1)
        for i in 0..<data.count {
            let lab = data[i].1
            if bucket[lab] < use_limit {
                num += 1
                bucket[lab] += 1
                sum += data[i].0
                if num >= num_wanted {
                    return sum
                }
            }
        }
        return sum
     }
    
    func watchedVideosByFriends(_ watchedVideos: [[String]], _ friends: [[Int]], _ id: Int, _ level: Int) -> [String] {
        var levelFriends = Set<Int>.init(arrayLiteral: id)
        var level = level
        var friendIds = [id]
        var dict = [String: Int]()
        while level > 0 {
            var nextFriends = [Int]()
            for curId in friendIds {
                for levelId in friends[curId] {
                    if !levelFriends.contains(levelId) {
                        levelFriends.insert(levelId)
                        nextFriends.append(levelId)
                    }
                }
            }
            friendIds = nextFriends
            level -= 1
        }
        levelFriends.remove(id)
        var res = Set<String>()
        for id in friendIds {
            for video in watchedVideos[id] {
                res.insert(video)
                dict[video, default:0] += 1
            }
        }
        let result = [String].init(res).sorted { (s1, s2) -> Bool in
            if dict[s1]! == dict[s2]! {
                return s1 < s2;
            }
            return dict[s1]! < dict[s2]!
        }
        return result
    }

    
    func findMaxLength(_ nums: [Int]) -> Int {
        var maxLen = 0
        for start in 0..<nums.count {
            var zeros = 0, ones = 0
            for end in start..<nums.count {
                if nums[end] == 0 {
                    zeros += 1
                } else {
                    ones += 1
                }
                if zeros == ones {
                    maxLen = max(maxLen, end - start + 1)
                }
             }
        }
        return maxLen
    }
    
    func findMaxLength1(_ nums: [Int]) -> Int {
        var arr = [Int].init(repeating: -1, count: 2 * nums.count + 1)
        arr[nums.count] = -1
        var maxLen = 0,count = 0
        for i in 0..<nums.count {
            count = count + (nums[i] == 0 ? -1: 1)
            if arr[count + nums.count] >= -1 {
                maxLen = max(maxLen, i - arr[count + nums.count])
            } else {
                arr[count + nums.count] = i
            }
        }
        return maxLen
    }
    
    func alphabetBoardPath(_ target: String) -> String {
        let board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"]
        var dict = [Character:(Int,Int)]()
        for (i,line) in board.enumerated() {
            for (j, c) in line.enumerated() {
                dict[c] = (i, j)
            }
        }
        
        var curPoint = (0,0)
        var res = ""
        for c in target {
            let targetPoint = dict[c]!
            if targetPoint.1 < curPoint.1 {
                for _ in 0..<curPoint.1 - targetPoint.1 {
                    res.append("L")
                }

            }
            
            if curPoint.0 > targetPoint.0 {
                for _ in 0..<curPoint.0 - targetPoint.0 {
                    res.append("U")
                }
            }
            if targetPoint.0 > curPoint.0 {
                for _ in 0..<targetPoint.0 - curPoint.0 {
                    res.append("D")
                }
            }

            
            if targetPoint.1 > curPoint.1 {
                for _ in 0..<targetPoint.1 - curPoint.1 {
                    res.append("R")
                }
            }


            curPoint = targetPoint
            res.append("!")
        }
        return res
    }
    
//    func countSubstrings(_ s: String, _ t: String) {
//
//    }
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dict = [Set<Character>: [String]]()
        for str in strs {
            dict[Set<Character>(str),default: []].append(str)
        }
        return [[String]](dict.values)
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var r = 0
        var a = a, b = b
        repeat {
            r = a % b
            a = b
            b = r
        } while r != 0
        return b
    }
    
    func bestLine(_ points: [[Int]]) -> [Int] {
        var dict = [[Int]: Int]()
        var dict1 = [[Int]: [Int]]()
        var maxCount = 0, res = [Int]()
        for i in 0..<points.count - 1 {
            for j in i+1 ..< points.count {
                var a = points[j][1] - points[i][1]
                var b = points[j][0] - points[i][0]
                var c = points[j][0] * points[i][1] - points[i][0] * points[j][1]
                let g = gcd(gcd(a, b), c)
                a /= g
                b /= g
                c /= g
                if dict1[[a,b,c]] == nil {
                    dict1[[a,b,c]] = [i,j]
                    dict[[a,b,c]] = 2
                } else {
                    dict[[a,b,c], default: 0] += 1
                }
                
                if dict[[a,b,c], default: 0] > maxCount {
                    maxCount = dict[[a,b,c], default: 0]
                    res = dict1[[a,b,c],default: [0,0]]
                }
            }
        }
        return res
    }
}


class RandomizedSet {

    /** Initialize your data structure here. */
    var set: Set<Int> = Set<Int>()
    init() {
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if set.contains(val) {
            return false
        }
        set.insert(val)
        return true
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        if set.contains(val) {
            set.remove(val)
            return true
        }
        return false
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        return set.randomElement()!
    }
}

