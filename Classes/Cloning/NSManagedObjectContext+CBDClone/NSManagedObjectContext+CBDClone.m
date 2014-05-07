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


- (NSDictionary *)cloneToThisContextTheObjects:(NSArray *)theManagedObjectsToClone
                                exludeEntities:(NSArray *)namesOfEntitiesToExclude
                        excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude
{
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init] ;
    
    NSMutableDictionary * theAlreadyCopiedObjects ;
    theAlreadyCopiedObjects = [[NSMutableDictionary alloc] init] ;
    
    for (NSManagedObject *obj in theManagedObjectsToClone)
    {
        NSManagedObject * resultObject = [obj cloneInContext:self
                                             withCopiedCache:theAlreadyCopiedObjects
                                              exludeEntities:namesOfEntitiesToExclude
                                      excludeAttributes_cbd_:namesOfAttributesToExclude] ;
        
        result[obj.objectID] = resultObject ;
    }
    
    return result ;
}



@end
