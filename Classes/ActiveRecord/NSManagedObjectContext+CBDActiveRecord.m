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


#pragma mark - Fetching all


- (NSArray *)allObjects_cbd_
{
    NSMutableSet * result = [[NSMutableSet alloc] init] ;
    
    for (NSEntityDescription * entity in [self allEntities_cbd_])
    {
        [result addObjectsFromArray:[entity allInMOC_cbd_:self]] ;
    }
    
    return [result allObjects] ;
}


- (NSArray *)allEntities_cbd_
{
    return self.persistentStoreCoordinator.managedObjectModel.entities ;
}



#pragma mark - Removing all


/** Removes all objects from the caller class. */
- (void)removeAllObjects_cbd_
{
    for (NSManagedObject* managedObject in [self allObjects_cbd_])
    {
        [managedObject remove_cbd_] ;
    }
}


#pragma mark - Counting all


TODO(This method can be accelerated)
/** Returns the total amount of the objects from the caller class. 
 
 Beware of not counting two time objects belonging to several entities.
 */
- (NSUInteger)countAllObjects_cbd_
{
    return [[self allObjects_cbd_] count] ;
// What follows does not work !!
//
//    NSUInteger result = 0 ;
//    
//    for (NSEntityDescription * entity in [self allEntities_cbd_])
//    {
//        result = result + [entity countInMOC_cbd_:self] ;
//    }
//    
//    return result ;
}




#pragma mark - Getting
/// @name Getting objects

/**
 Fetches all the NSManagedObject of the entity with the given name in the MOC.
 */
- (NSArray *) allForEntityWithName_cbd_:(NSString *)nameOfTheEntity
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity allInMOC_cbd_:self] ;
}




- (NSArray *) allForEntityWithName:(NSString *)nameOfTheEntity
                    orderedBy_cbd_:(NSString *)orderBy
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity allInMOC:self
             orderedBy_cbd_:orderBy] ;
}


/**
 The first instance in the fetch
 */
- (id) firstForEntityWithName:(NSString *)nameOfTheEntity
                    orderedBy:(NSString *)orderBy
           withPredicate_cbd_:(NSPredicate *)predicate
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity firstInMOC:self
                    orderedBy:orderBy
           withPredicate_cbd_:predicate] ;
    
}

/**
 The first instance in the fetch
 
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.
 */
- (id) firstForEntityWithName:(NSString *)nameOfTheEntity
                    orderedBy:(NSString *)orderBy
     withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(3, 4)
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    
    return [self firstForEntityWithName:nameOfTheEntity
                              orderedBy:orderBy
                     withPredicate_cbd_:myPredicate] ;
}

/**
 Does a fetch.
 */
- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                 withPredicate_cbd_:(NSPredicate *)predicate
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity findInMOC:self
          withPredicate_cbd_:predicate] ;
    
}


/**
 Does a fetch.
 
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.
 */
- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
           withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(2, 3)
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    
    return [self findForEntityWithName:nameOfTheEntity
                    withPredicate_cbd_:myPredicate] ;
}





/** Returns objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 */

- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                          orderedBy:(NSString *)orderBy
                 withPredicate_cbd_:(NSPredicate *)predicate
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity findInMOC:self
                   orderedBy:orderBy
          withPredicate_cbd_:predicate] ;
    
}

/** Returns objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.
 */

- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                          orderedBy:(NSString *)orderBy
           withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(3, 4)
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    
    return [self findForEntityWithName:nameOfTheEntity
                             orderedBy:orderBy
                    withPredicate_cbd_:myPredicate] ;
}




/** Returns objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 @param offset the index of the first element to retrieve.
 @param limit the maximum amount of objects to retrieve.
 */
- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                          orderedBy:(NSString *)orderBy
                             offset:(int)offset
                              limit:(int)limit
                 withPredicate_cbd_:(NSPredicate *)predicate
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity findInMOC:self
                   orderedBy:orderBy
                      offset:offset
                       limit:limit
          withPredicate_cbd_:predicate] ;
    
}


/** Returns objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 @param offset the index of the first element to retrieve.
 @param limit the maximum amount of objects to retrieve.
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.
 
 */
- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                          orderedBy:(NSString *)orderBy
                             offset:(int)offset
                              limit:(int)limit
           withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(5, 6)
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    
    return [self findForEntityWithName:nameOfTheEntity
                             orderedBy:orderBy
                                offset:offset
                                 limit:limit
                    withPredicate_cbd_:myPredicate] ;
}






#pragma mark - Counting
/// @name Counting



/** Returns the total amount of the objects from the entity with the given name. */
- (NSUInteger) countAllForEntityWithName_cbd_:(NSString *)nameOfTheEntity
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity countInMOC_cbd_:self] ;
    
}




/** Returns the total amount of the objects from the entity with the given name.
 
 @param predicate the predicate to filter with. */
- (NSUInteger) countForEntityWithName:(NSString *)nameOfTheEntity
                    forPredicate_cbd_:(NSPredicate *)predicate
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity countInMOC:self forPredicate_cbd_:predicate] ;
    
}


/** Returns the total amount of the objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.*/
- (NSUInteger) countForEntityWithName:(NSString *)nameOfTheEntity
              forPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(2, 3)
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);

    
    return [self countForEntityWithName:nameOfTheEntity
                      forPredicate_cbd_:myPredicate] ;
}







#pragma mark - Removing
/// @name Removing


/** Removes all objects from the entity with the given name. */
- (void) removeAllForEntityWithName:(NSString *)nameOfTheEntity
{
    NSEntityDescription * entity = [NSEntityDescription entityForName:nameOfTheEntity
                                               inManagedObjectContext:self] ;
    
    return [entity removeAllInMOC_cbd_:self] ;
    
}





#pragma mark - Getting an entity
/// @name Getting an entity


/** Get the entity with the given name. */
- (NSEntityDescription*) entityWithName_cbd_:(NSString *)nameOfTheEntity
{
    return [NSEntityDescription entityForName:nameOfTheEntity
                       inManagedObjectContext:self] ;
}






@end
