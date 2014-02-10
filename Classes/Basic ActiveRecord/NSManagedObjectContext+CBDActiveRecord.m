//
//  NSManagedObjectContext+CBDActiveRecord.m
//  MyCBDCoreDataToolKit
//
//  Created by Colas on 10/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import "NSManagedObjectContext+CBDActiveRecord.h"
#import "NSEntityDescription+CBDActiveRecord.h"
#import "NSManagedObject+CBDActiveRecord.h"

@implementation NSManagedObjectContext (CBDActiveRecord)


- (NSArray *)allObjectsOfModel_cbd_:(NSManagedObjectModel *)aManagedObjectModel
{
    NSMutableArray * result = [@[] mutableCopy] ;
    
    for (NSEntityDescription * entity in aManagedObjectModel.entities)
    {
        [result addObjectsFromArray:[entity allInMOC_cbd_:self]] ;
    }
    
    return result ;
}


#pragma mark - Removing


/** Removes all objects from the caller class. */
- (void)removeAllObjectsOfModel_cbd_:(NSManagedObjectModel *)aManagedObjectModel
{
    for (NSManagedObject* managedObject in [self allObjectsOfModel_cbd_:aManagedObjectModel])
    {
        [managedObject remove_cbd_] ;
    }
}



/** Returns the total amount of the objects from the caller class. */
- (NSUInteger)countAllObjectsOfModel_cbd_:(NSManagedObjectModel *)aManagedObjectModel
{
    NSUInteger result = 0 ;
    
    for (NSEntityDescription * entity in aManagedObjectModel.entities)
    {
        result = result + [entity countforMOC_cbd_:self] ;
    }
    
    return result ;
}




@end
