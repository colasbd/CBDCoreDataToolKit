// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityGamma.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct EntityGammaAttributes {
} EntityGammaAttributes;

extern const struct EntityGammaRelationships {
	__unsafe_unretained NSString *fromBetas;
	__unsafe_unretained NSString *toAlphas;
} EntityGammaRelationships;

extern const struct EntityGammaFetchedProperties {
} EntityGammaFetchedProperties;

@class EntityBeta;
@class EntityAlpha;


@interface EntityGammaID : NSManagedObjectID {}
@end

@interface _EntityGamma : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityGammaID*)objectID;





@property (nonatomic, strong) NSSet *fromBetas;

- (NSMutableSet*)fromBetasSet;




@property (nonatomic, strong) NSSet *toAlphas;

- (NSMutableSet*)toAlphasSet;





@end

@interface _EntityGamma (CoreDataGeneratedAccessors)

- (void)addFromBetas:(NSSet*)value_;
- (void)removeFromBetas:(NSSet*)value_;
- (void)addFromBetasObject:(EntityBeta*)value_;
- (void)removeFromBetasObject:(EntityBeta*)value_;

- (void)addToAlphas:(NSSet*)value_;
- (void)removeToAlphas:(NSSet*)value_;
- (void)addToAlphasObject:(EntityAlpha*)value_;
- (void)removeToAlphasObject:(EntityAlpha*)value_;

@end

@interface _EntityGamma (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveFromBetas;
- (void)setPrimitiveFromBetas:(NSMutableSet*)value;



- (NSMutableSet*)primitiveToAlphas;
- (void)setPrimitiveToAlphas:(NSMutableSet*)value;


@end
