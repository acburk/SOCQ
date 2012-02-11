//
//  SOCQ+NSArray.m
//  SOCQ+NSArray
//
//  Created by Adam Burkepile on 2/4/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQ+NSArray.h"

@implementation NSArray (SOCQ)

- (NSArray*)take:(NSUInteger)inCount {
    NSMutableArray* retArray = [NSMutableArray new];
    
    NSUInteger count = inCount > [self count] ? [self count] : inCount ;
    
    for (int i = 0; i < count; i++) {
        [retArray addObject:[self objectAtIndex:i]];
    }
    
    return [retArray copy];
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
    
    for (int i = 0; i < [self count]; i++) {
        if (check([self objectAtIndex:i]))
            [retArray addObject:[self objectAtIndex:i]];
    }
    
    return [retArray copy];
}

- (BOOL)any:(BOOL(^)(id obj))check {
    for (int i = 0; i < [self count]; i++) {
        if (check([self objectAtIndex:i]))
            return YES;
    }
    
    return NO;
}

- (BOOL)all:(BOOL(^)(id obj))check {
    for (int i = 0; i < [self count]; i++) {
        if (!check([self objectAtIndex:i]))
            return NO;
    }
    
    return YES;
}


@end
