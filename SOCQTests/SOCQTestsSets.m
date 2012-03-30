//
//  SOCQTestsSets.m
//  SOCQ
//
//  Created by Adam Burkepile on 3/11/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQTestsSets.h"
#import "SOCQ+NSSet.h"

@interface SetPerson : NSObject <NSCopying>
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) SetPerson* parent;

- (id)initWithFirstName:(NSString*)inFirstName 
               lastName:(NSString*)inLastName 
              andParent:(SetPerson*)inParent;
@end
@implementation SetPerson
@synthesize firstName;
@synthesize lastName;
@synthesize parent;

- (id)initWithFirstName:(NSString*)inFirstName 
               lastName:(NSString*)inLastName 
              andParent:(SetPerson*)inParent {
    if (self = [super init]) {
        firstName = inFirstName;
        lastName = inLastName;
        parent = inParent;
    }
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return [[SetPerson alloc] initWithFirstName:[self firstName] lastName:[self lastName] andParent:[self parent]];
}

-(BOOL)isEqual:(id)object {
    return ([[self firstName] isEqualToString:[object firstName]] &&
            [[self lastName] isEqualToString:[object lastName]] &&
            ([self parent] == [object parent] || [[self parent] isEqual:[object parent]]));
}
@end


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
    
    SetPerson* rick = [[SetPerson alloc] initWithFirstName:@"rick" lastName:@"rick" andParent:nil];
    SetPerson* adam = [[SetPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    SetPerson* dick = [[SetPerson alloc] initWithFirstName:@"dick" lastName:@"dick" andParent:rick];
    SetPerson* don = [[SetPerson alloc] initWithFirstName:@"don" lastName:@"don" andParent:adam];
    SetPerson* shane = [[SetPerson alloc] initWithFirstName:@"shane" lastName:@"shane" andParent:rick];
    SetPerson* bob = [[SetPerson alloc] initWithFirstName:@"bob" lastName:@"bob" andParent:adam];
    
    testPersonSet = [NSSet setWithObjects:dick,don,shane,bob, nil];
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

#pragma mark - groupby tests
- (void)testGroupByNil {
    NSDictionary* grouped = [testSet groupBy:^id(id obj) {
        return [NSNumber numberWithUnsignedInteger:[obj length]];
    }];
    
    STAssertNotNil(grouped, @"shouldnt be nil");
}

- (void)testGroupByCount {
    NSDictionary* grouped = [testSet groupBy:^id(id obj) {
        return [NSNumber numberWithUnsignedInteger:[obj length]];
    }];
    
    STAssertEquals([[grouped allKeys] count], 4u, @"should have 4 keys");
}

- (void)testGroupByFirstChar {
    NSDictionary* grouped = [testSet groupBy:^id(id obj) {
        return [NSString stringWithFormat:@"%c",[(NSString*)obj characterAtIndex:0]];
    }];
    
    STAssertEquals([[grouped allKeys] count], 5u, @"should have 5 keys");
}

- (void)testGroupByCustonClass {
    NSDictionary* grouped = [testPersonSet groupBy:^id(id obj) {
        return [(SetPerson*)obj parent];
    }];
    
    STAssertEquals([[grouped allKeys] count], 2u, @"should have 2 keys");
    STAssertEquals([[grouped objectForKey:[[grouped allKeys] objectAtIndex:0]] count], 2u, @"first key should have 2 keys");
    STAssertEquals([[grouped objectForKey:[[grouped allKeys] objectAtIndex:1]] count], 2u, @"second key should have 2 keys");
}

#pragma mark - select tests

- (void)testStringToPerson {
    NSSet* people = [testSet select:^(id obj){
        return [[SetPerson alloc] initWithFirstName:obj lastName:obj andParent:nil];
    }];
    
    STAssertEquals([people count], [testSet count],@"Both arrays should contain the same amount of objects");
    
    for (id newObject in people) {
        STAssertEqualObjects([newObject class], [SetPerson class], @"The new object should be a Person object");
    }
}

@end
