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
            [groupDictionary setObject:[NSMutableSet setWithObject:element] forKey:groupKey];
        }
    }
    
    return [groupDictionary copy];
}

- (NSSet*)select:(id(^)(id originalObject))transform {
    NSMutableSet* newObjectArray = [NSMutableSet new];
    
    for (id object in self) {
        [newObjectArray addObject:transform(object)];
    }
    
    return [newObjectArray copy];
}

- (NSSet*)selectKeypaths:(NSString*)keypath, ... {
    NSMutableSet* entries = [NSMutableSet new];
    NSMutableArray* keypathsToGet = [NSMutableArray new];
    
    va_list args;
    va_start(args, keypath);
    for (NSString *arg = keypath; arg != nil; arg = va_arg(args, NSString*))
        [keypathsToGet addObject:arg];
    
    va_end(args);
    
    for (id object in self) {
        NSMutableDictionary* keyvalues = [NSMutableDictionary new];
        
        for (NSString* key in keypathsToGet){
            id value = nil;
            
            //TODO: REMOVE TRY/CATCH BUT STILL KEEP FAULT TOLERANCE FOR UNDEFINED KEYS
            @try {
                value = [object valueForKeyPath:key];
            }
            @catch (NSException *exception) {
                if([[exception name] isEqualToString:NSUndefinedKeyException])
                    NSLog(@"Undefined Key:%@",key);
                else 
                    @throw exception;
            }
            
            value = value ? value : [NSNull null];
            [keyvalues setObject:value forKey:key];
        }
        
        [entries addObject:keyvalues];
    }
    
    return [entries copy];
}
@end
