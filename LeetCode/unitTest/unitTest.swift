//
//  unitTest.swift
//  unitTest
//
//  Created by apple on 2018/1/24.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import XCTest
import LeetCode
class unitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var x = [1, 100]

        XCTAssert(removeDuplicates(&x) == 2)
        var x1 = [10]
        XCTAssert(removeDuplicates(&x1) == 1)
        var x2 = [10,11,12,23,23,35,35,120]
        XCTAssert(removeDuplicates(&x2) == 6)


        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSss() {
        
    }
    
    func testadfadsf() {
        
    }
    
    func testLRU() {
        let cache = LRUCache(2);

        cache.put(1, 1);
        cache.put(2, 2);
        XCTAssertTrue(cache.get(1) == 1)
        cache.put(3, 3);    // 该操作会使得关键字 2 作废
        XCTAssertTrue(cache.get(2) == -1)       // 返回 -1 (未找到)
        cache.put(4, 4);    // 该操作会使得关键字 1 作废
        XCTAssertTrue(cache.get(1) == -1)      // 返回 -1 (未找到)
        XCTAssertTrue(cache.get(3) == 3)  // 返回  3
        XCTAssertTrue(cache.get(4) == 4)       // 返回  4

        let actions = ["LRUCache","put","put","put","put","get","get","get","get","put","get","get","get","get","get"]
        let parameters = [[3],[1,1],[2,2],[3,3],[4,4],[4],[3],[2],[1],[5,5],[1],[2],[3],[4],[5]]
        let result = [nil,nil,nil,nil,nil,4,3,2,-1,nil,-1,2,3,-1,5]
        let c = LRUCache(parameters[0][0])
        var zzz = [Int?]()
        for i in 1..<parameters.count {
            let z = lruAction(c, actions[i], parameters[i])
            zzz.append(z)
            print("\(actions[i]): \(parameters[i]) : \(z)")
            XCTAssertTrue(z == result[i])
        }
        print(zzz)
    }
    
    func lruAction(_ cache: LRUCache, _ action: String, _ parameters: [Int]) -> Int? {
        switch action {
        case "put":
            cache.put(parameters[0], parameters[1])
            return nil
        case "get":
            return cache.get(parameters[0])
        default:
            return nil
        }
    }
    
    func testCQueue() {
        let queue = CQueue()
        var arr = [1,2,3]
        for i in 0..<arr.count {
            queue.appendTail(arr[i])
        }
        for i in 0..<arr.count {
            XCTAssert(queue.deleteHead() == arr[i])
        }

    
    }
}
