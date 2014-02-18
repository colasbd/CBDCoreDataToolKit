// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityA.h instead.

#import <CoreData/CoreData.h>


extern const struct EntityAAttributes {
} EntityAAttributes;

extern const struct EntityARelationships {
	__unsafe_unretained NSString *objectB;
} EntityARelationships;

extern const struct EntityAFetchedProperties {
} EntityAFetchedProperties;

@class EntityB;


@interface EntityAID : NSManagedObjectID {}
@end

@interface _EntityA : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityAID*)objectID;





@property (nonatomic, strong) EntityB *objectB;

//- (BOOL)validateObjectB:(id*)value_ error:(NSError**)error_;





@end

@interface _EntityA (CoreDataGeneratedAccessors)

@end

@interface _EntityA (CoreDataGeneratedPrimitiveAccessors)



- (EntityB*)primitiveObjectB;
- (void)setPrimitiveObjectB:(EntityB*)value;


@end
