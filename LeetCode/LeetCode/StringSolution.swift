//
//  StringSolution.swift
//  LeetCode
//
//  Created by apple on 2019/5/10.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class StringSolution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        guard s3.count == s1.count + s2.count else {
            return false
        }
        var s1 = s1.utf8CString, s2 = s2.utf8CString, s3 = s3.utf8CString
        s1.removeLast()
        s2.removeLast()
        s3.removeLast()
        
        let dp111 = [Bool].init(repeating: false, count: s2.count + 1)
        var dp = [[Bool]].init(repeating: dp111, count: s1.count + 1)
        dp[0][0] = true
        for i in 1...s1.count {
            dp[i][0] = dp[i - 1][0] && (s1[i - 1] == s3[i - 1])
        }
        for i in 1...s2.count {
            dp[0][i] = dp[0][i - 1] && (s2[i - 1] == s3[i - 1])
        }
        for i in 1...s1.count {
            for j in 1...s2.count {
                dp[i][j] = ( dp[i - 1][j] && s1[i - 1] == s3[i - 1 + j] ) || (dp[i][j - 1] && s2[j - 1] == s3[j - 1 + i] )
            }
        }
        
        
        return dp[s1.count][s2.count]
    }
    
    
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var result = [String]()
        var curStartIndex = 0, curEndIndex = 0, curCount = 0
        for (index,s) in words.enumerated() {
            if curCount + s.count > maxWidth {
                let segmentNum = maxWidth - curCount + (curEndIndex - curStartIndex)
                let sectionNum = curEndIndex - curStartIndex - 1 > 0 ? curEndIndex - curStartIndex - 1 : 1
                let pinjun = segmentNum / sectionNum
                var yu = segmentNum % sectionNum
                var curString = ""
                for i in curStartIndex..<curEndIndex {
                    curString.append(words[i])
                    if i != curEndIndex - 1 {
                        let kkk = String([Character].init(repeating: " ", count: pinjun + (yu > 0 ? 1 : 0)))
                        curString.append(kkk)
                    }
                    yu = yu - 1
                }
                for _ in curString.count..<maxWidth {
                    curString.append(" ")
                }
                result.append(curString)
                curCount = s.count + 1
                curStartIndex = index
                curEndIndex = index + 1
            } else {
                curCount += s.count + 1
                curEndIndex += 1
            }
            print(curCount)
            if curEndIndex == words.count {
                var final = ""
                for i in curStartIndex..<words.count {
                    final.append(words[i])
                    if i != words.count - 1 {
                        final.append(" ")
                    }
                }
                for _ in final.count..<maxWidth {
                    final.append(" ")
                }
                result.append(final)
            }
        }

        return result
    }
    
    
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let s = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        let a = "a".unicodeScalars.first!.value
        var set = Set<String>()
        for i in words {
            var translate = ""
            for c in i.unicodeScalars {
                translate += s[Int(c.value - a)]
            }
            set.insert(translate)
        }
        return set.count
    }
    
    func numUniqueEmails(_ emails: [String]) -> Int {
        var set = Set<String>()
        for string in emails {
            var hasAdd = false, hasAt = false
            set.insert(string.filter { (c) -> Bool in
                if hasAt {
                    return true
                }
                if c == "@" {
                    hasAt = true
                    return true
                }
                if hasAdd {
                    return false
                }
                if c == "+" {
                    hasAdd = true
                    return false
                }
                if c == "." {
                    return false
                }
                return true
            })
        }
        return set.count
    }
    /*
     给定两个字符串，你需要从这两个字符串中找出最长的特殊序列。最长特殊序列定义如下：该序列为某字符串独有的最长子序列（即不能是其他字符串的子序列）。
     
     子序列可以通过删去字符串中的某些字符实现，但不能改变剩余字符的相对顺序。空序列为所有字符串的子序列，任何字符串为其自身的子序列。
     
     输入为两个字符串，输出最长特殊序列的长度。如果不存在，则返回 -1。*/
    func findLUSlength(_ a: String, _ b: String) -> Int {
        if a == b {
            return -1
        }
        return a.count > b.count ? a.count: b.count
    }

    /*给定一个由空格分割单词的句子 S。每个单词只包含大写或小写字母。
     
     我们要将句子转换为 “Goat Latin”（一种类似于 猪拉丁文 - Pig Latin 的虚构语言）。
     
     山羊拉丁文的规则如下：
     
     如果单词以元音开头（a, e, i, o, u），在单词后添加"ma"。
     例如，单词"apple"变为"applema"。
     
     如果单词以辅音字母开头（即非元音字母），移除第一个字符并将它放到末尾，之后再添加"ma"。
     例如，单词"goat"变为"oatgma"。
     
     根据单词在句子中的索引，在单词最后添加与索引相同数量的字母'a'，索引从1开始。
     例如，在第一个单词后添加"a"，在第二个单词后添加"aa"，以此类推。
     返回将 S 转换为山羊拉丁文后的句子。*/
    
    func toGoatLatin(_ S: String) -> String {
        var result = ""
        let yuany = "aeiouAEIOU"
        var set = Set<UInt32>()
        let kong = " ".unicodeScalars.first!.value
        for c in yuany.unicodeScalars {
            set.insert(c.value)
        }
        var start = ""
        var end = ""
        var index = 0
        for (i,c) in S.unicodeScalars.enumerated() {

            if c.value == kong || i == S.count - 1 {
                index += 1
                if start.count == 1 && set.contains(start.unicodeScalars.first!.value) {
                    result.append("\(start)\(end)")
                } else {
                    if i == S.count - 1 {
                        result.append("\(end)\(Character(c))\(start)")
                    } else {
                        result.append("\(end)\(start)")

                    }
                }
                start = ""
                end = ""
                if i != S.count - 1 {
                    result.append("ma")
                    result.append(contentsOf: Array<Character>.init(repeating: "a", count: index))
                    result.append(" ")
                } else {
                    result.append("ma")
                    result.append(contentsOf: Array<Character>.init(repeating: "a", count: index))

                }

            } else {
                if start.count == 0 {
                    start.append(Character(c))
                } else {
                    end.append(Character(c))
                }
            }
        }
        return result
    }
    
    func reverseWords(_ s: String) -> String {
        guard s.count > 0 else {
            return ""
        }
        let kong = " ".unicodeScalars.first!.value
        var result = [[Character]]()
        var ccc = [Character]()

        for i in s.unicodeScalars {
            if i.value == kong {
                result.append(ccc)
                ccc = [Character]()
            } else {
                ccc.append(Character(i))
            }
        }
        result.append(ccc)
        var resultString = ""
        for (index,i) in result.enumerated() {
            resultString += String(i.reversed())
            if index < result.count - 1 {
                resultString += " "
            }
        }
        return resultString
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var dict = [Character:Int]()
        var length = 0, start = 0
        for (index, c) in s.enumerated() {
            if let ii = dict[c] {
                start = start > ii ? start : ii + 1
                dict[c] = index
            } else {
                dict[c] = index
            }
            length = max(length, index - start + 1)

        }
        return length
    }
    
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 1 else {
            if strs.count == 1 {
                return strs[0]
            } else {
                return ""
            }
        }
        var sss = [[Character]]()
        for str in strs {
            sss.append(Array<Character>(str))
        }
        let cc = sss[0]
        for (index,c) in cc.enumerated() {
            for i in 1..<strs.count {
                if (index > sss[i].count - 1 || sss[i][index] != c) {
                    return String(cc.prefix(index))
                }
                
            }
        }
        return String(cc)
    }
    
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        if s2.count < s1.count {
            return false
        }
        
        
        var dict = [Character: Int]()
        for i in s1 {
            dict[i] = 1 + (dict[i] ?? 0)
        }
        let cc2 = Array<Character>(s2)
        var dict2 = [Character: Int]()
        var left = 0,right = s1.count - 1
        for i in 0..<s1.count {
            dict2[cc2[i]] = 1 + (dict2[cc2[i]] ?? 0)
        }
        while right < s2.count {
            if dict == dict2 {
                return true
            } else  {
                let count = dict2[cc2[left]]! - 1
                dict2[cc2[left]] = count == 0 ? nil : count
                left = left + 1
                if right < s2.count - 1 {
                    right = right + 1
                    dict2[cc2[right]] = (dict2[cc2[right]] ?? 0) + 1
                } else {
                    break
                }

            }
        }
        return false
    }
    
    func multiply(_ num1: String, _ num2: String) -> String {
        var result = [UInt32].init(repeating: 0, count: num1.count + num2.count)
        let zero = Character("0").unicodeScalars.first!.value
        for (index,i) in num1.unicodeScalars.reversed().enumerated() {
            for (jIndex,j) in num2.unicodeScalars.reversed().enumerated() {
                let cs = (i.value - zero) * (j.value - zero) + result[index + jIndex]
                
                result[index + jIndex] = cs % 10
                result[index + jIndex + 1] = cs / 10 + result[index + jIndex + 1]
            }
        }
        var firstNonzero = false
        var ss = ""
        for i in result.reversed() {
            if firstNonzero {
                ss += "\(i)"
            } else if i != 0 {
                ss += "\(i)"
                firstNonzero = true
            }
        }
        return ss.count == 0 ? "0" : ss
    }
    
    
    func simplifyPath(_ path: String) -> String {
        let components = path.components(separatedBy: "/")
        var results: [String] = []
        for (_,i) in components.enumerated() {
            if i.count != 0 {
                if i == ".." {
                    if results.count > 0 {
                        results.removeLast()
                    }
                } else if i == "." {
                    
                } else {
                    results.append(i)
                }

            }
        }
        var result = ""

        for i in results {
            result.append("/\(i)")
        }
        if result.count == 0 {
            return "/"
        }
        return result
    }
    
    func restoreIpAddresses(_ s: String) -> [String] {
        let ss = Array(s)
        var n = 0
        n = n + 1
        var result: [String] = []
        func huishuoss(ip: [String], count: Int) {
            if ip.count < 5 {
                if ip.count == 4 && count == s.count {
                    result.append(ip.joined(separator: "."))
                } else {
                    if s.count - count >= (4 - ip.count) &&
                        s.count - count <= 3 * (4 - ip.count) {
                        if s.count >= count + 1 {
                            huishuoss(ip: ip + [String(ss[count])], count: count + 1)
                        }
                        if s.count >= count + 2 {
                            let str = String(ss[count...count + 1])
                            if let ii = Int(str), ii > 9 {
                                huishuoss(ip: ip + [String(str)], count: count + 2)
                            }
                        }
                        if s.count >= count + 3 {
                            let str = String(ss[count...count + 2])
                            if let ii = Int(str), ii <= 0xff, ii > 99 {
                                huishuoss(ip: ip + [str], count: count + 3)
                            }
                        }
                    }
                }
            }
        }
        huishuoss(ip: [], count: 0)
        return result
    }

    func repeatedSubstringPattern(_ s: String) -> Bool {
        let N = s.count
        guard N > 1 else {
            return false
        }
        var sub = [Character]()
        sub.append(s.first!)
        let s = [Character](s)
        var i = 1
        while i < N {
            if s[i] != sub[i % sub.count] {
                var j = sub.count
                while j < N / 2 {
                    if N % (j + 1) == 0 {
                        sub.append(contentsOf: s[sub.count...j])
                        i = j + 1
                        break
                    } else {
                        j += 1
                    }
                }
                if j == sub.count || (s.count % 2 == 1 && j == s.count / 2) {
                    return false
                }
            } else {
                i += 1
            }
            
        }
        return true
    }
    
    func findItinerary(_ tickets: [[String]]) -> [String] {
        var dict = [String: PriorityQueue<String>]()
        var res = [String]()
        for ticket in tickets {
            dict[ticket[0],default: PriorityQueue<String>.init(sort: <)].enqueue(element: ticket[1])
        }

        func dfs(_ curr: String) {
            while dict.keys.contains(curr) && dict[curr,default: PriorityQueue<String>.init(sort: <)].count > 0 {
                if let tmp = dict[curr]?.dequeue() {
                    dfs(tmp)
                }
            }
            res.append(curr)
        }
        dfs("JFK")
        return res.reversed()
    }
    
    func findItinerary_arr(_ tickets: [[String]]) -> [String] {
        var dict = [String: [String]]()
        var indexDict = [String: Int]()
        
        for ticket in tickets {
            dict[ticket[0],default: []].append(ticket[1])
            indexDict[ticket[0]] = 0
        }
        for key in dict.keys {
            dict[key]?.sort()
        }
        var res: [String] = []
        func dfs(_ curr: String) {
            while let arr = dict[curr],
                  let index = indexDict[curr],
                  index < arr.count {
                let tmp = arr[index]
                indexDict[curr] = index + 1
                dfs(tmp)
            }
            res.append(curr)
        }
        dfs("JFK")
        return res.reversed()
    }
}

