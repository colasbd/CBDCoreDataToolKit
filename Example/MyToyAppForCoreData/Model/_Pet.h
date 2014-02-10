// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pet.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct PetAttributes {
} PetAttributes;

extern const struct PetRelationships {
	__unsafe_unretained NSString *family;
	__unsafe_unretained NSString *owner;
} PetRelationships;

extern const struct PetFetchedProperties {
} PetFetchedProperties;

@class Family;
@class Person;


@interface PetID : NSManagedObjectID {}
@end

@interface _Pet : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PetID*)objectID;





@property (nonatomic, strong) Family *family;

//- (BOOL)validateFamily:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Person *owner;

//- (BOOL)validateOwner:(id*)value_ error:(NSError**)error_;





@end

@interface _Pet (CoreDataGeneratedAccessors)

@end

@interface _Pet (CoreDataGeneratedPrimitiveAccessors)



- (Family*)primitiveFamily;
- (void)setPrimitiveFamily:(Family*)value;



- (Person*)primitiveOwner;
- (void)setPrimitiveOwner:(Person*)value;


@end
