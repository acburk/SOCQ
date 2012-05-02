//
//  SOCQTestDictionaries.m
//  SOCQ
//
//  Created by Adam Burkepile on 2/8/12.
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

#import "SOCQTestDictionaries.h"
#import "SOCQ+NSDictionary.h"

@implementation SOCQTestDictionaries

- (void)setUp
{
    [super setUp];
    
    testDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"Red",@"Steve", 
                     @"Green",@"Carl", 
                     @"Blue", @"Joe",
                     @"Yellow", @"Jason",
                     @"Black", @"Adam",
                     @"White", @"Matt",
                     @"Brown",@"Nick",nil];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

// All code under test must be linked into the Unit Test bundle
- (void)testWhereAllCount
{
    NSDictionary* retDictionary = [testDictionary where:^BOOL(id key, id value) {
                                                            return YES;
                                                        }];

    STAssertEquals([retDictionary count],[testDictionary count], @"Dictionary count should match");
}
- (void)testWhereAll
{
    NSDictionary* retDictionary = [testDictionary where:^BOOL(id key, id value) {
        return YES;
    }];
    
    for (id key in [testDictionary allKeys]) {
        STAssertTrue([[retDictionary allKeys] containsObject:key], @"Key(%@) does not exist",key);
        STAssertEqualObjects([retDictionary objectForKey:key], 
                             [retDictionary objectForKey:key], @"Objects do not match");
    }
}
- (void)testWhereNoneCount
{
    NSDictionary* retDictionary = [testDictionary where:^BOOL(id key, id value) {
        return NO;
    }];
    
    STAssertEquals([retDictionary count],0u, @"Dictionary count should be 0");
}

#pragma mark - any Tests
- (void)testAnyNone {
    STAssertFalse([testDictionary any:^BOOL(id key, id value) {
        return [key length] == 2;
    }], @"Statement should be false");
}
- (void)testAnySome {
    STAssertTrue([testDictionary any:^BOOL(id key, id value) {
        return [key length] == 4;
    }], @"Statement should be true");
}
- (void)testAnyAll {
    STAssertTrue([testDictionary any:^BOOL(id key, id value) {
        return [key length] >= 1;
    }], @"Statement should be true");
}

#pragma mark - any Tests
- (void)testAllNone {
    STAssertFalse([testDictionary all:^BOOL(id key, id value) {
        return [key length] >= 10;
    }], @"Statement should be false");
}
- (void)testAllSome {
    STAssertFalse([testDictionary all:^BOOL(id key, id value) {
        return [key length] >= 4;
    }], @"Statement should be false");
}
- (void)testAllAll {
    STAssertTrue([testDictionary all:^BOOL(id key, id value) {
        return [key length] >= 1;
    }], @"Statement should be true");
}
@end
