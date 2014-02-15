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


@implementation CBDCoreDataDiscriminator (UsingPredicateAndFetching)


/**
 Based on the Discriminator, we create a NSPredicate to fetch "virtually similar" objects.
 
 By virtually similar, we mean:
 - we check the attributes included in the Discriminator
 - we check the cardinality of to-many relationships
 */
- (NSPredicate *)cleverPredicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                           //  depthOfRecursivity:(NSUInteger)depth
{
    NSEntityDescription * entity = sourceObject.entity ;
    
    NSMutableArray * predicates = [[NSMutableArray alloc] init] ;
    
    
    /*
     Checking attributes
     */
    for (NSString * nameAttribute in [self attributesToCheckFor:entity])
    {
        NSPredicate * predicate ;
        predicate = [NSPredicate predicateWithFormat:@"%K == %@",
                     nameAttribute,
                     [sourceObject valueForKey:nameAttribute]] ;
        
        [predicates addObject:predicate] ;
    }
    
    
    NSSet * relationshipsToCheck = [self relationshipsToCheckFor:entity] ;
    NSDictionary * dispatchedRelationshipsToCheck = [entity dispatchedRelationshipsFrom_cbd_:relationshipsToCheck] ;
    
   // NSSet * toOneRelationships = dispatchedRelationshipsToCheck[CBDKeyDescriptionToOneRelationship] ;
    NSSet * toManyOrderedRelationships = dispatchedRelationshipsToCheck[CBDKeyDescriptionToManyOrderedRelationship] ;
    NSSet * toManyNonOrderedRelationships = dispatchedRelationshipsToCheck[CBDKeyDescriptionToManyNonOrderedRelationship] ;

    
    
    
//    /*
//     Checking to-one ordered relationships
//     */
//    if (depth>0)
//    {
//        for (NSRelationshipDescription * toOneRelationship in toOneRelationships)
//        {
//            NSManagedObject * newSourceObject = [sourceObject valueForKey:toOneRelationship.name] ;
//
//            [predicates addObject:[self cleverPredicateToFindObjectsVirtuallySimilarTo]]
//        }
//    }
    
    
    
    /*
     Checking to-many non-ordered relationships
     */
    for (NSRelationshipDescription * relationship in toManyNonOrderedRelationships)
    {
        NSPredicate * predicate ;
        
        NSString * keyPath = [NSString stringWithFormat:@"%@.@count", relationship.name] ;
        
        predicate = [NSPredicate predicateWithFormat:@"%K.@count == %@",
                     relationship.name,
                     [sourceObject valueForKeyPath:keyPath]] ;
        
        [predicates addObject:predicate] ;
    }
    
    
    /*
     Checking to-many ordered relationships
     */
    for (NSRelationshipDescription * relationship in toManyOrderedRelationships)
    {
        NSPredicate * predicate ;
        
        NSString * keyPath = [NSString stringWithFormat:@"%@.@count", relationship.name] ;
        
        predicate = [NSPredicate predicateWithFormat:@"%K.@count == %@",
                     relationship.name,
                     [sourceObject valueForKeyPath:keyPath]] ;
        
        [predicates addObject:predicate] ;
    }
    
    return [NSCompoundPredicate andPredicateWithSubpredicates:predicates] ;
}




/**
 This is the fetched result of `- (NSPredicate *)cleverPredicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject ;`.
 */
- (NSArray *)objectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                 inMOC:(NSManagedObjectContext *)aMOC
{
    return [sourceObject.entity findInMOC:aMOC
                       withPredicate_cbd_:[self cleverPredicateToFindObjectsVirtuallySimilarTo:sourceObject]] ;
}





- (BOOL)           isThisSourceObject:(NSManagedObject *)sourceObject
       virtuallySimilarToTargetObject:(NSManagedObject *)targetObject
{
    return [[self cleverPredicateToFindObjectsVirtuallySimilarTo:sourceObject] evaluateWithObject:targetObject] ;
//    return [[self objectsVirtuallySimilarTo:sourceObject
//                                      inMOC:targetObject.managedObjectContext] containsObject:targetObject] ;
}


@end
