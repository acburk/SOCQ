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

@end
