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
    
}
