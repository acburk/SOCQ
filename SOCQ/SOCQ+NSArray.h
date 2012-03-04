//
//  SOCQ+NSArray.h
//  SOCQ+NSArray
//
//  Created by Adam Burkepile on 2/4/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SOCQ)

- (NSArray*)take:(NSUInteger)inCount;
- (NSArray*)skip:(NSUInteger)inCount;
- (NSArray*)skip:(NSUInteger)inSkip take:(NSUInteger)inTake;
- (NSArray*)where:(BOOL(^)(id obj))check;
- (BOOL)any:(BOOL(^)(id obj))check;
- (BOOL)all:(BOOL(^)(id obj))check;
- (NSDictionary*)groupBy:(id(^)(id obj))groupBlock;
- (NSArray*)distinctObjectsByAddress;
- (NSArray*)distinct;
- (NSArray*)select:(id(^)(id originalObject))transform;
- (NSArray*)selectKeypaths:(NSString*)keypath, ... NS_REQUIRES_NIL_TERMINATION;
@end
