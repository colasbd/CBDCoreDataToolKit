//
//  NSManagedObjectContext+CBDActiveRecord.h
//  MyCBDCoreDataToolKit
//
//  Created by Colas on 10/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (CBDActiveRecord)


#pragma mark - Getting


- (NSArray *) allObjectsOfModel_cbd_:(NSManagedObjectModel *)aManagedObjectModel ;


#pragma mark - Removing


/** Removes all objects from the caller class. */
- (void) removeAllObjectsOfModel_cbd_:(NSManagedObjectModel *)aManagedObjectModel ;


/** Returns the total amount of the objects from the caller class. */
- (NSUInteger) countAllObjectsOfModel_cbd_:(NSManagedObjectModel *)aManagedObjectModel ;

@end
