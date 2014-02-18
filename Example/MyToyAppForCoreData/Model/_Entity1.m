// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity1.m instead.

#import "_Entity1.h"

const struct Entity1Attributes Entity1Attributes = {
};

const struct Entity1Relationships Entity1Relationships = {
	.fromObject3 = @"fromObject3",
	.toObject2 = @"toObject2",
};

const struct Entity1FetchedProperties Entity1FetchedProperties = {
};

@implementation Entity1ID
@end

@implementation _Entity1

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Entity1" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Entity1";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Entity1" inManagedObjectContext:moc_];
}

- (Entity1ID*)objectID {
	return (Entity1ID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic fromObject3;

	

@dynamic toObject2;

	






@end
