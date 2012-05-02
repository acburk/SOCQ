//
//  NSSet+SOCQ_NSSet.m
//  SOCQ
//
//  Created by Adam Burkepile on 3/9/12.
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
