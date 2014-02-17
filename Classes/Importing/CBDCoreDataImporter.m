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
#import "CBDCoreDataDecisionCenter.h"

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
@property (nonatomic, weak)CBDCoreDataDiscriminator * discriminator ;


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

//- (id)initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
//              targetMOC:(NSManagedObjectContext *)targetMOC
//      withDiscriminator:(CBDCoreDataDiscriminator *)discriminator
//{
//    self = [super init] ;
//    
//    if (self)
//    {
//        if (sourceMOC.persistentStoreCoordinator.managedObjectModel != targetMOC.persistentStoreCoordinator.managedObjectModel)
//        {
//            [NSException raise:NSInvalidArgumentException
//                        format:@"The two MOCs must be attached to the same NSManagedObjectModel."] ;
//        }
//        
//        self.sourceMOC = sourceMOC ;
//        self.targetMOC = targetMOC ;
//        self.discriminator = discriminator ;
//        _cache = [[NSMutableDictionary alloc] init] ;
//    }
//    
//    return self ;
//}



- (id)initWithDecisionCenterForDiscrimination:(CBDCoreDataDecisionCenter *)decisionCenterForDescriminating withDecisionCenterForCopy:(CBDCoreDataDecisionCenter *)decisionCenterForCopying
                                withSourceMOC:(NSManagedObjectContext *)sourceMOC
                                    targetMOC:(NSManagedObjectContext *)targetMOC
{
    self = [super init] ;
    
    if (self)
    {
        _cache = [[NSMutableDictionary alloc] init] ;
        _sourceMOC = sourceMOC ;
        _targetMOC = targetMOC ;
        _decisionCenterForCopy = decisionCenterForCopying ;
        self.decisionCenterForDescrimination = decisionCenterForDescriminating ;
    }
    
    return self ;
}



- (void)setDecisionCenterForDescrimination:(CBDCoreDataDecisionCenter *)decisionCenterForDescriminating
{
    _decisionCenterForDescrimination = decisionCenterForDescriminating ;
    
    CBDCoreDataDiscriminator * newDiscriminator ;
    newDiscriminator = [[CBDCoreDataDiscriminator alloc] initWithDecisionCenter:decisionCenterForDescriminating] ;
    self.discriminator = newDiscriminator ;
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
#pragma mark - Import : convenience methods
/**************************************/


//- (NSManagedObject *)import:(NSManagedObject *)objectToImport
//{
//    return [self import:objectToImport
//     copyAlsoAttributes:nil
//  copyAlsoRelationships:nil] ;
//}
//
//
//- (NSManagedObject *)import:(NSManagedObject *)objectToImport
//         copyAlsoAttributes:(NSArray *)namesOfAttribuesToExclude
//      copyAlsoRelationships:(NSArray *)namesOfRelationshipsToExclude
//{
//    return [self import:objectToImport
//     copyAlsoAttributes:(NSArray *)namesOfAttribuesToExclude
//  copyAlsoRelationships:(NSArray *)namesOfRelationshipsToExclude
//        excludeEntities:nil] ;
//}




//
//
/**************************************/
#pragma mark - Import : core method
/**************************************/


/**
 Performs an import.
 
 @argument namesOfAttribuesToExclude This is names of attributes for the objectToImport. Theses attibutes won't be copied to the new object resulting from the import.
 
 @warning Plus, these attributes will be removed from the list of attributes to be checked for discrimination. (If no discrimination unit is explicitely given
 
 @argument namesOfRelationshipsToExclude This is names of relationships for the objectToImport. Theses relationships won't be copied to the new object resulting from the import.
 
 @warning Plus, these relationships will be removed from the list of relationships to be checked for discrimination.
 */
- (NSManagedObject *) import:(NSManagedObject *)objectToImport
//          copyAlsoAttributes:(NSArray *)namesOfAttribuesToInclude
//       copyAlsoRelationships:(NSArray *)namesOfRelationshipsToInclude
//             excludeEntities:(NSArray *)namesOfTheEntitesToExclude
{
    NSLog(@"Importing %@", objectToImport) ;
    /*
     We exclude the nil case
     */
    if (!objectToImport)
    {
        return nil ;
    }
    
    
    
    /*
     First : we look in the cache
     */
    
    if ([[self.cache allKeys] containsObject:objectToImport.objectID])
    {
        return self.cache[objectToImport.objectID] ;
    }
    
    
    
    NSEntityDescription * entity = objectToImport.entity ;
    
    
    
    
    /*
     Creating a new DiscriminatorUnit, so that we won't damage the default one by adding our operations
     */
    //    CBDCoreDataDiscriminator * newDiscriminator = [self.discriminator copy];
    //
    //    if (namesOfRelationshipsToExclude
    //        ||
    //        namesOfAttributesToExclude
    //        ||
    //        namesOfTheEntitesToExclude)
    //    {
    //        CBDCoreDataDiscriminatorUnit * unit1 ;
    //        unit1 = [[CBDCoreDataDiscriminatorUnit alloc] initDiscriminatorUnitForEntity:entity
    //                                                                  ignoringAttributes:namesOfAttributesToExclude
    //                                                                    andRelationships:namesOfRelationshipsToExclude] ;
    //        [newDiscriminator addDiscriminatorUnit:unit1] ;
    //
    //        CBDCoreDataDiscriminatorUnit * unit2 ;
    //        for (NSString * nameEntity in namesOfTheEntitesToExclude)
    //        {
    //            NSEntityDescription * entityToExclude = [self.sourceMOC entityWithName_cbd_:nameEntity] ;
    //
    //            unit2 = [[CBDCoreDataDiscriminatorUnit alloc] initIgnoringDiscriminatorUnitForEntity:entityToExclude] ;
    //
    //            [newDiscriminator addDiscriminatorUnit:unit2] ;
    //        }
    //    }
    //
    //    [newDiscriminator flushTheCache] ;
    
    
    
    
    /*
     We test if the object is ALREADY in the targetMOC
     (modulo similarity)
     */
    NSManagedObject * firstSimilarObject = [self.discriminator firstSimilarObjectTo:objectToImport
                                                                              inMOC:self.targetMOC] ;
    
    if (firstSimilarObject)
    {
        /*
         We cache it
         */
        self.cache[objectToImport.objectID] = firstSimilarObject ;
        return firstSimilarObject ;
    }
    
    
    
    /*
     ELSE : we create it
     and we had it to the cache
     */
    NSManagedObject * objectImported = [entity createInMOC_cbd_:self.targetMOC] ;
    self.cache[objectToImport.objectID] = objectImported ;
    
    
    
    NSMutableArray * attributesToInclude = [[[self.decisionCenterForCopy attributesToCheckFor:entity] allObjects] mutableCopy] ;
    //[attributesToInclude addObjectsFromArray:namesOfAttribuesToInclude] ;
    
    
    /*
     First : we deal with the attributes
     */
    [objectImported fillInAttributesFrom:objectToImport
                     onlyAttributes_cbd_:attributesToInclude] ;
    
    
    
    
    /*
     Second, we deal with Relationships
     */
    for (NSRelationshipDescription * relation in [self.decisionCenterForCopy relationshipsToCheckFor:entity])
    {
//    for (NSRelationshipDescription * relation in [objectToImport.entity.relationshipsByName allValues])
//    {
//        if ([namesOfRelationshipsToInclude containsObject:relation.name]
//            ||
//            [[self.discriminator relationshipsToCheckFor:entity] containsObject:relation])
        if (![self.decisionCenterForCopy shouldIgnore:relation.destinationEntity])
        {
//            NSArray * attributesToInclude ;
//            NSArray * relationshipsToInclude ;
            
//            if (relation.destinationEntity == entity)
//            {
//                attributesToInclude = namesOfAttribuesToInclude ;
//                relationshipsToInclude = namesOfRelationshipsToInclude ;
//            }
            
            if (!relation.isToMany)
            {
                /*
                 To-one relationships
                 */
                [objectImported setValue:[self import:[objectToImport valueForKey:relation.name]
//                                   copyAlsoAttributes:attributesToInclude
//                                copyAlsoRelationships:relationshipsToInclude
//                                      excludeEntities:namesOfTheEntitesToExclude
                                          ]
                                  forKey:relation.name] ;
            }
            else if (!relation.isOrdered)
            {
                /*
                 To-many non-ordered relationships
                 */
                NSMutableSet * newSet = [[NSMutableSet alloc] init] ;
                
                for (NSManagedObject * obj in [objectToImport valueForKey:relation.name])
                {
                    [newSet addObject:[self import:obj
//                                copyAlsoAttributes:attributesToInclude
//                             copyAlsoRelationships:relationshipsToInclude
//                                   excludeEntities:namesOfTheEntitesToExclude
                                       ]];
                }
                
                [objectImported setValue:newSet
                                  forKey:relation.name] ;
                
            }
            else
            {
                /*
                 To-many ordered relationships
                 */
                
                NSMutableOrderedSet * newSet = [[NSMutableOrderedSet alloc] init] ;
                
                for (NSManagedObject * obj in [objectToImport valueForKey:relation.name])
                {
                    [newSet addObject:[self import:obj
//                                copyAlsoAttributes:attributesToInclude
//                             copyAlsoRelationships:relationshipsToInclude
//                                   excludeEntities:namesOfTheEntitesToExclude
                                       ]];
                }
                
                [objectImported setValue:newSet
                                  forKey:relation.name] ;
            }
        }
    }
    
    return objectImported ;
}



@end
