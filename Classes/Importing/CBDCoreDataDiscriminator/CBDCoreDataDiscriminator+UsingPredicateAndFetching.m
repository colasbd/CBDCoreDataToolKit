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
    NSExpression * expr = [NSExpression expressionForKeyPath:@"self"] ;
    
    
    /*
     Weird HACK
     
     I don't know why it is not working without ie
     
     return [self _predicateToFindObjectsVirtuallySimilarTo:sourceObject
     withInitialPath:expr
     withRecursiveDepth:depth] ;
     */
     
    return [NSPredicate predicateWithFormat:[self _predicateToFindObjectsVirtuallySimilarTo:sourceObject
                                           withInitialPath:expr
                                        withRecursiveDepth:depth].predicateFormat] ;
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


- (NSPredicate *)_predicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                           withInitialPath:(NSExpression *)initialPath
                                        withRecursiveDepth:(NSUInteger)depth
{
    /*
     See also:
     http://stackoverflow.com/questions/21802728/replacing-a-variable-in-an-nspredicate
     
     but it is not working:
     http://stackoverflow.com/questions/21823339/chaining-replacements-dont-work-in-nspredicate
     */
    
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
        predicate = [NSPredicate predicateWithFormat:@"%K.%K == %@",
                     initialPath.keyPath,
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
            
            NSString * keyPath = [NSString stringWithFormat:@"%@.%@", initialPath.keyPath, toOneRelationship.name] ;
            NSExpression * newInitialPath = [NSExpression expressionForKeyPath:keyPath] ;
            
            
            NSPredicate * predForThisRelationship = [self _predicateToFindObjectsVirtuallySimilarTo:newSourceObject
                                                                                    withInitialPath:newInitialPath
                                                                                 withRecursiveDepth:depth - 1] ;
            
            [predicatesForSubPredicate addObject:predForThisRelationship] ;
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
        
        predicate = [NSPredicate predicateWithFormat:@"%K.%K.@count == %@",
                     initialPath.keyPath,
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
        
        predicate = [NSPredicate predicateWithFormat:@"%K.%K.@count == %@",
                     initialPath.keyPath,
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
                
                
                NSString * keyPath = [NSString stringWithFormat:@"((%@.%@)[%d])", initialPath.keyPath, relationship.name, i] ;
                NSExpression * newInitialPath = [NSExpression expressionForKeyPath:keyPath] ;
                
                
                NSPredicate * predForThisRelationship = [self _predicateToFindObjectsVirtuallySimilarTo:newSourceObject
                                                                                        withInitialPath:newInitialPath
                                                                                     withRecursiveDepth:depth - 1] ;
                
                [predicatesForNewSubPredicate addObject:predForThisRelationship] ;
                
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
