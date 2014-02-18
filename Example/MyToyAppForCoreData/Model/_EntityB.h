// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityB.h instead.

#import <CoreData/CoreData.h>


extern const struct EntityBAttributes {
} EntityBAttributes;

extern const struct EntityBRelationships {
	__unsafe_unretained NSString *objectA;
} EntityBRelationships;

extern const struct EntityBFetchedProperties {
} EntityBFetchedProperties;

@class EntityA;


@interface EntityBID : NSManagedObjectID {}
@end

@interface _EntityB : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityBID*)objectID;





@property (nonatomic, strong) EntityA *objectA;

//- (BOOL)validateObjectA:(id*)value_ error:(NSError**)error_;





@end

@interface _EntityB (CoreDataGeneratedAccessors)

@end

@interface _EntityB (CoreDataGeneratedPrimitiveAccessors)



- (EntityA*)primitiveObjectA;
- (void)setPrimitiveObjectA:(EntityA*)value;


@end
