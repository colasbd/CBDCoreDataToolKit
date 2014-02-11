//
//  NSManagedObjectContext+CBDActiveRecord.m
//  MyCBDCoreDataToolKit
//
//  Created by Colas on 10/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//
//Copyright (c) 2012 Víctor Pena Placer (@vicpenap) http://www.victorpena.es/
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.





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
