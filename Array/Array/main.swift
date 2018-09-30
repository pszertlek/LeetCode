//
//  main.swift
//  Array
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018 Pszertlek. All rights reserved.
//

import Foundation

print("Hello, World!")

func moveZeroes(_ nums: inout [Int]) {
    var zeroCount = 0
    for i in 0..<nums.count {
        if nums[i] == 0 {
            zeroCount = zeroCount + 1
        } else {
            nums[i - zeroCount] = nums[i]
        }
        
    }
    for i in nums.count - zeroCount ..< nums.count {
        nums[i] = 0
    }
}

@discardableResult
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var valCount = 0
    for i in 0..<nums.count {
        if nums[i] == val {
            valCount = valCount + 1
        } else {
            nums[i - valCount] = nums[i]
        }
        
    }
    nums.removeLast(valCount)
    return nums.count
    
}

func removeDuplicates(_ nums: inout [Int]) -> Int {
    var count = 0, current = Int.min, deleteCount = 0
    for i in 0..<nums.count {
        if nums[i] == current {
            count = count + 1
            if count > 2 {
                deleteCount = deleteCount + 1
            }
        } else {
            current = nums[i]
            count = 1
        }
        nums[i - deleteCount] = nums[i]
    }
    nums.removeLast(deleteCount)
    return nums.count
}

func sortColors(_ nums: inout [Int]) {
    var redCount = 0, whiteCount = 0, blueCount = 0
    for i in 0..<nums.count {
        if nums[i] == 0 {
            redCount = redCount + 1
            nums[redCount - 1] = 0
        } else if nums[i] == 1 {
            whiteCount = whiteCount + 1
        } else {
            blueCount = blueCount + 1
        }
    }
    for i in redCount..<redCount+whiteCount {
        nums[i] = 1
    }
    for i in redCount+whiteCount..<nums.count {
        nums[i] = 2
    }
}


func sss(_  nums:inout [Int]) -> [Int] {
    var c = Array<Int>.init(repeating: 0, count: nums.count)
    for i in 0..<nums.count {
        c[nums[i]] = c[nums[i]] + 1
    }
    var k = 3
    for i in 1..<k {
        c[i] = c[i] + c[i - 1]
    }
    var n = nums.count - 1
    var rank = Array<Int>.init(repeating: 0 , count: nums.count)
    while n > 0 {
        c[nums[n]] = c[nums[n]] - 1
        rank[c[nums[n]]] = nums[n]
    }
    return rank
}



func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var array = nums.sorted()
    var numLagest = 1,current = array.last!,i = nums.count - 1
    while i >= 0  {
        if current != array[i] {
            current = array[i]
            numLagest = numLagest + 1
        }
        if numLagest == k + 1 {
            return nums.firstIndex(of: array[i])!
        }
        i = i - 1
    }
    return 0
}


func ss(_ nums: [Int]) -> Int {
    var i = 0, j = nums.count - 1,result = 0
    while i < j {
        result = max((j - i) * min(nums[i], nums[j]),result)
        if nums[i] < nums[j] {
            i = i + 1
        } else {
            j = j - 1
        }
    }
    return result
}


//print(ss([1,8,6,2,5,4,8,3,7]))
func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    var i = 0, j = 0,minX = nums.count, sum = nums[0], match = false
    while j < nums.count {
        if i == j {
            if sum < s {
                j = j + 1
                if j == nums.count {
                    break;
                }
                sum = nums[j] + sum
            } else {
                return 1
            }
        } else {
            if sum < s {
                j = j + 1
                if j == nums.count {
                    break
                }
                sum = nums[j] + sum
            } else {
                match = true
                minX = min(j - i + 1, minX)
                sum = sum - nums[i]
                i = i + 1
            }
        }
    }
    return match ? minX : 0
}

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
    
}
