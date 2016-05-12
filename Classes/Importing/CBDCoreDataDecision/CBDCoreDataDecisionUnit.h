//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSEntityDescription+CBDMiscMethods.h"








/**
 CBDCoreDataDecisionUnit is a helper class for the library CBDCoreDataToolKit.
 
 CBDCoreDataDecisionUnit encapsulates the data for the decision relatively to an entity.
 
 A CBDCoreDataDecisionUnit instance refers to an NSEntityDescription and to some attributes and/or relationships to consider to do various actions (comparing, deleting, copying, etc.).
 */
@interface CBDCoreDataDecisionUnit : NSObject



/**
 The entity of the instance
 */
@property (nonatomic, weak, readonly)NSEntityDescription *entity;


/**
 Should this entity be ignored ?
 */
@property (nonatomic, readonly)BOOL shouldBeIgnored;


/**
 The names of the attributes used for decision for the instance
 */
@property (nonatomic, readonly)NSSet *nameAttributesToUse;



/**
 The NSRelationshipDescription's of the  relationships used for decision for the instance
 */
@property (nonatomic, readonly)NSSet *relationshipDescriptionsToUse;



/**
 The names of the attributes explicitely ignored for decision for the instance
 */
@property (nonatomic, readonly)NSSet *nameAttributesToIgnore;



/**
 The NSRelationshipDescription's of the  relationships explicitely ignored for decision for the instance
 */
@property (nonatomic, readonly)NSSet *relationshipDescriptionsToIgnore;



/**
 The names of the other keys (they will not be used for decision) for the instance
 
 If non-empty, it means that the user has given some keys not corresponding to
 attributes nor relationships
 */
@property (nonatomic, readonly)NSSet *nameOtherKeys;









#pragma mark - Initialization
///Initialization

/**
 The designated initializer.
 
 A `CBDCoreDataDecisionUnit` will behave differently depending upon the @see `decisionType` of the `CBDCoreDataDecisionCenter` in which it is included. If the type of the center is "semi-facilitating" (meaning that by default, all the attributes are considered), and if you add to this center a unit that includes explicitely only one relationship, then both this relationship and all the attributes will be considered for actions.
 
 If you want, in this case, to have less attributes, you should use a `ignoringAttributes:` initializer.
 */
-  (instancetype)initForEntity:(NSEntityDescription *)entity
               usingAttributes:(NSArray *)namesUsedAttributeForDecision
            usingRelationships:(NSArray *)namesUsedRelationshipsForDecision
            ignoringAttributes:(NSArray *)namesIgnoredAttributeForDecision
         ignoringRelationships:(NSArray *)namesIgnoredRelationshipsForDecision
               shouldBeIgnored:(BOOL)shouldBeIgnored;



/**
 In this `init` method, you give attributes and relationships you want to use to discriminate between objects.
 */
- (instancetype)initForEntity:(NSEntityDescription *)entity
              usingAttributes:(NSArray *)namesAttributeForDecision
             andRelationships:(NSArray *)namesRelationshipForDecision;


/**
 In this `init` method, you give attributes and relationships you want to use to discriminate between objects.
 
 You (implicitely) exclude all the other attributes or relationships
 */
- (instancetype)initForEntity:(NSEntityDescription *)entity
          usingOnlyAttributes:(NSArray *)namesAttributeForDecision
         andOnlyRelationships:(NSArray *)namesRelationshipForDecision;


/**
 In this `init` method, you give attributes and relationships you want to use to discriminate between objects.
 */
- (instancetype)initForEntity:(NSEntityDescription *)entity
           ignoringAttributes:(NSArray *)namesIgnoredAttributes
             andRelationships:(NSArray *)namesIgnoredRelationships;


/**
 In this `init` method, you ask to ignore all  attributes or relationships.
 */
- (instancetype)initForEntity:(NSEntityDescription *)entity
        ignoringAllAttributes:(BOOL)ignoringAllAttributes
     ignoringAllRelationships:(BOOL)ignoringAllRelationships;


/**
 In this `init` method, you ask to include all  attributes or relationships.
 */
- (instancetype)initForEntity:(NSEntityDescription *)entity
         includeAllAttributes:(BOOL)includingAllAttributes
      includeAllRelationships:(BOOL)includingAllRelationships;




/**
 The given entity will be ignored in the decision.
 
 In other words, any two instances of the given entity will be considered as similar.
 */
- (instancetype)initWithIgnoringEntity:(NSEntityDescription *)entity;



/**
 Create a CBDCoreDataDecisionUnit instance with all attributes
 for the given NSEntityDescription as criteria for decision.
 */
- (instancetype)initSemiExhaustiveFor:(NSEntityDescription *)entity;



/**
 Create a CBDCoreDataDecisionUnit instance with all attributes and all relationships
 for the given NSEntityDescription as criteria for decision.
 */
- (instancetype)initExhaustiveFor:(NSEntityDescription *)entity;








#pragma mark - Modification
/// @name Modification
/**
 The constraints will add.
 
 If one of the unit is of the "ignoring" type, then the resulting constraint will also be.
 
 The ignores wins over the include (as long as the `const` parameter `ignoreWinsOverNotIgnore` is
 set to `YES`, the default value — which is not supposed to be changed)
 */
- (void)mergeWith:(CBDCoreDataDecisionUnit *)anOtherUnit;











#pragma mark - Remark
/// @name Remark
/**
 Remark : the method `isEqual:` is overwritten.
 
 Two DecisionUnits are equal if they are related to the same entity and operate on the same keys.
 */
- (BOOL)isEqual:(id)object;





@end
