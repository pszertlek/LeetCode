//
//  main.cpp
//  Cpp
//
//  Created by Pszertlek on 2020/1/30.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

#include <iostream>
#include <vector>
#include <stack>
#include <map>
#include <unordered_map>
using namespace std;

vector<int> nextGreaterElements(vector<int>& nums) {
    stack<int> st;
    vector<int> result;
    vector<int> increaseArr;
    int n = nums.size();
    for(int i = 0; i < n; i++) {
        while (st.size() > 0 && nums[st.top()] < nums[i]) {
            result[st.top()] = nums[i];
            st.pop();
        }
        result.push_back(-1);
        st.push(i);
        int maxN = increaseArr.size() > 0 ? increaseArr[increaseArr.size() - 1] : -1000000;
        if (maxN < nums[i]) {
            increaseArr.push_back(nums[i]);
        }
        
    }
    n = increaseArr.size();
    for (int i = 0; i < n; i++) {
         while (st.size() > 0 && nums[st.top()] < increaseArr[i]) {
             result[st.top()] = increaseArr[i];
             st.pop();
         }
    }
    return result;
}

class Employee {
public:
    // It's the unique ID of each node.
    // unique id of this employee
    int id;
    // the importance value of this employee
    int importance;
    // the id of direct subordinates
    vector<int> subordinates;
    
    unordered_map<int,Employee*> hmap;

    int getImportance(vector<Employee*> employees, int id) {
        hmap.clear();
        for (int i = 0; i < employees.size(); i++) {
            auto node = employees[i];
//            hashmap
            hmap[node->id] = node;
//            hmap.insert(node->id, node);
        }
        return dfs(id);
    }
    
    int dfs(int id) {
        auto employee = hmap[id];
        int importance = employee->importance;
        for (int i = 0; i < employee->subordinates.size(); i ++) {
            auto id = employee->subordinates[i];
            
            importance += dfs(id);
        }
        return importance;
    }

};




int main(int argc, const char * argv[]) {
    // insert code here...
    vector<int> z = {5,4,3,2,1};
    nextGreaterElements(z);
    std::cout << "Hello, World!\n";
    return 0;
}
