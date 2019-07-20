//
//  HashSolution.swift
//  LeetCode
//
//  Created by apple on 2019/5/5.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class HashSolution {
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
            
            for (index,i) in domains.enumerated() {
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
}
