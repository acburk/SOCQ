//
//  SOCQTestsArrays.m
//  SOCQTestsArrays
//
//  Created by Adam Burkepile on 2/4/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQTestsArrays.h"
#import "SOCQ+NSArray.h"

@implementation SOCQTestsArrays

- (void)setUp
{
    [super setUp];
    
    testArray = [NSArray arrayWithObjects:@"Red", 
                 @"Green", 
                 @"Blue", 
                 @"Yellow", 
                 @"Black", 
                 @"White", 
                 @"Brown",nil];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark - take Tests

- (void)testArrayTakeOverCount
{
    NSArray* ret = [testArray take:[testArray count] + 1];
    
    STAssertEquals([ret count], [testArray count], @"Return array count mismatch");
}

- (void)testArrayTakeOver
{
    NSArray* ret = [testArray take:[testArray count] + 1];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i], @"Object doesn't match");
    }
}

- (void)testArrayTakeNone
{
    NSArray* ret = [testArray take:0];
    
    STAssertEquals([ret count], (NSUInteger)0, @"Return array count mismatch");
}

- (void)testArrayTakeSomeCount
{
    NSArray* ret = [testArray take:3];
    
    STAssertEquals([ret count], (NSUInteger)3, @"Return array count mismatch");
}

- (void)testArrayTakeSome
{
    NSArray* ret = [testArray take:3];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i], @"Object doesn't match");
    }
}

- (void)testArraySkipNoneCount {
    NSUInteger skipAmount = 0;
    NSArray* ret = [testArray skip:skipAmount];
    
    STAssertEquals([ret count], [testArray count]-skipAmount, @"Return array count mismatch");
}
- (void)testArraySkipSomeCount {
    NSUInteger skipAmount = 3;
    NSArray* ret = [testArray skip:skipAmount];
    
    STAssertEquals([ret count], [testArray count]-skipAmount, @"Return array count mismatch");
}
- (void)testArraySkipAllCount {
    NSUInteger skipAmount = 7;
    NSArray* ret = [testArray skip:skipAmount];
    
    STAssertEquals([ret count], [testArray count]-skipAmount, @"Return array count mismatch");
}
- (void)testArraySkipOverCount {
    NSUInteger skipAmount = [testArray count]+1;
    NSArray* ret = [testArray skip:skipAmount];
    
    STAssertEquals([ret count], (NSUInteger)0, @"Return array count mismatch");
}

#pragma mark - skip Tests

- (void)testArraySkipNone {
    NSUInteger skipAmount = 0;
    NSArray* ret = [testArray skip:skipAmount];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i+skipAmount], @"Object doesn't match");
    }
}
- (void)testArraySkipSome {
    NSUInteger skipAmount = 3;
    NSArray* ret = [testArray skip:skipAmount];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i+skipAmount], @"Object doesn't match");
    }
}
- (void)testArraySkipAll {
    NSUInteger skipAmount = 7;
    NSArray* ret = [testArray skip:skipAmount];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i+skipAmount], @"Object doesn't match");
    }
}
- (void)testArraySkipOver {
    NSUInteger skipAmount = [testArray count]+1;
    NSArray* ret = [testArray skip:skipAmount];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i+skipAmount], @"Object doesn't match");
    }
}

#pragma mark - skip take Tests

- (void)testArraySkipSomeTakeSomeCount {
    NSUInteger skipAmount = 3;
    NSUInteger takeAmount = 3;
    NSArray* ret = [testArray skip:skipAmount take:takeAmount];
    
    STAssertEquals([ret count], takeAmount, @"Return array count mismatch");
}
- (void)testArraySkipSomeTakeOverCount {
    NSUInteger skipAmount = 3;
    NSArray* ret = [testArray skip:skipAmount take:[testArray count]];
    
    STAssertEquals([ret count], [testArray count]-skipAmount, @"Return array count mismatch");
}

- (void)testArraySkipSomeTakeSome {
    NSUInteger skipAmount = 3;
    NSUInteger takeAmount = 3;
    NSArray* ret = [testArray skip:skipAmount take:takeAmount];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i+skipAmount], @"Object doesn't match");
    }
}
- (void)testArraySkipSomeTakeOver {
    NSUInteger skipAmount = 3;
    NSUInteger takeAmount = [testArray count];
    NSArray* ret = [testArray skip:skipAmount take:takeAmount];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i+skipAmount], @"Object doesn't match");
    }
}

@end
