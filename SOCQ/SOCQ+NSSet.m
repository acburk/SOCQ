//
//  NSSet+SOCQ_NSSet.m
//  SOCQ
//
//  Created by Adam Burkepile on 3/9/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQ+NSSet.h"
#import "SOCQCore.h"

@implementation NSSet (SOCQ)
- (NSSet*)where:(BOOL(^)(id obj))check {
    NSMutableSet* retSet = [NSMutableSet new];

    [SOCQCore where:check onCollection:self withReturnCollection:retSet];
    
    return [retSet copy];
}

- (BOOL)any:(BOOL(^)(id obj))check {
    return [SOCQCore any:check onCollection:self];
}

- (BOOL)all:(BOOL(^)(id obj))check {
    return [SOCQCore all:check onCollection:self];
}

- (NSDictionary*)groupBy:(id(^)(id obj))groupBlock {
    NSMutableDictionary* groupDictionary = [NSMutableDictionary new];
    
    [SOCQCore groupBy:groupBlock onCollection:self withReturnDictionary:groupDictionary];
    
    return [groupDictionary copy];
}

- (NSSet*)select:(id(^)(id originalObject))transform {
    NSMutableSet* newObjectSet = [NSMutableSet new];
    
    [SOCQCore select:transform onCollection:self withReturnCollection:newObjectSet];
    
    return [newObjectSet copy];
}

- (NSSet*)selectKeypaths:(NSString*)keypath, ... {
    NSMutableSet* entries = [NSMutableSet new];
    NSMutableArray* keypathsToGet = [NSMutableArray new];
    
    va_list args;
    va_start(args, keypath);
    for (NSString *arg = keypath; arg != nil; arg = va_arg(args, NSString*))
        [keypathsToGet addObject:arg];
    
    va_end(args);
    
    [SOCQCore selectFromCollection:self withReturnCollection:entries keypaths:keypathsToGet];
    
    return [entries copy];
}
@end
