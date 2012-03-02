//
//  SOCQTestsArrays.m
//  SOCQTestsArrays
//
//  Created by Adam Burkepile on 2/4/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "SOCQTestsArrays.h"
#import "SOCQ+NSArray.h"

@interface Person : NSObject <NSCopying>
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) Person* parent;

- (id)initWithFirstName:(NSString*)inFirstName 
               lastName:(NSString*)inLastName 
              andParent:(Person*)inParent;
@end
@implementation Person
@synthesize firstName;
@synthesize lastName;
@synthesize parent;

- (id)initWithFirstName:(NSString*)inFirstName 
               lastName:(NSString*)inLastName 
              andParent:(Person*)inParent {
    if (self = [super init]) {
        firstName = inFirstName;
        lastName = inLastName;
        parent = inParent;
    }
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return [[Person alloc] initWithFirstName:[self firstName] lastName:[self lastName] andParent:[self parent]];
}

-(BOOL)isEqual:(id)object {
    return ([[self firstName] isEqualToString:[object firstName]] &&
            [[self lastName] isEqualToString:[object lastName]] &&
            ([self parent] == [object parent] || [[self parent] isEqual:[object parent]]));
}
@end

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
    
    
    Person* rick = [[Person alloc] initWithFirstName:@"rick" lastName:@"rick" andParent:nil];
    Person* adam = [[Person alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    Person* dick = [[Person alloc] initWithFirstName:@"dick" lastName:@"dick" andParent:rick];
    Person* don = [[Person alloc] initWithFirstName:@"don" lastName:@"don" andParent:adam];
    Person* shane = [[Person alloc] initWithFirstName:@"shane" lastName:@"shane" andParent:rick];
    Person* bob = [[Person alloc] initWithFirstName:@"bob" lastName:@"bob" andParent:adam];
    
    testPersonArray = [NSArray arrayWithObjects:dick,don,shane,bob, nil];
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

#pragma mark - skip Tests

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

#pragma mark - where Tests

- (void)testArrayWhereCount {
    NSArray* ret = [testArray where:^BOOL(id obj) {
        NSString* color = obj;
        
        return [color length] == 5;
    }];
    
    STAssertEquals([ret count], (NSUInteger)4, @"Return array count mismatch");
}

#pragma mark - any Tests
- (void)testAnyNone {
    STAssertFalse([testArray any:^BOOL(id obj) {
        return [obj length] == 2;
    }], @"Statement should be false");
}
- (void)testAnySome {
    STAssertTrue([testArray any:^BOOL(id obj) {
        return [obj length] == 4;
    }], @"Statement should be true");
}
- (void)testAnyAll {
    STAssertTrue([testArray any:^BOOL(id obj) {
        return [obj length] >= 1;
    }], @"Statement should be true");
}

#pragma mark - any Tests
- (void)testAllNone {
    STAssertFalse([testArray all:^BOOL(id obj) {
        return [obj length] >= 10;
    }], @"Statement should be false");
}
- (void)testAllSome {
    STAssertFalse([testArray all:^BOOL(id obj) {
        return [obj length] >= 4;
    }], @"Statement should be false");
}
- (void)testAllAll {
    STAssertTrue([testArray all:^BOOL(id obj) {
        return [obj length] >= 1;
    }], @"Statement should be true");
}

#pragma mark - groupby tests
- (void)testGroupByNil {
    NSDictionary* grouped = [testArray groupBy:^id(id obj) {
        return [NSNumber numberWithUnsignedInteger:[obj length]];
    }];
    
    STAssertNotNil(grouped, @"shouldnt be nil");
}

- (void)testGroupByCount {
    NSDictionary* grouped = [testArray groupBy:^id(id obj) {
        return [NSNumber numberWithUnsignedInteger:[obj length]];
    }];
    
    STAssertEquals([[grouped allKeys] count], 4u, @"should have 4 keys");
}

- (void)testGroupByFirstChar {
    NSDictionary* grouped = [testArray groupBy:^id(id obj) {
        return [NSString stringWithFormat:@"%c",[(NSString*)obj characterAtIndex:0]];
    }];
    
    STAssertEquals([[grouped allKeys] count], 5u, @"should have 5 keys");
}

- (void)testGroupByCustonClass {
    NSDictionary* grouped = [testPersonArray groupBy:^id(id obj) {
        return [(Person*)obj parent];
    }];
    NSLog(@"%@",grouped);
    STAssertEquals([[grouped allKeys] count], 2u, @"should have 2 keys");
    STAssertEquals([[grouped objectForKey:[[grouped allKeys] objectAtIndex:0]] count], 2u, @"first key should have 2 keys");
    STAssertEquals([[grouped objectForKey:[[grouped allKeys] objectAtIndex:1]] count], 2u, @"second key should have 2 keys");
}

#pragma mark - testDistinctObjectsByAddress

- (void)testDistinctObjectsByAddress1 {
    testArray = [NSArray arrayWithObjects:@"Red", 
                 @"Green", 
                 @"Blue", 
                 @"Yellow", 
                 @"Black", 
                 @"White", 
                 @"Brown",nil];
    
    NSArray* checkArray = [testArray distinctObjectsByAddress];
    
    STAssertEquals([checkArray count], [testArray count], @"Array count mismatch");
}

- (void)testDistinctObjectsByAddress2 {
    testArray = [NSArray arrayWithObjects:@"Red", 
                 @"Green", 
                 @"Blue", 
                 @"Blue", 
                 @"Yellow", 
                 @"Black", 
                 @"White", 
                 @"Black", 
                 @"White", 
                 @"Black", 
                 @"White", 
                 @"Brown",nil];
    
    NSArray* checkArray = [testArray distinctObjectsByAddress];
    
    STAssertEquals([checkArray count], 7u, @"Array count should be 7");
}

- (void)testDistinctObjectsByAddress3 {
    testArray = [NSArray arrayWithObjects:@"Red", 
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 nil];
    
    NSArray* checkArray = [testArray distinctObjectsByAddress];
    
    STAssertEquals([checkArray count], 1u, @"Array count should be 1");
}

- (void)testDistinctObjectsByAddress4 {
    Person* adam1 = [[Person alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
    testPersonArray = [NSArray arrayWithObjects:adam1,adam1, nil];
    
    NSArray* checkArray = [testPersonArray distinctObjectsByAddress];
    
    STAssertEquals([checkArray count], 1u, @"Array count should be 1");
}

- (void)testDistinctObjectsByAddress5 {
    Person* adam1 = [[Person alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    Person* adam2 = [[Person alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
    NSArray* personArray = [NSArray arrayWithObjects:adam1,adam2, nil];
    
    NSArray* checkArray = [personArray distinctObjectsByAddress];
    
    STAssertEquals([checkArray count], [personArray count], @"Array %@ counts should match %@ %@",checkArray,adam1,adam2);
}

#pragma mark - distinctObjects

- (void)testDistinct1 {
    testArray = [NSArray arrayWithObjects:@"Red", 
                 @"Green", 
                 @"Blue", 
                 @"Yellow", 
                 @"Black", 
                 @"White", 
                 @"Brown",nil];
    
    NSArray* checkArray = [testArray distinct];
    
    STAssertEquals([checkArray count], [testArray count], @"Array count mismatch");
}

- (void)testDistinct2 {
    testArray = [NSArray arrayWithObjects:@"Red", 
                 @"Green", 
                 @"Blue", 
                 @"Blue", 
                 @"Yellow", 
                 @"Black", 
                 @"White", 
                 @"Black", 
                 @"White", 
                 @"Black", 
                 @"White", 
                 @"Brown",nil];
    
    NSArray* checkArray = [testArray distinct];
    
    STAssertEquals([checkArray count], 7u, @"Array count should be 7");
}

- (void)testDistinct3 {
    testArray = [NSArray arrayWithObjects:@"Red", 
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 @"Red",
                 nil];
    
    NSArray* checkArray = [testArray distinct];
    
    STAssertEquals([checkArray count], 1u, @"Array count should be 1");
}

- (void)testDistinct4 {
    Person* adam1 = [[Person alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
    testPersonArray = [NSArray arrayWithObjects:adam1,adam1, nil];
    
    NSArray* checkArray = [testPersonArray distinct];
    
    STAssertEquals([checkArray count], 1u, @"Array count should be 1");
}

- (void)testDistinct5 {
    Person* adam1 = [[Person alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    Person* adam2 = [[Person alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
    NSArray* personArray = [NSArray arrayWithObjects:adam1,adam2, nil];
    
    NSArray* checkArray = [personArray distinct];
    
    STAssertEquals([checkArray count], 1u, @"Array %@ counts should match %@ %@",checkArray,adam1,adam2);
}

#pragma mark - select tests

- (void)testStringToPerson {
    NSArray* people = [testArray select:^(id obj){
        return [[Person alloc] initWithFirstName:obj lastName:obj andParent:nil];
    }];
    
    STAssertEquals([people count], [testArray count],@"Both arrays should contain the same amount of objects");
    
    for (id newObject in people) {
        STAssertEqualObjects([newObject class], [Person class], @"The new object should be a Person object");
    }
}

@end
