// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>
#import "EntityWithName.h"

extern const struct PersonAttributes {
	__unsafe_unretained NSString *birthYear;
	__unsafe_unretained NSString *isMale;
} PersonAttributes;

extern const struct PersonRelationships {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *colleagues;
	__unsafe_unretained NSString *company;
	__unsafe_unretained NSString *family;
	__unsafe_unretained NSString *friends;
	__unsafe_unretained NSString *peopleWhoHaveMeAsAFriend;
	__unsafe_unretained NSString *pets;
	__unsafe_unretained NSString *preferedCities;
} PersonRelationships;

extern const struct PersonFetchedProperties {
} PersonFetchedProperties;

@class City;
@class Person;
@class Company;
@class Family;
@class Person;
@class Person;
@class Pet;
@class City;




@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : EntityWithName {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;





@property (nonatomic, strong) NSNumber* birthYear;



@property int16_t birthYearValue;
- (int16_t)birthYearValue;
- (void)setBirthYearValue:(int16_t)value_;

//- (BOOL)validateBirthYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isMale;



@property BOOL isMaleValue;
- (BOOL)isMaleValue;
- (void)setIsMaleValue:(BOOL)value_;

//- (BOOL)validateIsMale:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) City *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *colleagues;

- (NSMutableSet*)colleaguesSet;




@property (nonatomic, strong) Company *company;

//- (BOOL)validateCompany:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Family *family;

//- (BOOL)validateFamily:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSOrderedSet *friends;

- (NSMutableOrderedSet*)friendsSet;




@property (nonatomic, strong) NSSet *peopleWhoHaveMeAsAFriend;

- (NSMutableSet*)peopleWhoHaveMeAsAFriendSet;




@property (nonatomic, strong) NSSet *pets;

- (NSMutableSet*)petsSet;




@property (nonatomic, strong) NSOrderedSet *preferedCities;

- (NSMutableOrderedSet*)preferedCitiesSet;





@end

@interface _Person (CoreDataGeneratedAccessors)

- (void)addColleagues:(NSSet*)value_;
- (void)removeColleagues:(NSSet*)value_;
- (void)addColleaguesObject:(Person*)value_;
- (void)removeColleaguesObject:(Person*)value_;

- (void)addFriends:(NSOrderedSet*)value_;
- (void)removeFriends:(NSOrderedSet*)value_;
- (void)addFriendsObject:(Person*)value_;
- (void)removeFriendsObject:(Person*)value_;

- (void)addPeopleWhoHaveMeAsAFriend:(NSSet*)value_;
- (void)removePeopleWhoHaveMeAsAFriend:(NSSet*)value_;
- (void)addPeopleWhoHaveMeAsAFriendObject:(Person*)value_;
- (void)removePeopleWhoHaveMeAsAFriendObject:(Person*)value_;

- (void)addPets:(NSSet*)value_;
- (void)removePets:(NSSet*)value_;
- (void)addPetsObject:(Pet*)value_;
- (void)removePetsObject:(Pet*)value_;

- (void)addPreferedCities:(NSOrderedSet*)value_;
- (void)removePreferedCities:(NSOrderedSet*)value_;
- (void)addPreferedCitiesObject:(City*)value_;
- (void)removePreferedCitiesObject:(City*)value_;

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveBirthYear;
- (void)setPrimitiveBirthYear:(NSNumber*)value;

- (int16_t)primitiveBirthYearValue;
- (void)setPrimitiveBirthYearValue:(int16_t)value_;




- (NSNumber*)primitiveIsMale;
- (void)setPrimitiveIsMale:(NSNumber*)value;

- (BOOL)primitiveIsMaleValue;
- (void)setPrimitiveIsMaleValue:(BOOL)value_;





- (City*)primitiveCity;
- (void)setPrimitiveCity:(City*)value;



- (NSMutableSet*)primitiveColleagues;
- (void)setPrimitiveColleagues:(NSMutableSet*)value;



- (Company*)primitiveCompany;
- (void)setPrimitiveCompany:(Company*)value;



- (Family*)primitiveFamily;
- (void)setPrimitiveFamily:(Family*)value;



- (NSMutableOrderedSet*)primitiveFriends;
- (void)setPrimitiveFriends:(NSMutableOrderedSet*)value;



- (NSMutableSet*)primitivePeopleWhoHaveMeAsAFriend;
- (void)setPrimitivePeopleWhoHaveMeAsAFriend:(NSMutableSet*)value;



- (NSMutableSet*)primitivePets;
- (void)setPrimitivePets:(NSMutableSet*)value;



- (NSMutableOrderedSet*)primitivePreferedCities;
- (void)setPrimitivePreferedCities:(NSMutableOrderedSet*)value;


@end
