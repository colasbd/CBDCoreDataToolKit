//
//  CBDCoreDataDiscriminator.m
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
#import "CBDCoreDataDiscriminatorUnit.h"
#import "NSManagedObject+CBDMiscMethods.h"
#import "NSEntityDescription+CBDMiscMethods.h"


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

/*
 When merging, if YES, ignore wins
 */
const BOOL ignoreWinsOverNotIgnore = YES;









//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATIONS PRIVÉES
/**************************************/
@interface CBDCoreDataDiscriminatorUnit ()

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


@implementation CBDCoreDataDiscriminatorUnit





//
//
/**************************************/
#pragma mark - Description
/**************************************/


- (NSString *)description
{
    return [NSString stringWithFormat:@"DiscriminatorUnit for %@ using the attributes %@ and relationships %@", self.entity.name, self.nameAttributesToUse, [self.relationshipDescriptionsToUse valueForKey:@"name"]] ;
}







//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/




-  (id)initDiscriminatorUnitForEntity:(NSEntityDescription *)entity
                  usingAttributes:(NSArray *)namesUsedAttributeForDiscrimination
               usingRelationships:(NSArray *)namesUsedRelationshipsForDiscrimination
               ignoringAttributes:(NSArray *)namesIgnoredAttributeForDiscrimination
            ignoringRelationships:(NSArray *)namesIgnoredRelationshipsForDiscrimination
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
        for (NSString * nameRelation in namesUsedRelationshipsForDiscrimination)
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
        
        for (NSString * nameAttribute in namesUsedAttributeForDiscrimination)
        {
            if ([self.entity.attributeKeys containsObject:nameAttribute])
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
        for (NSString * nameRelation in namesIgnoredRelationshipsForDiscrimination)
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
        
        for (NSString * nameAttribute in namesIgnoredAttributeForDiscrimination)
        {
            if ([self.entity.attributeKeys containsObject:nameAttribute])
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



-  (id) initDiscriminatorUnitForEntity:(NSEntityDescription *)entity
                       usingAttributes:(NSArray *)namesUsedAttributeForDiscrimination
                      andRelationships:(NSArray *)namesUsedRelationshipsForDiscrimination
{
    return [self initDiscriminatorUnitForEntity:entity
                                usingAttributes:namesUsedAttributeForDiscrimination
                             usingRelationships:namesUsedRelationshipsForDiscrimination
                             ignoringAttributes:nil
                          ignoringRelationships:nil
                                shouldBeIgnored:NO] ;
}


- (id)initDiscriminatorUnitForEntity:(NSEntityDescription *)entity
                  ignoringAttributes:(NSArray *)namesAttributeForDiscrimination
                    andRelationships:(NSArray *)namesRelationshipForDiscrimination
{
    return [self initDiscriminatorUnitForEntity:entity
                                usingAttributes:nil
                             usingRelationships:nil
                             ignoringAttributes:namesAttributeForDiscrimination
                          ignoringRelationships:namesRelationshipForDiscrimination
                                shouldBeIgnored:NO] ;

}


- (id)initSemiExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity
{
    return [self initDiscriminatorUnitForEntity:entity
                                usingAttributes:entity.attributeKeys
                             usingRelationships:nil
                             ignoringAttributes:nil
                          ignoringRelationships:[entity.relationshipsByName allKeys]
                                shouldBeIgnored:NO] ;
}



- (id)initExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity
{
    return [self initDiscriminatorUnitForEntity:entity
                                usingAttributes:entity.attributeKeys
                               andRelationships:[entity.relationshipsByName allKeys]] ;
}



- (id)initIgnoringDiscriminatorUnitForEntity:(NSEntityDescription *)entity
{
    return  [self initDiscriminatorUnitForEntity:entity
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
//- (NSSet *)toOneRelationshipDescriptions
//{
//    NSArray * array = [self.entity classifiedRelationshipsFrom_cbd_:self.usedRelationshipDescriptions][CBDKeyDescriptionToOneRelationship] ;
//    return [NSSet setWithArray:array] ;
//}
//
//
//- (NSSet *)orderedToManyRelationshipDescriptions
//{
//    NSArray * array = [self.entity classifiedRelationshipsFrom_cbd_:self.usedRelationshipDescriptions][CBDKeyDescriptionToManyOrderedRelationship] ;
//    return [NSSet setWithArray:array] ;
//}
//
//- (NSSet *)nonOrderedToManyRelationshipDescriptions
//{
//    NSArray * array = [self.entity classifiedRelationshipsFrom_cbd_:self.usedRelationshipDescriptions][CBDKeyDescriptionToManyNonOrderedRelationship] ;
//    return [NSSet setWithArray:array] ;
//}



//
//
/**************************************/
#pragma mark - Modification
/**************************************/




- (void)mergeWith:(CBDCoreDataDiscriminatorUnit *)anOtherUnit
{
    if (self.entity != anOtherUnit.entity)
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"You cannot merge two CBDCoreDataDiscriminatorUnit with different entities."] ;
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



/**
 Removes the given attributes and relationships from the DiscriminationUnit
 */
- (void)removeAttributes:(NSArray *)namessAttributeForDiscrimination
        andRelationships:(NSArray *)namesRelationshipForDiscrimination
{
    for (NSString * nameAttribute in namessAttributeForDiscrimination)
    {
        [self.mutableNameUsedAttributes removeObject:nameAttribute] ;
    }
    
    for (NSString * nameRelationship in namesRelationshipForDiscrimination)
    {
        [self.mutableUsedRelationshipDescriptions removeObject:self.entity.relationshipsByName[nameRelationship]] ;
    }
    
}




//
//
/**************************************/
#pragma mark - Discrimination
/**************************************/

/**
 Compares two objects **using only the attributes** of this instance of CBDCoreDataDiscriminatorUnit.
 
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
    
    return [self isEqualToDiscriminatorUnit:other];
}


- (BOOL)isEqualToDiscriminatorUnit:(CBDCoreDataDiscriminatorUnit *)other
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
