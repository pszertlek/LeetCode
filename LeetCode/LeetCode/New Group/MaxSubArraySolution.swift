//
//  MaxSubArraySolution.swift
//  LeetCode
//
//  Created by apple on 2019/7/19.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

class MaxSubArraySolution {
    //最大子序和
    /*
     1.查找出所有正数
     2.正数之间查找所有和大于0的区间和比较
     */
    
    func maxSubArray(_ nums: [Int]) -> Int {
        var positiveNums = [Int]()
        var maxSum = Int.min
        for (index, i) in nums.enumerated() {
            if i >= 0 {
                positiveNums.append(index)
            } else {
                maxSum = max(maxSum, i)
            }
        }
        guard positiveNums.count > 0 else {
            return maxSum
        }
        maxSum = 0
        var curSum = 0
        var curPositiveIndex = 0
        while curPositiveIndex < positiveNums.count {
            maxSum = max(maxSum, curSum + nums[positiveNums[curPositiveIndex]])
            if curPositiveIndex + 1 < positiveNums.count {
                for index in positiveNums[curPositiveIndex]..<positiveNums[curPositiveIndex + 1] {
                    curSum += nums[index]
                }
                if curSum < 0 {
                    curSum = 0
                }
            }
            curPositiveIndex += 1
        }
        return maxSum
    }
    
    func maxSubArray1(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var maxSum = nums[0]
        var length = 0
        for index in 0..<nums.count {
            if length > 0 {
                length += nums[index]
            } else {
                length = nums[index]
            }
            if maxSum < length {
                maxSum = length
            }
        }
        return maxSum
    }
    
    //分治法
    
    func masSubArrayFZF(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
        var maxLeftSum = 0, maxRightSum = 0
        var maxLeftBorderSum = 0, maxrightBorderSum = 0
        var leftBorderSum = 0, rightBorderSum = 0
        if left == right {
            if nums[left] > 0 {
                return nums[left]
            } else {
                return 0
            }
        }
        var mid = (left + right) / 2 , i = 0
        maxLeftSum = masSubArrayFZF(nums, left, mid)
        maxRightSum = masSubArrayFZF(nums, mid, right)
        maxLeftBorderSum = 0
        leftBorderSum = 0
        for i in stride(from: mid, through: left, by: -1) {
            leftBorderSum += nums[i]
            if leftBorderSum > maxLeftBorderSum {
                maxLeftBorderSum = leftBorderSum
            }
        }
        maxrightBorderSum = 0
        rightBorderSum = 0
        for i in mid+1...right {
            rightBorderSum += nums[i]
            if rightBorderSum > maxrightBorderSum {
                maxrightBorderSum = rightBorderSum
            }
        }
        return max(maxLeftSum, maxRightSum, maxLeftBorderSum + maxrightBorderSum)
    }
    
    func maxSubArrayFZ(_ nums: [Int]) -> Int {
        return masSubArrayFZF(nums, 0, nums.count - 1)
    }
}


class TriangleMiniSolution {
    /*
     [
     [2],
     [3,4],
     [6,5,7],
     [4,1,8,3]
     ]
     */
    
    
    //迭代法，超出时间限制
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        
        func mini(_ x: Int, _ y: Int) -> Int {
            if x < triangle.count {
                let left = triangle[x][y] + mini(x + 1, y)
                let right = triangle[x][y] + mini(x + 1, y + 1)
                return min(left, right)
            } else {
                return 0
            }
        }
        return mini(0, 0)
    }
    
    func minimumTotal1(_ triangle:[[Int]]) -> Int {
        let n = triangle.count
        var dp = triangle.last!
        for i in stride(from: n - 2, through: 0, by: -1) {
            for j in 0...i {
                dp[j] = min(dp[j], dp[j + 1]) + triangle[i][j]
            }
        }
        return dp[0]
    }
    
    func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
        var result = 1
        let evelopesSize = envelopes.count
        if evelopesSize == 0 {
            return 0
        }
        var dp = [Int].init(repeating: 1, count: evelopesSize)
        let envelopes = envelopes.sorted { (one, two) -> Bool in
            if one[0] == two[0] {
                return one[1] <= two[1]
            } else {
                return one[0] < two[0]
            }
        }
        
        for beginIndex in 1..<evelopesSize {
            for scanIndex in 0..<beginIndex {
                if envelopes[scanIndex][0] < envelopes[beginIndex][0] &&
                    envelopes[scanIndex][1] < envelopes[beginIndex][1] {
                    dp[beginIndex] = max(dp[beginIndex], dp[scanIndex] + 1)
                }
            }
            result = max(result, dp[beginIndex])
        }
        return result
    }
    /*
 
    static bool myCmp(pair<int, int> &one, pair<int, int> &two){
    if (one.first == two.first){
    return one.second <= two.second;
    }
    else{
    return one.first <= two.first;
    }
    }
    int maxEnvelopes(vector<pair<int, int>>& envelopes) {
    int result = 1;
    int envelopesSize = envelopes.size();
    if (envelopesSize == 0){
    return 0;
    }
    vector<int> dp(envelopesSize, 1);//dp[i]表示第i个信封能套的信封个数（包括自己）
    sort(envelopes.begin(), envelopes.end(), myCmp);//按照宽为主次序，高为辅次序,升序排序
    //开始动态规划
    for (int beginIndex = 1; beginIndex < envelopesSize; ++beginIndex){
    for (int scanIndex = 0; scanIndex < beginIndex; ++scanIndex){
    if(envelopes[scanIndex].first < envelopes[beginIndex].first && envelopes[scanIndex].second < envelopes[beginIndex].second){
    //动态转移方程
    dp[beginIndex] = max(dp[beginIndex], dp[scanIndex] + 1);
    }
    }
    result = max(result, dp[beginIndex]);
    }
    return result;
    }
    ---------------------
    作者：hestyle
    来源：CSDN
    原文：https://blog.csdn.net/qq_41855420/article/details/88554023
    版权声明：本文为博主原创文章，转载请附上博文链接！*/

    
}
