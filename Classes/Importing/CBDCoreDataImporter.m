//
//  CBDCoreDataImporter.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPORTS
/**************************************/
#import "CBDCoreDataImporter.h"
#import "CBDCoreDataDiscriminator.h"
#import "NSEntityDescription+CBDActiveRecord.h"
#import "NSManagedObject+CBDClone.h"

/*
 Classes modèle
 */


/*
 Moteur
 */


/*
 Singletons
 */


/*
 Vues
 */


/*
 Catégories
 */


/*
 Pods
 */


/*
 Autres
 */







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - INSTANCIATION DES CONSTANTES
/**************************************/
//
//NSString* const <#exempleDeConstante#> = @"Exemple de constante";









//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATIONS PRIVÉES
/**************************************/
@interface CBDCoreDataImporter ()

//#pragma mark -
//
//
/**************************************/
#pragma mark Properties de paramétrage
/**************************************/


//
//
/**************************************/
#pragma mark Properties assistantes
/**************************************/


//
//
/**************************************/
#pragma mark Properties strong
/**************************************/
@property (nonatomic, strong)NSMutableDictionary * cache ;


//
//
/**************************************/
#pragma mark Properties-référence
/**************************************/
@property (nonatomic, weak)NSManagedObjectContext * sourceMOC ;
@property (nonatomic, weak)NSManagedObjectContext * targetMOC ;


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




@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/
@implementation CBDCoreDataImporter



//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/

- (id)initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
              targetMOC:(NSManagedObjectContext *)targetMOC
      withDiscriminator:(CBDCoreDataDiscriminator *)discriminator
{
    self = [super init] ;
    
    if (self)
    {
        if (sourceMOC.persistentStoreCoordinator.managedObjectModel != targetMOC.persistentStoreCoordinator.managedObjectModel)
        {
            [NSException raise:NSInvalidArgumentException
                        format:@"The two MOCs must be attached to the same NSManagedObjectModel."] ;
        }
        
        self.sourceMOC = sourceMOC ;
        self.targetMOC = targetMOC ;
        self.discriminator = discriminator ;
        _cache = [[NSMutableDictionary alloc] init] ;
    }
    
    return self ;
}






//
//
/**************************************/
#pragma mark - Gestion du cache
/**************************************/


- (void)flushTheCache
{
    self.cache = [[NSMutableDictionary alloc] init] ;
}





//
//
/**************************************/
#pragma mark - Import
/**************************************/


TODO(GARDER les arguments namesOfRelationshipsToExclude (à mettre dans le discriminator))
TODO(enlever excludeEntities ou plutot le mettre dans le discriminator)

- (NSManagedObject *) import:(NSManagedObject *)objectToImport
           excludeAttributes:(NSArray *)namesOfAttributesToExclude
        excludeRelationships:(NSArray *)namesOfRelationshipsToExclude
             excludeEntities:(NSArray *)namesOfTheEntitesToExclude
{
    NSEntityDescription * entity = objectToImport.entity ;
    
    
    /*
     We test if the object is already in the targetMOC
     (modulo similarity)
     */
    NSArray * objectsToTest = [entity allInMOC_cbd_:self.targetMOC] ;
    
    __block NSManagedObject * result ;

    
    [objectsToTest enumerateObjectsUsingBlock:^(NSManagedObject * targetObj, NSUInteger idx, BOOL *stop)
    {
//        if ([self.discriminator isThisSourceObject:objectToImport
//                             similarToTargetObject:targetObj
//                            excludingRelationships:<#(NSSet *)#>
//                                 excludingEntities:<#(NSSet *)#>
//                                 usingResearchType:C ])
//        {
//            result = targetObj ;
//            *stop = YES ;
//        }
    }] ;
    
    return result ;
    
    
    /*
     Else : we create it
     */
    NSManagedObject * objectImported = [entity createInMOC_cbd_:self.targetMOC] ;
    
    
    /*
     First : we deal with the attributes
     */
    [objectImported fillInAttributesFrom:objectToImport
                   exludeAttributes_cbd_:namesOfAttributesToExclude] ;
    
    
    /*
     Second, we deal with Relationships
     */
    
    
}



@end
