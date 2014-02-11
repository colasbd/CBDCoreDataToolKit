//
//  NSManagedObjectContext+clone.h
//  CBDCoreDataToolKit
//
//  Created by Colas on 09/05/13.
//  Copyright (c) 2013 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 Import a bunch of objects from a MOC to another MOC.
 */
@interface NSManagedObjectContext (CBDClone)

/**
 Imports objects from a MOC to another MOC.
 */
- (void)cloneToThisContextTheObjects:(NSArray *)theManagedObjectsToClone
                      exludeEntities:(NSArray *)namesOfEntitiesToExclude
              excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude ;

@end
