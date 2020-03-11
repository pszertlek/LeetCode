//
//  main.cpp
//  BinarySearch
//
//  Created by Pszertlek on 2020/2/17.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

#include <iostream>

class Node {
public:
    int val;
    Node* left;
    Node* right;

    Node() {}

    Node(int _val) {
        val = _val;
        left = NULL;
        right = NULL;
    }

    Node(int _val, Node* _left, Node* _right) {
        val = _val;
        left = _left;
        right = _right;
    }
};
//func rebuild(_ root: TreeNode<Int>?) -> (TreeNode<Int>?, TreeNode<Int>?) {
//    guard let root = root else {
//        return (nil,nil)
//    }
//    var reLeft = rebuild(root.left).1
//    var reRight = rebuild(root.right).0
//    reLeft?.right = root
//    reRight?.left = root
//    root.left = reLeft
//    root.right = reRight
//    var left: TreeNode<Int>? = root
//    while left?.left != nil {
//        left = left?.left
//    }
//    var right: TreeNode<Int>? = root
//    while right?.right != nil {
//        right = right?.right
//    }
//    return (left, right)
//}
//let i = rebuild(root)
struct A {
    Node *first;
    Node *last;
};

class Solution {
public:
    A rebuild(Node *root) {
        if (root == NULL) {
            return A();
        }
        Node *reLeft = rebuild(root->left).last;
        Node *reRight = rebuild(root->right).first;
        if (reLeft != NULL) {
            reLeft->right = root;
        }
        if (reRight != NULL) {
            reRight->left = root;
        }
        root->left = reLeft;
        root->right = reRight;
        Node *left = root;
        while (left->left != NULL) {
            left = left->left;
        }
        Node *right = root;
        while (right->right != NULL) {
            right = right->right;
        }
        struct A a;
        a.first = left;
        a.last = right;
        return a;
    }
    Node* treeToDoublyList(Node* root) {
        A a = rebuild(root);
        a.first->left = a.last;
        a.last->right = a.first;
        return a.first;
    }
};

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    return 0;
}
