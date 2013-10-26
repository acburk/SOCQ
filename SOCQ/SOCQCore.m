//
//  SOCQCore.m
//  SOCQ
//
//  Created by Adam Burkepile on 4/3/12.
//  Copyright (C) 2012 Adam Burkepile.
//
//  Permission is hereby granted, free of charge, to any person 
//  obtaining a copy of this software and associated documentation 
//  files (the "Software"), to deal in the Software without 
//  restriction, including without limitation the rights to use, 
//  copy, modify, merge, publish, distribute, sublicense, and/or 
//  sell copies of the Software, and to permit persons to whom 
//  the Software is furnished to do so, subject to the following 
//  conditions:
//
//  The above copyright notice and this permission notice shall be 
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
//  OTHER DEALINGS IN THE SOFTWARE.
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
            id newObject = [NSNull null];
            
            if ([sourceCollection isKindOfClass:[NSArray class]])
                newObject = [NSMutableArray arrayWithObject:element];
            else if ([sourceCollection isKindOfClass:[NSSet class]])
                newObject = [NSMutableSet setWithObject:element];
            
            [targetCollection setObject:newObject forKey:groupKey];
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
