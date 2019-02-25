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
public: ListNode *next;
};

class Solution {
public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        if (headA == NULL || headB == NULL) {
            return NULL;
        }
        ListNode *nextA = headA;
        ListNode *nextB = headB;
        int m = 0, n = 0;
        while (nextA != NULL) {
            nextA = nextA->next;
            m ++;
        }
        while (nextB != NULL) {
            nextB = nextB->next;
            n ++;
        }
        nextA = headA;
        nextB = headB;
        if (n <= m) {
            int temp = n;
            n = m;
            m = temp;
            ListNode *tempNode = nextB;
            nextB = nextA;
            nextA = tempNode;
        }
        int i = n - m;
        while (i > 0) {
            nextA = nextA->next;
            i --;
        }
        while (nextA != NULL && nextB != NULL) {
            if (nextA == nextB) {
                return nextA;
            }
            nextA = nextA->next;
            nextB = nextB->next;
        }
        return NULL;
    }
};

uint32_t reverseBits(uint32_t n) {
    uint32_t r = 0, l = 31, result = 0;
    while (r < l) {
        result |= ( n & (1<<r)) << (31 - r);
        result |= (n & (1<<l)) >> (31 - l);
        r++;
        l--;
        printf("r%d,l%d", (n & 1<<r) >> r,(n & 1<<l) >> l);
        printf("\n");

        printf("r%d,l%d", (result & 1<<r) >> r,(result & 1<<l) >> l);
        printf("\n");
    }
    return result;
}

char** letterCasePermutation(char* S, int* returnSize) {
    int i = 0, j = 0;

    int *indexArray = (int *)malloc(sizeof(int) * 12);
    while (S[i] != '\0') {
        if ((S[i] <= 'z' && S[i] >= 'a') || (S[i] <= 'Z' && S[i] >= 'A')) {
            *(indexArray + j) = i;
            j ++;
        }
        i ++;
    }
    
    char **returnArray = (char **)malloc(sizeof(char *) * (1 << j));
    *returnSize = 1 << j;
    for (int m = 0; m < 1<< j; m ++) {
        char *ss = (char*) malloc(sizeof(char) * (i+1));
        for (int n = 0, alphaIndex = 0; n <= i; n++) {
            char c = 0;
            if (S[n] <= 'Z' && S[n] >= 'A') {
                c = S[n] - 'A' + 'a';
            } else {
                c = S[n];
            }
            if (alphaIndex < j && indexArray[alphaIndex] == n ) {
                if ((m >> alphaIndex & 1) == 1) {
                    c = c - 'a' + 'A';
                }
                alphaIndex ++;
            }
            if (n == i) {
                c = '\0';
            }
            *(ss + n) = c;
        }
        returnArray[m] = ss;
    }
    return returnArray;
}

int hammingWeight(uint32_t n) {
    int i = 0;
    while (n != 0) {
        if (n & 1) {
            i ++;
        }
        n = n >> 1;
    }
    return i;
}

int main(int argc, const char * argv[]) {
    // insert code here...
    int i = 0;
    printf("%i",hammingWeight(3));
    return 0;
}


