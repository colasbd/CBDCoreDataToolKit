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
 
 @return a dictionary whose keys are the ObjectID of theManagedObjectsToClone (in the old context)
 and whose values are the NSManagedObject in the current context
 */
- (NSDictionary *)cloneToThisContextTheObjects:(NSArray *)theManagedObjectsToClone
                                exludeEntities:(NSArray *)namesOfEntitiesToExclude
                        excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude ;

@end
