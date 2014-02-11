//
//  NSManagedObjectContext+ReplacingAnObject.h
//  CBDCoreDataToolKit
//
//  Created by Colas on 03/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 Let's say you have a graph with many objects in relation one with another. You want to replace one object in this graph by another one, and of course, you want the graph to stay the same. CBDCoreDataToolKit can do it.
 */
@interface NSManagedObjectContext (CBDReplacingAnObject)

/**
@param (NSArray *)namesOfRelationshipsToExclude The relationships in this array won't be "linked" with the new object
 @param (BOOL)withDeleting if YES, the OldObject will be delete at the end of the process
 */
- (void)replaceThisObject:(NSManagedObject *)theOldObject
             byThisObject:(NSManagedObject *)theNewObject
     excludeRelationships:(NSArray *)namesOfRelationshipsToExclude
        withDeleting_cbd_:(BOOL)withDeleting ;

@end
