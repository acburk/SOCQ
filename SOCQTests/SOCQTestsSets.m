//
//  SOCQTestsSets.m
//  SOCQ
//
//  Created by Adam Burkepile on 3/11/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQTestsSets.h"
#import "SOCQ+NSSet.h"

@implementation SOCQTestsSets

- (void)setUp
{
    [super setUp];
    
    testSet = [NSSet setWithObjects:@"Red", 
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


#pragma mark - where Tests

- (void)testSetWhereNone {
    NSSet* ret = [testSet where:^BOOL(id obj) {
        NSString* color = obj;
        
        return [color length] == 1;
    }];
    
    STAssertNotNil(ret,@"Return Value shouldn't be nil");
    STAssertEquals([ret count], (NSUInteger)0, @"Return array count mismatch");
}

- (void)testSetWhereCount {
    NSSet* ret = [testSet where:^BOOL(id obj) {
        NSString* color = obj;
        
        return [color length] == 5;
    }];
    
    STAssertEquals([ret count], (NSUInteger)4, @"Return array count mismatch");
}



#pragma mark - any Tests
- (void)testAnyNone {
    STAssertFalse([testSet any:^BOOL(id obj) {
        return [obj length] == 2;
    }], @"Statement should be false");
}
- (void)testAnySome {
    STAssertTrue([testSet any:^BOOL(id obj) {
        return [obj length] == 4;
    }], @"Statement should be true");
}
- (void)testAnyAll {
    STAssertTrue([testSet any:^BOOL(id obj) {
        return [obj length] >= 1;
    }], @"Statement should be true");
}

#pragma mark - any Tests
- (void)testAllNone {
    STAssertFalse([testSet all:^BOOL(id obj) {
        return [obj length] >= 10;
    }], @"Statement should be false");
}
- (void)testAllSome {
    STAssertFalse([testSet all:^BOOL(id obj) {
        return [obj length] >= 4;
    }], @"Statement should be false");
}
- (void)testAllAll {
    STAssertTrue([testSet all:^BOOL(id obj) {
        return [obj length] >= 1;
    }], @"Statement should be true");
}

@end
