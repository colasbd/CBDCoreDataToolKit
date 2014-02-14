//
//  CBDCoreDataDiscriminatorHintCatalog.m
//  Pods
//
//  Created by Colas on 13/02/2014.
//
//

//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPORTS
/**************************************/
#import "CBDCoreDataDiscriminatorHintCatalog.h"
#import "CBDCoreDataDiscriminatorHint.h"


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
@interface CBDCoreDataDiscriminatorHintCatalog ()

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
@property (nonatomic, strong, readwrite)NSMutableOrderedSet * mutableHints ;


//
//
/**************************************/
#pragma mark Properties-référence
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




@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/
@implementation CBDCoreDataDiscriminatorHintCatalog




//
//
/**************************************/
#pragma mark - Description
/**************************************/


- (NSString *)description
{
    return [NSString stringWithFormat:@"HintCatalog with hints %@", self.hints] ;
}







//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/

- (id)init
{
    self = [super init] ;
    
    if (self)
    {
        self.mutableHints = [[NSMutableOrderedSet alloc] init] ;
    }
    
    return self ;
}




//
//
/**************************************/
#pragma mark - Copying
/**************************************/

- (id)copy
{
    CBDCoreDataDiscriminatorHintCatalog * newCatalog = [[CBDCoreDataDiscriminatorHintCatalog alloc] init] ;
    
    [newCatalog addHintsFromCatalog:self] ;
    
    return newCatalog ;
}




//
//
/**************************************/
#pragma mark - Public properties
/**************************************/


- (NSArray *)hints
{
    return [self.mutableHints copy] ;
}




//
//
/**************************************/
#pragma mark - Adding a hint
/**************************************/



- (void)addHintOfSimilarityBetwenSourceObject:(NSManagedObject *)sourceObject
                              andTargetObject:(NSManagedObject *)targetObject
                                    hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus
{
    CBDCoreDataDiscriminatorHint * hint ;
    hint = [[CBDCoreDataDiscriminatorHint alloc] initWithSimilarityBetwenSourceObject:sourceObject
                                                                      andTargetObject:targetObject
                                                                            hasStatus:similarityStatus] ;
    
    [self addHint:hint] ;
}



- (void)addHintBetweenSourceObject:(NSManagedObject *)sourceObject
                   andTargetObject:(NSManagedObject *)targetObject
         toNotCheckTheRelationship:(NSRelationshipDescription *)relation
{
    CBDCoreDataDiscriminatorHint * hint ;
    hint = [[CBDCoreDataDiscriminatorHint alloc] initWithSimilarityOfSourceObject:sourceObject
                                                                  andTargetObject:targetObject
                                                            shouldNotBeCheckedFor:relation] ;
    
    [self addHint:hint] ;
}



- (void)addHint:(CBDCoreDataDiscriminatorHint *)hint
{
    //    Since it is a set, it is not nessary to check
    //
    //    if (![self.hints containsObject:hint])
    //    {
    [self.mutableHints addObject:hint] ;
    //    }
}


- (void)addHintsFromCatalog:(CBDCoreDataDiscriminatorHintCatalog *)hintCatalog
{
    for (CBDCoreDataDiscriminatorHint * hint in hintCatalog.hints)
    {
        [self addHint:hint] ;
    }
}



//
//
/**************************************/
#pragma mark - Flushing the catalog
/**************************************/

/**
 Removes all the hints from the hintCatalog.
 */
- (void)flush
{
    self.mutableHints = [[NSMutableOrderedSet alloc] init] ;
}

/**
 Removes the last hint from the hintCatalog.
 */
- (void)removeLastHint
{
    if ([self.mutableHints lastObject])
    {
        [self.mutableHints removeObject:[self.mutableHints lastObject]] ;
    }
}




//
//
/**************************************/
#pragma mark - Merging an array of status
/**************************************/


+ (CBDCoreDataDiscriminatorSimilarityStatus)statusFromArrayOfStatus:(NSArray *)arrayOfStatus
{
    __block CBDCoreDataDiscriminatorSimilarityStatus result = CBDCoreDataDiscriminatorSimilarityStatusNoStatus ;
    
    [arrayOfStatus enumerateObjectsUsingBlock:^(NSNumber *objectStatus, NSUInteger idx, BOOL *stop)
     {
         CBDCoreDataDiscriminatorSimilarityStatus status = [objectStatus integerValue] ;
         
         if (status == CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus
             ||
             result == CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus)
         {
             result = CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
             *stop = YES ;
             
             switch (result)
             {
                 case CBDCoreDataDiscriminatorSimilarityStatusNoStatus:
                     result = status ;
                     break;
                     
                 case CBDCoreDataDiscriminatorSimilarityStatusIsChecking:
                 {
                     if (status != CBDCoreDataDiscriminatorSimilarityStatusNoStatus)
                     {
                         result = status ;
                     }
                     break;
                 }
                     
                 case CBDCoreDataDiscriminatorSimilarityStatusIsSimilar:
                 {
                     if (status == CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar)
                     {
                         result = CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
                     }
                     else
                     {
                         result = CBDCoreDataDiscriminatorSimilarityStatusIsSimilar ;
                     }
                     break;
                 }
                     
                 case CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar:
                 {
                     if (status == CBDCoreDataDiscriminatorSimilarityStatusIsSimilar)
                     {
                         result = CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
                     }
                     else
                     {
                         result = CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar ;
                     }
                     break;
                 }
                     
                 default:
                     break;
             }
         }
     }];
    
    return result ;
}


//
//
/**************************************/
#pragma mark - Checking the status
/**************************************/

- (CBDCoreDataDiscriminatorSimilarityStatus)similarityStatusBetweenSourceObject:(NSManagedObject *)sourceObject
                                                                andTargetObject:(NSManagedObject *)targetObject
{
    NSArray * usefulHints = [self usefulHintsBetweenSourceObject:sourceObject
                                                 andTargetObject:targetObject] ;
    
    NSMutableArray * arrayOfStatus = [[NSMutableArray alloc] init] ;
    
    for (CBDCoreDataDiscriminatorHint * hint in usefulHints)
    {
        if (hint.type == CBDCoreDataDiscriminatorHintAboutSimilarity)
        {
            [arrayOfStatus addObject:[NSNumber numberWithInteger:hint.similarityStatus]] ;
        }
    }
    
    return [CBDCoreDataDiscriminatorHintCatalog statusFromArrayOfStatus:arrayOfStatus] ;
}



- (NSArray *)usefulHintsBetweenSourceObject:(NSManagedObject *)sourceObject
                            andTargetObject:(NSManagedObject *)targetObject
{
    NSMutableArray * usefulHints = [[NSMutableArray alloc] init] ;
    
    for (CBDCoreDataDiscriminatorHint * hint in self.hints)
    {
        if (hint.sourceObject == sourceObject
            &&
            hint.targetObject == targetObject)
        {
            [usefulHints addObject:hint] ;
        }
    }
    
    return usefulHints ;
}




//
//
/**************************************/
#pragma mark - Relationships to omit for a given object
/**************************************/


- (NSSet *)relationshipsToOmitForSourceObject:(NSManagedObject *)sourceObject
                              andTargetObject:(NSManagedObject *)targetObject
{
    NSMutableSet * result = [[NSMutableSet alloc] init] ;
    
    for (CBDCoreDataDiscriminatorHint * hint in self.hints)
    {
        if (hint.type == CBDCoreDataDiscriminatorHintAboutRelationship
            &&
            hint.sourceObject == sourceObject
            &&
            hint.targetObject == targetObject)
        {
            [result addObject:hint.relationship] ;
        }
    }
    
    return result ;
}


@end
