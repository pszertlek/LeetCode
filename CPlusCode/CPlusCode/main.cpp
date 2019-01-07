//
//  main.cpp
//  CPlusCode
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 Pszertlek. All rights reserved.
//

#include <iostream>
#include <math.h>


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

int main(int argc, const char * argv[]) {
    // insert code here...
    reverseBits(1);
    printf("%ud",reverseBits(43261596));
    
    return 0;
}


