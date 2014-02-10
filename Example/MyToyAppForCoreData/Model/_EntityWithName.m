// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityWithName.m instead.

#import "_EntityWithName.h"

const struct EntityWithNameAttributes EntityWithNameAttributes = {
	.name = @"name",
};

const struct EntityWithNameRelationships EntityWithNameRelationships = {
};

const struct EntityWithNameFetchedProperties EntityWithNameFetchedProperties = {
};

@implementation EntityWithNameID
@end

@implementation _EntityWithName

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EntityWithName" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EntityWithName";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EntityWithName" inManagedObjectContext:moc_];
}

- (EntityWithNameID*)objectID {
	return (EntityWithNameID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;











@end
