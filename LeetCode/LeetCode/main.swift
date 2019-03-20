//
//  main.swift
//  LeetCode
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

import Foundation

print(Backtracking().subsets1([1,2,3]))


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

//print(kSmallestPairs([1,7,11], [2,4,6], 3))
//print(kSmallestPairs([1,1,2], [1,2,3], 2))
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
//print(reorganizeString("cnwnznunhnqnbivififititxkxkxgxglelelamamomopjpjpcc"))
//print(reorganizeString("zrhmhyevkojpsegvwolkpystdnkyhcjrdvqtyhucxdcwm"))
//print(reorganizeString("aabb"))
//print(reorganizeString("aab"))
//print(reorganizeString("aaba"))
//print(reorganizeString("aabc"))
//print(reorganizeString("aaabcd"))
//print(reorganizeString("bfrbs"))
//print(reorganizeString("ogccckcwmbmxtsbmozli"))
//print(reorganizeString("tndsewnllhrtwsvxenkscbivijfqnysamckzoyfnapuotmdexzkkrpmppttficzerdndssuveompqkemtbwbodrhwsfpbmkafpwyedpcowruntvymxtyyejqtajkcjakghtdwmuygecjncxzcxezgecrxonnszmqmecgvqqkdagvaaucewelchsmebikscciegzoiamovdojrmmwgbxeygibxxltemfgpogjkhobmhwquizuwvhfaiavsxhiknysdghcawcrphaykyashchyomklvghkyabxatmrkmrfsppfhgrwywtlxebgzmevefcqquvhvgounldxkdzndwybxhtycmlybhaaqvodntsvfhwcuhvuccwcsxelafyzushjhfyklvghpfvknprfouevsxmcuhiiiewcluehpmzrjzffnrptwbuhnyahrbzqvirvmffbxvrmynfcnupnukayjghpusewdwrbkhvjnveuiionefmnfxao"))
