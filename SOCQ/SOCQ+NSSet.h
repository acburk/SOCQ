//
//  NSSet+SOCQ_NSSet.h
//  SOCQ
//
//  Created by Adam Burkepile on 3/9/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (SOCQ)
- (NSSet*)where:(BOOL(^)(id obj))check;
- (BOOL)any:(BOOL(^)(id obj))check;
- (BOOL)all:(BOOL(^)(id obj))check;
- (NSDictionary*)groupBy:(id(^)(id obj))groupBlock;
- (NSSet*)select:(id(^)(id originalObject))transform;
- (NSSet*)selectKeypaths:(NSString*)keypath, ... NS_REQUIRES_NIL_TERMINATION;
@end
