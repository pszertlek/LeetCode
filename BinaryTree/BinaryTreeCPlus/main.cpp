//
//  main.cpp
//  BinaryTreeCPlus
//
//  Created by Pszertlek on 2020/1/4.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

#include <iostream>
#include <Vector>
#include "TreeNode.hpp"
#include <map>
#include <pair>

using namespace std;

class CustomFunction {
public: int f(int x, int y) {
        return x + y;
    }
};


class Node {
public:
    int val;
    Node *next;
    Node *random;
    Node(int _val) {
        val = _val;
        next = NULL;
        random = NULL;
    }
    
    Node *copyRandomList(Node *head) {
        map<Node *, vector<int>> dict;
        vector<Node *> oldArr;
        vector<Node *> newArr;

        Node *res = new Node(0);
        Node *node = res;
        int i = 0;
        for (i = 0; head != NULL; i++, head = head->next) {
            node->next = new Node(head->val);
            oldArr.push_back(head);
            newArr.push_back(node);
            if (dict.find(<#const key_type &__k#>)) {
                
            } else {
                
            }
            dict[head->random] = i;
        }
        for (int j = 0; j < i; j ++) {
            
        }
        return NULL;
    }
};

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
//    hammingWeight(33232);

    return 0;
}
