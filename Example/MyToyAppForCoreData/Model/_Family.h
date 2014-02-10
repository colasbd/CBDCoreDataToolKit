// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Family.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct FamilyAttributes {
} FamilyAttributes;

extern const struct FamilyRelationships {
	__unsafe_unretained NSString *members;
	__unsafe_unretained NSString *pets;
} FamilyRelationships;

extern const struct FamilyFetchedProperties {
} FamilyFetchedProperties;

@class Person;
@class Pet;


@interface FamilyID : NSManagedObjectID {}
@end

@interface _Family : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FamilyID*)objectID;





@property (nonatomic, strong) NSSet *members;

- (NSMutableSet*)membersSet;




@property (nonatomic, strong) NSSet *pets;

- (NSMutableSet*)petsSet;





@end

@interface _Family (CoreDataGeneratedAccessors)

- (void)addMembers:(NSSet*)value_;
- (void)removeMembers:(NSSet*)value_;
- (void)addMembersObject:(Person*)value_;
- (void)removeMembersObject:(Person*)value_;

- (void)addPets:(NSSet*)value_;
- (void)removePets:(NSSet*)value_;
- (void)addPetsObject:(Pet*)value_;
- (void)removePetsObject:(Pet*)value_;

@end

@interface _Family (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveMembers;
- (void)setPrimitiveMembers:(NSMutableSet*)value;



- (NSMutableSet*)primitivePets;
- (void)setPrimitivePets:(NSMutableSet*)value;


@end
