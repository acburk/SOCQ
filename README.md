#SOCQ (Syntax for Objective-C Queries)

Bringin' some query love to Objective-C

__NSArray__

- skip:
- take:
- skip:take:
- where:
- any:
- all:
- groupby:
- distinctObjectsByAddress
- distinct
- select:
- selectKeypaths:

__NSDictionary__

- where:
- any:
- all:

__NSSet__

- where:

##NSArray
####take:
	- (NSArray*)take:(NSUInteger)inCount;
	
_Returns an array with the specified number of elements from the beginning of the target array._

	// Example - Getting the first five elements
	
	NSArray* elements = [people take:5];
	
####skip:
	- (NSArray*)skip:(NSUInteger)inCount;

_Skips the indicated number of elements in the array and returns an array of the remaining elements._

	// Example - skips the first five elements

	NSArray* remaining = [people skip:5];

####skip:take:
	- (NSArray*)skip:(NSUInteger)inSkip take:(NSUInteger)inTake;
	
_Simple convenience method that combines the skip and take methods. Ideal for pagination._
	
	// Example - get elements 6-10
	
	NSArray* remaining = [people skip:5 take:5];
	
	
####where:
	- (NSArray*)where:(BOOL(^)(id obj))check;
	
_Uses the `check` block on every element in the array to determine if they should be returned in the return array_

	// Example - find people that are 25 years old
	
	NSArray* 25YearOlds = [people where:^(id obj){ return [obj age] == 25; }];
	
####any:
	- (BOOL)any:(BOOL(^)(id obj))check;

_Checks every element in the array to see if any of the elements successfully pass the `check` block. If none pass, return `NO`, else `YES`._

	// Example - check to see if anyone is under 18

	BOOL containsMinors = [people any:^(id obj){ return [obj age] < 18; }];

####all:
	- (BOOL)all:(BOOL(^)(id obj))check;

_Checks every element in the array to see if all of the elements successfully pass the `check` block. If all elements pass, return `YES`, else `NO`._

	// Example - check to see if everyone is 25 or over

	BOOL everyone25orOver = [people all:^(id obj){ return [obj age] >= 25; }];
	
####groupby:
	- (NSDictionary*)groupBy:(id(^)(id obj))groupBlock;

_Uses the object returned from the `groupBlock` block as a key to group the object into a NSDictionary that contains a NSArray with all the objects that returned the same key_

	// Example - group everyone by their last name

	NSDictionary* peopleByFamilyName = [people groupBy:^(id obj){ return [obj lastName]; }];

####distinctObjectsByAddress
	- (NSArray*)distinctObjectsByAddress;

_Does a simple pointer address compare to remove elements that refer to the same object_

	// Example - remove the exact same elements

	NSArray* uniquePeople = [people distinctObjectsByAddress];

####distinct
	- (NSArray*)distinct;

_Uses the class' compare and hash method to remove elements that contain the same value_

	// Example - remove the exact same elements

	NSArray* uniquePeople = [people distinct];

####select:
	- (NSArray*)select:(id(^)(id originalObject))transform;
	
_Transforms elements in the array into another strongly type object that is returned from the `transform` block._

	// Example - Change people objects into American Class objects

	NSArray* americans = [people select:^(id obj){ return [[American alloc] initWithFirstName:[obj firstName]
													LastName:[obj lastName]
													age:[obj age]] }];

####selectKeypaths:
	- (NSArray*)selectKeypaths:(NSString*)keypath, ... NS_REQUIRES_NIL_TERMINATION;

_Selects properties from the elements in the array using the keypath mechanism. Any number of keypaths maybe specified but the list must be `nil` terminated. The return value is an array of dictionaries. The dictionary contain the keypaths that were passed in as the parameters as the keys and the valueForKeyPath: as the values._

	// Example - Get the four properties we need from the person object

	NSArray* americans = [people selectKeypaths:@"firstName",@"lastName",@"parent",@"age",nil];

##NSDictionary
####where:
	- (NSDictionary*)where:(BOOL(^)(id key, id value))check;
	
_Uses the `check` block on every key-object in the dictionary to determine if they should be returned in the return array_

    // Example - get all the keys and objects where the key is 3 or less characters
  
    NSDictionary* entriesWithKeysOf3OrLess = [peopleGroup where:^(id key, id value){ return [key length] <= 3; }];

####any:
	- (BOOL)any:(BOOL(^)(id key, id value))check;
	
_Checks every key-object in the dictionary to see if any of the elements successfully pass the `check` block. If none pass, return `NO`, else `YES`._

    // Exmaple - finds out if any of the keys are longer than 10 characters
  
    BOOL areAnyKeysLongerThan10 = [peopleGroups any:^(id key, id value){ return [key length] > 10 }];

####all:
	- (BOOL)all:(BOOL(^)(id key, id value))check;

_Checks every key-object in the dictionary to see if all of the elements successfully pass the `check` block. If all elements pass, return `YES`, else `NO`._

    // Exmaple - find out if all the keys are strings
  
    BOOL areKeysStrings = [peopleGroups all:^(id key, id value){ return [key class] == [NSString class] }];

##NSSet
####where:
	- (NSSet*)where:(BOOL(^)(id obj))check;
	
_Uses the `check` block on every element in the set to determine if they should be returned in the return set_

    // Example - find people that are 25 years old
	
    NSSet* 25YearOlds = [people where:^(id obj){ return [obj age] == 25; }];
