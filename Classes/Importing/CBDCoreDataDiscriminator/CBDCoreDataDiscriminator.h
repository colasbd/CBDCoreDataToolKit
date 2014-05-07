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
 Keys for the dictionnaries used for duplicate elements between two MOCs.
 */
NSString * const   CBDCoreDataDiscriminatorKeyForObjectInWorkingMOC ;
NSString * const   CBDCoreDataDiscriminatorKeyForObjectInReferenceMOC ;


/**
 CBDCoreDataDiscriminator is a helper class for CBDCoreDataDiscriminator.
 
 Short:
 CBDCoreDataDiscriminator helps CBDCoreDataImporter to discriminate if two objects should be considered as the equal.
 
 Long:
 When you import an object from `sourceMOC` to `targetMOC`, you want to avoid some problems. For instance, your MOCs may refer to two different copies of the same data. In this case, your two MOCs won't have any object in common: in real, the objects are the same but on the computer, they will have a different `objectID` for instance.
 
 So, to deal with this issue, instead of comparing object with `==` (or with `isEqual:`, which will be the same in that case, we use CBDCoreDataDiscriminator.
 
 A CBDCoreDataDiscriminator instance refers to several CBDCoreDataDiscrimintorUnit instances
 */
@interface CBDCoreDataDiscriminator : NSObject<NSCopying>







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
 The decisionCenter associated to the instance.
 */
@property (nonatomic, strong, readonly)CBDCoreDataDecisionCenter * decisionCenter ;





#pragma mark - Custom blocks to test similarity
/// @name Custom blocks to test similarity

// jojo
//TODO(add the possibility to have several blocks)
/**
 Add a block to test similarity.
 
 If you add a block, to your mechanism, it can improve the speed a lot!
 
 You can add several blocks.
 
 @warning The usual mechanism (checking attributes and relationships) WILL NOT be used. Only the block will.
 */
- (void)      addForEntity:(NSEntityDescription *)entity
     blockToTestSimilarity:(BOOL(^)(NSManagedObject * sourceObject, NSManagedObject *targetObject))blockToTestSimilarity ;


/**
 @return The block which is used (if any, otherwise `nil`) for testing similarity.
 */
- (BOOL(^)(NSManagedObject *, NSManagedObject *)) blockForEntity:(NSEntityDescription *)entity ;


/**
 Removes all the blocks for this entity.
 */
- (void) clearAllBlocksForEntity:(NSEntityDescription *)entity ;



#pragma mark - Managing the cache
/// @name Managing the cache

/**
 Removes all the entries of the cache
 */
- (void)flushTheCache ;


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
 First similar object
 */
- (NSManagedObject *)firstSimilarObjectTo:(NSManagedObject *)sourceObject
                                    inMOC:(NSManagedObjectContext *)MOC ;



//
//
/**************************************/
#pragma mark - Finding duplicates
/**************************************/
/// @name Finding duplicates



/**
 Find the duplicates of objects of referenceMOC in MOCWhereWeAreWorking of the specified entities.
 
 @return Returns a dictionnary, whose keys are the objectID of this objects, and whose values are dictionnaries with two keys:
 
 - `CBDCoreDataDiscriminatorKeyForObjectInWorkingMOC`: the object with `objectID` the key. It is the object in `MOCWhereWeAreWorking`.
 - `CBDCoreDataDiscriminatorKeyForObjectInReferenceMOC`: the object in `referenceMOC` which is similar to the other object.
 */
- (NSDictionary *) infosOnObjectsInWorkingMOC:(NSManagedObjectContext *)MOCWhereWeAreWorking
                alreadyExistingInReferenceMOC:(NSManagedObjectContext *)referenceMOC
                                   ofEntities:(NSArray *)namesOfEntities ;


/**
 Find the duplicates of objects of referenceMOC in MOCWhereWeAreWorking of the specified entities.
 
 @return The set of duplicate (the objects in `MOCWhereWeAreWorking`)
 */
- (NSSet *)      objectsInWorkingMOC:(NSManagedObjectContext *)MOCWhereWeAreWorking
       alreadyExistingInReferenceMOC:(NSManagedObjectContext *)referenceMOC
                          ofEntities:(NSArray *)namesOfEntities ;



/**
 Find the duplicates of objects of referenceMOC in MOCWhereWeAreWorking of all the entities.
 
 @return Returns a dictionnary, whose keys are the objectID of this objects, and whose values are dictionnaries with two keys:
 
 - `CBDCoreDataDiscriminatorKeyForObjectInWorkingMOC`: the object with `objectID` the key. It is the object in `MOCWhereWeAreWorking`.
 - `CBDCoreDataDiscriminatorKeyForObjectInReferenceMOC`: the object in `referenceMOC` which is similar to the other object.
 */
- (NSDictionary *)     infosOnObjectsInWorkingMOC:(NSManagedObjectContext *)MOCWhereWeAreWorking
                    alreadyExistingInReferenceMOC:(NSManagedObjectContext *)referenceMOC;


/**
 Find the duplicates of objects of referenceMOC in MOCWhereWeAreWorking of all the entities.
 
 @return The set of duplicate (the objects in `MOCWhereWeAreWorking`)
 */
- (NSSet *)      objectsInWorkingMOC:(NSManagedObjectContext *)MOCWhereWeAreWorking
       alreadyExistingInReferenceMOC:(NSManagedObjectContext *)referenceMOC  ;


#pragma mark - Managing the log
/// @name Managing the cache

/**
 Turn ON/OFF the log
 */
- (void)shouldLog:(BOOL)shouldLog ;



@end
