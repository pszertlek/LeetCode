//
//  main.cpp
//  CPlusCode
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

#include <iostream>
#include <math.h>
struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};
 struct TreeNode {
    int val;
    TreeNode *left;
        TreeNode *right;
        TreeNode(int x) : val(x), left(NULL), right(NULL) {}
    };

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("%d",firstBadVersion(2));
    std::cout << "Hello, World!\n";
    return 0;
}


