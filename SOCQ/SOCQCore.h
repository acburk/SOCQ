//
//  SOCQCore.h
//  SOCQ
//
//  Created by Adam Burkepile on 4/3/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOCQCore : NSObject
+ (void)where:(BOOL(^)(id obj))check onCollection:(id)sourceCollection withReturnCollection:(id)targetCollection;
+ (BOOL)any:(BOOL(^)(id obj))check onCollection:(id)sourceCollection;
+ (BOOL)all:(BOOL(^)(id obj))check onCollection:(id)sourceCollection;
+ (void)groupBy:(id(^)(id obj))groupBlock onCollection:(id)sourceCollection withReturnDictionary:(NSMutableDictionary*)targetCollection;
+ (void)select:(id(^)(id originalObject))transform onCollection:(id)sourceCollection withReturnCollection:(id)targetCollection;
+ (void)selectFromCollection:(id)sourceCollection withReturnCollection:(id)targetCollection keypaths:(NSArray*)keypathsToGet;
@end
