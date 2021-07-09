//
//  DoubleNodeSolution.swift
//  LeetCode
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class DoubleNodeSolution {
    func longestOnes1(_ A: [Int], _ K: Int) -> Int {
        var result = 0
        var i = 0, j = 0, start = 0
        var firstOnes = [Int]()
        while i + j < A.count {
            while j < K && i + j < A.count {
                if A[i + j] == 1 {
                    i = i + 1
                } else {
                    if (i + j >= 1 && A[i + j - 1] == 1) {
                        firstOnes.append(i + j)
                    } else {
                        firstOnes.append(0)
                    }
                    
                    j = j + 1
                }
            }
            result = max(result,i + j - start)
            while i + j < A.count {
                if A[i + j] == 1 {
                    result = max(result, i + j - start + 1)
                } else if A[start] == 0 {
                    start = start + 1
                } else  {
                    if firstOnes.count > 0 {
                        i =  firstOnes[0] + 1
                        start = i
                        j = 0
                        firstOnes.removeFirst()
                        break;
                    } else {
                        return result
                    }

                }
                i = i + 1
            }
        }
        return result
    }
    
    func longestOnes(_ A: [Int], _ K: Int) -> Int {
        let n:Int = A.count
        var pre:[Int] = [Int](repeating:0,count:n)
        for i in 0..<n
        {
            if A[i] == 0
            {
                pre[i] = 1
            }
        }
        for i in 1..<n
        {
            pre[i] = pre[i - 1] + pre[i]
        }
        print(pre)
        var fans:Int = 0
        for i in -1..<(n - 1)
        {
            var lo:Int = i + 1
            var hi:Int = n - 1
            var ans:Int = i
            while(lo <= hi)
            {
                let mid:Int = (lo + hi) / 2
                var val:Int = pre[mid]
                if i >= 0
                {
                    val -= pre[i]
                }
                if val <= K
                {
                    ans = mid
                    lo = mid + 1
                }
                else
                {
                    hi = mid - 1
                }
            }
            print(ans - i)
            fans = max(fans, ans - i)
        }
        return fans
    }
    
    
//    l = len(A)
//    zero = 0
//    lo,hi = 0,0
//    res = 0
//    for hi in range(l):
//    if A[hi] == 0:
//    zero += 1
//    while zero > k:
//    if A[lo] == 0:
//    zero -= 1
//    lo += 1
//    # print lo, hi
//    res = max(res, hi - lo + 1)
//
//    return res
    
    func longestOnes2(_ A: [Int], _ K: Int) -> Int {
        var zero = 0, lo = 0, res = 0
        for hi in 0..<A.count {
            if A[hi] == 0 {
                zero = zero + 1
            }
            while zero > K {
                if A[lo] == 0 {
                    zero = zero - 1
                }
                lo += 1
            }
            res = max(res,hi - lo + 1)
        }
        return res
    }
    
    func findLongestWord(_ s: String, _ d: [String]) -> String {
        var i = 0, j = 0
        let d = d.sorted { (s1, s2) -> Bool in
            if s1.count == s2.count {
                return s1 > s1
            } else {
                return s1.count > s2.count
            }
        }
        let dSort = d.map { (string) -> [Character] in
            return Array(string)
        }
        let s = Array(s)
        
        for ss in dSort {
            while j < ss.count && i < s.count {
                if s[i] == ss[j] {
                    j = j + 1
                }
                i = i + 1
            }
            if j == ss.count {
                return String(ss)
            }
            i = 0
            j = 0
        }
        return ""
    }
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var a = 0
        let nums = nums.sorted()
        var result = [[Int]]()
        while a < nums.count - 3 {
            var b = a + 1
            while b < nums.count - 2 {
                var c = b + 1
                while c < nums.count - 1 {
                    var d = c + 1
                    while d < nums.count {
                        if nums[a] + nums[b] + nums[c] + nums[d] == target {
                            result.append([nums[a],nums[b],nums[c],nums[d]])
                        }
                        d = d + 1
                    }
                    c = c + 1
                }
                b = b + 1
            }
            a = a + 1
        }
        return result
    }
    
    func numRescueBoats(_ people: [Int], _ limit: Int) -> Int {
        var i = 0, _ = 0, sum = 0
        var people = people.sorted()
        
        func binarySearch(_ nums: inout [Int], _ target: Int) -> Int {
            var left = 0 , right = nums.count - 1
            while left < right {
                let mid = (right + left ) / 2
                if nums[mid] == target {
                    return mid
                } else if nums[mid] > target {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            }
            return left
        }
        print(people)
        while people.count > 0 {
            sum = people[0]
            i += 1
            print("\(people[0])")
            people.remove(at: 0)

            if people.count == 0 {
                break
            }
            while people.count > 0 && sum + people[0] <= limit {
                var searchResult = binarySearch(&people, limit - sum)
                if people[searchResult] + sum == limit {
                    print("\(people[searchResult])")
                    sum += people[searchResult]
                    people.remove(at: searchResult)
                } else if people[searchResult] < limit - sum {
//                        searchResult = searchResult - 1
                    print("\(people[searchResult])")
                    sum += people[searchResult]
                    people.remove(at: searchResult)

                } else if searchResult > 0 {
                    searchResult = searchResult - 1
                    print("\(people[searchResult])")
                    sum += people[searchResult]
                    people.remove(at: searchResult)
                }
            }
            print("----------------")
        }
        return i


    }
    
    func numRescueBoats1(_ people: [Int], _ limit: Int) -> Int {
        var i = 0, j = people.count - 1 , sum = 0
        let people = people.sorted()
        
        while i <= j {
            if people[i] + people[j] > limit {
                j -= 1
            } else {
                i += 1
                j -= 1
            }
            sum += 1
        }
        
        return sum
    }
    
    
}
