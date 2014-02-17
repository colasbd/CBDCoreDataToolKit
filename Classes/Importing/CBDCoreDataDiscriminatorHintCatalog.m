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
    
    /*
     If we get a positive status, we remove the uncertain status
     */
    if (similarityStatus == CBDCoreDataDiscriminatorSimilarityStatusIsSimilar
        ||
        similarityStatus == CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar)
    {
        for (CBDCoreDataDiscriminatorHint * varHint in self.hints)
        {
            if ((varHint.similarityStatus == CBDCoreDataDiscriminatorSimilarityStatusIsChecking
                 ||
                 FIXME(a corriger)
//                 varHint.similarityStatus == CBDCoreDataDiscriminatorSimilarityStatusIsQuasiSimilar
//                 ||
                 varHint.relationship != nil)
                &&
                (varHint.sourceObject == sourceObject
                &&
                varHint.targetObject == targetObject))
            {
                [self.mutableHints removeObject:varHint] ;
            }
        }
    }
    
    hint = [[CBDCoreDataDiscriminatorHint alloc] initWithSimilarityBetwenSourceObject:sourceObject
                                                                      andTargetObject:targetObject
                                                                            hasStatus:similarityStatus] ;
    
    [self addHint:hint] ;
}


- (void)addHintOfSimilarityForRelationship:(NSRelationshipDescription *)relationship
                           forSourceObject:(NSManagedObject *)sourceObject
                           andTargetObject:(NSManagedObject *)targetObject
                                 hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus
{
    CBDCoreDataDiscriminatorHint * hint ;
    hint = [[CBDCoreDataDiscriminatorHint alloc] initWithSimilarityForRelationship:relationship
                                                                   forSourceObject:sourceObject
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
    [self.mutableHints addObject:hint] ;
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
         result = [CBDCoreDataDiscriminatorHintCatalog synthesisOfStatus:[objectStatus integerValue]
                                                               andStatus:result] ;
     }];
    
    return result ;
}




//typedef NS_ENUM(NSInteger, CBDCoreDataDiscriminatorSimilarityStatus)
//{
//    CBDCoreDataDiscriminatorSimilarityStatusNoStatus,
//    CBDCoreDataDiscriminatorSimilarityStatusIsSimilar,
//    CBDCoreDataDiscriminatorSimilarityStatusIsQuasiSimilar,
//    CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar,
//    CBDCoreDataDiscriminatorSimilarityStatusIsChecking,
//    CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus,
//    CBDCoreDataDiscriminatorSimilarityStatusCount
//};



+ (CBDCoreDataDiscriminatorSimilarityStatus) synthesisOfStatus:(CBDCoreDataDiscriminatorSimilarityStatus)firstStatus
                                                     andStatus:(CBDCoreDataDiscriminatorSimilarityStatus)secondStatus
{
    switch (firstStatus)
    {
            
            /***
             1
             ***/
        case CBDCoreDataDiscriminatorSimilarityStatusNoStatus:
        {
            return secondStatus ;
            break;
        }

            
            /***
             2
             ***/
        case CBDCoreDataDiscriminatorSimilarityStatusIsSimilar:
        {
            switch (secondStatus)
            {
                case CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
                    break;
                }
                    
                case CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
                    break;
                }
                    
                default:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusIsSimilar ;
                    break;
                }
            }
            break;
        }
         
            
            /***
             3
             ***/
        case CBDCoreDataDiscriminatorSimilarityStatusIsQuasiSimilar:
        {
            switch (secondStatus)
            {
                case CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
                    break;
                }
                    
                case CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar ;
                    break;
                }
                    
                case CBDCoreDataDiscriminatorSimilarityStatusIsSimilar:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusIsSimilar ;
                    break;
                }
                    
                default:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusIsQuasiSimilar ;
                    break;
                }
            }
            break;
        }
            
            
            /***
             4
             ***/
        case CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar:
        {
            switch (secondStatus)
            {
                case CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
                    break;
                }
                    
                case CBDCoreDataDiscriminatorSimilarityStatusIsSimilar:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
                    break;
                }
                    
                default:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar ;
                    break;
                }
            }
            break;
        }
            
            /***
             5
             ***/
        case CBDCoreDataDiscriminatorSimilarityStatusIsChecking:
        {
            switch (secondStatus)
            {
                case CBDCoreDataDiscriminatorSimilarityStatusNoStatus:
                {
                    return CBDCoreDataDiscriminatorSimilarityStatusIsChecking ;
                    break;
                }
                    
                default:
                {
                    return secondStatus ;
                    break;
                }
            }
            break;
        }

            /***
             6
             ***/
        case CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus:
        {
            return CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
            break;
        }
            
        default:
        {
            return CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus ;
            break;
        }
    }
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
        if (hint.type == CBDCoreDataDiscriminatorHintAboutSimilarity
            &&
            hint.relationship == nil)
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
    
    for (CBDCoreDataDiscriminatorHint * hint in [self usefulHintsBetweenSourceObject:sourceObject
                                                                     andTargetObject:targetObject])
    {
        if (hint.type == CBDCoreDataDiscriminatorHintAboutRelationship)
        {
            [result addObject:hint.relationship] ;
        }
        
        
        if (hint.type == CBDCoreDataDiscriminatorHintAboutSimilarity
            &&
            hint.relationship != nil
            &&
            hint.similarityStatus == CBDCoreDataDiscriminatorSimilarityStatusIsSimilar)
        {
            [result addObject:hint.relationship] ;
        }
    }
    
    return result ;
}


@end
