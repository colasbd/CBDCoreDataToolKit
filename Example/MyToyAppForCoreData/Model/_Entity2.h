// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity2.h instead.

#import <CoreData/CoreData.h>


extern const struct Entity2Attributes {
} Entity2Attributes;

extern const struct Entity2Relationships {
	__unsafe_unretained NSString *fromObject1;
	__unsafe_unretained NSString *toObject3;
} Entity2Relationships;

extern const struct Entity2FetchedProperties {
} Entity2FetchedProperties;

@class Entity1;
@class Entity3;


@interface Entity2ID : NSManagedObjectID {}
@end

@interface _Entity2 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (Entity2ID*)objectID;





@property (nonatomic, strong) Entity1 *fromObject1;

//- (BOOL)validateFromObject1:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Entity3 *toObject3;

//- (BOOL)validateToObject3:(id*)value_ error:(NSError**)error_;





@end

@interface _Entity2 (CoreDataGeneratedAccessors)

@end

@interface _Entity2 (CoreDataGeneratedPrimitiveAccessors)



- (Entity1*)primitiveFromObject1;
- (void)setPrimitiveFromObject1:(Entity1*)value;



- (Entity3*)primitiveToObject3;
- (void)setPrimitiveToObject3:(Entity3*)value;


@end
