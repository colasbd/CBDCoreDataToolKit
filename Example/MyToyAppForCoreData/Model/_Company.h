// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Company.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct CompanyAttributes {
} CompanyAttributes;

extern const struct CompanyRelationships {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *employees;
} CompanyRelationships;

extern const struct CompanyFetchedProperties {
} CompanyFetchedProperties;

@class City;
@class Person;


@interface CompanyID : NSManagedObjectID {}
@end

@interface _Company : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CompanyID*)objectID;





@property (nonatomic, strong) City *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *employees;

- (NSMutableSet*)employeesSet;





@end

@interface _Company (CoreDataGeneratedAccessors)

- (void)addEmployees:(NSSet*)value_;
- (void)removeEmployees:(NSSet*)value_;
- (void)addEmployeesObject:(Person*)value_;
- (void)removeEmployeesObject:(Person*)value_;

@end

@interface _Company (CoreDataGeneratedPrimitiveAccessors)



- (City*)primitiveCity;
- (void)setPrimitiveCity:(City*)value;



- (NSMutableSet*)primitiveEmployees;
- (void)setPrimitiveEmployees:(NSMutableSet*)value;


@end
