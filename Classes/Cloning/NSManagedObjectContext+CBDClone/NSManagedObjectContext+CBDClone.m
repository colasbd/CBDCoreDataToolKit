//
//  NSManagedObjectContext+clone.m
//  CBDCoreDataToolKit
//
//  Created by Colas on 09/05/13.
//  Copyright (c) 2013 Colas. All rights reserved.
//

#import "NSManagedObjectContext+CBDClone.h"

#import "NSManagedObject+CBDClone.h"

@implementation NSManagedObjectContext (CBDClone)


- (void)cloneToThisContextTheObjects:(NSArray *)theManagedObjectsToClone
                      exludeEntities:(NSArray *)namesOfEntitiesToExclude
              excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude
{
    NSMutableDictionary * theAlreadyCopiedObjects ;
    theAlreadyCopiedObjects = [[NSMutableDictionary alloc] init] ;
    
    for (NSManagedObject *obj in theManagedObjectsToClone)
    {
        [obj cloneInContext:self
            withCopiedCache:theAlreadyCopiedObjects
             exludeEntities:namesOfEntitiesToExclude
     excludeAttributes_cbd_:namesOfAttributesToExclude] ;
    }
}



@end
