//
//  CBDCoreDataDiscriminator.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class CBDCoreDataDecisionCenter ;




/**
 CBDCoreDataDiscriminator is a helper class for CBDCoreDataDiscriminator.
 
 Short:
 CBDCoreDataDiscriminator helps CBDCoreDataImporter to discriminate if two objects should be considered as the equal.
 
 Long:
 When you import an object from `sourceMOC` to `targetMOC`, you want to avoid some problems. For instance, your MOCs may refer to two different copies of the same data. In this case, your two MOCs won't have any object in common: in real, the objects are the same but on the computer, they will have a different `objectID` for instance.
 
 So, to deal with this issue, instead of comparing object with `==` (or with `isEqual:`, which will be the same in that case, we use CBDCoreDataDiscriminator.
 
 A CBDCoreDataDiscriminator instance refers to several CBDCoreDataDiscrimintorUnit instances
 */
@interface CBDCoreDataDiscriminator : NSObject







#pragma mark - Initialisation
/// @name Initialisation
/**
 The disgnated intializer takes a CBDCoreDataDecisionCenter as an argument.
 */
- (id)initWithDecisionCenter:(CBDCoreDataDecisionCenter *)decisionCenter ;


/**
 This convenience initializer will compare entities according to their attribues only.
 */
- (id)initWithDefaultType ;


/**
 A copy method.
 */
- (id)copy ;


/**
 The decisionCenter associated to the instance.
 */
@property (nonatomic, strong, readonly)CBDCoreDataDecisionCenter * decisionCenter ;





#pragma mark - Managing the cache
/// @name Managing the cache

/**
 Removes all the entries of the cache
 */
- (void)flushTheCache ;

/**
 Removes the last entry of the cache
 */
- (void)removeLastEntryOfTheCache ;

/**
 Show the cache
 */
- (void)logTheCache ;





//
//
/**************************************/
#pragma mark - Discriminate with attributes
/**************************************/
/// @name Discriminate with attributes


/**
 Using the attribute to check and not those to ignore, 
 considering also the information given about the parent entities,
 determine if the two objects are similar.
 
 The core method isThisSourceObject:similarToTargetObject: use this method and 
 also cheks the relationships
 */
- (BOOL)            doesObject:(NSManagedObject *)sourceObject
  haveTheSameAttributeValuesAs:(NSManagedObject *)targetObject ;




#pragma mark - Discriminate
/// @name Discriminate

/**
 The core and convenient method that compare two objects.
 
 By default, we use the semi-facilitating mode.
 
 By default, the result is stored in the cache.
 */
- (BOOL)    isSourceObject:(NSManagedObject *)sourceObject
     similarToTargetObject:(NSManagedObject *)targetObject ;


/**
 Finding similar objects
 */
- (NSArray *)similarObjectTo:(NSManagedObject *)sourceObject
                       inMOC:(NSManagedObjectContext *)MOC ;

/**
 First similar objects
 */
- (NSManagedObject *)firstSimilarObjectTo:(NSManagedObject *)sourceObject
                                    inMOC:(NSManagedObjectContext *)MOC ;


#pragma mark - Managing the log
/// @name Managing the cache

/**
 Turn ON/OFF the log
 */
- (void)shouldLog:(BOOL)shouldLog ;



@end
