// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pet.m instead.

#import "_Pet.h"

const struct PetAttributes PetAttributes = {
};

const struct PetRelationships PetRelationships = {
	.family = @"family",
	.owner = @"owner",
};

const struct PetFetchedProperties PetFetchedProperties = {
};

@implementation PetID
@end

@implementation _Pet

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pet" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pet";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:moc_];
}

- (PetID*)objectID {
	return (PetID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic family;

	

@dynamic owner;

	






@end
