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



/*
 Classes modèle
 */


/*
 Moteur
 */
#import "CBDCoreDataDiscriminator.h"


/*
 Singletons
 */


/*
 Vues
 */


/*
 Catégories
 */
#import "NSEntityDescription+CBDActiveRecord.h"
#import "NSManagedObject+CBDClone.h"
#import "NSManagedObjectContext+CBDActiveRecord.h"

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


/**
 Performs an import.
 
 @argument namesOfAttribuesToExclude This is names of attributes for the objectToImport. Theses attibutes won't be copied to the new object resulting from the import.
 
 @warning Plus, these attributes will be removed from the list of attributes to be checked for discrimination. (If no discrimination unit is explicitely given
 
 @argument namesOfRelationshipsToExclude This is names of relationships for the objectToImport. Theses relationships won't be copied to the new object resulting from the import.
 
 @warning Plus, these relationships will be removed from the list of relationships to be checked for discrimination.
 */
- (NSManagedObject *) import:(NSManagedObject *)objectToImport
           excludeAttributes:(NSArray *)namesOfAttributesToExclude
        excludeRelationships:(NSArray *)namesOfRelationshipsToExclude
             excludeEntities:(NSArray *)namesOfTheEntitesToExclude
{
    NSEntityDescription * entity = objectToImport.entity ;
    
    
    
    /*
     Creating a new DiscriminatorUnit, so that we won't damage the default one by adding our constraints
     */
    CBDCoreDataDiscriminator * newDiscriminator = [self.discriminator copy];
    
    CBDCoreDataDiscriminatorUnit * unit1 ;
    unit1 = [[CBDCoreDataDiscriminatorUnit alloc] initDiscriminatorUnitForEntity:entity
                                                              ignoringAttributes:namesOfAttributesToExclude
                                                                andRelationships:namesOfRelationshipsToExclude] ;
    [newDiscriminator addDiscriminatorUnit:unit1] ;
    
    CBDCoreDataDiscriminatorUnit * unit2 ;
    for (NSString * nameEntity in namesOfTheEntitesToExclude)
    {
        NSEntityDescription * entityToExclude = [self.sourceMOC entityWithName_cbd_:nameEntity] ;
        
        unit2 = [[CBDCoreDataDiscriminatorUnit alloc] initIgnoringDiscriminatorUnitForEntity:entityToExclude] ;
        
        [newDiscriminator addDiscriminatorUnit:unit2] ;
    }
        
    [newDiscriminator flushTheCache] ;
    
    
    
    
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
