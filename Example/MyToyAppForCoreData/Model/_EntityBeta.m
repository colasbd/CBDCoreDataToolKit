// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityBeta.m instead.

#import "_EntityBeta.h"

const struct EntityBetaAttributes EntityBetaAttributes = {
};

const struct EntityBetaRelationships EntityBetaRelationships = {
	.fromAlphas = @"fromAlphas",
	.toGammas = @"toGammas",
};

const struct EntityBetaFetchedProperties EntityBetaFetchedProperties = {
};

@implementation EntityBetaID
@end

@implementation _EntityBeta

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EntityBeta" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EntityBeta";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EntityBeta" inManagedObjectContext:moc_];
}

- (EntityBetaID*)objectID {
	return (EntityBetaID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic fromAlphas;

	
- (NSMutableSet*)fromAlphasSet {
	[self willAccessValueForKey:@"fromAlphas"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fromAlphas"];
  
	[self didAccessValueForKey:@"fromAlphas"];
	return result;
}
	

@dynamic toGammas;

	
- (NSMutableSet*)toGammasSet {
	[self willAccessValueForKey:@"toGammas"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"toGammas"];
  
	[self didAccessValueForKey:@"toGammas"];
	return result;
}
	






@end
