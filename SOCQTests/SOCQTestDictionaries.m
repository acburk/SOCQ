//
//  SOCQTestDictionaries.m
//  SOCQ
//
//  Created by Adam Burkepile on 2/8/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
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

    STAssertEquals([retDictionary count],[testDictionary count], @"Array count should match");
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
@end
