// Template created By Colas Bardavid
// Copyright (c) 2014 Colas. All rights reserved.
//
//  CBDCoreDataDecisionCenter.h
//  Pods
//
//  Created by Colas on 17/02/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



/**
 The following options deal with the case when an entity has no DecisionUnit associated.
 
 Let's recall that a DecisionUnit is meant to declare upon which attributes/relationships
 the objects of a given entity are considered (for copying, deleting, etc.).
 
 So, if an entity has no associated CBDCoreDataDecisionType, what to do ?
 
 We define three options :
 
 - CBDCoreDataDecisionTypeFacilitating: all the objects of such entities will be declared equal. It
 is equivalent to ignoring this entity
 
 - CBDCoreDataDecisionTypeSemiFacilitating: to compare two object of this entity, we only consider their attributes. This option is convenient but in some case, it could be too demanding, for instance if the objects of the given entity are markes with a `dateOfCreation` very precise.
 
 - CBDCoreDataDecisionTypeDemanding: to compare two object of this entity, we consider both all the attributes and all the relationships.
 */
typedef NS_ENUM(NSInteger, CBDCoreDataDecisionType)
{
    CBDCoreDataDecisionTypeFacilitating,
    CBDCoreDataDecisionTypeSemiFacilitating,
    CBDCoreDataDecisionTypeDemanding,
    CBDCoreDataDecisionTypeCount
};





//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - Used Classes
/**************************************/
//
@class CBDCoreDataDecisionUnit ;







/**
 A CBDCoreDataDecisionCenter models a system (a collection) of CBDCoreDataDecisionUnits.
 
 It is intended to decide which attributes/relationships/entities one should consider, for various actions (as deleting, copying, etc.)
 
 It is also designed to manage the case of parent/child entities having DecisionUnits on their own.
 */
@interface CBDCoreDataDecisionCenter : NSObject<NSCopying>
//





//
//
/**************************************/
#pragma mark - Initialization
/**************************************/
/// @name Initialization


/**
Chooses the facilitating type. This is the default type. When you change types, the cache is flushed.

When an entity has no DecisionUnit explicitely associated,
all the objects of such entities will be declared equal. It
is equivalent to ignoring this entity.

The relationships to objects with this entity will also be ignored.
*/
- (id)initWithFacilitatingType ;

/**
Chooses the semi-facilitating type. This is the default type. When you change types, the cache is flushed.
 
 When an entity has no DecisionUnit explicitely associated,
 to compare two object of this entity, we only consider their attributes.

This option is convenient but in some case, it could be too demanding, for instance if the objects of the given entity are markes with a `dateOfCreation` very precise.
 
 This is the default mode.
 */
- (id)initWithSemiFacilitatingType ;

/**
 Chooses the demanding type. This is the default type. When you change types, the cache is flushed.
 
 When an entity has no DecisionUnit explicitely associated,
 to compare two object of this entity,
 we consider both all the attributes and all the relationships.
 
 */
- (id)initWithDemandingType ;


/**
 The designated initializer
 */
- (id)initWithType:(CBDCoreDataDecisionType)decisionType ;




//
//
/**************************************/
#pragma mark - Managing the DecisionUnits
/**************************************/
/// @name Managing the decision centers

/**
The DecisionUnits composing the instance
*/
@property (nonatomic, readonly)NSArray * decisionUnits ;


/**
The entities explicitely registered by the instance for discriminating
 */
@property (nonatomic, readonly)NSArray * registeredEntities ;


/**
 To perform a decision, one should tell the CBDCoreDataDecision upon which criteria the decision will be done.

So, you should DecisionUnits if you want to precise to the engine upon which criteria you want the decision to be done.
 */
- (void)addDecisionUnit:(CBDCoreDataDecisionUnit *)aDecisionUnit ;



/**
 Remove all the DecisionUnits.
 */
- (void)removeAllDecisionUnits ;



/**
 Remove the DecisionUnit for entity
 */
- (void)removeDecisionUnitFor:(NSEntityDescription *)entity ;





//
//
/**************************************/
#pragma mark - Using the discriminatorUnits
/**************************************/
/// @name Using the discriminatorUnits


/**
 Returns the attributes to check for the entity.
 
 It uses the entity but also the parent entity (the superentity).
 @warning If there is a conflict, it the entity wins over the superentity
 @warning If there is a conflict, "ignore" wins over "include", depending on the value of the BOOL ignoreWinsOverInclude
 */
- (NSSet *)attributesFor:(NSEntityDescription *)entity ;

/**
 Returns the attributes to check for the entity.
 
 It uses the entity but also the parent entity (the superentity).
 @warning If there is a conflict, it the entity wins over the superentity
 @warning If there is a conflict, "ignore" wins over "include", depending on the value of the BOOL ignoreWinsOverInclude
 */
- (NSSet *)relationshipsFor:(NSEntityDescription *)entity ;


/**
 Reply YES if the entity should be ignored in the decision
 */
- (BOOL)shouldIgnore:(NSEntityDescription *)entity ;






@end
