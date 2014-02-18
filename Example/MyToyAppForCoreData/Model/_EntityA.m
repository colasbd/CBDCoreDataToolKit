// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityA.m instead.

#import "_EntityA.h"

const struct EntityAAttributes EntityAAttributes = {
};

const struct EntityARelationships EntityARelationships = {
	.objectB = @"objectB",
};

const struct EntityAFetchedProperties EntityAFetchedProperties = {
};

@implementation EntityAID
@end

@implementation _EntityA

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EntityA" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EntityA";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EntityA" inManagedObjectContext:moc_];
}

- (EntityAID*)objectID {
	return (EntityAID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic objectB;

	






@end
