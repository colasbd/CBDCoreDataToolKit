// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct CityAttributes {
} CityAttributes;

extern const struct CityRelationships {
	__unsafe_unretained NSString *companies;
	__unsafe_unretained NSString *inhabitants;
	__unsafe_unretained NSString *lovers;
} CityRelationships;

extern const struct CityFetchedProperties {
} CityFetchedProperties;

@class Company;
@class Person;
@class Person;


@interface CityID : NSManagedObjectID {}
@end

@interface _City : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CityID*)objectID;





@property (nonatomic, strong) NSSet *companies;

- (NSMutableSet*)companiesSet;




@property (nonatomic, strong) NSSet *inhabitants;

- (NSMutableSet*)inhabitantsSet;




@property (nonatomic, strong) NSSet *lovers;

- (NSMutableSet*)loversSet;





@end

@interface _City (CoreDataGeneratedAccessors)

- (void)addCompanies:(NSSet*)value_;
- (void)removeCompanies:(NSSet*)value_;
- (void)addCompaniesObject:(Company*)value_;
- (void)removeCompaniesObject:(Company*)value_;

- (void)addInhabitants:(NSSet*)value_;
- (void)removeInhabitants:(NSSet*)value_;
- (void)addInhabitantsObject:(Person*)value_;
- (void)removeInhabitantsObject:(Person*)value_;

- (void)addLovers:(NSSet*)value_;
- (void)removeLovers:(NSSet*)value_;
- (void)addLoversObject:(Person*)value_;
- (void)removeLoversObject:(Person*)value_;

@end

@interface _City (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveCompanies;
- (void)setPrimitiveCompanies:(NSMutableSet*)value;



- (NSMutableSet*)primitiveInhabitants;
- (void)setPrimitiveInhabitants:(NSMutableSet*)value;



- (NSMutableSet*)primitiveLovers;
- (void)setPrimitiveLovers:(NSMutableSet*)value;


@end
