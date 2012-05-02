//
//  SOCQCore.h
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

#import <Foundation/Foundation.h>

@interface SOCQCore : NSObject
+ (void)where:(BOOL(^)(id obj))check onCollection:(id)sourceCollection withReturnCollection:(id)targetCollection;
+ (BOOL)any:(BOOL(^)(id obj))check onCollection:(id)sourceCollection;
+ (BOOL)all:(BOOL(^)(id obj))check onCollection:(id)sourceCollection;
+ (void)groupBy:(id(^)(id obj))groupBlock onCollection:(id)sourceCollection withReturnDictionary:(NSMutableDictionary*)targetCollection;
+ (void)select:(id(^)(id originalObject))transform onCollection:(id)sourceCollection withReturnCollection:(id)targetCollection;
+ (void)selectFromCollection:(id)sourceCollection withReturnCollection:(id)targetCollection keypaths:(NSArray*)keypathsToGet;
@end
