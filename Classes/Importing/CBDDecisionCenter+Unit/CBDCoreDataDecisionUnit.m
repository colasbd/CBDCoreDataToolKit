//
//  CBDCoreDataDiscriminator.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//




#import "CBDCoreDataDecisionUnit.h"
#import "NSManagedObject+CBDMiscMethods.h"
#import "NSEntityDescription+CBDMiscMethods.h"





/*
 When merging, if YES, ignore wins
 */
const BOOL ignoreWinsOverNotIgnore = YES;








@interface CBDCoreDataDecisionUnit ()

//#pragma mark -

//
//
/**************************************/
#pragma mark Properties strong
/**************************************/
@property (nonatomic, readwrite)BOOL shouldBeIgnored ;

@property (nonatomic, strong, readwrite)NSMutableSet* mutableNameUsedAttributes ;
@property (nonatomic, strong, readwrite)NSMutableSet* mutableUsedRelationshipDescriptions ;

@property (nonatomic, strong, readwrite)NSMutableSet* mutableNameIgnoredAttributes ;
@property (nonatomic, strong, readwrite)NSMutableSet* mutableIgnoredRelationshipDescriptions ;


@property (nonatomic, strong, readwrite)NSMutableSet* mutableNameOtherKeys ;



//
//
/**************************************/
#pragma mark Properties-référence
/**************************************/
@property (nonatomic, weak, readwrite)NSEntityDescription *entity ;


@end









//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/


@implementation CBDCoreDataDecisionUnit





//
//
/**************************************/
#pragma mark - Description
/**************************************/


- (NSString *)description
{
    return [NSString stringWithFormat:@"DecisionUnit for %@:\n * including the attributes %@ and relationships %@\n * excluding the attributes %@ and relationships %@\n * ignoring:%@",
            self.entity.name,
            self.nameAttributesToUse,
            [self.relationshipDescriptionsToUse valueForKey:@"name"],
            self.nameAttributesToIgnore,
            [self.relationshipDescriptionsToIgnore valueForKey:@"name"],
            self.shouldBeIgnored?@"YES":@"NO"
            ] ;
}







//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/




-  (id)       initForEntity:(NSEntityDescription *)entity
            usingAttributes:(NSArray *)namesUsedAttributeForDecision
         usingRelationships:(NSArray *)namesUsedRelationshipsForDecision
         ignoringAttributes:(NSArray *)namesIgnoredAttributeForDecision
      ignoringRelationships:(NSArray *)namesIgnoredRelationshipsForDecision
            shouldBeIgnored:(BOOL)shouldBeIgnored
{
    self = [super init] ;
    
    if (self)
    {
        self.entity = entity ;
        self.shouldBeIgnored = shouldBeIgnored ;
        
        NSMutableSet * nameUsedAttributes = [[NSMutableSet alloc] init] ;
        NSMutableSet * usedRelationshipDescriptions = [[NSMutableSet alloc] init] ;
        
        NSMutableSet * nameIgnoredAttributes = [[NSMutableSet alloc] init] ;
        NSMutableSet * ignoredRelationshipDescriptions = [[NSMutableSet alloc] init] ;
        
        NSMutableSet * nameOtherKeys = [[NSMutableSet alloc] init] ;
        
        
        /*
         USED
         */
        for (NSString * nameRelation in namesUsedRelationshipsForDecision)
        {
            if ([[entity.relationshipsByName allKeys] containsObject:nameRelation])
            {
                [usedRelationshipDescriptions addObject:entity.relationshipsByName[nameRelation]] ;
            }
            else
            {
                [nameOtherKeys addObject:nameRelation] ;
            }
        }
        
        for (NSString * nameAttribute in namesUsedAttributeForDecision)
        {
            if ([[entity.attributesByName allKeys] containsObject:nameAttribute])
            {
                [nameUsedAttributes addObject:nameAttribute] ;
            }
            else
            {
                [nameOtherKeys addObject:nameAttribute] ;
            }
        }
        
        
        /*
         IGNORED
         */
        for (NSString * nameRelation in namesIgnoredRelationshipsForDecision)
        {
            if ([[entity.relationshipsByName allKeys] containsObject:nameRelation])
            {
                [ignoredRelationshipDescriptions addObject:entity.relationshipsByName[nameRelation]] ;
            }
            else
            {
                [nameOtherKeys addObject:nameRelation] ;
            }
        }
        
        for (NSString * nameAttribute in namesIgnoredAttributeForDecision)
        {
            if ([[entity.attributesByName allKeys] containsObject:nameAttribute])
            {
                [nameIgnoredAttributes addObject:nameAttribute] ;
            }
            else
            {
                [nameOtherKeys addObject:nameAttribute] ;
            }
        }
        
        self.mutableNameUsedAttributes = nameUsedAttributes ;
        self.mutableUsedRelationshipDescriptions = usedRelationshipDescriptions ;
        
        self.mutableNameIgnoredAttributes = nameIgnoredAttributes ;
        self.mutableIgnoredRelationshipDescriptions = ignoredRelationshipDescriptions ;
        
        self.mutableNameOtherKeys = nameOtherKeys ;
        
    }
    
    return self ;
}



-  (id) initForEntity:(NSEntityDescription *)entity
      usingAttributes:(NSArray *)namesUsedAttributeForDecision
     andRelationships:(NSArray *)namesUsedRelationshipsForDecision
{
    return [self initForEntity:entity
               usingAttributes:namesUsedAttributeForDecision
            usingRelationships:namesUsedRelationshipsForDecision
            ignoringAttributes:nil
         ignoringRelationships:nil
               shouldBeIgnored:NO] ;
}


- (id)initForEntity:(NSEntityDescription *)entity
 ignoringAttributes:(NSArray *)namesAttributeForDecision
   andRelationships:(NSArray *)namesRelationshipForDecision
{
    return [self initForEntity:entity
               usingAttributes:nil
            usingRelationships:nil
            ignoringAttributes:namesAttributeForDecision
         ignoringRelationships:namesRelationshipForDecision
               shouldBeIgnored:NO] ;
    
}


- (id)initSemiExhaustiveFor:(NSEntityDescription *)entity
{
    return [self initForEntity:entity
               usingAttributes:[entity.attributesByName allKeys]
            usingRelationships:nil
            ignoringAttributes:nil
         ignoringRelationships:[entity.relationshipsByName allKeys]
               shouldBeIgnored:NO] ;
}



- (id)initExhaustiveFor:(NSEntityDescription *)entity
{
    return [self initForEntity:entity
               usingAttributes:[entity.attributesByName allKeys]
              andRelationships:[entity.relationshipsByName allKeys]] ;
}



- (id)initWithIgnoringEntity:(NSEntityDescription *)entity
{
    return  [self initForEntity:entity
                usingAttributes:nil
             usingRelationships:nil
             ignoringAttributes:nil
          ignoringRelationships:nil
                shouldBeIgnored:NO] ;
}








//
//
/**************************************/
#pragma mark - Convenience methods
/**************************************/



- (NSSet *)relationshipDescriptionsToUse
{
    return [self.mutableUsedRelationshipDescriptions copy] ;
}


- (NSSet *)nameAttributesToUse
{
    return [self.mutableNameUsedAttributes copy] ;
}


- (NSSet *)relationshipDescriptionsToIgnore
{
    return [self.mutableIgnoredRelationshipDescriptions copy] ;
}


- (NSSet *)nameAttributesToIgnore
{
    return [self.mutableNameIgnoredAttributes copy] ;
}


- (NSSet *)nameOtherKeys
{
    return [self.mutableNameOtherKeys copy] ;
}





//
//
/**************************************/
#pragma mark - Modification
/**************************************/




- (void)mergeWith:(CBDCoreDataDecisionUnit *)anOtherUnit
{
    if (self.entity != anOtherUnit.entity)
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"You cannot merge two CBDCoreDataDecisionUnit with different entities."] ;
    }
    
    if (anOtherUnit.shouldBeIgnored
        && ignoreWinsOverNotIgnore)
    {
        self.shouldBeIgnored = YES ;
    }
    
    if (!anOtherUnit.shouldBeIgnored
        && !ignoreWinsOverNotIgnore)
    {
        self.shouldBeIgnored = NO ;
    }
    
    [self.mutableNameUsedAttributes unionSet:anOtherUnit.nameAttributesToUse] ;
    [self.mutableUsedRelationshipDescriptions unionSet:anOtherUnit.relationshipDescriptionsToUse] ;
    
    [self.mutableNameIgnoredAttributes unionSet:anOtherUnit.nameAttributesToIgnore] ;
    [self.mutableIgnoredRelationshipDescriptions unionSet:anOtherUnit.relationshipDescriptionsToIgnore] ;
    
    [self.mutableNameOtherKeys unionSet:anOtherUnit.nameOtherKeys] ;
}






//
//
/**************************************/
#pragma mark - Decision
/**************************************/

/**
 Compares two objects **using only the attributes** of this instance of CBDCoreDataDecisionUnit.
 
 This method is used by CBDCoreDataDiscriminator but should not be used directly.
 */
- (BOOL)              doesObject:(NSManagedObject *)sourceObject
    haveTheSameAttributeValuesAs:(NSManagedObject *)targetObject
{
    for (NSString * nameAttribute in self.nameAttributesToUse)
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
            return [self returnTheValue:YES
                        forSourceObject:sourceObject
                        andTargetObject:targetObject
                            withMessage:@"Both attributes are nil."
                                logging:NO] ;
        }
        
        if (![valueSourceObject isEqual:valueTargetObject])
        {
            //return NO ;
            NSString * message = [NSString stringWithFormat:@"The fail comes from the attribute %@", nameAttribute] ;
            return [self returnTheValue:NO
                        forSourceObject:sourceObject
                        andTargetObject:targetObject
                            withMessage:message
                                logging:NO] ;
        }
    }
    
    //return YES ;
    return [self returnTheValue:YES
                forSourceObject:sourceObject
                andTargetObject:targetObject
                    withMessage:nil
                        logging:NO] ;
}





//
//
/**************************************/
#pragma mark - Filtering the return
/**************************************/


- (BOOL)returnTheValue:(BOOL)theBOOLreturn
       forSourceObject:(id)sourceObject
       andTargetObject:(id)targetObject
           withMessage:(NSString *)message
               logging:(BOOL)logging
{
    if (logging)
    {
        NSLog(@"Similarity of %@ and %@ : %@. \n Remark: %@", sourceObject, targetObject, theBOOLreturn?@"YES":@"NO", message?message:@"");
    }
    
    return theBOOLreturn ;
}



//
//
/**************************************/
#pragma mark - isEqual
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
    
    return [self isEqualToDecisionUnit:other];
}


- (BOOL)isEqualToDecisionUnit:(CBDCoreDataDecisionUnit *)other
{
    if (self.entity == other.entity
        && [self.nameAttributesToUse isEqualToSet:other.nameAttributesToUse]
        && [self.relationshipDescriptionsToUse isEqualToSet:other.relationshipDescriptionsToUse]
        && [self.nameAttributesToIgnore isEqualToSet:other.nameAttributesToIgnore]
        && [self.relationshipDescriptionsToIgnore isEqualToSet:other.relationshipDescriptionsToIgnore]
        && self.shouldBeIgnored == other.shouldBeIgnored)
    {
        return YES ;
    }
    else
    {
        return NO ;
    }
}




@end
