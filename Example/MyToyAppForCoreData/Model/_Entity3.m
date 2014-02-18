// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity3.m instead.

#import "_Entity3.h"

const struct Entity3Attributes Entity3Attributes = {
};

const struct Entity3Relationships Entity3Relationships = {
	.fromObject2 = @"fromObject2",
	.toObject1 = @"toObject1",
};

const struct Entity3FetchedProperties Entity3FetchedProperties = {
};

@implementation Entity3ID
@end

@implementation _Entity3

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Entity3" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Entity3";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Entity3" inManagedObjectContext:moc_];
}

- (Entity3ID*)objectID {
	return (Entity3ID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic fromObject2;

	

@dynamic toObject1;

	






@end
