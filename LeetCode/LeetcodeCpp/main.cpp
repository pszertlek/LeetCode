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
#include <unordered_map>
#include <pthread.h>
#include <unistd.h>
using namespace std;

class Node {
public:
    int val;
    Node* next;
    Node* random;
    
    Node(int _val) {
        val = _val;
        next = NULL;
        random = NULL;
    }
};

struct ListNode {
     int val;
     ListNode *next;
     ListNode(int x) : val(x), next(NULL) {}
 };

class Solution {
public:
    Node *copyRandomList(Node *head) {
        if (head == NULL) {
            return NULL;
        }
        //2 ^ 14标记
        unordered_map<Node *, Node *> map;
        Node *node = head;
        Node *copyNode = new Node(node->val);
        while (node != NULL) {
            node = node->next;
            Node *copy = new Node(node->val);
            copyNode->next = copy;
            copyNode = copy;
            map[node] = copy;
            
        }
        node = head;
        while (node != NULL) {
            Node *copy = map[node];
            Node *randomNode = map[node->random];
            copy->random = randomNode;
            node = node->next;
        }
        return map[head];
    }
    
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        ListNode *nodeA = headA;
        ListNode *nodeB = headB;
        while (nodeA != NULL || nodeB != NULL) {
            nodeA = nodeA->next;
            nodeB = nodeB->next;
        }
        ListNode *nodeAA = headA;
        ListNode *nodeBB = headB;
        while (nodeA != NULL ) {
            nodeA = nodeA->next;
            nodeAA = nodeAA->next;
        }
        while (nodeB != NULL ) {
            nodeB = nodeB->next;
            nodeBB = nodeBB->next;
        }
        while (nodeBB != nodeAA) {
            nodeAA = nodeAA->next;
            nodeBB = nodeBB->next;
        }
        return nodeAA;
    }
};
int k = 2;
class ZeroEvenOdd {
private:
    int n;
    pthread_mutex_t mutex0;
    pthread_mutex_t mutex1;
    pthread_mutex_t mutex2;
public:
    ZeroEvenOdd(int n) {
        this->n = n;
        pthread_mutex_init(&mutex0, NULL);
        pthread_mutex_init(&mutex1, NULL);
        pthread_mutex_init(&mutex2, NULL);
        
        pthread_mutex_lock(&mutex1);
        pthread_mutex_lock(&mutex2);
    }
    
    void zero(function<void(int)> printNumber) {
        for(int i = 1; i <= n; i++) {
            pthread_mutex_lock(&mutex0);
            printNumber(0);
            if(i & 1) pthread_mutex_unlock(&mutex1);
            else pthread_mutex_unlock(&mutex2);
        }
    }

    void even(function<void(int)> printNumber) {
        for(int i = 2; i <= n; i+=2) {
            pthread_mutex_lock(&mutex2);
            printNumber(i);
            pthread_mutex_unlock(&mutex0);
        }
    }

    void odd(function<void(int)> printNumber) {
        for(int i = 1; i <= n; i+=2) {
            pthread_mutex_lock(&mutex1);
            printNumber(i);
            pthread_mutex_unlock(&mutex0);
        }
    }

};

ZeroEvenOdd *zeo = NULL;
void ppp(int i) {
    static int zzz = 0;
    if (zzz == 2 * k) {
        printf("over");
    }
    zzz += 1;
    printf("%d",i);
}

void *thread000(void *arg) {
    zeo->zero(ppp);
    return NULL;
}

void *thread111(void *arg) {
    zeo->odd(ppp);

    return NULL;

}

void *thread222(void *arg) {
    zeo->even(ppp);

    return NULL;
}
int main(int argc, const char * argv[]) {
    // insert code here...
    zeo = new ZeroEvenOdd(k);
    std::cout << "Hello, World!\n";
    pthread_t thread0;
    pthread_create(&thread0, NULL, thread000, NULL);
    pthread_t thread1;
    pthread_create(&thread1, NULL, thread111, NULL);
    pthread_t thread2;
    pthread_create(&thread2, NULL, thread222, NULL);
    while(true) {
        sleep(1);
    }

    return 0;
}


