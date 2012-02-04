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
                 @"Brown", nil];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testArrayTakeAllOver
{
    NSArray* ret = [testArray take:10];
    
    STAssertEquals([ret count], [testArray count], @"Array counts should equal");
}

- (void)testArrayTakeAll
{
    NSArray* ret = [testArray take:10];
    
    for (int i = 0 ; i < [testArray count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i], @"Object doesn't match");
    }
}

- (void)testArrayTakeNone
{
    NSArray* ret = [testArray take:0];
    
    STAssertEquals([ret count], (NSUInteger)0, @"Array counts should be 0");
}

- (void)testArrayTakeSomeCount
{
    NSArray* ret = [testArray take:3];
    
    STAssertEquals([ret count], (NSUInteger)3, @"Array counts should be 0");
}

- (void)testArrayTakeSome
{
    NSArray* ret = [testArray take:3];
    
    for (int i = 0 ; i < [ret count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i], @"Object doesn't match");
    }
}

@end
