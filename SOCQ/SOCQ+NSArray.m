//
//  SOCQ+NSArray.m
//  SOCQ+NSArray
//
//  Created by Adam Burkepile on 2/4/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQ+NSArray.h"
#import "SOCQCore.h"
#import <Foundation/NSKeyValueCoding.h>

@implementation NSArray (SOCQ)

- (NSArray*)take:(NSUInteger)inCount {
    NSUInteger position = 0 ;
    NSUInteger size = inCount > [self count] ? [self count] : inCount;
    
    NSRange range;
    range.location = position;
    range.length = size;
    
    return [self subarrayWithRange:range];
}

- (NSArray*)skip:(NSUInteger)inCount {
    NSUInteger position = inCount > [self count] ? [self count] : inCount ;
    NSUInteger size = [self count] - position;
    
    NSRange range;
    range.location = position;
    range.length = size;
    
    return [self subarrayWithRange:range];
}

- (NSArray*)skip:(NSUInteger)inSkip take:(NSUInteger)inTake {
    return [[self skip:inSkip] take:inTake];
}

- (NSArray*)where:(BOOL(^)(id obj))check {
    NSMutableArray* retArray = [NSMutableArray new];
    
    [SOCQCore where:check onCollection:self withReturnCollection:retArray];
    
    return [retArray copy];
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

- (NSArray*)distinctObjectsByAddress {
    NSMutableArray* retArray = [NSMutableArray new];
    BOOL matchFound = NO;
    
    for (int i = 0; i < [self count]; i++) {
        matchFound = NO;
        for (id retObj in retArray) {
            if ([[NSString stringWithFormat:@"%p",retObj] 
                 isEqualToString:
                 [NSString stringWithFormat:@"%p",[self objectAtIndex:i]]]) {
                matchFound = YES;
                break;
            }
        }
        
        if (!matchFound) {
            [retArray addObject:[self objectAtIndex:i]];
        }
    }
    
    return [retArray copy];
}

- (NSArray*)distinct {
    NSMutableArray* retArray = [NSMutableArray new];
    
    for (int i = 0; i < [self count]; i++) {
        if (![retArray containsObject:[self objectAtIndex:i]])
            [retArray addObject:[self objectAtIndex:i]];
    }
    
    return [retArray copy];
}

- (NSArray*)select:(id(^)(id originalObject))transform {
    NSMutableArray* newObjectArray = [NSMutableArray new];
    
    [SOCQCore select:transform onCollection:self withReturnCollection:newObjectArray];
    
    return [newObjectArray copy];
}

- (NSArray*)selectKeypaths:(NSString*)keypath, ... {
    NSMutableArray* entries = [NSMutableArray new];
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