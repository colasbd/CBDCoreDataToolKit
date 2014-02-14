//
//  CBDCoreDataDiscriminator.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <Foundation/Foundation.h>
#import "CBDCoreDataDiscriminatorUnit.h"

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



/**
 The following options deal with the case when an entity has no DiscriminatorUnit associated.
 
 Let's recall that a DiscriminatorUnit is meant to declare upon which attributes/relationships
 the objects of a given entity are compared.

 So, if an entity has no associated CBDCoreDataDiscriminatorResearchType, what to do ?
 
 We define three options :
 
 - CBDCoreDataDiscriminatorResearchFacilitating: all the objects of such entities will be declared equal. It
 is equivalent to ignoring this entity
 
 - CBDCoreDataDiscriminatorResearchSemiFacilitating: to compare two object of this entity, we only consider their attributes. This option is convenient but in some case, it could be too demanding, for instance if the objects of the given entity are markes with a `dateOfCreation` very precise.
 
 - CBDCoreDataDiscriminatorResearchSemiFacilitating: to compare two object of this entity, we only consider both all the attributes and all the relationships.
 */
typedef NS_ENUM(NSInteger, CBDCoreDataDiscriminatorResearchType)
{
    CBDCoreDataDiscriminatorResearchFacilitating,
    CBDCoreDataDiscriminatorResearchSemiFacilitating,
    CBDCoreDataDiscriminatorResearchDemanding,
    CBDCoreDataDiscriminatorResearchTypeCount
};


/**
 The discriminatorUnits composing the instance
 */
@property (nonatomic, readonly)NSArray * discriminatorUnits ;

/**
 The entities checked by the instance when discriminating
 */
@property (nonatomic, readonly)NSSet * entitiesRegistered ;



/// Initialisation
/**
 The usual `init` method.
 */
- (id)init ;

/**
 To perform a discrimination, one should tell the CBDCoreDataDiscriminator upon which criteria the discrimination will be done.
 
 So, you should DiscriminatorUnits if you want to precise to the engine upon which criteria you want the discrimination to be done.
 */
TODO(fusionner les unit de meme entité. Du coup modifier la structure de je-sais-plus-quoi)
- (void)addDiscrimintorUnit:(CBDCoreDataDiscriminatorUnit *)aDiscriminatorUnit ;


/**
 Remove all the DiscriminatorUnits.
 */
- (void)removeAllDiscriminatorUnits ;


/// Managing the cache

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


///Discriminate

/**
 The core and convenient method that compare two objects.
 
 By default, we use the semi-facilitating mode.
 
 By default, the result is stored in the cache.
 */
- (BOOL)isThisSourceObject:(NSManagedObject *)sourceObject
     similarToTargetObject:(NSManagedObject *)targetObject ;


/**
 The core method that compare two objects.
 
 @argument relationshipsNotToCheck The NSSet argument is composed of NSRelationshipDescription. Theses relationships will be ignored.
 
 @argument entitiesToExclude The NSSet argument is composed of NSEntityDescription. Theses entities will be ignored. 
 If the sourceObject's (and targetObject's) entity is in this list (or inherits from an entity of this list), returns YES.
 
 @argument researchType Facilitating, SemiFacilitating or Demanding
 
 @argument researchType Facilitating (`CBDCoreDataDiscriminatorResearchFacilitating`), SemiFacilitating (`CBDCoreDataDiscriminatorResearchSemiFacilitating`) or Demanding (`CBDCoreDataDiscriminatorResearchDemanding`)

 @argument cachingTheResult If set to YES, the result will be stored in a cache, to accelerate next checks.
 
 If the sourceObject and targetObject have different NSEntityDescription, returns NO.

 */
- (BOOL)     isThisSourceObject:(NSManagedObject *)sourceObject
          similarToTargetObject:(NSManagedObject *)targetObject
         excludingRelationships:(NSSet *)relationshipsNotToCheck
              excludingEntities:(NSSet *)entitiesToExclude
              usingResearchType:(CBDCoreDataDiscriminatorResearchType)researchType  ;


@end
