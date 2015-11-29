//
//  CBDCoreDataDiscriminator+UsingPredicateAndFetching.h
//  Pods
//
//  Created by Colas on 15/02/2014.
//
//

#import "CBDCoreDataDiscriminator.h"





/**
 In this category, we gather few methods that use the fetching of CoreData.
 */
@interface CBDCoreDataDiscriminator (UsingPredicateAndFetching)


//
//
/**************************************/
#pragma mark - Predicates
/**************************************/
/// @name Predicates


/**
 Based on the Discriminator, we create a NSPredicate to fetch "virtually similar" objects.
 
 By virtually similar, we mean:
 - we check the attributes included in the Discriminator
 - we check the cardinality of to-many relationships
 */
- (NSPredicate *)predicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                       withPredicateDepth:(NSUInteger)depth ;


/**
 We use `- predicateToFindObjectsVirtuallySimilarTo:withPredicateDepth:` with `depth = 0`
*/
 - (NSPredicate *)predicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject ;




//
//
/**************************************/
#pragma mark - Testing virtual similarity
/**************************************/
/// @name Testing virtual similarity




/**
 If returns NO, it means that the two objects canno't be similar.
 
 If returns YES, it means that they still can be similar
 */
- (BOOL)           isThisSourceObject:(NSManagedObject *)sourceObject
       virtuallySimilarToTargetObject:(NSManagedObject *)targetObject
                   withPredicateDepth:(NSUInteger)depth ;

/**
 We use `- isThisSourceObject:virtuallySimilarToTargetObject:withPredicateDepth:` with `depth = 0`
 */
- (BOOL)           isThisSourceObject:(NSManagedObject *)sourceObject
       virtuallySimilarToTargetObject:(NSManagedObject *)targetObject ;



//
//
/**************************************/
#pragma mark - Virtually similar objects
/**************************************/
/// @name Virtually similar objects


/**
 This is the fetched result of `- (NSPredicate *)cleverPredicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject ;`.
 */
- (NSArray *)objectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                    withPredicateDepth:(NSUInteger)depth
                                 inMOC:(NSManagedObjectContext *)aMOC ;
/**
 We use `- objectsVirtuallySimilarTo:withPredicateDepth:inMOC:` with `depth = 0`
 */
- (NSArray *)objectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                 inMOC:(NSManagedObjectContext *)aMOC ;





@end
