//
//  NSEntityDescription+CBDMiscMethods.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <CoreData/CoreData.h>

@interface NSEntityDescription (CBDMiscMethods)

extern NSString* const CBDKeyDescriptionAttribute ;
extern NSString* const CBDKeyDescriptionToOneRelationship ;
extern NSString* const CBDKeyDescriptionToManyNonOrderedRelationship ;
extern NSString* const CBDKeyDescriptionToManyOrderedRelationship ;
extern NSString* const CBDKeyUnmatchedKey ;



//
//
/**************************************/
#pragma mark - Getting the relationships and attributes
/**************************************/
/// @name Getting the relationships and attributes

/**
 This method takes an array of names and return a dictionnary.
 
 The dictionnary returned has five keys:
  - CBDKeyDescriptionAttribute ;
  - CBDKeyDescriptionToOneRelationship ;
  - CBDKeyDescriptionToManyNonOrderedRelationship ;
  - CBDKeyDescriptionToManyOrderedRelationship ;
  - CBDKeyUnmatchedKey ;
 
 The names in the NSArray* argument namesOfAttributesOrRelationships are dispatched in these five keys. 
 If the name does not correspond to any attribute or relationships, it will be in "excluded".
 
 The object for each key is a NSArray.
 */
- (NSDictionary *)dispatchedAttributesAndRelationshipsFrom_cbd_:(NSArray *)namesOfAttributesOrRelationships ;




/**
 This method takes an set of RelationshipDescription and return a dictionnary.
 
 The dictionnary returned has four keys:
 - CBDKeyDescriptionToOneRelationship ;
 - CBDKeyDescriptionToManyNonOrderedRelationship ;
 - CBDKeyDescriptionToManyOrderedRelationship ;
 - CBDKeyUnmatchedKey ;
 
 The relationships in the NSSet* argument setOfRelationshipDescriptions are dispatched in these four keys.
 If the relationships does not correspond to any relationships, it will be associated to the CBDKeyUnmatchedKey.
 
 The object for each key is a NSSet.
 */
- (NSDictionary *)dispatchedRelationshipsFrom_cbd_:(NSSet *)setOfRelationshipDescriptions ;



/**
 This method returns a dictionnary with the relationships dispatched, with the same pattern as before.
 
 The object for each key is a NSSet.
 */
- (NSDictionary *)dispatchedRelationships_cbd_ ;




//
//
/**************************************/
#pragma mark - Managing parent entities
/**************************************/
/// @name Getting the relationships and attributes



/**
 Is the instance a subentity on the entity (in the same model) with the given name.
 */
- (BOOL)isKindOfEntityWithName_cbd_:(NSString *)nameEntity ;


/**
 Returns the entities whose the instance inherits
 */
- (NSSet *)parentEntitiesAmong_cbd_:(NSSet *)setOfEntities ;

/**
 Returns YES if any of the entities in the given set is a "parent-entity" of the instance
 */
- (BOOL)inheritsFromSomeEntityAmong_cbd_:(NSSet *)setOfEntities ;

@end
