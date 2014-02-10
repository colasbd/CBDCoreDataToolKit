//
//  NSManagedObjectContext+clone.h
//  MyMaths
//
//  Created by Colas on 09/05/13.
//  Copyright (c) 2013 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Clone)

- (void)cloneToThisContextTheObjects:(NSArray *)theManagedObjectsToClone
                      exludeEntities:(NSArray *)namesOfEntitiesToExclude
              excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude ;

@end
