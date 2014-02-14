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

/**
 CBDCoreDataDiscriminatorUnit is a helper class for CBDCoreDataDiscriminator.
 
 CBDCoreDataDiscriminatorUnit encapsulates the data for the discrimination relatively to an entity.
 
  A CBDCoreDataDiscriminatorUnit instance refers to an NSEntityDescription and to some attributes and/or relationships to decide if two instances of this NSEntityDescription should be considered as equal.
*/
@interface CBDCoreDataDiscriminatorUnit : NSObject
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
 The names of the attributes used for discrimination for the instance
 */
@property (nonatomic, strong, readonly)NSSet* nameAttributes ;


/**
 The NSRelationshipDescription's of the  relationships used for discrimination for the instance
 */
@property (nonatomic, readonly)NSSet* relationshipDescriptions ;


/**
 The NSRelationshipDescription's of the to-one relationships used for discrimination for the instance
 */
@property (nonatomic, strong, readonly)NSSet* toOneRelationshipDescriptions ;

/**
 The NSRelationshipDescription's of the non-ordered to-many relationships used for discrimination for the instance
 */
@property (nonatomic, strong, readonly)NSSet* nonOrderedToManyRelationshipDescriptions ;

/**
 The NSRelationshipDescription's of the ordered to-many relationships used for discrimination for the instance
 */
@property (nonatomic, strong, readonly)NSSet* orderedToManyRelationshipDescriptions ;

/**
 The names of the other keys (they will not be used for discrimination) for the instance
 
 If non-empty, it means that the user has given some keys not corresponding to
 attributes nor relationships
 */
@property (nonatomic, strong, readonly)NSSet* nameOtherKeys ;

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

///Initialization

/**
 In the `init` method, you give attributes and relationships you want to use to discriminate between objects.
 */
TODO(plutôt entityWithName)
-             (id) initForEntity:(NSEntityDescription *)entity
    withDiscriminationAttributes:(NSArray *)namessAttributeForDiscrimination
 withDiscriminationRelationships:(NSArray *)namesRelationshipForDiscrimination ;

TODO(possibilité de dire : on ignore les entités...)


/**
 Create a CBDCoreDataDiscriminatorUnit instance with all attributes
 for the given NSEntityDescription as criteria for discrimination.
 */
-     (id)initSemiExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity ;



/**
 Create a CBDCoreDataDiscriminatorUnit instance with all attributes and all relationships
 for the given NSEntityDescription as criteria for discrimination.
 */
-     (id)initExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity ;


/// Discrimination

/**
 Compares two objects **using only the attributes** of this instance of CBDCoreDataDiscriminatorUnit.
 
 This method is used by CBDCoreDataDiscriminator but should not be used directly.
 */
- (BOOL)              doesObject:(NSManagedObject *)sourceObject
    haveTheSameAttributeValuesAs:(NSManagedObject *)targetObject ;





/**
 Remark : the method `isEqual:` is overwritten.
 
 Two DiscriminationUnits are equal if they are related to the same entity and operate on the same keys.
 */
- (BOOL)isEqual:(id)object ;





@end
