//
//  NSManagedObjectContext+CBDActiveRecord.h
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




#import <CoreData/CoreData.h>

/**
 Handy methods to fetch/count/remove `NSManagedObject` of an MOC.
 */
@interface NSManagedObjectContext (CBDActiveRecord)



#pragma mark - Getting
/// Getting objects

/**
 Fetches all the NSManagedObject of the entity with the given name in the MOC.
 */
- (NSArray *) allForEntityWithName_cbd_:(NSString *)nameOfTheEntity ;

/*
 *******
 Exemple de orderBy :
 person.name asc, person.age desc
 
 
 Returns an array of sort descriptors based on the SQL-like string passed
 as parameter.
 
 Usage:
 
 You can pass an order-by clause just like in SQL. Syntax expected:
 property [asc|desc][, property [asc|desc]][, ...]
 
 Examples:
 - date
 - date asc
 - date desc, title, id asc
 
 *******
 */

/**
 Fetches all the NSManagedObject of the entity with the given name in the MOC, ordered.
 
 @param (NSString *)orderBy A SQL-like string
 
 Example of orderBy :
 `person.name asc`, `person.age desc`
 
 Returns an array of sort descriptors based on the SQL-like string passed
 as parameter.
 
 Usage:
 
 You can pass an order-by clause just like in SQL. Syntax expected:
 property [asc|desc][, property [asc|desc]][, ...]
 
 Examples:
 - `date`
 - `date asc`
 - `date desc`, `title`, `id asc`
 
 */
- (NSArray *) allForEntityWithName:(NSString *)nameOfTheEntity
                    orderedBy_cbd_:(NSString *)orderBy ;


/**
 The first instance in the fetch
 */
- (id) firstForEntityWithName:(NSString *)nameOfTheEntity
                              orderedBy:(NSString *)orderBy
                     withPredicate_cbd_:(NSPredicate *)predicate ;

/**
 The first instance in the fetch
 
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.
 */
- (id) firstForEntityWithName:(NSString *)nameOfTheEntity
                              orderedBy:(NSString *)orderBy
               withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(3, 4) ;


/**
 Does a fetch.
 */
- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                 withPredicate_cbd_:(NSPredicate *)predicate ;


/**
 Does a fetch.
 
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.
 */
- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
           withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(2, 3) ;





/** Returns objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 */

- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                          orderedBy:(NSString *)orderBy
                 withPredicate_cbd_:(NSPredicate *)predicate ;

/** Returns objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.
 */

- (NSArray *) findForEntityWithName:(NSString *)nameOfTheEntity
                          orderedBy:(NSString *)orderBy
           withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(3, 4) ;




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
                 withPredicate_cbd_:(NSPredicate *)predicate ;


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
           withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(5, 6) ;






#pragma mark - Counting
/// Counting



/** Returns the total amount of the objects from the entity with the given name. */
- (NSUInteger) countAllForEntityWithName_cbd_:(NSString *)nameOfTheEntity ;




/** Returns the total amount of the objects from the entity with the given name.
 
 @param predicate the predicate to filter with. */
- (NSUInteger) countForEntityWithName:(NSString *)nameOfTheEntity
                    forPredicate_cbd_:(NSPredicate *)predicate ;


/** Returns the total amount of the objects from the entity with the given name.
 
 @param predicate the predicate to filter with.
 @param (NSString *)formatString Instead of building an `NSPredicate` with `[NSPredicate predicateWithFormat:...`, you can pass the format string directly here.*/
- (NSUInteger) countForEntityWithName:(NSString *)nameOfTheEntity
              forPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(2, 3) ;







#pragma mark - Removing
/// Removing


/** Removes all objects from the entity with the given name. */
- (void) removeAllForEntityWithName:(NSString *)nameOfTheEntity ;




#pragma mark - Getting all
/// Getting all


/** Returns all the objects in the MOC for the associated model. */
- (NSArray *) allObjects_cbd_ ;

/** Returns all the entities associated to model associated to the MOC. */
- (NSArray *) allEntities_cbd_ ;

#pragma mark - Counting all
/// Counting all

/** Returns the total amount of the objects in the MOC for the associated model. */
- (NSUInteger) countAllObjects_cbd_ ;


#pragma mark - Removing all
/// Removing all


/** Removes all objects in the MOC for the associated model. */
- (void) removeAllObjects_cbd_ ;






@end
