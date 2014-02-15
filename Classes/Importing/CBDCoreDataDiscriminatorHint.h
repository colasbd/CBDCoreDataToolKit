//
//  CBDCoreDataDiscriminatorHelper.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CBDCoreDataDiscriminatorSimilarityStatus.h"
#import "CBDCoreDataDiscriminatorHintType.h"


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
@interface CBDCoreDataDiscriminatorHint : NSObject
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
@property (nonatomic, readonly) CBDCoreDataDiscriminatorHintType type ;
@property (nonatomic, weak, readonly) NSManagedObject * sourceObject ;
@property (nonatomic, weak, readonly) NSManagedObject * targetObject ;
@property (nonatomic, weak, readonly) NSRelationshipDescription * relationship ;
@property (nonatomic, readonly) CBDCoreDataDiscriminatorSimilarityStatus similarityStatus ;

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

- (id)  initWithSimilarityBetwenSourceObject:(NSManagedObject *)sourceObject
                             andTargetObject:(NSManagedObject *)targetObject
                                   hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus ;


- (id)  initWithSimilarityForRelationship:(NSRelationshipDescription *)relationship
                          forSourceObject:(NSManagedObject *)sourceObject
                          andTargetObject:(NSManagedObject *)targetObject
                                hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus ;


- (id)  initWithSimilarityOfSourceObject:(NSManagedObject *)sourceObject
                         andTargetObject:(NSManagedObject *)targetObject
                   shouldNotBeCheckedFor:(NSRelationshipDescription *)relation ;





- (BOOL)isEqual:(id)object ;

@end
