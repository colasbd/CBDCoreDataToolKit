//
//  NSEntityDescription+CBDActiveRecord.h
//  MyCBDCoreDataToolKit
//
//  Created by Colas on 10/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSEntityDescription (CBDActiveRecord)





/*
 *************************************
 ATTENTION !!!
 
 Les méthodes de classe ne marchent que si la méthode de classe
 + (NSString*)nameEntity
 est implémentée.
 
 C'est le cas pour les classes générées par mogenerator.
 **************************************
 */



#pragma mark - Getting

- (NSArray *)allInMOC_cbd_:(NSManagedObjectContext *)theMOC ;

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

- (NSArray *)   allInMOC:(NSManagedObjectContext *)theMOC
          orderedBy_cbd_:(NSString *)orderBy ;

- (instancetype) firstInMOC:(NSManagedObjectContext *)theMOC
                       orderedBy:(NSString *)orderBy
              withPredicate_cbd_:(NSPredicate *)predicate ;

- (instancetype) firstInMOC:(NSManagedObjectContext *)theMOC
                       orderedBy:(NSString *)orderBy
        withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(3, 4) ;



- (NSArray *)        findInMOC:(NSManagedObjectContext *)theMOC
            withPredicate_cbd_:(NSPredicate *)predicate ;

- (NSArray *)      findInMOC:(NSManagedObjectContext *)theMOC
    withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(2, 3) ;





/** Returns objects from the caller class.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause. */

- (NSArray *) findInMOC:(NSManagedObjectContext *)theMOC
              orderedBy:(NSString *)orderBy
     withPredicate_cbd_:(NSPredicate *)predicate ;


- (NSArray *)    findInMOC:(NSManagedObjectContext *)theMOC
                 orderedBy:(NSString *)orderBy
  withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(3, 4) ;




/** Returns objects from the caller class.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 @param offset the index of the first element to retrieve.
 @param limit the maximum amount of objects to retrieve.
 */
- (NSArray *) findInMOC:(NSManagedObjectContext *)theMOC
              orderedBy:(NSString *)orderBy
                 offset:(int)offset
                  limit:(int)limit
     withPredicate_cbd_:(NSPredicate *)predicate ;

- (NSArray *)       findInMOC:(NSManagedObjectContext *)theMOC
                    orderedBy:(NSString *)orderBy
                       offset:(int)offset
                        limit:(int)limit
     withPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(5, 6) ;






#pragma mark - Counting



/** Returns the total amount of the objects from the caller class. */
- (NSUInteger) countforMOC_cbd_:(NSManagedObjectContext *)theMOC ;
;

/** Returns the total amount of the objects from the caller class.
 
 @param predicate the predicate to filter with. */
- (NSUInteger) countForMOC:(NSManagedObjectContext *)theMOC
         forPredicate_cbd_:(NSPredicate *)predicate ;

- (NSUInteger)     countForMOC:(NSManagedObjectContext *)theMOC
       forPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(2, 3) ;







#pragma mark - Removing



/** Removes all objects from the caller class. */
- (void) removeAllforMOC_cbd_:(NSManagedObjectContext *)theMOC ;
;





@end
