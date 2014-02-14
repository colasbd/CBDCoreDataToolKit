//
//  CBDCoreDataDiscriminatorHintCatalog.h
//  Pods
//
//  Created by Colas on 13/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CBDCoreDataDiscriminatorSimilarityStatus.h"




//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - Classes utilisées
/**************************************/
//
@class CBDCoreDataDiscriminatorHint ;








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
@interface CBDCoreDataDiscriminatorHintCatalog : NSObject
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
@property (nonatomic, readonly)NSOrderedSet * hints ;

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


/// Initialisation and setting

// This method is private
//+ (CBDCoreDataDiscriminatorSimilarityStatus)statusFromArrayOfStatus:(NSArray *)arrayOfStatus ;

/**
 An init method.
 */
- (id)init ;

/**
 A copy method.
 */
- (id)copy ;

// This method is private
//- (void)addHint:(CBDCoreDataDiscriminatorHint *)hint ;

/**
 Gives a hint about similarity.
 */
- (void)addHintOfSimilarityBetwenSourceObject:(NSManagedObject *)sourceObject
                              andTargetObject:(NSManagedObject *)targetObject
                                    hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus ;


/**
 Gives a hint that a relationship should not be checked (to avoid infinite loops).
 */
- (void)addHintBetweenSourceObject:(NSManagedObject *)sourceObject
                   andTargetObject:(NSManagedObject *)targetObject
         toNotCheckTheRelationship:(NSRelationshipDescription *)relation ;


/**
 Adds hints.
 */
- (void)addHintsFromCatalog:(CBDCoreDataDiscriminatorHintCatalog *)hintCatalog ;




/// Flushing the catalog

/**
 Removes all the hints from the hintCatalog.
 */
- (void)flush ;

/**
 Removes the last hint from the hintCatalog.
 */
- (void)removeLastHint ;



/// Using the HintCatalog

/**
 Decides, depending of the HintCatalog, what can be said about the similary between sourceObject and targetObject
 */
- (CBDCoreDataDiscriminatorSimilarityStatus)similarityStatusBetweenSourceObject:(NSManagedObject *)sourceObject
                                                                andTargetObject:(NSManagedObject *)targetObject ;

/**
 Returns the set of the relationships that shouldn't be used to check the similarity of sourceObject with another object.
 
 This set depends of the HintCatalog
 */
- (NSSet *)relationshipsToOmitForSourceObject:(NSManagedObject *)sourceObject
                               andTargetObject:(NSManagedObject *)targetObject ;

@end
