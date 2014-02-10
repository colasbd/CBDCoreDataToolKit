// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EntityWithName.h instead.

#import <CoreData/CoreData.h>


extern const struct EntityWithNameAttributes {
	__unsafe_unretained NSString *name;
} EntityWithNameAttributes;

extern const struct EntityWithNameRelationships {
} EntityWithNameRelationships;

extern const struct EntityWithNameFetchedProperties {
} EntityWithNameFetchedProperties;




@interface EntityWithNameID : NSManagedObjectID {}
@end

@interface _EntityWithName : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityWithNameID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _EntityWithName (CoreDataGeneratedAccessors)

@end

@interface _EntityWithName (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
