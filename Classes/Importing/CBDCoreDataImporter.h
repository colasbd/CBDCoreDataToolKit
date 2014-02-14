//
//  CBDCoreDataImporter.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <CoreData/CoreData.h>

@class CBDCoreDataDiscriminator ;



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
#pragma mark Properties strong
/**************************************/
@property (nonatomic, strong)CBDCoreDataDiscriminator * discriminator ;


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


#pragma mark Initializing and settings
/// Initializing and settings
/**
 The two MOCs have to have the same NSManagedObjectModel.
*/
- (id)initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
              targetMOC:(NSManagedObjectContext *)targetMOC
      withDiscriminator:(CBDCoreDataDiscriminator *)discriminator ;


/**
 In order not to copy several times the same object, an instance of CBDCoreDataImporting maintains a cache.
 
 Flushing the cache may lead to doublons!
 */
- (void)flushTheCache ;


#pragma mark Importing
/// Initializing and settings

- (NSManagedObject *)import:(NSManagedObject *)objectToImport ;

- (NSManagedObject *)import:(NSManagedObject *)objectToImport
          excludeAttributes:(NSArray *)namesOfAttribuesToExclude
       excludeRelationships:(NSArray *)namesOfRelationshipsToExclude ;

- (NSManagedObject *)import:(NSManagedObject *)objectToImport
          excludeAttributes:(NSArray *)namesOfAttribuesToExclude
       excludeRelationships:(NSArray *)namesOfRelationshipsToExclude
            excludeEntities:(NSArray *)namesOfTheEntitesToExclude ;


@end
