//
//  main.cpp
//  LeetcodeCpp
//
//  Created by Apple on 2020/7/3.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
TreeNode *ancestor;
TreeNode *pNode;
TreeNode *qNode;
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        this->pNode = p;
        this->qNode = q;
        postOrder(root);
        return ancestor;
    }

    int postOrder(TreeNode *root) {
        if (ancestor != NULL) {
            return 3;
        }
        if (root == NULL) {
            return 0;
        }
        int i = postOrder(root->left);
        int j = postOrder(root->right);
        int result = i | j;
        if (root->val == pNode->val) {
            result = result | 1 ;
        } else if (root->val == qNode->val) {
            result = result | 2;
        }
        if (result == 3) {
            ancestor = root;
        }
        return result;
    }

};

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    

    return 0;
}

