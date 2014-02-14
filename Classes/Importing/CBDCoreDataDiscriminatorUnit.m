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
//NSString* const <#exempleDeConstante#> = @"Exemple de constante";









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
@property (nonatomic, strong, readwrite)NSSet* nameAttributes ;
@property (nonatomic, strong, readwrite)NSSet* toOneRelationshipDescriptions ;
@property (nonatomic, strong, readwrite)NSSet* nonOrderedToManyRelationshipDescriptions ;
@property (nonatomic, strong, readwrite)NSSet* orderedToManyRelationshipDescriptions ;
@property (nonatomic, strong, readwrite)NSSet* nameOtherKeys ;


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
    return [NSString stringWithFormat:@"DiscriminatorUnit for %@ using the attributes %@ and relationships %@", self.entity.name, self.nameAttributes, [self.relationshipDescriptions valueForKey:@"name"]] ;
}







//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/

-                (id)initForEntity:(NSEntityDescription *)entity
      withDiscriminationAttributes:(NSArray *)attributesForDiscrimination
   withDiscriminationRelationships:(NSArray *)relationshipsForDiscrimination
{
    self = [super init] ;
    
    if (self)
    {
        self.entity = entity ;
        
        NSMutableArray * arrayAttributesOrRelationships ;
        
        arrayAttributesOrRelationships = [attributesForDiscrimination mutableCopy] ;
        [arrayAttributesOrRelationships addObjectsFromArray:relationshipsForDiscrimination] ;
        
        [self checkAndSetAttributesOrRelationshipsWith:arrayAttributesOrRelationships] ;
    }
    
    return self ;
}


- (id)initSemiExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity
{
    return        [self initForEntity:entity
         withDiscriminationAttributes:entity.attributeKeys
      withDiscriminationRelationships:nil] ;
}


- (id)initExhaustiveDiscriminationUnitFor:(NSEntityDescription *)entity
{
    return        [self initForEntity:entity
         withDiscriminationAttributes:entity.attributeKeys
      withDiscriminationRelationships:[entity.relationshipsByName allKeys]] ;
}



- (void)checkAndSetAttributesOrRelationshipsWith:(NSArray *)namesOfKeys
{
    NSDictionary * classifiedKeys = [self.entity classifyAttributesAndRelationships_cbd_:namesOfKeys] ;

    /*
     The attributes
     */
    self.nameAttributes = [NSSet setWithArray:classifiedKeys[CBDKeyDescriptionAttribute]] ;
    
    /*
     The other keys
     */
    self.nameOtherKeys = [NSSet setWithArray:classifiedKeys[CBDKeyUnmatchedKey]] ;

    
    NSDictionary *dicoRelationships = self.entity.relationshipsByName ;
    
    
    NSMutableSet * auxSet ;
    
    /*
     The to-one relationships (the NSRelationshipDescription's)
     */
    
    auxSet = [[NSMutableSet alloc] init] ;
    
    for (NSString * nameRelationship in classifiedKeys[CBDKeyDescriptionToOneRelationship])
    {
        [auxSet addObject:dicoRelationships[nameRelationship]] ;
    }
    
    self.toOneRelationshipDescriptions = auxSet ;
    
    
    /*
     The to-one relationships (the NSRelationshipDescription's)
     */
    
    auxSet = [[NSMutableSet alloc] init] ;
    
    for (NSString * nameRelationship in classifiedKeys[CBDKeyDescriptionToManyOrderedRelationship])
    {
        [auxSet addObject:dicoRelationships[nameRelationship]] ;
    }
    
    self.orderedToManyRelationshipDescriptions = auxSet ;

    
    /*
     The to-one relationships (the NSRelationshipDescription's)
     */
    
    auxSet = [[NSMutableSet alloc] init] ;
    
    for (NSString * nameRelationship in classifiedKeys[CBDKeyDescriptionToManyNonOrderedRelationship])
    {
        [auxSet addObject:dicoRelationships[nameRelationship]] ;
    }
    
    self.nonOrderedToManyRelationshipDescriptions = auxSet ;
    
}





//
//
/**************************************/
#pragma mark - All relationships
/**************************************/



- (NSSet *)relationshipDescriptions
{
    NSMutableSet * result = [[NSMutableSet alloc] init] ;
    
    [result unionSet:self.toOneRelationshipDescriptions] ;
    [result unionSet:self.nonOrderedToManyRelationshipDescriptions] ;
    [result unionSet:self.orderedToManyRelationshipDescriptions] ;
    
    return result ;
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
    for (NSString * nameAttribute in self.nameAttributes)
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
        && [self.nameAttributes isEqualToSet:other.nameAttributes]
        && [self.toOneRelationshipDescriptions isEqualToSet:other.toOneRelationshipDescriptions]
        && [self.nonOrderedToManyRelationshipDescriptions isEqualToSet:other.nonOrderedToManyRelationshipDescriptions]
        && [self.orderedToManyRelationshipDescriptions isEqualToSet:other.orderedToManyRelationshipDescriptions])
    {
        return YES ;
    }
    else
    {
        return NO ;
    }
}




@end
