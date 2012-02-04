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

- (void)testArrayAllOver
{
    NSArray* ret = [testArray take:10];
    
    STAssertEquals([ret count], [testArray count], @"Array counts should equal");
}

- (void)testArrayAll
{
    NSArray* ret = [testArray take:10];
    
    for (int i = 0 ; i < [testArray count] ;i++) {
        STAssertEqualObjects([ret objectAtIndex:i],
                             [testArray objectAtIndex:i], @"Object doesn't match");
    }
}


@end
