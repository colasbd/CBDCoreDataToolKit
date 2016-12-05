//
//  NSManagedObject+Clone.h
//  CBDCoreDataToolKit
//
//  Created by Colas on 07/05/13.
//  Copyright (c) 2013 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 Methods for cloning an object from a MOC to another MOC
 */
@interface NSManagedObject (CBDClone)

#pragma mark - Cloning
/// @name Cloning

/**
 Copy the given object to another MOC, but with omitting certains objects.
 
 All the objects in relationships with the given objects will be *copied*, except those belonging to `(NSArray *)namesOfEntitiesToExclude`
 */
- (NSManagedObject *)cloneToContext:(NSManagedObjectContext *)context
                exludeEntities_cbd_:(NSArray *)namesOfEntitiesToExclude;


/**
 Copy the given object to another MOC, but with omitting certains objects.
 
 All the objects in relationships with the given objects will be *copied*, except those belonging to `(NSArray *)namesOfEntitiesToExclude`
 
 @param (NSArray *)namesOfAttributesToExclude The attributes won't be copied
 */
- (NSManagedObject *)cloneToContext:(NSManagedObjectContext *)context
                     exludeEntities:(NSArray *)namesOfEntitiesToExclude
             excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude;

/**
 Cloning the object, but omitting all the relationships.
 
 @param (NSArray *)namesOfAttributesToExclude Some attributes can also be omitted
 */
- (NSManagedObject *)cloneOnlyAttribuesToContext:(NSManagedObjectContext *)context
                           exludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude;


/**
 Copy the given object to another MOC, but with omitting certains objects.
 
 This method is more of an helper method, used bu other ones. Avoid using it.
 
 All the objects in relationships with the given objects will be *copied*, except those in the `NSMutableDictionary *)alreadyCopied` and those belonging to `(NSArray *)namesOfEntitiesToExclude`
 
 @param (NSMutableDictionary *)alreadyCopied The dictionnary is of the form `@{objectID : theObject}`
 @param (NSArray *)namesOfAttributesToExclude The attributes won't be copied
 */
- (NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context
                    withCopiedCache:(NSMutableDictionary *)alreadyCopied
                     exludeEntities:(NSArray *)namesOfEntitiesToExclude
             excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude;



/**
 Copy the given object to another MOC, but with omitting certains objects.
 
 This method is more of an helper method, used bu other ones. Avoid using it.
 
 All the objects in relationships with the given objects will be *copied*, except those in the `NSMutableDictionary *)alreadyCopied` and those belonging to `(NSArray *)namesOfEntitiesToExclude`
 
 @param (NSMutableDictionary *)alreadyCopied The dictionnary is of the form `@{objectID : theObject}`
 @param (NSArray *)namesOfAttributesToExclude The attributes won't be copied
 @param (NSArray *)namesOfRelationshipsToExclude The relationships won't be "followed"
 */
- (NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context
                    withCopiedCache:(NSMutableDictionary *)alreadyCopied
                     exludeEntities:(NSArray *)namesOfEntitiesToExclude
                  excludeAttributes:(NSArray *)namesOfAttributesToExclude
          excludeRelationships_cbd_:(NSArray *)namesOfRelationshipsToExclude;




#pragma mark - Copying the attributes
/// @name Copying the attributes

/**
 Given two existing `NSManagedObject`, you want to copy the attributes of one to another one.
 */
- (void)fillInAttributesFrom:(NSManagedObject *)sourceObject
       exludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude;


/**
 Given two existing `NSManagedObject`, you want to copy the attributes of one to another one.
 */
- (void)fillInAttributesFrom:(NSManagedObject *)sourceObject
         onlyAttributes_cbd_:(NSArray *)namesOfAttributesToCopy;





@end