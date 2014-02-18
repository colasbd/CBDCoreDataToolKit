// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity2.m instead.

#import "_Entity2.h"

const struct Entity2Attributes Entity2Attributes = {
};

const struct Entity2Relationships Entity2Relationships = {
	.fromObject1 = @"fromObject1",
	.toObject3 = @"toObject3",
};

const struct Entity2FetchedProperties Entity2FetchedProperties = {
};

@implementation Entity2ID
@end

@implementation _Entity2

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Entity2" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Entity2";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Entity2" inManagedObjectContext:moc_];
}

- (Entity2ID*)objectID {
	return (Entity2ID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic fromObject1;

	

@dynamic toObject3;

	






@end
