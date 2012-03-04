//
//  SOCQ+NSArray.m
//  SOCQ+NSArray
//
//  Created by Adam Burkepile on 2/4/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQ+NSArray.h"
#import <Foundation/NSKeyValueCoding.h>

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
    
    for (id object in self) {
        [newObjectArray addObject:transform(object)];
    }
    
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