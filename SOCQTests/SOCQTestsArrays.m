//
//  SOCQTestsArrays.m
//  SOCQTestsArrays
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

#import "SOCQTestsArrays.h"
#import "SOCQ+NSArray.h"

@interface ArrayPerson : NSObject <NSCopying>
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) ArrayPerson* parent;

- (id)initWithFirstName:(NSString*)inFirstName 
               lastName:(NSString*)inLastName 
              andParent:(ArrayPerson*)inParent;
@end
@implementation ArrayPerson
@synthesize firstName;
@synthesize lastName;
@synthesize parent;

- (id)initWithFirstName:(NSString*)inFirstName 
               lastName:(NSString*)inLastName 
              andParent:(ArrayPerson*)inParent {
    if (self = [super init]) {
        firstName = inFirstName;
        lastName = inLastName;
        parent = inParent;
    }
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return [[ArrayPerson alloc] initWithFirstName:[self firstName] lastName:[self lastName] andParent:[self parent]];
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
    mutableTestArray = [testArray mutableCopy];

    
    ArrayPerson* rick = [[ArrayPerson alloc] initWithFirstName:@"rick" lastName:@"rick" andParent:nil];
    ArrayPerson* adam = [[ArrayPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    ArrayPerson* dick = [[ArrayPerson alloc] initWithFirstName:@"dick" lastName:@"dick" andParent:rick];
    ArrayPerson* don = [[ArrayPerson alloc] initWithFirstName:@"don" lastName:@"don" andParent:adam];
    ArrayPerson* shane = [[ArrayPerson alloc] initWithFirstName:@"shane" lastName:@"shane" andParent:rick];
    ArrayPerson* bob = [[ArrayPerson alloc] initWithFirstName:@"bob" lastName:@"bob" andParent:adam];
    
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
        return [(ArrayPerson*)obj parent];
    }];

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
    ArrayPerson* adam1 = [[ArrayPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
    testPersonArray = [NSArray arrayWithObjects:adam1,adam1, nil];
    
    NSArray* checkArray = [testPersonArray distinctObjectsByAddress];
    
    STAssertEquals([checkArray count], 1u, @"Array count should be 1");
}

- (void)testDistinctObjectsByAddress5 {
    ArrayPerson* adam1 = [[ArrayPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    ArrayPerson* adam2 = [[ArrayPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
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
    ArrayPerson* adam1 = [[ArrayPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
    testPersonArray = [NSArray arrayWithObjects:adam1,adam1, nil];
    
    NSArray* checkArray = [testPersonArray distinct];
    
    STAssertEquals([checkArray count], 1u, @"Array count should be 1");
}

- (void)testDistinct5 {
    ArrayPerson* adam1 = [[ArrayPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    ArrayPerson* adam2 = [[ArrayPerson alloc] initWithFirstName:@"adam" lastName:@"adam" andParent:nil];
    
    NSArray* personArray = [NSArray arrayWithObjects:adam1,adam2, nil];
    
    NSArray* checkArray = [personArray distinct];
    
    STAssertEquals([checkArray count], 1u, @"Array %@ counts should match %@ %@",checkArray,adam1,adam2);
}

#pragma mark - select tests

- (void)testStringToPerson {
    NSArray* people = [testArray select:^(id obj){
        return [[ArrayPerson alloc] initWithFirstName:obj lastName:obj andParent:nil];
    }];
    
    STAssertEquals([people count], [testArray count],@"Both arrays should contain the same amount of objects");
    
    for (id newObject in people) {
        STAssertEqualObjects([newObject class], [ArrayPerson class], @"The new object should be a Person object");
    }
}

#pragma mark - selectKeypaths tests

- (void)testSelectKeyPathskey {
    NSArray* people = [testPersonArray selectKeypaths:@"firstName", nil];
    
    STAssertEquals([people count], [testPersonArray count],@"Both arrays should contain the same amount of objects");
    
    for (id person in people) {
        STAssertNotNil([person objectForKey:@"firstName"],@"FirstName should not be nil");
    }
}
- (void)testSelectKeyPathsUndefinedKey {
    NSArray* people = [testPersonArray selectKeypaths:@"age", nil];
    
    STAssertEquals([people count], [testPersonArray count],@"Both arrays should contain the same amount of objects");
    
    for (id person in people) {
        STAssertEqualObjects([person objectForKey:@"age"], [NSNull null],@"Age should be nil");
    }
}
- (void)testSelectKeyPathskeypath {
    NSArray* people = [testPersonArray selectKeypaths:@"parent.firstName", nil];
    
    STAssertEquals([people count], [testPersonArray count],@"Both arrays should contain the same amount of objects");

    for (id person in people) {
        STAssertNotNil([person objectForKey:@"parent.firstName"],@"parent.firstName should not be nil");
    }
}
- (void)testSelectKeyPathsundefinedkeypath {
    NSArray* people = [testPersonArray selectKeypaths:@"parent.parent.firstName", nil];
    
    STAssertEquals([people count], [testPersonArray count],@"Both arrays should contain the same amount of objects");
    
    for (id person in people) {
        STAssertEqualObjects([person objectForKey:@"parent.parent.firstName"], [NSNull null],@"parent.parent.firstName should be nil");
    }
}

- (void)testSelectKeyPathsAll {
    NSArray* people = [testPersonArray selectKeypaths:@"firstName",@"age",@"parent.firstName",@"parent.parent.firstName", nil];
    
    STAssertEquals([people count], [testPersonArray count],@"Both arrays should contain the same amount of objects");
    
    for (id person in people) {
        STAssertNotNil([person objectForKey:@"firstName"],@"FirstName should not be nil");
        STAssertEqualObjects([person objectForKey:@"age"], [NSNull null],@"Age should be nil");
        STAssertNotNil([person objectForKey:@"parent.firstName"],@"parent.firstName should not be nil");
        STAssertEqualObjects([person objectForKey:@"parent.parent.firstName"], [NSNull null],@"parent.parent.firstName should be nil");
    }
}

#pragma mark - first and second tests
- (void)testFirstNotNil {
    STAssertNotNil([testArray firstObject], @"Object should not be nil.");
}
- (void)testFirstNil {
    STAssertNil([[NSArray array] firstObject], @"Object should be nil.");
}
- (void)testFirstCorrectness {
    STAssertTrue([[testArray firstObject] isEqualToString:@"Red"], @"First object should be Red");
}

- (void)testSecondNotNil {
    STAssertNotNil([testArray secondObject], @"Object should not be nil.");
}
- (void)testSecondNil {
    STAssertNil([[NSArray array] secondObject], @"Object should be nil.");
}
- (void)testSecondCorrectness {
    STAssertTrue([[testArray secondObject] isEqualToString:@"Green"], @"First object should be Green");
}

#pragma mark - popobjectatindex
- (void)testPopSecondElement {
    id secondElement = [mutableTestArray popObjectAtIndex:1];
    
    STAssertEquals([mutableTestArray count], [testArray count] - 1, @"Array should be 1 smaller.");
    STAssertEqualObjects(secondElement, @"Green",@"Should of popped Green string");
}
- (void)testPopFirstElement {
    id secondElement = [mutableTestArray popFirstObject];
    
    STAssertEquals([mutableTestArray count], [testArray count] - 1, @"Array should be 1 smaller.");
    STAssertEqualObjects(secondElement, @"Red",@"Should of popped Red string");
}
- (void)testPopLastElement {
    id secondElement = [mutableTestArray popLastObject];
    
    STAssertEquals([mutableTestArray count], [testArray count] - 1, @"Array should be 1 smaller.");
    STAssertEqualObjects(secondElement, @"Brown",@"Should of popped Brown string");
}
- (void)testPopOutOfRange {
    STAssertThrowsSpecificNamed([mutableTestArray popObjectAtIndex:[mutableTestArray count]],NSException,NSRangeException,@"Should throw exception for out of range value");
}
- (void)testPopUnderRange {
    STAssertThrowsSpecificNamed([mutableTestArray popObjectAtIndex:-1],NSException,NSRangeException,@"Should throw exception for out of range value");
}
@end
