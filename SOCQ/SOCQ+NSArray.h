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
- (NSArray*)distinct;
@end
