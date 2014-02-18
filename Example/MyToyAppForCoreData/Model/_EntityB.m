// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityB.m instead.

#import "_EntityB.h"

const struct EntityBAttributes EntityBAttributes = {
};

const struct EntityBRelationships EntityBRelationships = {
	.objectA = @"objectA",
};

const struct EntityBFetchedProperties EntityBFetchedProperties = {
};

@implementation EntityBID
@end

@implementation _EntityB

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EntityB" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EntityB";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EntityB" inManagedObjectContext:moc_];
}

- (EntityBID*)objectID {
	return (EntityBID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic objectA;

	






@end
