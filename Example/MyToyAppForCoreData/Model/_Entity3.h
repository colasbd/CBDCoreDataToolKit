// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity3.h instead.

#import <CoreData/CoreData.h>


extern const struct Entity3Attributes {
} Entity3Attributes;

extern const struct Entity3Relationships {
	__unsafe_unretained NSString *fromObject2;
	__unsafe_unretained NSString *toObject1;
} Entity3Relationships;

extern const struct Entity3FetchedProperties {
} Entity3FetchedProperties;

@class Entity2;
@class Entity1;


@interface Entity3ID : NSManagedObjectID {}
@end

@interface _Entity3 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (Entity3ID*)objectID;





@property (nonatomic, strong) Entity2 *fromObject2;

//- (BOOL)validateFromObject2:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Entity1 *toObject1;

//- (BOOL)validateToObject1:(id*)value_ error:(NSError**)error_;





@end

@interface _Entity3 (CoreDataGeneratedAccessors)

@end

@interface _Entity3 (CoreDataGeneratedPrimitiveAccessors)



- (Entity2*)primitiveFromObject2;
- (void)setPrimitiveFromObject2:(Entity2*)value;



- (Entity1*)primitiveToObject1;
- (void)setPrimitiveToObject1:(Entity1*)value;


@end
