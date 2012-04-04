//
//  SOCQCore.m
//  SOCQ
//
//  Created by Adam Burkepile on 4/3/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQCore.h"

@implementation SOCQCore

+ (void)where:(BOOL(^)(id obj))check onCollection:(id)sourceCollection withReturnCollection:(id)targetCollection {
    for (id obj in sourceCollection) {
        if (check(obj))
            [targetCollection addObject:obj];
    }
}

+ (BOOL)any:(BOOL(^)(id obj))check onCollection:(id)sourceCollection {
    for (id obj in sourceCollection) {
        if (check(obj))
            return YES;
    }
    
    return NO;
}

+ (BOOL)all:(BOOL(^)(id obj))check onCollection:(id)sourceCollection {
    for (id obj in sourceCollection) {
        if (!check(obj))
            return NO;
    }
    
    return YES;
}

+ (void)groupBy:(id(^)(id obj))groupBlock onCollection:(id)sourceCollection withReturnDictionary:(NSMutableDictionary*)targetCollection {
    for (id element in sourceCollection) {
        id groupKey = groupBlock(element);
        
        if ([[targetCollection allKeys] containsObject:groupKey]) {
            id matchingKey = nil;
            
            for (id searchKey in [targetCollection allKeys]) {
                if ([searchKey isEqual:groupKey]) {
                    matchingKey = searchKey;
                    break;
                }
            }
            
            [[targetCollection objectForKey:matchingKey] addObject:element];
        }
        else {
            id newObject = nil;
            
            if ([sourceCollection isKindOfClass:[NSMutableArray class]])
                newObject = [NSMutableArray arrayWithObject:element];
            else if ([sourceCollection isKindOfClass:[NSMutableSet class]])
                newObject = [NSMutableSet setWithObject:element];
            
            [targetCollection setObject:[NSMutableSet setWithObject:element] forKey:groupKey];
        }
    }
}

+ (void)select:(id(^)(id originalObject))transform onCollection:(id)sourceCollection withReturnCollection:(id)targetCollection {
    for (id object in sourceCollection) {
        [targetCollection addObject:transform(object)];
    }
}

+ (void)selectFromCollection:(id)sourceCollection withReturnCollection:(id)targetCollection keypaths:(NSArray*)keypathsToGet {
    for (id object in sourceCollection) {
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
        
        [targetCollection addObject:keyvalues];
    }
}
@end
