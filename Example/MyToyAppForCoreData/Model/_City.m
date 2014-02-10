// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.m instead.

#import "_City.h"

const struct CityAttributes CityAttributes = {
};

const struct CityRelationships CityRelationships = {
	.companies = @"companies",
	.inhabitants = @"inhabitants",
	.lovers = @"lovers",
};

const struct CityFetchedProperties CityFetchedProperties = {
};

@implementation CityID
@end

@implementation _City

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"City";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"City" inManagedObjectContext:moc_];
}

- (CityID*)objectID {
	return (CityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic companies;

	
- (NSMutableSet*)companiesSet {
	[self willAccessValueForKey:@"companies"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"companies"];
  
	[self didAccessValueForKey:@"companies"];
	return result;
}
	

@dynamic inhabitants;

	
- (NSMutableSet*)inhabitantsSet {
	[self willAccessValueForKey:@"inhabitants"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"inhabitants"];
  
	[self didAccessValueForKey:@"inhabitants"];
	return result;
}
	

@dynamic lovers;

	
- (NSMutableSet*)loversSet {
	[self willAccessValueForKey:@"lovers"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"lovers"];
  
	[self didAccessValueForKey:@"lovers"];
	return result;
}
	






@end
