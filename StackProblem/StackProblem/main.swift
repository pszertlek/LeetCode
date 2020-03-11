//
//  main.swift
//  StackProblem
//
//  Created by apple on 2018/2/26.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

import Foundation

print("Hello, World!")

let problem = StackProblem()
let stock = StockSpanner()

//for i in [100,80,60,70,60,75,85] {
//    print(stock.next(i))
//}

//for i in [1,1,1,1,1,1,1,1,1] {
//    print(stock.next(i))
//
//}
print(problem.sumSubarrayMins([3,1,2,4]))
print(problem.sumSubarrayMins([48,87,27]))
//print(problem.asteroidCollision([5,10,-5]))
//print(problem.asteroidCollision([8,-8]))
//print(problem.asteroidCollision([10,2,-5]))
//print(problem.asteroidCollision([-2,-1,1,2]))
