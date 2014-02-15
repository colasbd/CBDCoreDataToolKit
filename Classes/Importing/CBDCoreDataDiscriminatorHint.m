//
//  CBDCoreDataDiscriminatorHelper.m
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
@interface CBDCoreDataDiscriminatorHint ()

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


//
//
/**************************************/
#pragma mark Properties-référence
/**************************************/
@property (nonatomic, readwrite) CBDCoreDataDiscriminatorHintType type ;
@property (nonatomic, weak, readwrite) NSManagedObject * sourceObject ;
@property (nonatomic, weak, readwrite) NSManagedObject * targetObject ;
@property (nonatomic, weak, readwrite) NSRelationshipDescription * relationship ;
@property (nonatomic, readwrite) CBDCoreDataDiscriminatorSimilarityStatus similarityStatus ;

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
@implementation CBDCoreDataDiscriminatorHint




//
//
/**************************************/
#pragma mark - Description
/**************************************/


- (NSString *)description
{
    switch (self.type)
    {
        case CBDCoreDataDiscriminatorHintAboutSimilarity:
        {
            NSString * similarityStatus ;
            
            switch (self.similarityStatus)
            {
                case CBDCoreDataDiscriminatorSimilarityStatusIsSimilar:
                    similarityStatus = @"similar" ;
                    break;
                    
                case CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar:
                    similarityStatus = @"not similar" ;
                    break;
                    
                case CBDCoreDataDiscriminatorSimilarityStatusIsChecking:
                    similarityStatus = @"checking similarity" ;
                    break;
                    
                case CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus:
                    similarityStatus = @"invalid status" ;
                    break;
                    
                case CBDCoreDataDiscriminatorSimilarityStatusNoStatus:
                    similarityStatus = @"no status" ;
                    break;
                    
                default:
                    break;
            }
            
            
            NSString * auxString =@"" ;
            if (self.relationship)
            {
                auxString = [NSString stringWithFormat:@" for the relationship %@", self.relationship.name] ;
            }
            
            return [NSString stringWithFormat:@"The similarity status between %@ and %@ is %@%@", self.sourceObject, self.targetObject, similarityStatus, auxString] ;
            break;
        }
            
        case CBDCoreDataDiscriminatorHintAboutRelationship:
        {
             return [NSString stringWithFormat:@"The relationship %@ should not be checked for %@ and %@", self.relationship.name, self.sourceObject, self.targetObject] ;
            break;
        }
            
            
        default:
            return @"Hint with invalid type" ;
            break;
    }
}



//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/


- (id)    initWithType:(CBDCoreDataDiscriminatorHintType)typeOfTheHint
          sourceObject:(NSManagedObject *)sourceObject
          targetObject:(NSManagedObject *)targetObject
          relationship:(NSRelationshipDescription *)relationship
   statusForSimilarity:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus
{
    self = [super init] ;
    
    if (self)
    {
        self.type = typeOfTheHint ;
        self.sourceObject = sourceObject ;
        self.targetObject = targetObject ;
        self.relationship = relationship ;
        self.similarityStatus = similarityStatus ;
    }
    
    return self ;
}



- (id)  initWithSimilarityForRelationship:(NSRelationshipDescription *)relationship
                          forSourceObject:(NSManagedObject *)sourceObject
                          andTargetObject:(NSManagedObject *)targetObject
                                hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus
{
    return [self initWithType:CBDCoreDataDiscriminatorHintAboutSimilarity
                 sourceObject:sourceObject
                 targetObject:targetObject
                 relationship:relationship
          statusForSimilarity:similarityStatus] ;
}




- (id)initWithSimilarityBetwenSourceObject:(NSManagedObject *)sourceObject
                           andTargetObject:(NSManagedObject *)targetObject
                                 hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus
{
    return [self initWithType:CBDCoreDataDiscriminatorHintAboutSimilarity
                 sourceObject:sourceObject
                 targetObject:targetObject
                 relationship:nil
          statusForSimilarity:similarityStatus] ;
}




- (id)  initWithSimilarityOfSourceObject:(NSManagedObject *)sourceObject
                         andTargetObject:(NSManagedObject *)targetObject
                   shouldNotBeCheckedFor:(NSRelationshipDescription *)relation
{
    return [self initWithType:CBDCoreDataDiscriminatorHintAboutRelationship
                 sourceObject:sourceObject
                 targetObject:targetObject
                 relationship:relation
          statusForSimilarity:0] ;
}





//
//
/**************************************/
#pragma mark - Overwritting of isEqual
/**************************************/

- (BOOL)isEqual:(id)other
{
    if (other == self)
    {
        return YES ;
    }
    
    if (!other
        || ![other isKindOfClass:[self class]])
    {
        return NO;
    }
    
    return [self isEqualToHint_cbd_:other];
}



/*
 self.type = typeOfTheHint ;
 self.sourceObject = sourceObject ;
 self.targetObject = targetObject ;
 self.relationship = relationship ;
 self.similarityStatus = similarityStatus ;
 */
- (BOOL)isEqualToHint_cbd_:(CBDCoreDataDiscriminatorHint *)hint
{
    return (self.type == hint.type
            &&
            self.sourceObject == hint.sourceObject
            &&
            self.targetObject == hint.targetObject
            &&
            self.relationship == hint.relationship
            &&
            self.similarityStatus == hint.similarityStatus) ;
}


@end
