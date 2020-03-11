//
//  TreeNode.hpp
//  BinaryTreeCPlus
//
//  Created by Pszertlek on 2020/1/4.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

#ifndef TreeNode_hpp
#define TreeNode_hpp

#include <stdio.h>
#include <vector>

//using namespace std;
//struct TreeNode {
//    int val;
//    TreeNode *left;
//    TreeNode *right;
//    TreeNode(int x) :val(x),left(NULL),right(NULL) { }
//};
//
//
//class CNode {
//public:
//    int val;
//    vector<int> result;
//    vector<Node*> children;
//
//    Node() {}
//
//    Node(int _val) {
//        val = _val;
//    }
//
//    Node(int _val, vector<Node*> _children) {
//        val = _val;
//        children = _children;
//    }
//    public:
//    int maxDepth(Node* root) {
//        vector<Node *> queue = root->children;
//        int result = 1;
//        while (queue.size() > 0) {
//            result += 1;
//            vector<Node *>newQueue;
//            for(int i = 0; i < queue.size(); i++) {
//                newQueue.insert(newQueue.end(), queue[i]->children.begin(),queue[i]->children.end());
//            }
//            queue = newQueue;
//        }
//        return result;
//    }
//
//    vector<int> preorder(Node* root) {
//        if (root != NULL) {
//            result.push_back(root->val);
//            for (int i = 0; i < root->children.size(); i ++) {
//                preorder(root);
//            }
//        }
//        return result;
//    }
//
//};

#endif /* TreeNode_hpp */
