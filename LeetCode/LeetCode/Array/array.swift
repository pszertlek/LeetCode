//
//  main.swift
//  Array
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018 Pszertlek. All rights reserved.
//

import Foundation


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
    var i = m - 1, j = n - 1
    while i + j + 1 >= 0 && j != -1 {
        if i >= 0 && nums1[i] >= nums2[j]{
            nums1[i + j + 1] = nums1[i]
            i = i - 1
        } else {
            nums1[i + j + 1] = nums2[j]
            j = j - 1
        }
    }
}

func isAnagram(_ s: String, _ t: String) -> Bool {
    
    guard s.count == t.count else {
        return false
    }
    var dictS = [Character: A](), dictT = [Character: A]()
    var indexs = [(Character,Int)](), indext = [(Character,Int)]()
    class A {
        var array = [Int]()
    }
    for (index,c) in s.enumerated() {
        var array: A!
        if  dictS[c] != nil {
            array = dictS[c]
        } else {
            array = A()
            indexs.append((c,index))
            dictS[c] = array
        }
        array.array.append(index)
    }

    for (index,c) in t.enumerated() {
        var array: A!
        if  dictT[c] != nil {
            array = dictT[c]
        } else {
            array = A()
            indext.append((c,index))
            dictT[c] = array
        }
        array.array.append(index)
    }
    guard indext.count == indexs.count else {
        return false
    }
    for i in 0..<indexs.count {
        
        if (dictS[indexs[i].0]!.array != dictT[indext[i].0]!.array) {
            return false
        }
    }
    
    return true
}


func frequencySort(_ s: String) -> String {
    var dict = [Character: Int]()
    for i in s {
        dict[i] = (dict[i] ?? 0 ) + 1
    }

    let keys = dict.keys.sorted(by: { dict[$0]! >= dict[$1]! } )
    var s = ""
    for key in keys {
        for _ in 0..<dict[key]! {
            s.append(key)
        }
    }
    return s
}

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for (index,i) in nums.enumerated() {
        dict[i] = index
    }
    for (index,i) in nums.enumerated() {
        if let j = dict[target - i], index != j {
            return [index,j]
        }
    }
    return [0,0]
}


func threeSum(_ nums: [Int]) -> [[Int]] {
    
    var dict = [Int: Int]()
    for (index,i) in nums.enumerated() {
        dict[i] = index
    }
    var result = Set<[Int]>()
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if let index = dict[0 - nums[i] - nums[j]], index > i, index > j {
                let element = [nums[i],nums[j],nums[index]].sorted()
                result.insert(element)
            }
        }
    }
    
    return Array(result)
}

extension Array: Hashable where Element: Hashable {
    public var hashValue: Int {
        var hash = 0
        for i in self {
            hash = hash ^ i.hashValue
        }
        return hash
        
    }
    public func hash(into hasher: inout Hasher) {
        
    }
    
}


func firstUniqChar(_ s: String) -> Int {
    var dict = [Character: Int]()
    for c in s {
        dict[c] = (dict[c] ?? 0) + 1
    }
    for (index, c) in s.enumerated() {
        if dict[c]! == 1 {
            return index
        }
    }
    return 0
}

func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    guard nums.count > 1 && k != 0 else {
        return false
    }
    let s = k >= nums.count - 1 ? nums.count - 1: k
    var set = Set<Int>(Array(nums[0...s]))
    if set.count < s + 1 {
        return true
    }
    for i in 1..<nums.count - s {
        set.remove(nums[i - 1])
        if set.contains(nums[i + s]) {
            return true
        } else {
            set.insert(nums[i + s])
        }
    }
    return false
    
}

func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
    var dict = [String: Int].init(minimumCapacity: list1.count)
    var dict1 = [String: Int].init(minimumCapacity: max(list1.count, list2.count))
    
    
    for (index,s) in list1.enumerated() {
        dict[s] = index
    }
    var minIndex = list2.count + list1.count
    for (index,s) in list2.enumerated() {
        if let firstIndex = dict[s] {
            let sum = firstIndex + index
            minIndex = min(minIndex, sum)
            dict1[s] = sum
        }
    }
    var array = [String]()
    for (key,value) in dict1 {
        if value == minIndex {
            array.append(key)
        }
    }
    return array
}

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var result = [String:Int]()
    var resutltArray = [[String]]()
    for i in strs {
        let hash = String(i.sorted())
        if let index = result[hash] {
            result[hash] = index
            resutltArray[index].append(i)
        } else {
            var array = [String]()
            resutltArray.append(array)
            result[hash] = resutltArray.count - 1
            resutltArray[resutltArray.count - 1].append(i)
        }
    }
    return  resutltArray
}

func isValidSudoku(_ board: [[Character]]) -> Bool {
    for i in board {
        var set = Set<Character>.init(minimumCapacity: 9)
        for c in i {
            if c != "." {
                if set.contains(c) {
                    return false
                } else {
                    set.insert(c)
                }
            }
        }
    }
    for i in 0..<9 {
        var set = Set<Character>.init(minimumCapacity: 9)
        for j in 0..<9 {
            let c = board[j][i]
            if c != "." {
                if set.contains(c) {
                    return false
                } else {
                    set.insert(c)
                }
            }
        }
    }
    for i in 0..<3 {
        for j in 0..<3 {
            let x = i * 3
            let y = j * 3
            var set = Set<Character>.init(minimumCapacity: 9)
            for n in 0..<9 {
                let c = board[y + n / 3][x + n % 3]
                if c != "." {
                    if set.contains(c) {
                        return false
                    } else {
                        set.insert(c)
                    }
                }
            }
        }
    }
    
    return true
}


func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    var sortNums = nums.sorted()
    var closest = Int.max
    for i in 0..<sortNums.count {
        var left = i,right = sortNums.count - 1
        while left < right {
            let minus = sortNums[left] + sortNums[right] + sortNums[i]
            if abs(target - minus) < abs(target - closest) {
                closest = minus
            }
            if minus > target {
                left = left + 1
            } else {
                right = right - 1
            }
            if closest == 0 {
                return 0
            }
        }
    }
    return closest
}



func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
    let wordArray = paragraph.components(separatedBy: CharacterSet(charactersIn: ",. "))
    let bannedSet = Set(banned)
    var dict = [String: Int]()
    var maxNum = 0, currentString: String!
    for w in wordArray {
        if w.count == 0 {
            continue
        }
        let word = w.lowercased()
        dict[word] = (dict[word] ?? 0 ) + 1
        if !bannedSet.contains(word) {
            if maxNum < dict[word]! {
                maxNum = dict[word]!
                currentString =  word
            }
        }
    }
    return currentString
}


func compress(_ chars: inout [Character]) -> Int {
    var currentStart = 0, current: Character!, currentCount = -1
    
    
    for (_, c) in chars.enumerated() {
        if current != c {
            if currentCount > 1 {
                chars[currentStart] = current
                let countString = "\(currentCount)"
                chars.replaceSubrange(Range<Int>.init(currentStart + 1 ..< currentStart + currentCount), with: countString)
                currentStart = countString.count + currentStart + 1
            } else if currentCount == 1 {
                chars[currentStart] = current
                currentStart = currentStart + 1
            }
            current = c
            currentCount = 1
        } else {
            currentCount = currentCount + 1
        }
    }
    if currentCount > 1 {
        chars[currentStart] = current
        let countString = "\(currentCount)"
        chars.replaceSubrange(Range<Int>.init(currentStart + 1 ..< currentStart + currentCount), with: countString)
        currentStart = countString.count + currentStart + 1
    } else if currentCount == 1 {
        chars[currentStart] = current
        currentStart = currentStart + 1
    }
    return currentStart
}

postfix func -- (_ num: inout Int) -> Int {
    num = num - 1
    return num
}


postfix func ++ (_ num: inout Int) -> Int {
    num = num + 1
    return num
}

func ss(_ n: Int) -> Int{
    var r = 0, l = 31, result = 0
    while r < l {
        result = (( n & (1<<r)) << (31 - r)) | result;
        result = ((n & (1<<l)) >> (31 - l)) | result;
        r++;
        l--;
    }
    return result
}


func findWords(_ words: [String]) -> [String] {
    let set1 = Set("qwertyuiop")
    let set2 = Set("asdfghjkl")
    let set3 = Set("zxcvbnm")

    var result = [String]()
    for word in words {
        let wordSet = Set(word.lowercased())
        if set1.isSuperset(of: wordSet) || set2.isSuperset(of: wordSet) || set3.isSuperset(of: wordSet) {
            result.append(word)
        }
        
    }
    return result
}


/*实现获取下一个排列的函数，算法需要将给定数字序列重新排列成字典序中下一个更大的排列。
 
 如果不存在下一个更大的排列，则将数字重新排列成最小的排列（即升序排列）。
 
 必须原地修改，只允许使用额外常数空间。
 
 以下是一些例子，输入位于左侧列，其相应输出位于右侧列。
 1,2,3 → 1,3,2
 3,2,1 → 1,2,3
 1,1,5 → 1,5,1*/

func next(_ nums: inout [Int]) {
    
}

func trap(_ height: [Int]) -> Int {
    var maxR = Array<Int>(repeating: 0, count: height.count)
    var currentMax = 0
    var i = height.count - 1
    while i >= 0 {
        if height[i] > currentMax {
            currentMax = height[i]
            maxR[i] = currentMax
        } else {
            maxR[i] = currentMax
        }
        i = i - 1
    }
    currentMax = 0
    var sum = 0
    for (index, n) in height.enumerated() {
        if n < currentMax {
            let max = min(maxR[index], currentMax) - n
            sum = sum + max
        } else {
            currentMax = n
        }
    }
    return sum
}

class Solution {
//    func sortArrayByParity(_ A: [Int]) -> [Int] {
//
//    }

}
func sortArrayByParity(_ A: [Int]) -> [Int] {
    var nums = A
    var last = nums.count - 1
    
    for (index,i) in nums.enumerated() {
        if i % 2 != 0 {
            while index < last && nums[last] % 2 != 0 {
                last = last - 1
            }
            nums[index] = nums[last]
            nums[last] = i
        }
    }
    return nums
    
}

var a = [1,3,2,4]
func transpose(_ A: [[Int]]) -> [[Int]] {
    var column = A.count
    var row = A.first!.count
    
    var result = [[Int]]()
    var i = 0, j = 0
    while i < row {
        var array = [Int]()
        j = 0
        while j < column {
            array.append(A[j][i])
            j = j + 1
        }
        result.append(array)
        i = i + 1
    }
    return result
}

func matrixReshape(_ nums: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
    guard r * c == nums.count * nums.first!.count else {
        return nums
    }
    var result = [[Int]]()
    for i in 0..<r {
        var array = [Int]()
        for j in 0..<c {
            let row = (j + i * c) % nums.first!.count
            let column = (j + i * c) / nums.first!.count
            array.append(nums[column][row])
        }
        result.append(array)
    }
    return result
}


func flipAndInvertImage(_ A: [[Int]]) -> [[Int]] {
    var result = [[Int]]()
    let count = A.count;
    for i in 0..<count {
        var array = [Int]()
        for j in 0..<A[i].count {
            array.append(1 - A[i][A[i].count - 1 - j])
        }
        result.append(array)
    }
    return result
}

func sortArrayByParityII(_ A: [Int]) -> [Int] {
    var result = A
    for i in 0..<A.count {
        if i % 2 != result[i] % 2 {
            var j = i + 1
            while i % 2 != result[j] % 2 {
                j = j + 2
            }
            result.swapAt(i, j)
        }
    }
    return result
}

func fib(_ N: Int) -> Int {
    if N == 0 {
        return 0
    } else if N == 1 {
        return 1
    }
    return fib(N - 1) + fib(N - 2)
}



func largestPerimeter(_ A: ContiguousArray<Int>) -> Int {
    var aa = A.sorted()
    var largest = 0
    var i = A.count - 3
    while i >= 0 {
        if (aa[i] + aa[i + 1] > aa[i + 2]) {
            largest = aa[i] + aa[i + 1] + aa[i + 2]
            break;
        }
        i = i - 1
    }
    return largest
}



func isMonotonic(_ A: [Int]) -> Bool {
    guard A.count > 2 else {
        return true
    }
    var isIncrease = true
    if A[0] > A.last! {
        isIncrease = false
    }
    var i = 0
    let compareNum: (Int,Int) -> Bool = !isIncrease ? { $0 < $1 } : { $0 > $1}
    while i < A.count-1 {
        if (compareNum(A[i], A[i+1])){
            return false
        }
        i = i + 1
    }
    return true
}

func largeGroupPositions(_ S: String) -> [[Int]] {
    var currentStart = 0
    var currentEnd = 0
    var currentChar: Character = "\n"
    var result = [[Int]]()
    for (index,char) in S.enumerated() {
        if char != currentChar {
            if currentEnd - currentStart >= 2 {
                result.append([currentStart,currentEnd])
            }
            currentStart = index
            currentEnd = index
            currentChar = char
        } else {
            currentEnd = index
        }
    }
    if currentEnd - currentStart >= 2 {
        result.append([currentStart,currentEnd])
    }
    return result
}

func maxDistToClosest(_ seats: [Int]) -> Int {
    var lastSitIndex = 0
    var largestLeft = 0
    var largestRight = 0
    var largest = 0
    for (index, i) in seats.enumerated() {
        if i == 1 {
            largestLeft = index - lastSitIndex
            break;
        }
    }
    var i = seats.count - 1
    lastSitIndex = seats.count - 1
    while i >= 0 {
        if seats[i] == 1 {
            largestRight = lastSitIndex - i
            break;
        }
        i = i - 1
    }
    lastSitIndex = largestLeft
    for i in largestLeft ..< seats.count - largestRight {
        if seats[i] == 1 {
            largest = max(largest, i - lastSitIndex)
            lastSitIndex = i
        }
    }
    
    return max(largestLeft, largestRight, largest / 2)
    /*
     let count = seats.count
     var left = -1
     var dis = 0
     for i in 0..<count {
     if seats[i] == 1 { // 有人
     if left == -1 {
     dis = max(dis, i - left - 1)
     } else {
     dis = max(dis, (i - left) / 2)
     }
     left = i
     }
     }
     dis = max(dis, count - 1 - left)
     return dis*/
}

func validMountainArray(_ A: [Int]) -> Bool {
    guard A.count >= 3 else {
        return false
    }
    var i = 0, j = A.count - 1
    var cha = A.count - 1
    while i + 1 <= j {
        if A[i + 1] > A[i] {
            i = i + 1
        }
        if (A[j] < A[j - 1]) {
            j = j - 1
        }
        if (cha == j - i) {
            return j - i == 0
        } else {
            cha = j - i
        }
    }
    return i != 0 && j != A.count - 1
}

func sortedSquares(_ A: [Int]) -> [Int] {
    var zeroIndex = 0
    for (index, i) in A.enumerated() {
        if i >= 0 {
            zeroIndex = index
            break
        }
    }
    var result = [Int]()
    var upIndex = 0
    var littleIndex = 0
    for _ in 0..<A.count {
        let upUpIndex = zeroIndex + upIndex, downIndex = zeroIndex - littleIndex - 1
        
        if upUpIndex < A.count && downIndex >= 0 {
            if A[upUpIndex] + A[downIndex] > 0 {
                result.append(A[downIndex] * A[downIndex])
                littleIndex = littleIndex + 1
            } else {
                result.append(A[upUpIndex] * A[upUpIndex])
                upIndex = upIndex + 1
            }
        } else if upUpIndex < A.count {
            result.append(A[upUpIndex] * A[upUpIndex])
            upIndex = upIndex + 1

        } else if downIndex >= 0 {
            result.append(A[downIndex] * A[downIndex])
            littleIndex = littleIndex + 1
        }
    }
    return result
}

print(sortedSquares([0]))

print(sortedSquares([-2,-1,0,1,2,3,4]))
print(sortedSquares([-7,-3,2,3,11]))
