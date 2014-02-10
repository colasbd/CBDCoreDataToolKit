// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Family.m instead.

#import "_Family.h"

const struct FamilyAttributes FamilyAttributes = {
};

const struct FamilyRelationships FamilyRelationships = {
	.members = @"members",
	.pets = @"pets",
};

const struct FamilyFetchedProperties FamilyFetchedProperties = {
};

@implementation FamilyID
@end

@implementation _Family

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Family" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Family";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Family" inManagedObjectContext:moc_];
}

- (FamilyID*)objectID {
	return (FamilyID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic members;

	
- (NSMutableSet*)membersSet {
	[self willAccessValueForKey:@"members"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"members"];
  
	[self didAccessValueForKey:@"members"];
	return result;
}
	

@dynamic pets;

	
- (NSMutableSet*)petsSet {
	[self willAccessValueForKey:@"pets"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pets"];
  
	[self didAccessValueForKey:@"pets"];
	return result;
}
	






@end
