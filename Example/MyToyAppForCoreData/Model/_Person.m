// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

const struct PersonAttributes PersonAttributes = {
	.birthYear = @"birthYear",
	.isMale = @"isMale",
};

const struct PersonRelationships PersonRelationships = {
	.city = @"city",
	.colleagues = @"colleagues",
	.company = @"company",
	.family = @"family",
	.friends = @"friends",
	.peopleWhoHaveMeAsAFriend = @"peopleWhoHaveMeAsAFriend",
	.pets = @"pets",
	.preferedCities = @"preferedCities",
};

const struct PersonFetchedProperties PersonFetchedProperties = {
};

@implementation PersonID
@end

@implementation _Person

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (PersonID*)objectID {
	return (PersonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"birthYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"birthYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isMaleValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isMale"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic birthYear;



- (int16_t)birthYearValue {
	NSNumber *result = [self birthYear];
	return [result shortValue];
}

- (void)setBirthYearValue:(int16_t)value_ {
	[self setBirthYear:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveBirthYearValue {
	NSNumber *result = [self primitiveBirthYear];
	return [result shortValue];
}

- (void)setPrimitiveBirthYearValue:(int16_t)value_ {
	[self setPrimitiveBirthYear:[NSNumber numberWithShort:value_]];
}





@dynamic isMale;



- (BOOL)isMaleValue {
	NSNumber *result = [self isMale];
	return [result boolValue];
}

- (void)setIsMaleValue:(BOOL)value_ {
	[self setIsMale:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsMaleValue {
	NSNumber *result = [self primitiveIsMale];
	return [result boolValue];
}

- (void)setPrimitiveIsMaleValue:(BOOL)value_ {
	[self setPrimitiveIsMale:[NSNumber numberWithBool:value_]];
}





@dynamic city;

	

@dynamic colleagues;

	
- (NSMutableSet*)colleaguesSet {
	[self willAccessValueForKey:@"colleagues"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"colleagues"];
  
	[self didAccessValueForKey:@"colleagues"];
	return result;
}
	

@dynamic company;

	

@dynamic family;

	

@dynamic friends;

	
- (NSMutableOrderedSet*)friendsSet {
	[self willAccessValueForKey:@"friends"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"friends"];
  
	[self didAccessValueForKey:@"friends"];
	return result;
}
	

@dynamic peopleWhoHaveMeAsAFriend;

	
- (NSMutableSet*)peopleWhoHaveMeAsAFriendSet {
	[self willAccessValueForKey:@"peopleWhoHaveMeAsAFriend"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"peopleWhoHaveMeAsAFriend"];
  
	[self didAccessValueForKey:@"peopleWhoHaveMeAsAFriend"];
	return result;
}
	

@dynamic pets;

	
- (NSMutableSet*)petsSet {
	[self willAccessValueForKey:@"pets"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pets"];
  
	[self didAccessValueForKey:@"pets"];
	return result;
}
	

@dynamic preferedCities;

	
- (NSMutableOrderedSet*)preferedCitiesSet {
	[self willAccessValueForKey:@"preferedCities"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"preferedCities"];
  
	[self didAccessValueForKey:@"preferedCities"];
	return result;
}
	






@end
