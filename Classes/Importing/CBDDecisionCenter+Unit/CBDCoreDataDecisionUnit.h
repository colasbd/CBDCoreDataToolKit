//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSEntityDescription+CBDMiscMethods.h"








/*
 When merging, if YES, ignore wins
 */
const BOOL ignoreWinsOverNotIgnore ;




/**
 CBDCoreDataDecisionUnit is a helper class for the library CBDCoreDataToolKit.
 
 CBDCoreDataDecisionUnit encapsulates the data for the decision relatively to an entity.
 
 A CBDCoreDataDecisionUnit instance refers to an NSEntityDescription and to some attributes and/or relationships to consider to do various actions (comparing, deleting, copying, etc.).
 */
@interface CBDCoreDataDecisionUnit : NSObject



/**
 The entity of the instance
 */
@property (nonatomic, weak, readonly)NSEntityDescription *entity ;


/**
 Should this entity be ignored ?
 */
@property (nonatomic, readonly)BOOL shouldBeIgnored ;


/**
 The names of the attributes used for decision for the instance
 */
@property (nonatomic, readonly)NSSet* nameAttributesToUse ;



/**
 The NSRelationshipDescription's of the  relationships used for decision for the instance
 */
@property (nonatomic, readonly)NSSet* relationshipDescriptionsToUse ;



/**
 The names of the attributes explicitely ignored for decision for the instance
 */
@property (nonatomic, readonly)NSSet* nameAttributesToIgnore ;



/**
 The NSRelationshipDescription's of the  relationships explicitely ignored for decision for the instance
 */
@property (nonatomic, readonly)NSSet* relationshipDescriptionsToIgnore ;



/**
 The names of the other keys (they will not be used for decision) for the instance
 
 If non-empty, it means that the user has given some keys not corresponding to
 attributes nor relationships
 */
@property (nonatomic, readonly)NSSet* nameOtherKeys ;









#pragma mark - Initialization
///Initialization

/**
 The designated initializer.
 */
-  (id)       initForEntity:(NSEntityDescription *)entity
            usingAttributes:(NSArray *)namesUsedAttributeForDecision
         usingRelationships:(NSArray *)namesUsedRelationshipsForDecision
         ignoringAttributes:(NSArray *)namesIgnoredAttributeForDecision
      ignoringRelationships:(NSArray *)namesIgnoredRelationshipsForDecision
            shouldBeIgnored:(BOOL)shouldBeIgnored ;



/**
 In the `init` method, you give attributes and relationships you want to use to discriminate between objects.
 */
- (id)     initForEntity:(NSEntityDescription *)entity
         usingAttributes:(NSArray *)namesAttributeForDecision
        andRelationships:(NSArray *)namesRelationshipForDecision ;


/**
 The given entity will be ignored in the decision.
 
 In other words, any two instances of the given entity will be considered as similar.
 */
- (id)initWithIgnoringEntity:(NSEntityDescription *)entity ;



/**
 Create a CBDCoreDataDecisionUnit instance with all attributes
 for the given NSEntityDescription as criteria for decision.
 */
- (id)initSemiExhaustiveFor:(NSEntityDescription *)entity ;



/**
 Create a CBDCoreDataDecisionUnit instance with all attributes and all relationships
 for the given NSEntityDescription as criteria for decision.
 */
- (id)initExhaustiveFor:(NSEntityDescription *)entity ;



/**
 In the `init` method, you give attributes and relationships you want to use to discriminate between objects.
 */
- (id)      initForEntity:(NSEntityDescription *)entity
       ignoringAttributes:(NSArray *)namesIgnoredAttributes
         andRelationships:(NSArray *)namesIgnoredRelationships;





#pragma mark - Modification
/// @name Modification
/**
 The constraints will add.
 
 If one of the unit is of the "ignoring" type, then the resulting constraint will also be.
 
 The ignores wins over the include (as long as the `const` parameter `ignoreWinsOverNotIgnore` is 
 set to `YES`, the default value — which is not supposed to be changed)
 */
- (void)mergeWith:(CBDCoreDataDecisionUnit *)anOtherUnit ;


///**
// Removes the given attributes and relationships from the DecisionUnit
// */
//- (void)removeAttributes:(NSArray *)namessAttributeForDecision
//        andRelationships:(NSArray *)namesRelationshipForDecision ;
//








#pragma mark - Remark
/// @name Remark
/**
 Remark : the method `isEqual:` is overwritten.
 
 Two DecisionUnits are equal if they are related to the same entity and operate on the same keys.
 */
- (BOOL)isEqual:(id)object ;





@end
