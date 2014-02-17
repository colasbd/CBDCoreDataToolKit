//
//  CBDCoreDataDiscriminator.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSEntityDescription+CBDMiscMethods.h"



//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - Classes utilisées
/**************************************/
//
//@class <#nom de la classe#> ;








//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATION DES CONSTANTES
/**************************************/
//
//extern NSString* const <#exempleDeConstante#> ;







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATION PUBLIQUE : properties
/**************************************/


/*
 When merging, if YES, ignore wins
 */
const BOOL ignoreWinsOverNotIgnore ;




/**
 CBDCoreDataDiscriminatorUnit is a helper class for CBDCoreDataDiscriminator.
 
 CBDCoreDataDiscriminatorUnit encapsulates the data for the discrimination relatively to an entity.
 
  A CBDCoreDataDiscriminatorUnit instance refers to an NSEntityDescription and to some attributes and/or relationships to decide if two instances of this NSEntityDescription should be considered as equal.
*/
@interface CBDCoreDataDecisionUnit : NSObject
//
//
/**************************************/
#pragma mark Properties de paramétrage
/**************************************/


//
//
/**************************************/
#pragma mark Properties strong
/**************************************/


//
//
/**************************************/
#pragma mark Properties-référence
/**************************************/


//
//
/**************************************/
#pragma mark Properties read only
/**************************************/



/**
The entity of the instance
*/
@property (nonatomic, weak, readonly)NSEntityDescription *entity ;


/**
 Should this entity be ignored ?
 */
@property (nonatomic, readonly)BOOL shouldBeIgnored ;


/**
 The names of the attributes used for discrimination for the instance
 */
@property (nonatomic, readonly)NSSet* nameAttributesToUse ;



/**
 The NSRelationshipDescription's of the  relationships used for discrimination for the instance
 */
@property (nonatomic, readonly)NSSet* relationshipDescriptionsToUse ;



/**
 The names of the attributes explicitely ignored for discrimination for the instance
 */
@property (nonatomic, readonly)NSSet* nameAttributesToIgnore ;



/**
 The NSRelationshipDescription's of the  relationships explicitely ignored for discrimination for the instance
 */
@property (nonatomic, readonly)NSSet* relationshipDescriptionsToIgnore ;



/**
 The names of the other keys (they will not be used for discrimination) for the instance
 
 If non-empty, it means that the user has given some keys not corresponding to
 attributes nor relationships
 */
@property (nonatomic, readonly)NSSet* nameOtherKeys ;

//
//
/**************************************/
#pragma mark Properties de convenance
/**************************************/


//
//
/**************************************/
#pragma mark IBOutlets
/**************************************/







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATION PUBLIQUE : méthodes
/**************************************/

#pragma mark - Initialization
///Initialization

/**
 In the `init` method, you give attributes and relationships you want to use to discriminate between objects.
 */
- (id)initDiscriminatorUnitForEntity:(NSEntityDescription *)entity
                  usingAttributes:(NSArray *)namessAttributeForDiscrimination
                 andRelationships:(NSArray *)namesRelationshipForDiscrimination ;


/**
 The given entity will be ignored in the discrimination.
 
 In other words, any two instances of the given entity will be considered as similar.
 */
- (id)initIgnoringDiscriminatorUnitForEntity:(NSEntityDescription *)entity ;



/**
 Create a CBDCoreDataDiscriminatorUnit instance with all attributes
 for the given NSEntityDescription as criteria for discrimination.
 */
- (id)initSemiExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity ;



/**
 Create a CBDCoreDataDiscriminatorUnit instance with all attributes and all relationships
 for the given NSEntityDescription as criteria for discrimination.
 */
- (id)initExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity ;



/**
 In the `init` method, you give attributes and relationships you want to use to discriminate between objects.
 */
- (id)initDiscriminatorUnitForEntity:(NSEntityDescription *)entity
                  ignoringAttributes:(NSArray *)namesIgnoredAttributeForDiscrimination
                    andRelationships:(NSArray *)namesIgnoredRelationshipForDiscrimination ;



#pragma mark - Modification
/// @name Modification
/**
 The constraints will add.
 
 If one of the unit is of the "ignoring" type, then the resulting constraint will also be.
 */
- (void)mergeWith:(CBDCoreDataDecisionUnit *)anOtherUnit ;


/**
 Removes the given attributes and relationships from the DiscriminationUnit 
 */
- (void)removeAttributes:(NSArray *)namessAttributeForDiscrimination
        andRelationships:(NSArray *)namesRelationshipForDiscrimination ;




//
//#pragma mark - Discrimination
///// @name Discrimination
//
///**
// Compares two objects **using only the attributes** of this instance of CBDCoreDataDiscriminatorUnit.
// 
// This method is used by CBDCoreDataDiscriminator but should not be used directly.
// */
//- (BOOL)              doesObject:(NSManagedObject *)sourceObject
//    haveTheSameAttributeValuesAs:(NSManagedObject *)targetObject ;
//







#pragma mark - Remark
/// @name Remark
/**
 Remark : the method `isEqual:` is overwritten.
 
 Two DiscriminationUnits are equal if they are related to the same entity and operate on the same keys.
 */
- (BOOL)isEqual:(id)object ;





@end
