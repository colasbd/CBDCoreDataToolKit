// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityAlpha.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct EntityAlphaAttributes {
} EntityAlphaAttributes;

extern const struct EntityAlphaRelationships {
	__unsafe_unretained NSString *friends;
	__unsafe_unretained NSString *fromGammas;
	__unsafe_unretained NSString *toBetas;
} EntityAlphaRelationships;

extern const struct EntityAlphaFetchedProperties {
} EntityAlphaFetchedProperties;

@class EntityAlpha;
@class EntityGamma;
@class EntityBeta;


@interface EntityAlphaID : NSManagedObjectID {}
@end

@interface _EntityAlpha : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityAlphaID*)objectID;





@property (nonatomic, strong) NSSet *friends;

- (NSMutableSet*)friendsSet;




@property (nonatomic, strong) NSSet *fromGammas;

- (NSMutableSet*)fromGammasSet;




@property (nonatomic, strong) NSSet *toBetas;

- (NSMutableSet*)toBetasSet;





@end

@interface _EntityAlpha (CoreDataGeneratedAccessors)

- (void)addFriends:(NSSet*)value_;
- (void)removeFriends:(NSSet*)value_;
- (void)addFriendsObject:(EntityAlpha*)value_;
- (void)removeFriendsObject:(EntityAlpha*)value_;

- (void)addFromGammas:(NSSet*)value_;
- (void)removeFromGammas:(NSSet*)value_;
- (void)addFromGammasObject:(EntityGamma*)value_;
- (void)removeFromGammasObject:(EntityGamma*)value_;

- (void)addToBetas:(NSSet*)value_;
- (void)removeToBetas:(NSSet*)value_;
- (void)addToBetasObject:(EntityBeta*)value_;
- (void)removeToBetasObject:(EntityBeta*)value_;

@end

@interface _EntityAlpha (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveFriends;
- (void)setPrimitiveFriends:(NSMutableSet*)value;



- (NSMutableSet*)primitiveFromGammas;
- (void)setPrimitiveFromGammas:(NSMutableSet*)value;



- (NSMutableSet*)primitiveToBetas;
- (void)setPrimitiveToBetas:(NSMutableSet*)value;


@end
