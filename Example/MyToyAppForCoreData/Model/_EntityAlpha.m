// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityAlpha.m instead.

#import "_EntityAlpha.h"

const struct EntityAlphaAttributes EntityAlphaAttributes = {
};

const struct EntityAlphaRelationships EntityAlphaRelationships = {
	.friends = @"friends",
	.fromGammas = @"fromGammas",
	.toBetas = @"toBetas",
};

const struct EntityAlphaFetchedProperties EntityAlphaFetchedProperties = {
};

@implementation EntityAlphaID
@end

@implementation _EntityAlpha

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EntityAlpha" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EntityAlpha";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EntityAlpha" inManagedObjectContext:moc_];
}

- (EntityAlphaID*)objectID {
	return (EntityAlphaID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic friends;

	
- (NSMutableSet*)friendsSet {
	[self willAccessValueForKey:@"friends"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"friends"];
  
	[self didAccessValueForKey:@"friends"];
	return result;
}
	

@dynamic fromGammas;

	
- (NSMutableSet*)fromGammasSet {
	[self willAccessValueForKey:@"fromGammas"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fromGammas"];
  
	[self didAccessValueForKey:@"fromGammas"];
	return result;
}
	

@dynamic toBetas;

	
- (NSMutableSet*)toBetasSet {
	[self willAccessValueForKey:@"toBetas"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"toBetas"];
  
	[self didAccessValueForKey:@"toBetas"];
	return result;
}
	






@end
