// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntitySelf.h instead.

#import <CoreData/CoreData.h>


extern const struct EntitySelfAttributes {
} EntitySelfAttributes;

extern const struct EntitySelfRelationships {
	__unsafe_unretained NSString *objectSelf;
} EntitySelfRelationships;

extern const struct EntitySelfFetchedProperties {
} EntitySelfFetchedProperties;

@class EntitySelf;


@interface EntitySelfID : NSManagedObjectID {}
@end

@interface _EntitySelf : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntitySelfID*)objectID;





@property (nonatomic, strong) EntitySelf *objectSelf;

//- (BOOL)validateObjectSelf:(id*)value_ error:(NSError**)error_;





@end

@interface _EntitySelf (CoreDataGeneratedAccessors)

@end

@interface _EntitySelf (CoreDataGeneratedPrimitiveAccessors)



- (EntitySelf*)primitiveObjectSelf;
- (void)setPrimitiveObjectSelf:(EntitySelf*)value;


@end
