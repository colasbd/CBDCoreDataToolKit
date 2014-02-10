// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Company.m instead.

#import "_Company.h"

const struct CompanyAttributes CompanyAttributes = {
};

const struct CompanyRelationships CompanyRelationships = {
	.city = @"city",
	.employees = @"employees",
};

const struct CompanyFetchedProperties CompanyFetchedProperties = {
};

@implementation CompanyID
@end

@implementation _Company

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Company";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Company" inManagedObjectContext:moc_];
}

- (CompanyID*)objectID {
	return (CompanyID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic city;

	

@dynamic employees;

	
- (NSMutableSet*)employeesSet {
	[self willAccessValueForKey:@"employees"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"employees"];
  
	[self didAccessValueForKey:@"employees"];
	return result;
}
	






@end
