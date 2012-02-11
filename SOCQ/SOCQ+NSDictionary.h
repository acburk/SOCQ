//
//  SOCQ+NSDictionary.h
//  SOCQ
//
//  Created by Adam Burkepile on 2/8/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SOCQ)
- (NSDictionary*)where:(BOOL(^)(id key, id value))check;
- (BOOL)any:(BOOL(^)(id key, id value))check;
- (BOOL)all:(BOOL(^)(id key, id value))check;
@end
