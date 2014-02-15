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


/**
 Based on the Discriminator, we create a NSPredicate to fetch "virtually similar" objects.
 
 By virtually similar, we mean:
 - we check the attributes included in the Discriminator
 - we check the cardinality of to-many relationships
 */
- (NSPredicate *)cleverPredicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject ;


/**
 This is the fetched result of `- (NSPredicate *)cleverPredicateToFindObjectsVirtuallySimilarTo:(NSManagedObject *)sourceObject ;`.
 */
- (NSArray *)objectsVirtuallySimilarTo:(NSManagedObject *)sourceObject
                                 inMOC:(NSManagedObjectContext *)aMOC ;



/**
 If returns NO, it means that the two objects canno't be similar.
 
 If returns YES, it means that they still can be similar
 */
- (BOOL)           isThisSourceObject:(NSManagedObject *)sourceObject
       virtuallySimilarToTargetObject:(NSManagedObject *)targetObject ;


@end
