// Template created By Colas Bardavid
// Copyright (c) 2014 Colas. All rights reserved.
//
//  CBDEnhancedCloner.m
//  Pods
//
//  Created by Colas on 17/06/2014.
//
//

//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPORTS
/**************************************/
#import "CBDEnhancedCloner.h"


/*
 Model Classes
 */


/*
 Engine
 */
#import "CBDCoreDataDecisionCenter.h"

/*
 Singletons
 */


/*
 Assistant classes
 */


/*
 Views
 */


/*
 Categories
 */
#import "NSManagedObject+CBDClone.h"

/*
 Global information
 */


/*
 Pods
 */


/*
 Others
 */







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - INSTANCIATION OF CONSTANTS
/**************************************/
//
//NSString* const <#example of a constant#> = @"Example of a constant";






//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - ENUMS
/**************************************/
//
//typedef NS_ENUM(NSInteger, <#example of ENUM#>)
//{
//    <#example of ENUM#>Item1,
//    <#example of ENUM#>Item2,
//    <#example of ENUM#>Item3,
//    <#example of ENUM#>Count
//};







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - PRIVATE HEADER
/**************************************/
@interface CBDEnhancedCloner ()
//
//
/**************************************/
#pragma mark Properties used as parameters for the instance
/**************************************/


//
//
/**************************************/
#pragma mark Strong Properties
/**************************************/
@property (nonatomic, strong, readwrite) NSManagedObjectContext * sourceMOC ;
@property (nonatomic, strong, readwrite) NSManagedObjectContext * targetMOC ;

//
//
/**************************************/
#pragma mark Scalar types Properties
/**************************************/


//
//
/**************************************/
#pragma mark Weak Properties
/**************************************/


//
//
/**************************************/
#pragma mark Read-only Properties
/**************************************/


//
//
/**************************************/
#pragma mark Convenience Properties
/**************************************/


//
//
/**************************************/
#pragma mark IBOutlets
/**************************************/



@end








//
//
/**************************************/
#pragma mark - Optional comments
/**************************************/


#define CBDCOREDATATOOLKIT_ENHANCED_CLONER_COMMENTS_ON 0


#if CBDCOREDATATOOLKIT_ENHANCED_CLONER_COMMENTS_ON
#define CBDCloneLog(frmt, ...)   NSLog(frmt, ##__VA_ARGS__)
#else
#define CBDCloneLog(frmt, ...)
#endif





//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLEMENTATION
/**************************************/
@implementation CBDEnhancedCloner



//
//
/**************************************/
#pragma mark - Init Methods
/**************************************/

- (instancetype)initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
                    withTargetMOC:(NSManagedObjectContext *)targetMOC
               withDecisionCenter:(CBDCoreDataDecisionCenter *)decisionCenter
{
    self = [super init] ;
    
    if (self)
    {
        _sourceMOC = sourceMOC ;
        _targetMOC = targetMOC ;
        _decisionCenter = decisionCenter ;
    }
    
    return self ;
}





//
//
/**************************************/
#pragma mark - Core method
/**************************************/


- (void)     cloneObjects:(NSArray *)arrayOfObjects
                usingCache:(NSDictionary *)cache
           isAsynchronous:(BOOL)isAsynchronous
    withCompletionHandler:(void (^)(NSDictionary * dictionary))completionBlock
{
    __block NSMutableDictionary * mutableCache = [cache mutableCopy] ;
    __block NSMutableDictionary * dicoAttributesToExclude = [[NSMutableDictionary alloc] init] ;
    __block NSMutableDictionary * dicoRelationshipsToExclude = [[NSMutableDictionary alloc] init] ;

    
    
    /*
     Managing the multithreading
     */
    void (*dispatchingFunction)(dispatch_queue_t, dispatch_block_t) = dispatch_async ;
    
    if (isAsynchronous)
    {
        dispatchingFunction = dispatch_async ;
    }
    else
    {
        dispatchingFunction = dispatch_sync ;
    }
    
    dispatch_queue_t myQueue = dispatch_queue_create("Cloning managed objects", DISPATCH_QUEUE_SERIAL) ;
    
    
    
    
    
    /*
     Launching the action !!
     */
    dispatchingFunction(myQueue, ^{
        for (NSManagedObject * object in arrayOfObjects)
        {
            if (object.managedObjectContext != self.sourceMOC)
            {
                NSLog(@"Warning : %@ is not in the source MOC.", object) ;
            }
            else
            {
                if (mutableCache[object.objectID])
                {
                    // do nothing
                }
                else
                {
                    NSString * nameEntity = object.entity.name ;
                    
                    
                    /*
                     First, we deal with computing the attributes and relationships to remove
                     */
                    if (!dicoAttributesToExclude[nameEntity])
                    {
                        /*
                         Computing the attributes to keep and to remove
                         */
                        NSArray * attributesToKeep = [[self.decisionCenter attributesFor:object.entity] allObjects] ;
                        
                        NSMutableArray * attributesToExclude = [[[object.entity attributesByName] allValues] mutableCopy] ;
                        [attributesToExclude removeObjectsInArray:attributesToKeep] ;
                        
                        dicoAttributesToExclude[nameEntity] = [attributesToExclude copy] ;
                    }
                    
                    
                    
                    if (!dicoRelationshipsToExclude[nameEntity])
                    {
                        /*
                         Computing the attributes to keep and to remove
                         */
                        NSArray * relationshipsToKeep = [[self.decisionCenter relationshipsFor:object.entity] allObjects] ;
                        
                        NSMutableArray * relationshipsToExclude = [[[object.entity relationshipsByName] allValues] mutableCopy] ;
                        [relationshipsToExclude removeObjectsInArray:relationshipsToKeep] ;
                        
                        dicoRelationshipsToExclude[nameEntity] = [relationshipsToExclude copy] ;
                    }
                    
                    [self cloneObject:object
                           usingCache:mutableCache] ;
                }
            }
        }
        
        
        
        /*
         Finally, we execute the completion block
         */
        if (completionBlock)
        {
            completionBlock(mutableCache) ;
        }
    }) ;
}




//
//
/**************************************/
#pragma mark - Clone objects
/**************************************/


int numberOfEntitiesCopied_cbd_ = 0 ;
int const limitNumberOfNonSavedObjects = 10 ;

- (NSManagedObject *)cloneObject:(NSManagedObject *)sourceObject
                      usingCache:(NSMutableDictionary *)mutableCache
{
    /*
     First test
     */
    if (sourceObject.managedObjectContext != self.sourceMOC)
    {
        NSLog(@"Warning : %@ is not in the source MOC.", sourceObject) ;
    }


    
    /*
     Case of nil cache
     */
    if (!mutableCache)
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"The cache can't be nil"] ;
    }
    
    

    /*
     ********************
     Go !!
     ********************
     */

    
    NSString *entityName = [[sourceObject entity] name];
    NSEntityDescription * entity = [sourceObject entity] ;
    

    
    CBDCloneLog(@"Cloning a NSManagedObject of type %@", entityName) ;
    CBDCloneLog(@"  | size of the cache : %ld", [mutableCache count]) ;
    
    
    
    if ([self.decisionCenter shouldIgnore:entity])
    //if ([namesOfEntitiesToExclude containsObject:entityName])
    {
        CBDCloneLog(@"  | ¡ objet not copied !") ;
        CBDCloneLog(@"  | (because its entitity is excluded of the copy)") ;
        
        return nil;
    }
    
    
    
    /*
     Case where the object is already in the cache
     */
    __block NSManagedObject *cloned = [mutableCache objectForKey:[sourceObject objectID]];
    if (cloned != nil)
    {
        CBDCloneLog(@"  | ¡ objet not copied !");
        CBDCloneLog(@"  | (because it is the cache)");
        
        return cloned;
    }
    
    
    
    /*
     We save every 10 objects
     */
    numberOfEntitiesCopied_cbd_ = numberOfEntitiesCopied_cbd_ + 1;
    
    if (numberOfEntitiesCopied_cbd_ >= limitNumberOfNonSavedObjects)
    {
        [self.targetMOC performBlock:
         ^{
             NSError *error;
             [self.targetMOC save:&error];
         }];
        
        numberOfEntitiesCopied_cbd_ = 0;
    }
    
    
    /*
     create new object in data store
     */
    [self.targetMOC performBlockAndWait:
     ^{
         cloned = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                inManagedObjectContext:self.targetMOC];
         [mutableCache setObject:cloned
                          forKey:[sourceObject objectID]];
     }];
    
    
    
    
    /*
     loop through all attributes and assign then to the clone
     */
    NSDictionary *attributes = [[NSEntityDescription entityForName:entityName
                                            inManagedObjectContext:self.targetMOC] attributesByName];
    
    CBDCloneLog(@"Copying the attributes : ") ;
    
    for (NSString *attr in attributes)
    {
        if ([[self.decisionCenter attributesFor:entity] containsObject:attr])
        {
            [self.targetMOC performBlockAndWait:
             ^{
                 [cloned setValue:[sourceObject valueForKey:attr]
                           forKey:attr];
             }] ;
            
            CBDCloneLog(@"  | the attribute %@ gets the value %@ ", attr, [sourceObject valueForKey:attr]) ;
        }
    }
    
    
    
    /*
     Loop through all relationships, and clone them.
     */
    NSDictionary *relationships = [[NSEntityDescription entityForName:entityName
                                               inManagedObjectContext:self.targetMOC] relationshipsByName];
    
    CBDCloneLog(@"Taking account of the relationships (for %@) : ", entityName) ;
    
    for (NSString *relName in [relationships allKeys])
    {
        NSRelationshipDescription *rel = [relationships objectForKey:relName];
        
        NSString *keyName = rel.name;
        
        CBDCloneLog(@"  | Relationships '%@' (for %@)", keyName, entityName) ;
        
        if ([[self.decisionCenter relationshipsFor:entity] containsObject:rel])
        {
            [self.targetMOC performBlockAndWait:
             ^{
                 if ([rel isToMany])
                 {
//                     id sourceSet ;
//                     id clonedSet ;
                     
                     /*
                      On gère selon que la relation est ordonnée ou non
                      */
                     if (![rel isOrdered])
                     {
                         /*
                          Case of unordered relationships !!!
                          */
                         NSSet * sourceSet = [sourceObject valueForKey:keyName] ;//[sourceObject mutableSetValueForKey:keyName];
                         NSMutableSet * clonedSet = [[NSMutableSet alloc] init] ;//[cloned mutableSetValueForKey:keyName];
                         
                         NSEnumerator *e = [sourceSet objectEnumerator];
                         NSManagedObject *relatedObject;
                         
                         while (relatedObject = [e nextObject])
                         {
                             /*
                              Clone it, and add clone to set
                              */
                             NSManagedObject *clonedRelatedObject = [self cloneObject:relatedObject
                                                                           usingCache:mutableCache] ;
                             
                             if (clonedRelatedObject)
                             {
                                 [clonedSet addObject:clonedRelatedObject];
                             }
                         }
                         
                         /*
                          We set the set for the relationship
                          */
                         [cloned setValue:[clonedSet copy]
                                   forKey:keyName] ;
                         
                     }
                     else
                     {
                         /*
                          Case of ordered relationships !!!
                          */
                         
                         NSOrderedSet * sourceSet = [sourceObject valueForKey:keyName] ;//[sourceObject mutableOrderedSetValueForKey:keyName];
                         NSMutableOrderedSet * clonedSet = [[NSMutableOrderedSet alloc] init] ;//[cloned mutableOrderedSetValueForKey:keyName];
                         
                         
                         for (NSManagedObject * relatedObject in sourceSet)
                         {
                             /*
                              Clone it, and add clone to set
                              */
                             NSManagedObject *clonedRelatedObject = [self cloneObject:relatedObject
                                                                           usingCache:mutableCache] ;
                             
                             if (clonedRelatedObject)
                             {
                                 [clonedSet addObject:clonedRelatedObject];
                             }
                         }
                         
                         /*
                          We set the set for the relationship
                          */
                         [cloned setValue:[clonedSet copy]
                                   forKey:keyName] ;

                         
                     }
                 }
                 else
                 {
                     NSManagedObject *relatedObject = [sourceObject valueForKey:keyName];
                     if (relatedObject != nil)
                     {
                         NSManagedObject *clonedRelatedObject = [self cloneObject:relatedObject
                                                                       usingCache:mutableCache];

                         
                         if (clonedRelatedObject)
                         {
                             [cloned setValue:clonedRelatedObject forKey:keyName];
                         }
                     }
                 }
             }] ;
        }
    }
    
    return cloned;
}

@end
