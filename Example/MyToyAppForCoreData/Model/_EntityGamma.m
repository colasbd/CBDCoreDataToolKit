// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityGamma.m instead.

#import "_EntityGamma.h"

const struct EntityGammaAttributes EntityGammaAttributes = {
};

const struct EntityGammaRelationships EntityGammaRelationships = {
	.fromBetas = @"fromBetas",
	.toAlphas = @"toAlphas",
};

const struct EntityGammaFetchedProperties EntityGammaFetchedProperties = {
};

@implementation EntityGammaID
@end

@implementation _EntityGamma

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EntityGamma" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EntityGamma";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EntityGamma" inManagedObjectContext:moc_];
}

- (EntityGammaID*)objectID {
	return (EntityGammaID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic fromBetas;

	
- (NSMutableSet*)fromBetasSet {
	[self willAccessValueForKey:@"fromBetas"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fromBetas"];
  
	[self didAccessValueForKey:@"fromBetas"];
	return result;
}
	

@dynamic toAlphas;

	
- (NSMutableSet*)toAlphasSet {
	[self willAccessValueForKey:@"toAlphas"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"toAlphas"];
  
	[self didAccessValueForKey:@"toAlphas"];
	return result;
}
	






@end
