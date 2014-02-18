// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityBeta.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct EntityBetaAttributes {
} EntityBetaAttributes;

extern const struct EntityBetaRelationships {
	__unsafe_unretained NSString *fromAlphas;
	__unsafe_unretained NSString *toGammas;
} EntityBetaRelationships;

extern const struct EntityBetaFetchedProperties {
} EntityBetaFetchedProperties;

@class EntityAlpha;
@class EntityGamma;


@interface EntityBetaID : NSManagedObjectID {}
@end

@interface _EntityBeta : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityBetaID*)objectID;





@property (nonatomic, strong) NSSet *fromAlphas;

- (NSMutableSet*)fromAlphasSet;




@property (nonatomic, strong) NSSet *toGammas;

- (NSMutableSet*)toGammasSet;





@end

@interface _EntityBeta (CoreDataGeneratedAccessors)

- (void)addFromAlphas:(NSSet*)value_;
- (void)removeFromAlphas:(NSSet*)value_;
- (void)addFromAlphasObject:(EntityAlpha*)value_;
- (void)removeFromAlphasObject:(EntityAlpha*)value_;

- (void)addToGammas:(NSSet*)value_;
- (void)removeToGammas:(NSSet*)value_;
- (void)addToGammasObject:(EntityGamma*)value_;
- (void)removeToGammasObject:(EntityGamma*)value_;

@end

@interface _EntityBeta (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveFromAlphas;
- (void)setPrimitiveFromAlphas:(NSMutableSet*)value;



- (NSMutableSet*)primitiveToGammas;
- (void)setPrimitiveToGammas:(NSMutableSet*)value;


@end
