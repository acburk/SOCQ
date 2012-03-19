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

- (BOOL)any:(BOOL(^)(id obj))check {
    for (id obj in self) {
        if (check(obj))
            return YES;
    }
    
    return NO;
}

- (BOOL)all:(BOOL(^)(id obj))check {
    for (id obj in self) {
        if (!check(obj))
            return NO;
    }
    
    return YES;
}

- (NSDictionary*)groupBy:(id(^)(id obj))groupBlock {
    NSMutableDictionary* groupDictionary = [NSMutableDictionary new];
    
    for (id element in self) {
        id groupKey = groupBlock(element);
        
        if ([[groupDictionary allKeys] containsObject:groupKey]) {
            id matchingKey = nil;
            
            for (id searchKey in [groupDictionary allKeys]) {
                if ([searchKey isEqual:groupKey]) {
                    matchingKey = searchKey;
                    break;
                }
            }
            
            [[groupDictionary objectForKey:matchingKey] addObject:element];
        }
        else {
            [groupDictionary setObject:[NSMutableArray arrayWithObject:element] forKey:groupKey];
        }
    }
    
    return [groupDictionary copy];
}
@end
