//
//  CBDCoreDataDiscriminator.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import "CBDCoreDataDecisionUnit.h"




/**
 CBDCoreDataDiscriminator is a helper class for CBDCoreDataDiscriminator.
 
 Short:
 CBDCoreDataDiscriminator helps CBDCoreDataImporter to discriminate if two objects should be considered as the equal.
 
 Long:
 When you import an object from `sourceMOC` to `targetMOC`, you want to avoid some problems. For instance, your MOCs may refer to two different copies of the same data. In this case, your two MOCs won't have any object in common: in real, the objects are the same but on the computer, they will have a different `objectID` for instance.
 
 So, to deal with this issue, instead of comparing object with `==` (or with `isEqual:`, which will be the same in that case, we use CBDCoreDataDiscriminator.
 
 A CBDCoreDataDiscriminator instance refers to several CBDCoreDataDiscrimintorUnit instances
 */
@interface CBDCoreDataDiscriminator : NSObject







#pragma mark - Initialisation
/// @name Initialisation
/**
 The usual `init` method.
 */
- (id)init ;


/**
 A copy method.
 */
- (id)copy ;








#pragma mark - Managing the cache
/// @name Managing the cache

/**
 Removes all the entries of the cache
 */
- (void)flushTheCache ;

/**
 Removes the last entry of the cache
 */
- (void)removeLastEntryOfTheCache ;

/**
 Show the cache
 */
- (void)logTheCache ;





#pragma mark - Choosing the mode of discrimination
/// @name Choosing the mode of discrimination

/**
 Chooses the facilitating type. This is the default type. When you change types, the cache is flushed.
 
 When an entity has no DiscriminatorUnit explicitely associated,
 all the objects of such entities will be declared equal. It
 is equivalent to ignoring this entity.
 
 The relationships to objects with this entity will also be ignored.
 */
- (void)chooseFacilitatingType ;

/**
 Chooses the semi-facilitating type. This is the default type. When you change types, the cache is flushed.
 
 When an entity has no DiscriminatorUnit explicitely associated,
 to compare two object of this entity, we only consider their attributes.
 
 This option is convenient but in some case, it could be too demanding, for instance if the objects of the given entity are markes with a `dateOfCreation` very precise.
 */
- (void)chooseSemiFacilitatingType ;

/**
 Chooses the demanding type. This is the default type. When you change types, the cache is flushed.
 
 When an entity has no DiscriminatorUnit explicitely associated,
 to compare two object of this entity,
 we consider both all the attributes and all the relationships.
 
 */
- (void)chooseDemandingType ;







//
//#pragma mark - Managing the discrimination units
///// @name Managing the discrimination units
//
///**
// The discriminatorUnits composing the instance
// */
//@property (nonatomic, readonly)NSArray * discriminatorUnits ;
//
//
///**
// The entities explicitely registered by the instance for discriminating
// */
//@property (nonatomic, readonly)NSArray * registeredEntities ;
//
//
///**
// To perform a discrimination, one should tell the CBDCoreDataDiscriminator upon which criteria the discrimination will be done.
// 
// So, you should DiscriminatorUnits if you want to precise to the engine upon which criteria you want the discrimination to be done.
// */
//- (void)addDiscriminatorUnit:(CBDCoreDataDecisionUnit *)aDiscriminatorUnit ;
//
//
//
///**
// Remove all the DiscriminatorUnits.
// */
//- (void)removeAllDiscriminatorUnits ;
//
//
//
///**
// Remove the DiscriminatorUnit for entity
//*/
//- (void)removeDiscriminatorUnitFor:(NSEntityDescription *)entity ;
//





//
//
/**************************************/
#pragma mark - Using the discriminatorUnits
/**************************************/
/// @name Using the discriminatorUnits





/**
 Returns the attributes to check for the entity.
 
 It uses the entity but also the parent entity (the superentity).
 @warning If there is a conflict, it the entity wins over the superentity
 @warning If there is a conflict, "ignore" wins over "include", depending on the value of the BOOL ignoreWinsOverInclude
 */
- (NSSet *)attributesToCheckFor:(NSEntityDescription *)entity ;

/**
 Returns the attributes to check for the entity.
 
 It uses the entity but also the parent entity (the superentity).
 @warning If there is a conflict, it the entity wins over the superentity
 @warning If there is a conflict, "ignore" wins over "include", depending on the value of the BOOL ignoreWinsOverInclude
 */
- (NSSet *)relationshipsToCheckFor:(NSEntityDescription *)entity ;


/**
 Reply YES if the entity should be ignored in the discrimination
 */
- (BOOL)shouldIgnore:(NSEntityDescription *)entity ;






//
//
/**************************************/
#pragma mark - Discriminate with attributes
/**************************************/
/// @name Discriminate with attributes


/**
 Using the attribute to check and not those to ignore, 
 considering also the information given about the parent entities,
 determine if the two objects are similar.
 
 The core method isThisSourceObject:similarToTargetObject: use this method and 
 also cheks the relationships
 */
- (BOOL)            doesObject:(NSManagedObject *)sourceObject
  haveTheSameAttributeValuesAs:(NSManagedObject *)targetObject ;




#pragma mark - Discriminate
/// @name Discriminate

/**
 The core and convenient method that compare two objects.
 
 By default, we use the semi-facilitating mode.
 
 By default, the result is stored in the cache.
 */
- (BOOL)isThisSourceObject:(NSManagedObject *)sourceObject
     similarToTargetObject:(NSManagedObject *)targetObject ;


/**
 Finding similar objects
 */
- (NSArray *)similarObjectTo:(NSManagedObject *)sourceObject
                       inMOC:(NSManagedObjectContext *)MOC ;

/**
 First similar objects
 */
- (NSManagedObject *)firstSimilarObjectTo:(NSManagedObject *)sourceObject
                                    inMOC:(NSManagedObjectContext *)MOC ;


#pragma mark - Managing the log
/// @name Managing the cache

/**
 Turn ON/OFF the log
 */
- (void)shouldLog:(BOOL)shouldLog ;



@end
