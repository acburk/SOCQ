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
@end
