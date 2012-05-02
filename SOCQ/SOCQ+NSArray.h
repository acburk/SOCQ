//
//  SOCQ+NSArray.h
//  SOCQ+NSArray
//
//  Created by Adam Burkepile on 2/4/12.
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
- (id)firstObject;
- (id)secondObject;
@end

@interface NSMutableArray (SOCQ)
- (id)popObjectAtIndex:(NSUInteger)inIndex;
- (id)popFirstObject;
- (id)popLastObject;
@end