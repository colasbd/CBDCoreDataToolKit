//
//  CBCoreDataDiscriminator.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import "CBDCoreDataDiscriminator.h"

#import "CBDCoreDataDecisionCenter.h"

#import "CBDCoreDataDiscriminatorHint.h"
#import "CBDCoreDataDiscriminatorHintCatalog.h"

#import "NSEntityDescription+CBDMiscMethods.h"
#import "NSManagedObject+CBDMiscMethods.h"

#import "NSEntityDescription+CBDActiveRecord.h"
#import "CBDCoreDataDiscriminator+UsingPredicateAndFetching.h"




/**********************************************************************
 **********************************************************************
 *****************           PARAMETERS            ********************
 **********************************************************************
 **********************************************************************/

/*
 This boolean sets the method with use.
 If YES: the method is more likely to end, but I didn't prove that the algorithm is exact (but I don't have any counter-example)
 If NO: the method is exact
 */
const BOOL optionYESIfChecking = NO ;


/*
 If safeMode == YES, there is less chance of NSException, 
 but I didn't prove that the algorithm is exact (but I don't have any counter-example)
 
 If safeMode == NO, it could lead to an NSException (I didn't encountered), but the algorithm is exact.
 */
const BOOL safeMode = NO ;


/*
 If YES, to boost the research, we do a kind of pre-search, using NSPredicates and CoreData.
 */
const BOOL usingCoreDataAcceleration = YES ;
const int depthForCoreDataAcceleration_cbd_=2 ;


/**********************************************************************
 **********************************************************************/






@interface CBDCoreDataDiscriminator ()

@property (nonatomic)BOOL shouldLog ;

@property (nonatomic, strong, readwrite)CBDCoreDataDecisionCenter * decisionCenter ;

@property (nonatomic, strong, readwrite)CBDCoreDataDiscriminatorHintCatalog * globalHintCatalog ;


- (CBDCoreDataDiscriminatorHintCatalog *)globalHintCatalogEnhancedWith:(CBDCoreDataDiscriminatorHintCatalog *)otherCatalog ;

@end









@implementation CBDCoreDataDiscriminator




//
//
/**************************************/
#pragma mark - Init
/**************************************/




- (id)initWithDecisionCenter:(CBDCoreDataDecisionCenter *)decisionCenter
{
    self = [super init] ;
    
    if (self)
    {
        _shouldLog = NO ;
        _globalHintCatalog = [[CBDCoreDataDiscriminatorHintCatalog alloc] init] ;
        _decisionCenter = decisionCenter ;
    }
    
    return self ;
}


- (id)initWithDefaultType
{
    CBDCoreDataDecisionCenter * center ;
    center = [[CBDCoreDataDecisionCenter alloc] initWithSemiFacilitatingType] ;
    
    return [self initWithDecisionCenter:center];
}


- (id)copy
{
    CBDCoreDataDiscriminator * newDiscriminator = [[CBDCoreDataDiscriminator alloc] init] ;
    
    newDiscriminator.decisionCenter = [self.decisionCenter copy] ;
    newDiscriminator.shouldLog = self.shouldLog ;
    
    return newDiscriminator ;
}









//
//
/**************************************/
#pragma mark - Managing the cache
/**************************************/


/**
 Removes all the entries of the cache
 */
- (void)flushTheCache
{
    [self.globalHintCatalog flush] ;
}




- (void)logTheCache
{
    NSLog(@"The cache is %@", self.globalHintCatalog) ;
}







//
//
/**************************************/
#pragma mark - Managing the log
/**************************************/


- (void)shouldLog:(BOOL)shouldLog
{
    self.shouldLog = shouldLog ;
}








//
//
/**************************************/
#pragma mark - Enhancing the catalog
/**************************************/


- (CBDCoreDataDiscriminatorHintCatalog *)globalHintCatalogEnhancedWith:(CBDCoreDataDiscriminatorHintCatalog *)otherCatalog
{
    CBDCoreDataDiscriminatorHintCatalog * result ;
    
    result = [self.globalHintCatalog copy] ;
    [result addHintsFromCatalog:otherCatalog] ;
    
    return result ;
}








//
//
/**************************************/
#pragma mark - Duplicates
/**************************************/


NSString * const    CBDCoreDataDiscriminatorKeyForObjectInWorkingMOC = @"CBDCoreDataDiscriminatorKeyForObjectInWorkingMOC";
NSString * const   CBDCoreDataDiscriminatorKeyForObjectInReferenceMOC = @"CBDCoreDataDiscriminatorKeyForObjectInReferenceMOC" ;


- (NSDictionary *)     objectsInWorkingMOC:(NSManagedObjectContext *)MOCWhereWeAreWorking
             alreadyExistingInReferenceMOC:(NSManagedObjectContext *)referenceMOC;
{
    NSArray * arrayOfAllEntities = [[MOCWhereWeAreWorking.persistentStoreCoordinator.managedObjectModel entitiesByName] allKeys] ;
    
    return [self objectsInWorkingMOC:MOCWhereWeAreWorking
       alreadyExistingInReferenceMOC:referenceMOC
                          ofEntities:arrayOfAllEntities] ;
}



- (NSDictionary *)     objectsInWorkingMOC:(NSManagedObjectContext *)MOCWhereWeAreWorking
             alreadyExistingInReferenceMOC:(NSManagedObjectContext *)referenceMOC
                                ofEntities:(NSArray *)namesOfEntities ;

{
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init] ;
    
    for (NSString * nameEntity in namesOfEntities)
    {
        NSEntityDescription * entity = [NSEntityDescription entityForName:nameEntity
                                                   inManagedObjectContext:MOCWhereWeAreWorking] ;
        
        if (self.shouldLog)
        {
            NSLog(@"Starting to search for the duplicates of %@", nameEntity) ;
        }
        
        NSArray * allObjects = [entity allInMOC_cbd_:referenceMOC] ;
        
// CODE MULTITHREAD  -> bug
//
//        [allObjects enumerateObjectsWithOptions:NSEnumerationConcurrent
//                                     usingBlock:^(NSManagedObject * object, NSUInteger idx, BOOL *stop)
//        {
//            NSManagedObject * resultObject = [self firstSimilarObjectTo:object
//                                                                  inMOC:referenceMOC] ;
//            
//            if (!resultObject)
//            {
//                NSDictionary * dico = @{CBDCoreDataDiscriminatorKeyForObjectInWorkingMOC: object,
//                                        CBDCoreDataDiscriminatorKeyForObjectInReferenceMOC: resultObject} ;
//                
//                result[object.objectID] = dico ;
//            }
//
//        }] ;
        
        for (NSManagedObject * object in allObjects)
        {
            NSManagedObject * resultObject = [self firstSimilarObjectTo:object
                                                                  inMOC:referenceMOC] ;
            
            if (!resultObject)
            {
                NSDictionary * dico = @{CBDCoreDataDiscriminatorKeyForObjectInWorkingMOC: object,
                                        CBDCoreDataDiscriminatorKeyForObjectInReferenceMOC: resultObject} ;
                
                result[object.objectID] = dico ;
            }
        }
    }
    
    return result ;
}









//
//
/**************************************/
#pragma mark - Discriminate : convenience methods
/**************************************/




- (BOOL)     isSourceObject:(NSManagedObject *)sourceObject
          similarToTargetObject:(NSManagedObject *)targetObject
{
    /*
     I don't know if putting YES to this option make the algorithm not correct.
     I don't know if putting NO to this option make the algorithm falling in infinite loops.
     */
    
    BOOL result =  [self isThisSourceObject:sourceObject
                      similarToTargetObject:targetObject
                           usingHintCatalog:self.globalHintCatalog
                        assumeYESifChecking:optionYESIfChecking
                              numberOfCalls:1] ;

    
    /*
     Returning the result
     */
    return result ;
}









//
//
/**************************************/
#pragma mark - Discriminate with attributes
/**************************************/



- (BOOL)            doesObject:(NSManagedObject *)sourceObject
  haveTheSameAttributeValuesAs:(NSManagedObject *)targetObject
{
    /*
     Case of different entities
     */
    if (sourceObject.entity != targetObject.entity)
    {
        return NO ;
    }
    
    
    /*
     We start by clearing off the trivial cases when one of the objets is nil
     */
    
    if (!sourceObject
        &&
        !targetObject)
    {
        return YES ;
    }
    
    if (!sourceObject
        &&
        targetObject)
    {
        return NO ;
    }
    
    if (sourceObject
        &&
        !targetObject)
    {
        return NO ;
    }
    
    
    NSEntityDescription * entity = sourceObject.entity ;
    
    NSSet *setOfAttributesToCheck = [self.decisionCenter attributesFor:entity] ;
    
    
    
    for (NSString * nameAttribute in setOfAttributesToCheck)
    {
        id valueSourceObject = [sourceObject valueForKey:nameAttribute] ;
        id valueTargetObject = [targetObject valueForKey:nameAttribute] ;
        
        
        /*
         We have to deal with the case nil-nil separately
         */
        if (!valueSourceObject
            &&
            !valueTargetObject)
        {
            //return YES ;
            //            return [self returnTheValue:YES
            //                        forSourceObject:sourceObject
            //                        andTargetObject:targetObject
            //                            withMessage:@"Both attributes are nil."
            //                                logging:NO] ;
            
            return YES ;
        }
        
        if (![valueSourceObject isEqual:valueTargetObject])
        {
            //return NO ;
            NSString * message = [NSString stringWithFormat:@"The fail comes from the attribute %@", nameAttribute] ;
            
            return [self registerAndReturnThisAnswer:NO
                                             trueYES:NO
                                     forSourceObject:sourceObject
                                     andTargetObject:targetObject
                                         withMessage:message
                                             logging:YES] ;
        }
    }
    
    //return YES ;
    //    return [self returnTheValue:YES
    //                forSourceObject:sourceObject
    //                andTargetObject:targetObject
    //                    withMessage:nil
    //                        logging:NO] ;
    return YES ;
}







//
//
/**************************************/
#pragma mark - ■■■■■■ Discriminate : CORE METHOD  ■■■■■■
/**************************************/


- (BOOL)     isThisSourceObject:(NSManagedObject *)sourceObject
          similarToTargetObject:(NSManagedObject *)targetObject
               usingHintCatalog:(CBDCoreDataDiscriminatorHintCatalog *)hintCatalog
            assumeYESifChecking:(BOOL)assumeYESIfChecking
                  numberOfCalls:(NSInteger)numberOfCalls
{
    /*************************
     *     QUICK HINTS
     *************************
     To accelerate the algorithm
     *************************/
    
    if ([self.globalHintCatalog quickStatusBetween:sourceObject
                                               and:targetObject])
    {
        return YES ;
    }
    
    
    /*************************
     *     Normal tests
     *************************
     *************************/
    
    if (self.shouldLog)
    {
        NSLog(@"Checking similarity of %@ and %@", sourceObject, targetObject) ;
    }
    
    /*
     We start by clearing off the trivial cases when one of the objets is nil
     */
    
    if (!sourceObject
        &&
        !targetObject)
    {
        return YES ;
    }
    
    if (!sourceObject
        &&
        targetObject)
    {
        return NO ;
    }
    
    if (sourceObject
        &&
        !targetObject)
    {
        return NO ;
    }
    
    
    
    
    /*
     Allocating and initializing nil argument
     */
    if (!hintCatalog)
    {
        hintCatalog = [[CBDCoreDataDiscriminatorHintCatalog alloc] init] ;
    }


    
    
    /*
     We check if the entities are the same
     */
    if (sourceObject.entity != targetObject.entity)
    {
        //return NO ;
        
        return [self registerAndReturnThisAnswer:NO
                                         trueYES:NO
                                 forSourceObject:sourceObject
                                 andTargetObject:targetObject
                                     withMessage:@"Entities are not the same."
                                         logging:NO] ;
    }
    
    
    NSEntityDescription * entity = sourceObject.entity ;
    
    
    
    /*
     We check if the entity is excluded
     */
    if ([self.decisionCenter shouldIgnore:entity])
    {
        return [self registerAndReturnThisAnswer:YES
                                         trueYES:YES
                                 forSourceObject:sourceObject
                                 andTargetObject:targetObject
                                     withMessage:@"The entity is in the black list."
                                         logging:NO] ;
    }
    
    
    
    
    
    /*
     We use the core-data acceleration
     */
    if (usingCoreDataAcceleration
        &&
        ![self           isThisSourceObject:sourceObject
             virtuallySimilarToTargetObject:targetObject
                         withPredicateDepth:depthForCoreDataAcceleration_cbd_])
    {
        return [self registerAndReturnThisAnswer:NO
                                         trueYES:NO
                                 forSourceObject:sourceObject
                                 andTargetObject:targetObject
                                     withMessage:@"The two objects are not virtually similar."
                                         logging:NO] ;
    }
    
    
    
    
    
    
    /*
     We use the hints if possible
     */
    
    CBDCoreDataDiscriminatorHintCatalog * catalog ;
    catalog = [self globalHintCatalogEnhancedWith:hintCatalog] ;
    
    
    CBDCoreDataDiscriminatorSimilarityStatus statusSimilarity ;
    statusSimilarity = [catalog similarityStatusBetweenSourceObject:sourceObject
                                                    andTargetObject:targetObject] ;
    

    switch (statusSimilarity)
    {
        case CBDCoreDataDiscriminatorSimilarityStatusIsSimilar:
            //return YES ;
            return [self registerAndReturnThisAnswer:YES
                                             trueYES:YES
                                     forSourceObject:sourceObject
                                     andTargetObject:targetObject
                                         withMessage:@"We used the cache."
                                             logging:YES] ;
            
            break;
            
        case CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar:
            //return NO ;
            return [self registerAndReturnThisAnswer:NO
                                             trueYES:NO
                                     forSourceObject:sourceObject
                                     andTargetObject:targetObject
                                         withMessage:@"We used the cache."
                                             logging:YES] ;
            break;
            
        case CBDCoreDataDiscriminatorSimilarityStatusIsChecking:
        {
            if (assumeYESIfChecking)
            {
                //return YES ;
                return [self registerAndReturnThisAnswer:YES
                                                 trueYES:NO
                                         forSourceObject:sourceObject
                                         andTargetObject:targetObject
                                             withMessage:@"We used the cache + the status was \"checking\" but the option \"assumeYESIfChecking\" was on."
                                                 logging:YES] ;
            }
            break ;
        }
         
        case CBDCoreDataDiscriminatorSimilarityStatusIsQuasiSimilar:
        {
            if (assumeYESIfChecking)
            {
                //return YES ;
                return [self registerAndReturnThisAnswer:YES
                                                 trueYES:NO
                                         forSourceObject:sourceObject
                                         andTargetObject:targetObject
                                             withMessage:@"We used the cache + it is a quasi-similar."
                                                 logging:YES] ;
            }
            break ;
        }
            
        case CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus:
        {
            if (safeMode)
            {
                NSLog(@"INVALID STATUS turned to NO.") ;
                
                return [self registerAndReturnThisAnswer:NO
                                                 trueYES:NO
                                         forSourceObject:sourceObject
                                         andTargetObject:targetObject
                                             withMessage:@"INVALID STATUS turned to NO."
                                                 logging:YES] ;
            }
            else
            {
                [NSException raise:@"Uncompatible hints are being used"
                            format:@"The hints of %@ for %@ and %@ are uncompatible.", catalog, sourceObject, targetObject] ;
            }

            break ;
        }
            
            
        default:
            break;
    }
    
    
    
    /*
     ************************
     We go in the core method
     ************************
     */
    
    
    
    /*
     The CoreData Acceleration checks the attributes.
     So, there is no need to redo it
     */
    if (!usingCoreDataAcceleration)
    {
        /*
         ********
         FIRST : we check the attributes !!!
         ********
         */
        
        
        if (![self doesObject:sourceObject haveTheSameAttributeValuesAs:targetObject])
        {
            return [self registerAndReturnThisAnswer:NO
                                             trueYES:NO
                                     forSourceObject:sourceObject
                                     andTargetObject:targetObject
                                         withMessage:@"By checking the attributes."
                                             logging:YES] ;
        }
        
        
    }
    
    
    
    /*
     *********
     SECOND : we propagate the checking trough relationships
     *********
     */
  
    

    /********
     *****************
     *       INTERMEDE : we gather the relationships we are going to use
     *****************
     *********/

    
    /*
     We get the relations to consider
     */
    NSMutableSet * relationsToCheck = [[self.decisionCenter relationshipsFor:entity] mutableCopy];
    
    
    
    /*
     We exclude the relations not to be considered, thanks to the hints
     */
    catalog = [self globalHintCatalogEnhancedWith:hintCatalog] ;
    
    NSSet * relationshipsNotToCheck = [catalog relationshipsToOmitForSourceObject:sourceObject
                                                                  andTargetObject:targetObject] ;
    
    [relationsToCheck minusSet:relationshipsNotToCheck] ;
    
    
    /*
     We exclude the relations not to be considered, thanks to the entities that should not be considered
     */
    NSMutableSet * result = [relationsToCheck mutableCopy] ;
    
    for (NSRelationshipDescription * relation in relationsToCheck)
    {
        if ([self.decisionCenter shouldIgnore:relation.entity])
        {
            [result removeObject:relation] ;
        }
    }
    
    
    /*
     We set the found result
     */
    relationsToCheck = result ;
    
    
    
    /*
     We dispatch the relationships between toOne, ordered and non-ordered
     */
    NSDictionary * dispatchedRelations = [entity dispatchedRelationshipsFrom_cbd_:relationsToCheck] ;
    
    NSMutableSet * toOneRelationsToCheck = dispatchedRelations[CBDKeyDescriptionToOneRelationship] ;
    NSMutableSet * toManyNonOrderedRelationsToCheck = dispatchedRelations[CBDKeyDescriptionToManyNonOrderedRelationship] ;
    NSMutableSet * toManyOrderedRelationsToCheck = dispatchedRelations[CBDKeyDescriptionToManyOrderedRelationship] ;

    
    
    
    
    
    
    
    
    /*
     ********
     Second - 1
     ********
     
     We check the to-one relationships
     */
    
    
    
    /*
     We create a new catalog
     */
    CBDCoreDataDiscriminatorHintCatalog * newCatalog = [catalog copy] ;
    
    [newCatalog addHintOfSimilarityBetwenSourceObject:sourceObject
                                      andTargetObject:targetObject
                                            hasStatus:CBDCoreDataDiscriminatorSimilarityStatusIsChecking] ;
    
    
    /*
     Adding new hints to the catalog
     */
    for (NSRelationshipDescription * toOneRelationship in toOneRelationsToCheck)
    {
        [self           addNewHintsToCatalog:newCatalog
                     whenChekingRelationship:toOneRelationship
                         betweenSourceObject:sourceObject
                             andTargetObject:targetObject] ;
    }
    
    
    
    
    for (NSRelationshipDescription * toOneRelationship in toOneRelationsToCheck)
    {
        if (self.shouldLog)
        {
            NSLog(@"Checking the relationship %@", toOneRelationship.name) ;
        }
        
        BOOL isRelationSimilar ;
        
        NSManagedObject * newSourceObject = [sourceObject valueForKey:toOneRelationship.name] ;
        NSManagedObject * newTargetObject = [targetObject valueForKey:toOneRelationship.name] ;
        
        isRelationSimilar =  [self isThisSourceObject:newSourceObject
                                similarToTargetObject:newTargetObject
                                     usingHintCatalog:newCatalog
                                  assumeYESifChecking:assumeYESIfChecking
                                        numberOfCalls:numberOfCalls+1] ;

        
        if (isRelationSimilar)
        {
            [self.globalHintCatalog addHintOfSimilarityForRelationship:toOneRelationship
                                                       forSourceObject:sourceObject
                                                       andTargetObject:targetObject
                                                             hasStatus:CBDCoreDataDiscriminatorSimilarityStatusIsSimilar] ;
        }
        
        if (!isRelationSimilar)
        {
            //return NO ;
            
            NSString * message = [NSString stringWithFormat:@"By checking the relationship %@", toOneRelationship.name] ;
            
            return [self registerAndReturnThisAnswer:NO
                                             trueYES:NO
                                     forSourceObject:sourceObject
                                     andTargetObject:targetObject
                                         withMessage:message
                                             logging:YES] ;
        }
    }
    
    
    
    
    
    /*
     ********
     Second - 2
     ********
     
     We check the to-many non-ordered relationships
     */
    
    
    
    newCatalog = [catalog copy] ;
    
    [newCatalog addHintOfSimilarityBetwenSourceObject:sourceObject
                                      andTargetObject:targetObject
                                            hasStatus:CBDCoreDataDiscriminatorSimilarityStatusIsChecking] ;
    
    
    /*
     Adding new hints to the catalog
     */
    for (NSRelationshipDescription * toManyNonOrderedRelationship in toManyNonOrderedRelationsToCheck)
    {
        [self           addNewHintsToCatalog:newCatalog
                     whenChekingRelationship:toManyNonOrderedRelationship
                         betweenSourceObject:sourceObject
                             andTargetObject:targetObject] ;
    }
    

    
    
    
    for (NSRelationshipDescription * toManyNonOrderedRelationship in toManyNonOrderedRelationsToCheck)
    {
        if (self.shouldLog)
        {
            NSLog(@"Checking the relationship %@", toManyNonOrderedRelationship.name) ;
        }
        
        BOOL isRelationSetSimilar ;
        
        NSSet * sourceSet = [sourceObject valueForKey:toManyNonOrderedRelationship.name] ;
        NSSet * targetSet = [targetObject valueForKey:toManyNonOrderedRelationship.name] ;
        
        isRelationSetSimilar = [self isThisSet:sourceSet
                              similarToThisSet:targetSet
                              usingHintCataLog:newCatalog
                           assumeYESifChecking:YES
                                 numberOfCalls:numberOfCalls + 1] ;
    

        if (isRelationSetSimilar)
        {
            [self.globalHintCatalog addHintOfSimilarityForRelationship:toManyNonOrderedRelationship
                                                       forSourceObject:sourceObject
                                                       andTargetObject:targetObject
                                                             hasStatus:CBDCoreDataDiscriminatorSimilarityStatusIsSimilar] ;
        }
        
        if (!isRelationSetSimilar)
        {
            //return NO ;
            return [self  registerAndReturnThisAnswer:NO
                                              trueYES:NO
                                      forSourceObject:sourceSet
                                      andTargetObject:targetSet
                                          withMessage:nil
                                              logging:YES] ;
        }
    }
    
    
    
    
    
    /*
     ********
     Second - 3
     ********
     
     We check the to-many ordered relationships
     */
    
    
    
    newCatalog = [catalog copy] ;
    
    [newCatalog addHintOfSimilarityBetwenSourceObject:sourceObject
                                      andTargetObject:targetObject
                                            hasStatus:CBDCoreDataDiscriminatorSimilarityStatusIsChecking] ;
    
    
    /*
     Adding new hints to the catalog
     */
    for (NSRelationshipDescription * toManyOrderedRelationship in toManyOrderedRelationsToCheck)
    {
        [self           addNewHintsToCatalog:newCatalog
                     whenChekingRelationship:toManyOrderedRelationship
                         betweenSourceObject:sourceObject
                             andTargetObject:targetObject] ;
    }
    
    
    for (NSRelationshipDescription * toManyOrderedRelationship in toManyOrderedRelationsToCheck)
    {
        if (self.shouldLog)
        {
            NSLog(@"Checking the relationship %@", toManyOrderedRelationship.name) ;
        }
        
        BOOL isRelationOrderedSetSimilar ;
        
        NSOrderedSet * sourceOrderedSet = [sourceObject valueForKey:toManyOrderedRelationship.name] ;
        NSOrderedSet * targetOrderedSet = [targetObject valueForKey:toManyOrderedRelationship.name] ;
        
        
        isRelationOrderedSetSimilar = [self  isThisOrderedSet:sourceOrderedSet
                                      similarToThisOrderedSet:targetOrderedSet
                                             usingHintCataLog:newCatalog
                                          assumeYESifChecking:YES
                                                numberOfCalls:numberOfCalls + 1] ;
        
        
        if (isRelationOrderedSetSimilar)
        {
            [self.globalHintCatalog addHintOfSimilarityForRelationship:toManyOrderedRelationship
                                                       forSourceObject:sourceObject
                                                       andTargetObject:targetObject
                                                             hasStatus:CBDCoreDataDiscriminatorSimilarityStatusIsSimilar] ;
        }
        
        
        if (!isRelationOrderedSetSimilar)
        {
            //return NO ;
            return [self  registerAndReturnThisAnswer:NO
                                              trueYES:NO
                                      forSourceObject:sourceOrderedSet
                                      andTargetObject:targetOrderedSet
                                          withMessage:nil
                                              logging:YES] ;
        }
    }
    
    
    /*
     Here, trueYES can also be set to YES
     
     For more safety, we set it to NO
     */
    //return YES ;
    return [self registerAndReturnThisAnswer:YES
                                     trueYES:NO
                             forSourceObject:sourceObject
                             andTargetObject:targetObject
                                 withMessage:@"This YES comes from the bottom of the core method"
                                     logging:YES];
}











//
//
/**************************************/
#pragma mark - We explore the graph in only one way
/**************************************/


- (void)addNewHintsToCatalog:(CBDCoreDataDiscriminatorHintCatalog *)catalog
     whenChekingRelationship:(NSRelationshipDescription *)relationship
         betweenSourceObject:(NSManagedObject *)sourceObject
             andTargetObject:(NSManagedObject *)targetObject
{
    NSRelationshipDescription * inverseRelationship = relationship.inverseRelationship ;
    
    /*
     If the inverseRelationship is not set, we do nothing
     */
    if (!inverseRelationship)
    {
        return ;
    }
    
    NSSet * setOfNewSourceObjects = [sourceObject setValueForRelationship_cbd_:relationship] ;
    NSSet * setOfNewTargetObjects = [targetObject setValueForRelationship_cbd_:relationship] ;
    
    for (NSManagedObject * newSourceObject in setOfNewSourceObjects)
    {
        for (NSManagedObject * newTargetObject in setOfNewTargetObjects)
        {
            NSSet * setOfInverseObjectsForSource = [newSourceObject setValueForRelationship_cbd_:inverseRelationship] ;
            NSSet * setOfInverseObjectsForTarget = [newTargetObject setValueForRelationship_cbd_:inverseRelationship] ;
            
            if ([setOfInverseObjectsForSource count] == 1
                &&
                [setOfInverseObjectsForTarget count] == 1)
                
                [catalog addHintBetweenSourceObject:newSourceObject
                                    andTargetObject:newTargetObject
                          toNotCheckTheRelationship:inverseRelationship] ;
        }
    }
}








//
//
/**************************************/
#pragma mark - Discriminate ordered sets
/**************************************/




- (BOOL)           isThisOrderedSet:(NSOrderedSet *)sourceOrderedSet
            similarToThisOrderedSet:(NSOrderedSet *)targetOrderedSet
                   usingHintCataLog:(CBDCoreDataDiscriminatorHintCatalog *)hintCalalog
                assumeYESifChecking:(BOOL)assumeYESIfChecking
                      numberOfCalls:(NSInteger)numberOfCalls
{
    if ([sourceOrderedSet count] != [targetOrderedSet count])
    {
        //return NO ;
        return [self registerAndReturnThisAnswer:NO
                                         trueYES:NO
                                 forSourceObject:sourceOrderedSet
                                 andTargetObject:targetOrderedSet
                                     withMessage:@"The two ordered sets don't have the same cardinality"
                                         logging:NO];
    }
    
    if ([sourceOrderedSet count] == 0
        &&
        [targetOrderedSet count] == 0)
    {
        //return YES ;
        return [self registerAndReturnThisAnswer:YES
                                         trueYES:YES
                                 forSourceObject:sourceOrderedSet
                                 andTargetObject:targetOrderedSet
                                     withMessage:@"The two ordered sets are empty"
                                         logging:NO];
    }
    
    NSManagedObject * firstSourceObject = sourceOrderedSet[0] ;
    NSManagedObject * firstTargetObject = targetOrderedSet[0] ;
    
    if (![self isThisSourceObject:firstSourceObject
            similarToTargetObject:firstTargetObject
                 usingHintCatalog:hintCalalog
              assumeYESifChecking:YES
                    numberOfCalls:numberOfCalls + 1])
    {
        return NO ;
    }
    
    /*
     Recursive step
     */
    NSRange newRange = NSMakeRange(1, sourceOrderedSet.count-1) ;
    
    NSOrderedSet * newSourceOrderedSet ;
    newSourceOrderedSet = [[NSOrderedSet alloc] initWithOrderedSet:sourceOrderedSet
                                                             range:newRange
                                                         copyItems:NO] ;
    
    NSOrderedSet * newTargeOrderedSet ;
    newTargeOrderedSet = [[NSOrderedSet alloc] initWithOrderedSet:targetOrderedSet
                                                            range:newRange
                                                        copyItems:NO] ;
    
    return           [self isThisOrderedSet:newSourceOrderedSet
                    similarToThisOrderedSet:newTargeOrderedSet
                           usingHintCataLog:hintCalalog
                        assumeYESifChecking:assumeYESIfChecking
                              numberOfCalls:numberOfCalls + 1
                      ] ;
    
    
}










//
//
/**************************************/
#pragma mark - Discriminate sets
/**************************************/



- (BOOL)           isThisSet:(NSSet *)sourceSet
            similarToThisSet:(NSSet *)targetSet
            usingHintCataLog:(CBDCoreDataDiscriminatorHintCatalog *)hintCalalog
         assumeYESifChecking:(BOOL)assumeYESIfChecking
               numberOfCalls:(NSInteger)numberOfCalls
{
    if ([sourceSet count] != [targetSet count])
    {
        //return NO ;
        return [self registerAndReturnThisAnswer:NO
                                         trueYES:NO
                                 forSourceObject:sourceSet
                                 andTargetObject:targetSet
                                     withMessage:@"The two sets don't have the same cardinality"
                                         logging:NO];
    }
    
    
    if ([sourceSet count] == 0
        &&
        [targetSet count] == 0)
    {
        //return YES ;
        return [self registerAndReturnThisAnswer:YES
                                         trueYES:YES
                                 forSourceObject:sourceSet
                                 andTargetObject:targetSet
                                     withMessage:@"The two sets are empty"
                                         logging:NO];
        
    }

    //(decommenter  --> plus de bug)
    //(commenter  --> plus long)

//    NSSet * setOfGoodHints = [self hintsOfPositiveSimilarityTypeFrom:hintCalalog
//                                               whoseSourceObjectIsIn:sourceSet
//                                                 assumeYESifChecking:assumeYESIfChecking] ;
//    
//    for (CBDCoreDataDiscriminatorHint * hint in setOfGoodHints)
//    {
//        NSManagedObject * chosenSourceObject = hint.sourceObject ;
//        NSManagedObject * testedTargetObject = hint.targetObject ;
//        
//        if ([targetSet containsObject:testedTargetObject])
//        {
//            return [self isSourceSet:sourceSet
//                  similarToTargetSet:targetSet
//                    withSourceObject:chosenSourceObject
//                           similarTo:testedTargetObject
//                    usingHintCataLog:hintCalalog
//                 assumeYESifChecking:assumeYESIfChecking
//                       numberOfCalls:numberOfCalls + 1] ;
//        }
//    }
    
    
    /*
     Worst case: we had no hint.
     We'll have to enumerate sourceSet and targetSet and compare them.
     */
    for (NSManagedObject * sourceObject in sourceSet)
    {
        for (NSManagedObject * targetObject in targetSet)
        {
            if ([self isThisSourceObject:sourceObject
                   similarToTargetObject:targetObject
                        usingHintCatalog:hintCalalog
                     assumeYESifChecking:assumeYESIfChecking
                           numberOfCalls:numberOfCalls + 1])
            {
                return [self isSourceSet:sourceSet
                      similarToTargetSet:targetSet
                        withSourceObject:sourceObject
                               similarTo:targetObject
                        usingHintCataLog:hintCalalog
                     assumeYESifChecking:assumeYESIfChecking
                           numberOfCalls:numberOfCalls + 1] ;
            }
        }
    }
    
    return NO ;
}



- (BOOL)      isSourceSet:(NSSet *)sourceSet
       similarToTargetSet:(NSSet *)targetSet
         withSourceObject:(NSManagedObject *)sourceObject
                similarTo:(NSManagedObject *)targetObject
         usingHintCataLog:(CBDCoreDataDiscriminatorHintCatalog *)hintCalalog
      assumeYESifChecking:(BOOL)assumeYESIfChecking
            numberOfCalls:(NSInteger)numberOfCalls
{
    NSMutableSet * newSourceSet = [sourceSet mutableCopy] ;
    [newSourceSet removeObject:sourceObject] ;
    NSMutableSet * newTargetSet = [targetSet mutableCopy] ;
    [newTargetSet removeObject:targetObject]  ;
    
    return        [self isThisSet:newSourceSet
                 similarToThisSet:newTargetSet
                 usingHintCataLog:hintCalalog
              assumeYESifChecking:assumeYESIfChecking
                    numberOfCalls:numberOfCalls + 1] ;
    
}






//
//
/**************************************/
#pragma mark - Filtering the return for adding hints to the catalog and logging
/**************************************/



- (BOOL)registerAndReturnThisAnswer:(BOOL)theBOOLReturn
                            trueYES:(BOOL)isATrueYES
                    forSourceObject:(id)sourceObject
                    andTargetObject:(id)targetObject
                        withMessage:(NSString *)message
                            logging:(BOOL)logging
{
    CBDCoreDataDiscriminatorSimilarityStatus status ;
    if (theBOOLReturn)
    {
        if (isATrueYES)
        {
            status = CBDCoreDataDiscriminatorSimilarityStatusIsSimilar ;
        }
        else
        {
            status = CBDCoreDataDiscriminatorSimilarityStatusIsQuasiSimilar ;
        }
    }
    else
    {
        status = CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar ;
    }
    
    
    /*
     We add it to the global catalog !!!
     If sourceObject and targetObject are NSManagedObjects
     */
    if ([sourceObject isKindOfClass:[NSManagedObject class]]
        &&
        !status)
    {
        [self.globalHintCatalog addHintOfSimilarityBetwenSourceObject:sourceObject
                                                      andTargetObject:targetObject
                                                            hasStatus:status] ;
    }
    
    
    /*
     We log
     */
    if (logging
        &&
        self.shouldLog)
    {
        NSLog(@"Similarity of %@ and %@ : %@. \n Remark: %@", sourceObject, targetObject, theBOOLReturn?@"YES":@"***NO***", message?message:@"");
    }
    
    
    /*
     We return the value
     */
    return theBOOLReturn ;
}






//
//
/**************************************/
#pragma mark - Finding similar object
/**************************************/


- (NSArray *)similarObjectTo:(NSManagedObject *)sourceObject
                       inMOC:(NSManagedObjectContext *)MOC
{
    if (!sourceObject
        ||
        !MOC)
    {
        return @[] ;
    }
    
    NSEntityDescription * entity = sourceObject.entity ;
    
    NSArray * objectsToTest ;
    
    if (usingCoreDataAcceleration)
    {
        objectsToTest = [self objectsVirtuallySimilarTo:sourceObject
                                     withPredicateDepth:depthForCoreDataAcceleration_cbd_
                                                  inMOC:MOC] ;
    }
    else
    {
        objectsToTest = [entity allInMOC_cbd_:MOC] ;
    }
    
    NSMutableArray * result = [[NSMutableArray alloc] init] ;
    
    for (NSManagedObject * objectToTest in objectsToTest)
    {
        if ([self isSourceObject:sourceObject
               similarToTargetObject:objectToTest])
        {
            [result addObject:objectsToTest] ;
        }
    }
    
    return result ;
}



- (NSManagedObject *)firstSimilarObjectTo:(NSManagedObject *)sourceObject
                                    inMOC:(NSManagedObjectContext *)MOC
{
    if (!sourceObject
        ||
        !MOC)
    {
        return nil ;
    }
    
    NSEntityDescription * entity = sourceObject.entity ;
    
    NSArray * objectsToTest ;
    
    if (usingCoreDataAcceleration)
    {
        objectsToTest = [self objectsVirtuallySimilarTo:sourceObject
                                     withPredicateDepth:depthForCoreDataAcceleration_cbd_
                                                  inMOC:MOC] ;
    }
    else
    {
        objectsToTest = [entity allInMOC_cbd_:MOC] ;
    }
    
    
    __block NSManagedObject * result ;
    
    [objectsToTest enumerateObjectsUsingBlock:^(NSManagedObject * objectToTest, NSUInteger idx, BOOL *stop)
    {
        if ([self     isSourceObject:sourceObject
               similarToTargetObject:objectToTest])
        {
            result = objectToTest ;
            *stop = YES ;
        }
    }] ;
    
    return result ;
}

@end
