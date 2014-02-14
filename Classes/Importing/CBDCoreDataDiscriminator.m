//
//  CBCoreDataDiscriminator.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import "CBDCoreDataDiscriminator.h"
#import "CBDCoreDataDiscriminatorUnit.h"
#import "CBDCoreDataDiscriminatorHint.h"
#import "CBDCoreDataDiscriminatorHintCatalog.h"
#import "NSEntityDescription+CBDMiscMethods.h"
#import "NSManagedObject+CBDMiscMethods.h"


@interface CBDCoreDataDiscriminator ()

@property (nonatomic, strong, readwrite)NSMutableArray * mutableDiscriminatorUnits ;
@property (nonatomic, strong, readwrite)NSMutableSet * mutableEntitiesRegistered ;
@property (nonatomic, strong, readwrite)NSMutableDictionary * discriminatorUnitsByEntity ;

@property (nonatomic, strong, readwrite)CBDCoreDataDiscriminatorHintCatalog * globalHintCatalog ;

- (CBDCoreDataDiscriminatorHintCatalog *)globalHintCatalogEnhancedWith:(CBDCoreDataDiscriminatorHintCatalog *)otherCatalog ;

@end


@implementation CBDCoreDataDiscriminator



//
//
/**************************************/
#pragma mark - Init
/**************************************/

- (id)init
{
    self = [super init] ;
    
    if (self)
    {
        self.mutableDiscriminatorUnits = [[NSMutableArray alloc] init] ;
        self.mutableEntitiesRegistered = [[NSMutableSet alloc] init] ;
        self.globalHintCatalog = [[CBDCoreDataDiscriminatorHintCatalog alloc] init] ;
        self.discriminatorUnitsByEntity = [[NSMutableDictionary alloc] init] ;
    }
    
    return self ;
}



//
//
/**************************************/
#pragma mark - Managing Units and entities
/**************************************/


- (NSArray *)discriminatorUnits
{
    return [self.mutableDiscriminatorUnits copy] ;
}


- (NSSet *)entitiesRegistered
{
    return [self.mutableEntitiesRegistered copy] ;
}


- (void)addDiscrimintorUnit:(CBDCoreDataDiscriminatorUnit *)aDiscriminatorUnit
{
    if (![self.discriminatorUnits containsObject:aDiscriminatorUnit])
    {
        [self.mutableDiscriminatorUnits addObject:aDiscriminatorUnit] ;
        [self.mutableEntitiesRegistered addObject:aDiscriminatorUnit.entity] ;
        
        [self updateDiscriminatorUnitsByEntityFor:aDiscriminatorUnit] ;
    }
}


- (void)updateDiscriminatorUnitsByEntityFor:(CBDCoreDataDiscriminatorUnit *)aDiscriminatorUnit
{
    if (!self.discriminatorUnitsByEntity[aDiscriminatorUnit.entity.name])
    {
        self.discriminatorUnitsByEntity[aDiscriminatorUnit.entity.name] = [[NSMutableArray alloc] init] ;
    }
    
    [self.discriminatorUnitsByEntity[aDiscriminatorUnit.entity.name] addObject:aDiscriminatorUnit] ;
}


- (NSArray *)discriminatorUnitsForEntity:(NSEntityDescription *)entity
{
    NSMutableArray * result = [[NSMutableArray alloc] init] ;
    
    for (CBDCoreDataDiscriminatorUnit * discriminatorUnit in self.discriminatorUnits)
    {
        if (discriminatorUnit.entity == entity)
        {
            [result addObject:discriminatorUnit] ;
        }
    }
    
    return result ;
}



- (void)removeAllDiscriminatorUnits
{
    self.mutableDiscriminatorUnits = [[NSMutableArray alloc] init] ;
    self.mutableEntitiesRegistered = [[NSMutableSet alloc] init] ;
    self.discriminatorUnitsByEntity = [[NSMutableDictionary alloc] init] ;
    
    [self flushTheCache] ;
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

/**
 Removes the last entry of the cache
 */
- (void)removeLastEntryOfTheCache
{
    [self.globalHintCatalog removeLastHint] ;
}


- (void)logTheCache
{
    NSLog(@"The cache is %@", self.globalHintCatalog) ;
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
#pragma mark - Discriminate : convenience methods
/**************************************/

TODO(class à reprendre)
/*
 Idée : ne pas renvoyer un BOOL mais un objet qui parle du résultat (genre : échec...)
 Reprendre aussi l'algo avec Fred.
 
 Plusieurs modes de recherches (borne sur la profondeur récursive plus ou moins grande)
 
 Au lieu de usingResearchType : mettre des méthodes sur CBDCoreDataDiscriminator, du genre : setResearchFacilitating, etc. Quand on change de mode, faire un flush.
 */
- (BOOL)isThisSourceObject:(NSManagedObject *)sourceObject
     similarToTargetObject:(NSManagedObject *)targetObject
{
    return [self isThisSourceObject:sourceObject
              similarToTargetObject:targetObject
             excludingRelationships:nil
                  excludingEntities:nil
                  usingResearchType:CBDCoreDataDiscriminatorResearchSemiFacilitating] ;
}






- (BOOL)     isThisSourceObject:(NSManagedObject *)sourceObject
          similarToTargetObject:(NSManagedObject *)targetObject
         excludingRelationships:(NSSet *)relationshipsNotToCheck
              excludingEntities:(NSSet *)entitiesToExclude
              usingResearchType:(CBDCoreDataDiscriminatorResearchType)researchType
{
    /*
     I don't know if putting YES to this option make the algorithm not correct.
     I don't know if putting NO to this option make the algorithm falling in infinite loops.
     */
    
    BOOL optionYESIfChecking = YES ;
    
    BOOL result =  [self isThisSourceObject:sourceObject
                      similarToTargetObject:targetObject
                     excludingRelationships:relationshipsNotToCheck
                          excludingEntities:entitiesToExclude
                           usingHintCatalog:self.globalHintCatalog
                        assumeYESifChecking:optionYESIfChecking
                          usingResearchType:researchType
                              numberOfCalls:1] ;

    
    /*
     Returning the result
     */
    return result ;
}







//
//
/**************************************/
#pragma mark - Discriminate : core methods
/**************************************/


- (BOOL)     isThisSourceObject:(NSManagedObject *)sourceObject
          similarToTargetObject:(NSManagedObject *)targetObject
         excludingRelationships:(NSSet *)relationshipsNotToCheck
              excludingEntities:(NSSet *)entitiesToExclude
               usingHintCatalog:(CBDCoreDataDiscriminatorHintCatalog *)hintCatalog
            assumeYESifChecking:(BOOL)assumeYESIfChecking
              usingResearchType:(CBDCoreDataDiscriminatorResearchType) researchType
                  numberOfCalls:(NSInteger)numberOfCalls
{
    //DDLogVerbose(@"Checking similarity of %@ and %@", sourceObject, targetObject) ;
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
    
    
    // pour le debug
    //
    //
//    if ([sourceObject respondsToSelector:@selector(name)]
//        &&
//        [[sourceObject valueForKey:@"name"] isEqualToString:[targetObject valueForKey:@"name"]]
//        &&
//        [sourceObject.entity.name isEqualToString:@"Company"])
//    {
//        //NSLog( @"here" );
//    }
    
    
    
    
    /*
     Allocating and initializing nil argument
     */
    if (!hintCatalog)
    {
        hintCatalog = [[CBDCoreDataDiscriminatorHintCatalog alloc] init] ;
    }
    if (!relationshipsNotToCheck)
    {
        relationshipsNotToCheck = [[NSSet alloc] init] ;
    }
    if (!entitiesToExclude)
    {
        entitiesToExclude = [[NSSet alloc] init] ;
    }
    
    
    
    /*
     We check if the entities are the same
     */
    if (![sourceObject.entity isEqual:targetObject.entity])
    {
        //return NO ;
        
        return [self registerAndReturnThisAnswer:NO
                                 forSourceObject:sourceObject
                                 andTargetObject:targetObject
                                     withMessage:@"Entities are not the same."
                                         logging:NO] ;
    }
    
    
    /*
     If the entity of the objects to check is in the list of entities to omit
     */
    if ([sourceObject.entity inheritsFromSomeEntityAmong_cbd_:entitiesToExclude])
    {
        //        [NSException raise:NSInvalidArgumentException
        //                    format:@"You want to know if %@ is similar to %@ but you have asked to exclude from the check the following entities %@", sourceObject, targetObject, entitiesToExclude];
        
        //return YES ;
        
        return [self registerAndReturnThisAnswer:YES
                                 forSourceObject:sourceObject
                                 andTargetObject:targetObject
                                     withMessage:@"The entity is in the black list."
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
                                     forSourceObject:sourceObject
                                     andTargetObject:targetObject
                                         withMessage:@"We used the cache."
                                             logging:YES] ;
            
            break;
            
        case CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar:
            //return NO ;
            return [self registerAndReturnThisAnswer:NO
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
                                         forSourceObject:sourceObject
                                         andTargetObject:targetObject
                                             withMessage:@"We used the cache + the status was \"checking\" but the option \"assumeYESIfChecking\" was on."
                                                 logging:YES] ;
            }
            break ;
        }
            
        case CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus:
        {
            [NSException raise:@"Uncompatible hints are being used"
                        format:@"The hints of %@ for %@ and %@ are uncompatible.", catalog, sourceObject, targetObject] ;
            break ;
        }
            
            
        default:
            break;
    }
    
    
    
    /*
     We go in the core method
     */
    
    
    /*
     We gather the discriminatorUnits that we are going to use
     */
    NSMutableArray * usedDiscriminatorUnits = [[NSMutableArray alloc] init] ;
    
    NSEntityDescription * entity = sourceObject.entity ;
    
    for (NSString * nameEntity in [self.discriminatorUnitsByEntity allKeys])
    {
        if ([entity isKindOfEntityWithName_cbd_:nameEntity])
        {
            [usedDiscriminatorUnits addObjectsFromArray:self.discriminatorUnitsByEntity[nameEntity]] ;
        }
    }
    
    
    
    /*
     Case where this is no discriminationUnit for this entity !!
     */
    if ([usedDiscriminatorUnits count] == 0)
    {
        switch (researchType)
        {
            case CBDCoreDataDiscriminatorResearchFacilitating:
            {
                // do nothing
                break;
            }
                
            case CBDCoreDataDiscriminatorResearchSemiFacilitating:
            {
                CBDCoreDataDiscriminatorUnit * defaultUnit ;
                defaultUnit = [[CBDCoreDataDiscriminatorUnit alloc] initSemiExhaustiveDiscriminationUnitFor:entity] ;
                
                [usedDiscriminatorUnits addObject:defaultUnit] ;
                break;
            }
                
            case CBDCoreDataDiscriminatorResearchDemanding:
            {
                CBDCoreDataDiscriminatorUnit * defaultUnit ;
                defaultUnit = [[CBDCoreDataDiscriminatorUnit alloc] initExhaustiveDiscriminationUnitFor:entity] ;
                
                [usedDiscriminatorUnits addObject:defaultUnit] ;
                break;
            }
                
            default:
                break;
        }
        
    }
    
    
    
    /*
     ********
     FIRST : we check the attributes !!!
     ********
     */
    
    for (CBDCoreDataDiscriminatorUnit * discriminatorUnit in usedDiscriminatorUnits)
    {
        if (![discriminatorUnit doesObject:sourceObject
              haveTheSameAttributeValuesAs:targetObject])
        {
            //return NO ;
            
            return [self registerAndReturnThisAnswer:NO
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
    catalog = [self globalHintCatalogEnhancedWith:hintCatalog] ;
    
    NSMutableSet * totalRelationshipsNotToCheck = [relationshipsNotToCheck mutableCopy] ;
    [totalRelationshipsNotToCheck unionSet:[catalog relationshipsToOmitForSourceObject:sourceObject
                                                                       andTargetObject:targetObject]] ;
    
    
    
    /*
     We create a new catalog
     */
    CBDCoreDataDiscriminatorHintCatalog * newCatalog = [catalog copy] ;
    
    [newCatalog addHintOfSimilarityBetwenSourceObject:sourceObject
                                      andTargetObject:targetObject
                                            hasStatus:CBDCoreDataDiscriminatorSimilarityStatusIsChecking] ;
    
    
    
    /*
     Second - 1
     
     We check the to-one relationships
     */
    
    NSMutableSet * toOneRelationsToCheck = [[NSMutableSet alloc] init] ;
    
    for (CBDCoreDataDiscriminatorUnit * discriminatorUnit in usedDiscriminatorUnits)
    {
        NSSet *toOneRelationships = discriminatorUnit.toOneRelationshipDescriptions ;
        
        for (NSRelationshipDescription * relationDescr in toOneRelationships)
        {
            if (![totalRelationshipsNotToCheck containsObject:relationDescr])
            {
                NSEntityDescription * destinationEntity = relationDescr.destinationEntity ;
                
                if (![destinationEntity inheritsFromSomeEntityAmong_cbd_:entitiesToExclude])
                {
                    [toOneRelationsToCheck addObject:relationDescr] ;
                }
            }
        }
    }
    
    
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
        BOOL isRelationSimilar ;
        
        NSManagedObject * newSourceObject = [sourceObject valueForKey:toOneRelationship.name] ;
        NSManagedObject * newTargetObject = [targetObject valueForKey:toOneRelationship.name] ;
        
        
        isRelationSimilar = [self isThisSourceObject:newSourceObject
                               similarToTargetObject:newTargetObject
                              excludingRelationships:relationshipsNotToCheck
                                   excludingEntities:entitiesToExclude
                                    usingHintCatalog:newCatalog
                                 assumeYESifChecking:assumeYESIfChecking
                                   usingResearchType:researchType
                                       numberOfCalls:numberOfCalls+1] ;
        
        if (!isRelationSimilar)
        {
            //return NO ;
            
            NSString * message = [NSString stringWithFormat:@"By checking the relationship %@", toOneRelationship.name] ;
            
            return [self registerAndReturnThisAnswer:NO
                                     forSourceObject:sourceObject
                                     andTargetObject:targetObject
                                         withMessage:message
                                             logging:YES] ;
        }
    }
    
    
    
    /*
     Second - 2
     
     We check the to-many non-ordered relationships
     */
    
    NSMutableSet * toManyNonOrderedRelationsToCheck = [[NSMutableSet alloc] init] ;
    
    for (CBDCoreDataDiscriminatorUnit * discriminatorUnit in usedDiscriminatorUnits)
    {
        NSSet *toManyNonOrderedRelationships = discriminatorUnit.nonOrderedToManyRelationshipDescriptions ;
        
        for (NSRelationshipDescription * relationDescr in toManyNonOrderedRelationships)
        {
            if (![totalRelationshipsNotToCheck containsObject:relationDescr])
            {
                NSEntityDescription * destinationEntity = relationDescr.destinationEntity ;
                
                if (![destinationEntity inheritsFromSomeEntityAmong_cbd_:entitiesToExclude])
                {
                    [toManyNonOrderedRelationsToCheck addObject:relationDescr] ;
                }
            }
        }
    }
    
    
    
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
        BOOL isRelationSetSimilar ;
        
        NSSet * sourceSet = [sourceObject valueForKey:toManyNonOrderedRelationship.name] ;
        NSSet * targetSet = [targetObject valueForKey:toManyNonOrderedRelationship.name] ;
        
        
        isRelationSetSimilar = [self isThisSet:sourceSet
                              similarToThisSet:targetSet
                        excludingRelationships:relationshipsNotToCheck
                             excludingEntities:entitiesToExclude
                              usingHintCataLog:newCatalog
                           assumeYESifChecking:YES
                             usingResearchType:researchType
                                 numberOfCalls:numberOfCalls + 1] ;
        
        
        if (!isRelationSetSimilar)
        {
            //return NO ;
            return [self  registerAndReturnThisAnswer:NO
                                      forSourceObject:sourceSet
                                      andTargetObject:targetSet
                                          withMessage:nil
                                              logging:YES] ;
        }
    }
    
    
    
    
    
    /*
     Second - 3
     
     We check the to-many ordered relationships
     */
    
    NSMutableSet * toManyOrderedRelationsToCheck = [[NSMutableSet alloc] init] ;
    
    for (CBDCoreDataDiscriminatorUnit * discriminatorUnit in usedDiscriminatorUnits)
    {
        NSSet *toManyOrderedRelationships = discriminatorUnit.orderedToManyRelationshipDescriptions ;
        
        for (NSRelationshipDescription * relationDescr in toManyOrderedRelationships)
        {
            if (![totalRelationshipsNotToCheck containsObject:relationDescr])
            {
                NSEntityDescription * destinationEntity = relationDescr.destinationEntity ;
                
                if (![destinationEntity inheritsFromSomeEntityAmong_cbd_:entitiesToExclude])
                {
                    [toManyOrderedRelationsToCheck addObject:relationDescr] ;
                }
            }
        }
    }
    
    
    
    
    
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
        BOOL isRelationOrderedSetSimilar ;
        
        NSOrderedSet * sourceOrderedSet = [sourceObject valueForKey:toManyOrderedRelationship.name] ;
        NSOrderedSet * targetOrderedSet = [targetObject valueForKey:toManyOrderedRelationship.name] ;
        
        
        
        isRelationOrderedSetSimilar = [self  isThisOrderedSet:sourceOrderedSet
                                      similarToThisOrderedSet:targetOrderedSet
                                       excludingRelationships:relationshipsNotToCheck
                                            excludingEntities:entitiesToExclude
                                             usingHintCataLog:newCatalog
                                          assumeYESifChecking:YES
                                            usingResearchType:researchType
                                                numberOfCalls:numberOfCalls + 1] ;
        
        
        
        if (!isRelationOrderedSetSimilar)
        {
            //return NO ;
            return [self  registerAndReturnThisAnswer:NO
                                      forSourceObject:sourceOrderedSet
                                      andTargetObject:targetOrderedSet
                                          withMessage:nil
                                              logging:YES] ;
        }
    }
    
    //return YES ;
    return [self registerAndReturnThisAnswer:YES
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
             excludingRelationships:(NSSet *)relationshipsNotToCheck
                  excludingEntities:(NSSet *)entitiesToExclude
                   usingHintCataLog:(CBDCoreDataDiscriminatorHintCatalog *)hintCalalog
                assumeYESifChecking:(BOOL)assumeYESIfChecking
                  usingResearchType:(CBDCoreDataDiscriminatorResearchType)researchType
                      numberOfCalls:(NSInteger)numberOfCalls
{
    if ([sourceOrderedSet count] != [targetOrderedSet count])
    {
        //return NO ;
        return [self registerAndReturnThisAnswer:NO
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
                                 forSourceObject:sourceOrderedSet
                                 andTargetObject:targetOrderedSet
                                     withMessage:@"The two ordered sets are empty"
                                         logging:NO];
    }
    
    NSManagedObject * firstSourceObject = sourceOrderedSet[0] ;
    NSManagedObject * firstTargetObject = targetOrderedSet[0] ;
    
    if (![self isThisSourceObject:firstSourceObject
            similarToTargetObject:firstTargetObject
           excludingRelationships:relationshipsNotToCheck
                excludingEntities:entitiesToExclude
                 usingHintCatalog:hintCalalog
              assumeYESifChecking:YES
                usingResearchType:researchType
                    numberOfCalls:numberOfCalls + 1])
    {
        return NO ;
    }
    
    /*
     Recursive step
     */
    NSRange newRange = NSMakeRange(1, sourceOrderedSet.count) ;
    
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
                     excludingRelationships:relationshipsNotToCheck
                          excludingEntities:entitiesToExclude
                           usingHintCataLog:hintCalalog
                        assumeYESifChecking:assumeYESIfChecking
                          usingResearchType:researchType
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
      excludingRelationships:(NSSet *)relationshipsNotToCheck
           excludingEntities:(NSSet *)entitiesToExclude
            usingHintCataLog:(CBDCoreDataDiscriminatorHintCatalog *)hintCalalog
         assumeYESifChecking:(BOOL)assumeYESIfChecking
           usingResearchType:(CBDCoreDataDiscriminatorResearchType)researchType
               numberOfCalls:(NSInteger)numberOfCalls
{
    if ([sourceSet count] != [targetSet count])
    {
        //return NO ;
        return [self registerAndReturnThisAnswer:NO
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
                                 forSourceObject:sourceSet
                                 andTargetObject:targetSet
                                     withMessage:@"The two sets are empty"
                                         logging:NO];
        
    }
    
    NSSet * setOfGoodHints = [self hintsOfPositiveSimilarityTypeFrom:hintCalalog
                                               whoseSourceObjectIsIn:sourceSet
                                                 assumeYESifChecking:assumeYESIfChecking
                              ] ;
    
    for (CBDCoreDataDiscriminatorHint * hint in setOfGoodHints)
    {
        NSManagedObject * chosenSourceObject = hint.sourceObject ;
        NSManagedObject * testedTargetObject = hint.targetObject ;
        
        if ([targetSet containsObject:testedTargetObject])
        {
            return [self isSourceSet:sourceSet
                  similarToTargetSet:targetSet
                    withSourceObject:chosenSourceObject
                           similarTo:testedTargetObject
              excludingRelationships:relationshipsNotToCheck
                   excludingEntities:entitiesToExclude
                    usingHintCataLog:hintCalalog
                 assumeYESifChecking:assumeYESIfChecking
                   usingResearchType:researchType
                       numberOfCalls:numberOfCalls + 1] ;
        }
    }
    
    
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
                  excludingRelationships:relationshipsNotToCheck
                       excludingEntities:entitiesToExclude
                        usingHintCatalog:hintCalalog
                     assumeYESifChecking:assumeYESIfChecking
                       usingResearchType:researchType
                           numberOfCalls:numberOfCalls + 1])
            {
                return [self isSourceSet:sourceSet
                      similarToTargetSet:targetSet
                        withSourceObject:sourceObject
                               similarTo:targetObject
                  excludingRelationships:relationshipsNotToCheck
                       excludingEntities:entitiesToExclude
                        usingHintCataLog:hintCalalog
                     assumeYESifChecking:assumeYESIfChecking
                       usingResearchType:researchType
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
   excludingRelationships:(NSSet *)relationshipsNotToCheck
        excludingEntities:(NSSet *)entitiesToExclude
         usingHintCataLog:(CBDCoreDataDiscriminatorHintCatalog *)hintCalalog
      assumeYESifChecking:(BOOL)assumeYESIfChecking
        usingResearchType:(CBDCoreDataDiscriminatorResearchType)researchType
            numberOfCalls:(NSInteger)numberOfCalls
{
    NSMutableSet * newSourceSet = [sourceSet mutableCopy] ;
    [newSourceSet removeObject:sourceObject] ;
    NSMutableSet * newTargetSet = [targetSet mutableCopy] ;
    [newTargetSet removeObject:targetObject]  ;
    
    return        [self isThisSet:newSourceSet
                 similarToThisSet:newTargetSet
           excludingRelationships:(NSSet *)relationshipsNotToCheck
                excludingEntities:(NSSet *)entitiesToExclude
                 usingHintCataLog:hintCalalog
              assumeYESifChecking:assumeYESIfChecking
                usingResearchType:researchType
                    numberOfCalls:numberOfCalls + 1] ;
    
}




- (NSSet *) hintsOfPositiveSimilarityTypeFrom:(CBDCoreDataDiscriminatorHintCatalog *)hintCalalog
                        whoseSourceObjectIsIn:(NSSet *)sourceSet
                          assumeYESifChecking:(BOOL)assumeYESIfChecking
{
    NSMutableSet * result = [[NSMutableSet alloc] init] ;
    
    for (CBDCoreDataDiscriminatorHint * hint in hintCalalog.hints)
    {
        if ([sourceSet containsObject:hint.sourceObject]
            && hint.type == CBDCoreDataDiscriminatorHintAboutSimilarity
            && (hint.similarityStatus == CBDCoreDataDiscriminatorSimilarityStatusIsSimilar
                ||
                (hint.similarityStatus == CBDCoreDataDiscriminatorSimilarityStatusIsChecking
                 &&
                 assumeYESIfChecking)))
        {
            [result addObject:hint] ;
        }
    }
    
    return result ;
}







//
//
/**************************************/
#pragma mark - Filtering the return for adding hints to the catalog and logging
/**************************************/



- (BOOL)registerAndReturnThisAnswer:(BOOL)theBOOLReturn
                    forSourceObject:(id)sourceObject
                    andTargetObject:(id)targetObject
                        withMessage:(NSString *)message
                            logging:(BOOL)logging
{
    CBDCoreDataDiscriminatorSimilarityStatus status ;
    if (theBOOLReturn)
    {
        status = CBDCoreDataDiscriminatorSimilarityStatusIsSimilar ;
    }
    else
    {
        status = CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar ;
    }
    
    
    TODO(nettoyer le catalog)
    /*
     We had it to the global catalog !!!
     If sourceObject and targetObject are NSManagedObjects
     */
    if ([sourceObject isKindOfClass:[NSManagedObject class]])
    {
        [self.globalHintCatalog addHintOfSimilarityBetwenSourceObject:sourceObject
                                                      andTargetObject:targetObject
                                                            hasStatus:status] ;
    }
    
    
    /*
     We log
     */
    if (logging)
    {
     //   NSLog(@"Similarity of %@ and %@ : %@. \n Remark: %@", sourceObject, targetObject, theBOOLReturn?@"YES":@"***NO***", message?message:@"");
    }
    
    
    /*
     We return the value
     */
    return theBOOLReturn ;
}



@end
