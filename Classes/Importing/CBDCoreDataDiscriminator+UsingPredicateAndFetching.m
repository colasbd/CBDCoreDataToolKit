//
//  CBDCoreDataDiscriminator+UsingPredicateAndFetching.m
//  Pods
//
//  Created by Colas on 15/02/2014.
//
//

#import "CBDCoreDataDiscriminator+UsingPredicateAndFetching.h"
#import "NSEntityDescription+CBDMiscMethods.h"
#import "NSEntityDescription+CBDActiveRecord.h"



const int depthForDefaultMethods_cbd_ = 0 ;



@implementation CBDCoreDataDiscriminator (UsingPredicateAndFetching)




//
//
/**************************************/
#pragma mark - Clever predicate :
/**************************************/




- (NSPredicate *)predicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                       withPredicateDepth:(NSUInteger)depth
{
    NSPredicate * returnedResult = [self _cleverPredicateToFindObjectsVirtuallySimilarTo:sourceObject
                                                                      withRecursiveDepth:depth] ;
    
    NSPredicate * result =  [returnedResult predicateWithSubstitutionVariables:@{@"my_var": [NSExpression expressionForKeyPath:@"self"]}];
    
    NSLog(@"%@", result) ;
    
    return result ;
}



- (NSPredicate *)predicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
{
    return [self predicateToFindObjectsVirtuallySimilarTo:sourceObject
                                       withPredicateDepth:depthForDefaultMethods_cbd_] ;
}




//
//
/**************************************/
#pragma mark - Other methods
/**************************************/




- (NSArray *)objectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                    withPredicateDepth:(NSUInteger)depth
                                 inMOC:(NSManagedObjectContext *)aMOC

{
    return [sourceObject.entity findInMOC:aMOC
                       withPredicate_cbd_:[self predicateToFindObjectsVirtuallySimilarTo:sourceObject
                                                                      withPredicateDepth:depth]] ;
}


- (NSArray *)objectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                 inMOC:(NSManagedObjectContext *)aMOC
{
    return [self objectsVirtuallySimilarTo:sourceObject
                        withPredicateDepth:depthForDefaultMethods_cbd_
                                     inMOC:aMOC] ;
}





- (BOOL)           isThisSourceObject:(NSManagedObject *)sourceObject
       virtuallySimilarToTargetObject:(NSManagedObject *)targetObject
                   withPredicateDepth:(NSUInteger)depth

{
    return [[self predicateToFindObjectsVirtuallySimilarTo:sourceObject
                                        withPredicateDepth:depth] evaluateWithObject:targetObject] ;
}



- (BOOL)           isThisSourceObject:(NSManagedObject *)sourceObject
       virtuallySimilarToTargetObject:(NSManagedObject *)targetObject

{
    return           [self isThisSourceObject:sourceObject
               virtuallySimilarToTargetObject:targetObject
                           withPredicateDepth:depthForDefaultMethods_cbd_] ;
}



//
//
/**************************************/
#pragma mark - Clever predicate : core method
/**************************************/


- (NSPredicate *)_cleverPredicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                              withRecursiveDepth:(NSUInteger)depth
{
    if (depth == 3)
    {
        NSLog(@"here") ;
    }
    NSEntityDescription * entity = sourceObject.entity ;
    
    NSMutableArray * predicates = [[NSMutableArray alloc] init] ;
    
    
    
    /*
     Checking attributes
     */
    for (NSString * nameAttribute in [self attributesToCheckFor:entity])
    {
        NSPredicate * predicate ;
        predicate = [NSPredicate predicateWithFormat:@"$my_var.%K == %@",
                     nameAttribute,
                     [sourceObject valueForKey:nameAttribute]] ;
        
        [predicates addObject:predicate] ;
    }
    
    
    NSSet * relationshipsToCheck = [self relationshipsToCheckFor:entity] ;
    NSDictionary * dispatchedRelationshipsToCheck = [entity dispatchedRelationshipsFrom_cbd_:relationshipsToCheck] ;
    
    NSSet * toOneRelationships = dispatchedRelationshipsToCheck[CBDKeyDescriptionToOneRelationship] ;
    NSSet * toManyOrderedRelationships = dispatchedRelationshipsToCheck[CBDKeyDescriptionToManyOrderedRelationship] ;
    NSSet * toManyNonOrderedRelationships = dispatchedRelationshipsToCheck[CBDKeyDescriptionToManyNonOrderedRelationship] ;
    
    
    
    
    
    
    /*
     Checking to-one ordered relationships
     */
    if (depth>0)
    {
        NSMutableArray * predicatesForSubPredicate = [[NSMutableArray alloc] init] ;
        
        for (NSRelationshipDescription * toOneRelationship in toOneRelationships)
        {
            NSManagedObject * newSourceObject = [sourceObject valueForKey:toOneRelationship.name] ;
            
            
            NSPredicate * predForThisRelationship = [self _cleverPredicateToFindObjectsVirtuallySimilarTo:newSourceObject
                                                                                       withRecursiveDepth:depth - 1] ;
            
            NSString * keyPath = [NSString stringWithFormat:@"$my_var.%@", toOneRelationship.name] ;
            
            /*
             Thank you SO !!
             http://stackoverflow.com/questions/21802728/replacing-a-variable-in-an-nspredicate
             */
            NSPredicate * newPred = [predForThisRelationship predicateWithSubstitutionVariables:@{@"my_var": [NSExpression expressionForKeyPath:keyPath]}];
            
            
            [predicatesForSubPredicate addObject:newPred] ;
        }
        
        if ([predicatesForSubPredicate count] > 0)
        {
            [predicates addObject:[NSCompoundPredicate andPredicateWithSubpredicates:predicatesForSubPredicate]];
        }
    }
    
    
    
    
    NSMutableArray * predicatesForSubPredicate = [[NSMutableArray alloc] init] ;
    
    
    /*
     Checking to-many non-ordered relationships
     */
    for (NSRelationshipDescription * relationship in toManyNonOrderedRelationships)
    {
        NSPredicate * predicate ;
        
        NSString * keyPath = [NSString stringWithFormat:@"%@.@count", relationship.name] ;
        
        predicate = [NSPredicate predicateWithFormat:@"$my_var.%K.@count == %@",
                     relationship.name,
                     [sourceObject valueForKeyPath:keyPath]] ;
        
        [predicatesForSubPredicate addObject:predicate] ;
    }
    
    if ([predicatesForSubPredicate count] > 0)
    {
        [predicates addObject:[NSCompoundPredicate andPredicateWithSubpredicates:predicatesForSubPredicate]] ;
    }
    
    
    
    
    
    predicatesForSubPredicate = [[NSMutableArray alloc] init] ;
    
    
    /*
     Checking to-many ordered relationships
     */
    for (NSRelationshipDescription * relationship in toManyOrderedRelationships)
    {
        NSPredicate * predicate ;
        
        NSString * keyPath = [NSString stringWithFormat:@"%@.@count", relationship.name] ;
        
        NSNumber * lengthSet = [sourceObject valueForKeyPath:keyPath] ;
        
        predicate = [NSPredicate predicateWithFormat:@"$my_var.%K.@count == %@",
                     relationship.name,
                     lengthSet] ;
        
        [predicatesForSubPredicate addObject:predicate] ;
        
        
        
        
        
        /*
         Checking each member of the ordered relationship
         */
        if (depth>0)
        {
            NSMutableArray * predicatesForNewSubPredicate = [[NSMutableArray alloc] init] ;
            
            for (int i=0; i<[lengthSet intValue]; i++)
            {
                //NSString * newRootPath = [NSString stringWithFormat:@"%@.%@[%d]", rootPath, relationship.name, i] ;
                
                NSManagedObject * newSourceObject = [sourceObject valueForKey:relationship.name][i] ;
                
                
                NSPredicate * predForThisRelationship = [self _cleverPredicateToFindObjectsVirtuallySimilarTo:newSourceObject
                                                                                           withRecursiveDepth:depth - 1] ;
                
                NSString * keyPath = [NSString stringWithFormat:@"$my_var.%@[%d]", relationship.name, i] ;
                
                NSPredicate * newPred = [predForThisRelationship predicateWithSubstitutionVariables:@{@"my_var": [NSExpression expressionForKeyPath:keyPath]}];
                
                [predicatesForNewSubPredicate addObject:newPred] ;
                
            }
            
            if ([predicatesForNewSubPredicate count] > 0)
            {
                [predicatesForSubPredicate addObject:[NSCompoundPredicate andPredicateWithSubpredicates:predicatesForNewSubPredicate]] ;
            }
        }
    }
    
    if ([predicatesForSubPredicate count] > 0)
    {
        [predicates addObject:[NSCompoundPredicate andPredicateWithSubpredicates:predicatesForSubPredicate]] ;
    }
    
    return [NSCompoundPredicate andPredicateWithSubpredicates:predicates] ;
}









@end
