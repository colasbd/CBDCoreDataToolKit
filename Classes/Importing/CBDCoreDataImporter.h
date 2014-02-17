//
//  CBDCoreDataImporter.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <CoreData/CoreData.h>

@class CBDCoreDataDecisionCenter, CBDCoreDataDiscriminator ;



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
@interface CBDCoreDataImporter : NSObject
//
//
/**************************************/
#pragma mark Properties de paramétrage
/**************************************/




//
//
/**************************************/
#pragma mark Properties read only
/**************************************/
@property (nonatomic, strong, readonly)CBDCoreDataDecisionCenter * decisionCenterForDescrimination ;
@property (nonatomic, strong, readonly)CBDCoreDataDecisionCenter * decisionCenterForCopy ;
@property (nonatomic, strong, readonly)CBDCoreDataDiscriminator * discriminator ;




//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATION PUBLIQUE : méthodes
/**************************************/


#pragma mark Initializing and settings
/// @name Initializing and settings
/**
 The discriminator's goal is to decide if two NSManagedObjects are similar.
*/
//- (id)initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
//              targetMOC:(NSManagedObjectContext *)targetMOC
//      withDiscriminator:(CBDCoreDataDiscriminator *)discriminator ;


- (id) initWithDecisionCenterForDiscrimination:(CBDCoreDataDecisionCenter *)decisionCenterForDescriminating
                  withDecisionCenterForCopy:(CBDCoreDataDecisionCenter *)decisionCenterForCopying
                                 withSourceMOC:(NSManagedObjectContext *)sourceMOC
                                     targetMOC:(NSManagedObjectContext *)targetMOC ;


/**
 In order not to copy several times the same object, an instance of CBDCoreDataImporting maintains a cache.
 
 Flushing the cache may lead to doublons!
 */
- (void)flushTheCache ;


#pragma mark Importing
/// @name Importing

/**
 Performs an import.
 
 It will copy all the attributes and relationships (by performing a recursive import)
 
 @warning If the object exists already, according to the discriminator, no new object will be created.
 */
- (NSManagedObject *)import:(NSManagedObject *)objectToImport ;


///**
// Performs an import.
// 
// @argument namesOfAttribuesToExclude This is names of attributes for the objectToImport. Theses attibutes won't be copied to the new object resulting from the import. 
// 
// @warning Plus, these attributes will be removed from the list of attributes to be checked for discrimination. (If no discrimination unit is explicitely given
// 
// @argument namesOfRelationshipsToExclude This is names of relationships for the objectToImport. Theses relationships won't be copied to the new object resulting from the import.
// 
// @warning Plus, these relationships will be removed from the list of relationships to be checked for discrimination.
// */
//- (NSManagedObject *)import:(NSManagedObject *)objectToImport
//         copyAlsoAttributes:(NSArray *)namesOfAttribuesToInclude
//      copyAlsoRelationships:(NSArray *)namesOfRelationshipsToInclude ;
//
//FIXME(projet à reprendre je veux pouvoir distinguer les critère de recherche et les critères de copie)
//
//- (NSManagedObject *)import:(NSManagedObject *)objectToImport
//         copyAlsoAttributes:(NSArray *)namesOfAttribuesToInclude
//      copyAlsoRelationships:(NSArray *)namesOfRelationshipsToInclude
//            excludeEntities:(NSArray *)namesOfTheEntitesToExclude ;


@end
