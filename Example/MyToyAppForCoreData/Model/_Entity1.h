// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity1.h instead.

#import <CoreData/CoreData.h>


extern const struct Entity1Attributes {
} Entity1Attributes;

extern const struct Entity1Relationships {
	__unsafe_unretained NSString *fromObject3;
	__unsafe_unretained NSString *toObject2;
} Entity1Relationships;

extern const struct Entity1FetchedProperties {
} Entity1FetchedProperties;

@class Entity3;
@class Entity2;


@interface Entity1ID : NSManagedObjectID {}
@end

@interface _Entity1 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (Entity1ID*)objectID;





@property (nonatomic, strong) Entity3 *fromObject3;

//- (BOOL)validateFromObject3:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Entity2 *toObject2;

//- (BOOL)validateToObject2:(id*)value_ error:(NSError**)error_;





@end

@interface _Entity1 (CoreDataGeneratedAccessors)

@end

@interface _Entity1 (CoreDataGeneratedPrimitiveAccessors)



- (Entity3*)primitiveFromObject3;
- (void)setPrimitiveFromObject3:(Entity3*)value;



- (Entity2*)primitiveToObject2;
- (void)setPrimitiveToObject2:(Entity2*)value;


@end
