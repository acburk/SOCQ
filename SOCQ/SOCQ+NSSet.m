//
//  NSSet+SOCQ_NSSet.m
//  SOCQ
//
//  Created by Adam Burkepile on 3/9/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQ+NSSet.h"

@implementation NSSet (SOCQ)
- (NSSet*)where:(BOOL(^)(id obj))check {
    NSMutableSet* retSet = [NSMutableSet new];

    for (id obj in self) {
        if (check(obj))
            [retSet addObject:obj];
    }
    
    return [retSet copy];
}
@end
