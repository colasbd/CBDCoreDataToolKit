// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntitySelf.m instead.

#import "_EntitySelf.h"

const struct EntitySelfAttributes EntitySelfAttributes = {
};

const struct EntitySelfRelationships EntitySelfRelationships = {
	.objectSelf = @"objectSelf",
};

const struct EntitySelfFetchedProperties EntitySelfFetchedProperties = {
};

@implementation EntitySelfID
@end

@implementation _EntitySelf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EntitySelf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EntitySelf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EntitySelf" inManagedObjectContext:moc_];
}

- (EntitySelfID*)objectID {
	return (EntitySelfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic objectSelf;

	






@end
