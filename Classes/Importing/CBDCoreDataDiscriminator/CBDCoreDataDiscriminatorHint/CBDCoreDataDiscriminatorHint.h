//
//  CBDCoreDataDiscriminatorHelper.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CBDCoreDataDiscriminatorSimilarityStatus.h"
#import "CBDCoreDataDiscriminatorHintType.h"








@interface CBDCoreDataDiscriminatorHint : NSObject



//
//
/**************************************/
#pragma mark Properties read only
/**************************************/
@property (nonatomic, readonly) CBDCoreDataDiscriminatorHintType type ;
@property (nonatomic, weak, readonly) NSManagedObject * sourceObject ;
@property (nonatomic, weak, readonly) NSManagedObject * targetObject ;
@property (nonatomic, weak, readonly) NSRelationshipDescription * relationship ;
@property (nonatomic, readonly) CBDCoreDataDiscriminatorSimilarityStatus similarityStatus ;





//
//
/**************************************/
#pragma mark - Init methods
/**************************************/
/// @name Init methods


- (id)  initWithSimilarityBetwenSourceObject:(NSManagedObject *)sourceObject
                             andTargetObject:(NSManagedObject *)targetObject
                                   hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus ;


- (id)  initWithSimilarityForRelationship:(NSRelationshipDescription *)relationship
                          forSourceObject:(NSManagedObject *)sourceObject
                          andTargetObject:(NSManagedObject *)targetObject
                                hasStatus:(CBDCoreDataDiscriminatorSimilarityStatus)similarityStatus ;


- (id)  initWithSimilarityOfSourceObject:(NSManagedObject *)sourceObject
                         andTargetObject:(NSManagedObject *)targetObject
                   shouldNotBeCheckedFor:(NSRelationshipDescription *)relation ;





- (BOOL)isEqual:(id)object ;

@end
