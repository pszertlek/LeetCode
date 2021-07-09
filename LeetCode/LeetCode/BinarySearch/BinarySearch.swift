//
//  main.swift
//  BinarySearch
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

class BinarySearch {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var lhs = 0, rhs = nums.count - 1, mid = 0
        while lhs <= rhs {
            mid = lhs + (rhs - lhs) / 2
            if nums[mid] == target {
                return mid
            } else if nums[lhs] < nums[rhs] {
                if nums[mid] > target {
                    rhs = mid
                } else {
                    lhs = mid + 1
                }
            } else if lhs == rhs {
                return nums[mid] == target ? mid : -1
            } else {
                if nums[lhs] <= nums[mid] {
                    if target < nums[lhs] || target > nums[mid] {
                        lhs = mid + 1
                    } else {
                        rhs = mid
                    }
                } else {
                    if target > nums[rhs] || target < nums[mid] {
                        rhs = mid
                    } else {
                        lhs = mid + 1
                    }
                }
                
            }
        }
        return -1
    }

    func binarySearch<T>(_ nums: [T], _ target: T, compare: ((Int,T),T) -> ComparisonResult) -> Int {
        var lhs = 0, rhs = nums.count - 1
        while lhs <= rhs {
            let mid = lhs + (rhs - lhs) / 2
            let result = compare((mid,nums[mid]),target)
            if result == .orderedSame {
                return mid
            } else if result == .orderedAscending {
                rhs = mid - 1
            } else {
                lhs = mid + 1
            }
        }
        return -1
    }

    func binarySearch<T: Comparable>(_ nums: [T], _ target: T) -> Int {
        var lhs = 0, rhs = nums.count - 1
        while lhs <= rhs {
            let mid = lhs + (rhs - lhs) / 2
            if nums[mid] == target {
                return mid
            } else if nums[mid] > target {
                rhs = mid - 1
            } else {
                lhs = mid + 1
            }
        }
        return -1
    }

    func binarySearch<T: Comparable>(_ nums: [T], _ target: T, _ range: (Int,Int)) -> Int {
        guard range.0 <= range.1 else {
            return -1
        }
        let mid: Int = range.0 + (range.1 - range.0) / 2
        if nums[mid] == target {
            return mid
        } else if nums[mid] > target {
            return binarySearch(nums, target, (range.0,mid - 1))
        } else {
            return binarySearch(nums, target, (mid+1,range.1))
        }
    }

    //print(search([1,2,3,4], 1))


    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 0 else {
            return [-1, -1]
        }
        var findIndex = binarySearch(nums, target, (0,nums.count - 1))
        var lower = findIndex , upper = findIndex
        while findIndex != -1 && findIndex > 0 {
            findIndex = binarySearch(nums, target, (0,findIndex - 1))
            if findIndex != -1 {
                lower = findIndex
            }
        }
        findIndex = upper
        while findIndex != -1 && findIndex < nums.count - 1  {
            findIndex = binarySearch(nums, target, (findIndex + 1,nums.count - 1))
            if findIndex != -1 {
                upper = findIndex
            }
        }
        return [lower,upper]
    }




    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        var lhs = 0, rhs = arr.count - k, mid = 0
        while lhs < rhs {
            mid = lhs + (rhs - lhs) / 2

            if (abs(arr[mid] - x) <= abs(arr[mid + k] - x)) {
                rhs = mid
            }
            else {
                lhs = mid + 1
            }
        }
        return Array(arr[lhs..<rhs+k])
    //    return arr[lhs..<rhs+k]
    }

    func myPow(_ x: Double, _ n: Int) -> Double {
        var result = 1.0, nn = n > 0 ? n : -n
        var i = nn

        while i > 0 {
            if n > 0 {
                result = result * x
            } else {
                result = result / x
            }
            i = i - 1
        }
        return result
    }


    func isPerfectSquare(_ num: Int) -> Bool {
        var lhs = 0 , rhs = num, mid = 0, result = 0
        while lhs <= rhs {
            mid = (rhs + lhs ) / 2
            result = mid * mid
            if result == num {
                return true
            } else if (lhs == rhs) {
                return false;
            }  else if result > num {
                rhs = mid
            } else {
                lhs = mid + 1
            }
        }
        
        return false
    }

    func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
        
        var lhs = 0, rhs = letters.count - 1, lastIndex = -1
        while lhs <= rhs {
            let mid = lhs + (rhs - lhs) / 2
            if letters[mid] >= target {
                rhs = mid - 1
                if letters[mid] > target {
                    lastIndex = mid
                }
            } else {
                lhs = mid + 1
            }
        }
        return lastIndex == -1 ? letters[0] : letters[lastIndex]
    }



    func findMinTemplate<T:Comparable>(_ nums: [T]) -> T {
        var lhs = 0, rhs = nums.count - 1, mid = 0
        while lhs <= rhs {
            mid = lhs + (rhs - lhs) / 2
            if nums[lhs] <= nums[rhs] {
                return nums[lhs]
            } else if rhs - lhs == 1 {
                return nums[lhs] < nums[rhs] ? nums[lhs] : nums[rhs]
            } else {
                if nums[lhs] < nums[mid]  {
                    lhs = mid + 1
                } else {
                    rhs = mid
                    
                }
            }
        }
        return nums[lhs]
    }

    func findMin(_ nums: [Int]) -> Int {
        return findMinTemplate(nums)
    }

    func mountain(_ nums: [Int]) -> Int {
        var maxIndex = 0
        for i in 0..<nums.count - 2 {
            if nums[maxIndex] < nums[i+1] {
                maxIndex = i
            }
        }
        return maxIndex
    }

    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var dict1 = [Int: Int](), result = [Int]()
        for i in nums1 {
            dict1[i] = (dict1[i] ?? 0) + 1
        }
        for i in nums2 {
            if let value = dict1[i] {
                result.append(i)
                if value > 1 {
                    dict1[i] = value - 1
                } else {
                    dict1.removeValue(forKey: i)
                }
            }
        }
        return result
    }

    func arrangeCoins(_ n: Int) -> Int {
        guard n > 1 else {
            return n
        }
        var lhs = 0, rhs = n, mid = 0
        while lhs < rhs {
            mid = (rhs + lhs) / 2
            let result = (1 + mid) * mid / 2
            if result == n {
                return mid
            } else if result > n {
                rhs = mid
            } else {
                lhs = mid + 1
            }
        }
        return lhs - 1
    }

    func findPeakElement(_ nums: [Int]) -> Int {
        var lhs = 0, rhs = nums.count - 1, mid = 0
        while lhs < rhs {
            mid = (rhs + lhs) / 2
            if mid == 0 {
                return nums[lhs] >= nums[rhs] ? lhs : rhs
            }
            
            if (mid == nums.count - 1) {
                return mid - 1
            }
            
            if nums[mid] > nums[mid + 1] && nums[mid - 1] < nums[mid] {
                lhs = (lhs + mid) / 2
                rhs = (rhs + mid) / 2
            } else if nums[mid] < nums[mid - 1] {
                rhs = mid - 1
            } else {
                lhs = mid + 1
            }
        }
        return lhs
    }


    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        for (index,i) in numbers.enumerated() {
            let tar = target - i
            let findIndex = binarySearch(numbers, tar)
            if findIndex != -1 {
                if findIndex == index {
                    if findIndex - 1 > 0 && numbers[findIndex - 1] == tar {
                        return [index,findIndex - 1]
                    } else if findIndex + 1 < numbers.count && numbers[findIndex + 1] == tar  {
                        return [index,findIndex + 1]
                    }
                } else {
                    return [index,findIndex]
                }
            }
        }
        return [0,0]
    }

    func twoSum1(_ numbers: [Int], _ target: Int) -> [Int] {
        var dict = Dictionary<Int,Int>.init(minimumCapacity: numbers.count)
        for (index,i) in numbers.enumerated() {
            let tar = target - i
            if let findIndex = dict[tar] {
                return [index, findIndex]
            }
            dict[i] = index
            
        }
        return [0,0]
    }

    func findMin1(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1 }
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            
            let mid = (left + right)/2;
            
            if nums[mid] >= nums[right] {
                
                left = mid + 1;
            } else {
                
                right = mid;
            }
        }
        
        return nums[left]
    }


    func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
        let houses = houses.sorted()
        let headerSorts = heaters.sorted()
        var result = 0, currentHeaterIndex = 0, i = 0
        func findHeater(currentHeater: Int, house: Int) -> Int {
            var index = currentHeater
            while index < headerSorts.count - 1 {
                index = index + 1
                if headerSorts[index] - result <= house && headerSorts[index] + result >= house {
                    return index
                }
            }
            return -1
        }
        
        while i < houses.count {
            if headerSorts[currentHeaterIndex] - result <= houses[i] && headerSorts[currentHeaterIndex] + result >= houses[i] {
                i = i + 1
            } else {
                let find = findHeater(currentHeater: currentHeaterIndex, house: houses[i])
                if find != -1 {
                    currentHeaterIndex = find
                    i = i + 1
                } else {
                    var index = currentHeaterIndex
                    var currentResult = Int.max
                    while index < headerSorts.count {
                        currentResult = min(abs(headerSorts[index] - houses[i]), currentResult)
                        index = index + 1
                    }
                    result = currentResult
                    i = i + 1
                }
            }

        }
        return result
    }

    /*
     给定一个包含 n + 1 个整数的数组 nums，其数字都在 1 到 n 之间（包括 1 和 n），可知至少存在一个重复的整数。假设只有一个重复的整数，找出这个重复的数。
     
     示例 1:
     
     输入: [1,3,4,2,2]
     输出: 2
     示例 2:
     
     输入: [3,1,3,4,2]
     输出: 3
     */
    
    //两种解法：一种快速指针法，复杂度O（n），二分查找法o(nlogn)
    func findDuplicate(_ nums: [Int]) -> Int {
        var left = 0, right = nums.count - 1
        while left < right {
            let mid = (left + right) / 2
            var count = 0
            for i in nums {
                if i <= mid  {
                    count = count + 1
                }
            }
            if count <= mid {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return right
    }
    
    func findDuplicate1(_ nums: [Int]) -> Int {
        var fast = nums[0], slow = nums[0]
        while true {
            fast = nums[nums[fast]]
            slow = nums[slow]
            if(slow == fast){
                fast = nums[0]; //这里也是从第一个数字开始
                while(slow != fast){  //两个下标相等，此时是两个指针第二次相遇的前一个位置，下一时刻就会相遇，返回此时的下标就是重复的数字
                    slow = nums[slow];
                    fast = nums[fast];
                }
                return slow;
            }
        }
    }
    
    func findMagicIndex(_ nums: [Int]) -> Int {
        var res = 0, N = nums.count
        while res < N {
            if res < nums[res] {
                res = nums[res]
            } else if res == nums[res] {
                return res
            } else {
                res += 1
            }
        }
        return -1
    }
    
    func maxDistance(_ position: [Int], _ m: Int) -> Int {
        let ps = position.sorted()
        func check(_ x: Int, _ position: [Int], _ m: Int) -> Bool {
            var pre = position[0], cnt = 1
            for i in 1..<position.count {
                if position[i] - pre >= x {
                    pre = position[i]
                    cnt += 1
                }
            }
            return cnt >= m
        }
        
        var left = 1, right = ps.last!, ans = -1
        while left <= right {
            let mid = (left + right) / 2
            if check(mid, ps, m) {
                ans = mid
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return ans
    }
    

}
