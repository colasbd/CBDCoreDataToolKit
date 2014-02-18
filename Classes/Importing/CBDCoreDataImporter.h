//
//  CBDCoreDataImporter.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <CoreData/CoreData.h>

@class CBDCoreDataDecisionCenter, CBDCoreDataDiscriminator ;






//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATION PUBLIQUE : properties
/**************************************/
@interface CBDCoreDataImporter : NSObject



TODO(on peut ameliorer le process)
/*
 On peut améliorer les recherches à l'aide du cache.
 On peut créer une meilleure classe qui tisse des correspondances entre deux MOCS, et utiliser ces correspondances pour créer des contraintes dans l'import.
 
 Il faudrait utiliser ces contraintes pour faire des meilleurs discriminations.
 
 On pourrait utiliser les objectID à cet effet.
 
 à suivre !!!
 */




#pragma mark Initializing and settings
/// @name Initializing and settings

/*
 The importer takes four arguments :
 
 @argument sourceMOC The MOC where the objects are coming from
 
 @argument targetMOC The MOC where the objects are coming to
 
 @argument decisionCenterForDescrimination A CBDCoreDataDecisionCenter to help the importer to decide if two objects (one in `sourceMOC` and the other one in `targetMOC`) should be considered as similar. Please refer to the documentation
 
 @argument decisionCenterForCopy A CBDCoreDataDecisionCenter to help the importer to decide which attributes and relationships it should consider in the import.
 
 @warning It is important to understand that the different roles of `decisionCenterForDescrimination` and `decisionCenterForCopy`. For instance, imagine you have two MOC (of `Person`'s having `Car`s:two entities), exactly identical, except that in the `sourceMOC`, there is one more car `specialCar`, owned by `Joe`. If we put two many constraints on `decisionCenterForDescrimination`, `Joe(sourceMOC)` will not be considered as similar to `Joe(targetMOC)`, and thus, he will be copied, and as a result, we will have two `Joe`s in the `targetMOC`. On the opposite, if the `decisionCenterForCopy` is not strong enough (does not ask for enough `relationships` to be considered), then, when we import `Joe(sourceMOC)` to `targetMOC`, its `cars` won't be taken into account, and the import will not import the new `Car`.
 */
- (id) initWithDecisionCenterForDiscrimination:(CBDCoreDataDecisionCenter *)decisionCenterForDescrimination
                     withDecisionCenterForCopy:(CBDCoreDataDecisionCenter *)decisionCenterForCopy
                                 withSourceMOC:(NSManagedObjectContext *)sourceMOC
                                     targetMOC:(NSManagedObjectContext *)targetMOC ;




/**
 With this convenience initializer: the object between `sourceMOC` and `targetMOC` will be discriminate only upon their attributes. And, when an object is effectively imported (copied) to `targetMOC`, all its attributes and relationships will also be imported (and copied if necessary).
 */
- (id) initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
               targetMOC:(NSManagedObjectContext *)targetMOC ;




/**
 `decisionCenterForDescrimination` is the CBDCoreDataDecisionCenter to help the importer to decide if two objects (one in `sourceMOC` and the other one in `targetMOC`) should be considered as similar. Please refer to the documentation.
 
 You have to create a new `CBDCoreDataImporter` if you want to change it.
 */
@property (nonatomic, strong, readonly)CBDCoreDataDecisionCenter * decisionCenterForDiscrimination ;



/**
 `decisionCenterForCopy` is the CBDCoreDataDecisionCenter to help the importer to decide which attributes and relationships it should consider in the import.
 
 You have to create a new `CBDCoreDataImporter` if you want to change it.
 */
@property (nonatomic, strong, readonly)CBDCoreDataDecisionCenter * decisionCenterForCopy ;


/**
 The discriminator based on `decisionCenterForDescrimination`.
 */
@property (nonatomic, strong, readonly)CBDCoreDataDiscriminator * discriminator ;


/**
 In order not to copy several times the same object, an instance of CBDCoreDataImporting maintains a cache.
 
 Flushing the cache may lead to doublons!
 */
- (void)flushTheCache ;


/**
 Logging
 */
- (void)shouldLog:(BOOL)shouldLog
          deepLog:(BOOL)deepLog ;


#pragma mark Importing
/// @name Importing

/**
 Performs an import.
 
 It will copy all the attributes and relationships (by performing a recursive import), depending on `decisionCenterForCopy`.
 
 @warning If the object exists already (according to the discriminator based on `decisionCenterForDescrimination`) no new object will be created.
 */
- (NSManagedObject *)import:(NSManagedObject *)objectToImport ;



@end
