//
//  NSManagedObject+CBDActiveRecord.m
//  MyCBDCoreDataToolKit
//
//  Created by Colas on 10/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//
//
//Copyright (c) 2012 Víctor Pena Placer (@vicpenap) http://www.victorpena.es/
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



#import "NSEntityDescription+CBDActiveRecord.h"
#import "NSSortDescriptor+CBDTransformSQLToSortDescriptors.h"
#import "NSManagedObject+CBDActiveRecord.h"







@implementation NSEntityDescription (CBDActiveRecord)







#pragma mark - Getting

- (NSArray *)allInMOC_cbd_:(NSManagedObjectContext *)theMOC
{
    return [self findInMOC:theMOC
        withPredicate_cbd_:nil] ;
}

- (NSArray *)   allInMOC:(NSManagedObjectContext *)theMOC
          orderedBy_cbd_:(NSString *)orderBy
{
    return [self findInMOC:theMOC
                 orderedBy:orderBy
        withPredicate_cbd_:nil] ;
}


- (instancetype)firstInMOC:(NSManagedObjectContext *)theMOC
                      orderedBy:(NSString *)orderBy
             withPredicate_cbd_:(NSPredicate *)predicate
{
    NSArray * objects = [self findInMOC:theMOC
                              orderedBy:orderBy
                     withPredicate_cbd_:predicate] ;
    
    if ([objects count] > 0)
    {
        return [objects objectAtIndex:0] ;
    }
    else
    {
        return nil ;
    }
    
}


- (instancetype)firstInMOC:(NSManagedObjectContext *)theMOC
                      orderedBy:(NSString *)orderBy
       withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    return [self firstInMOC:theMOC
                  orderedBy:orderBy
         withPredicate_cbd_:myPredicate] ;
}







- (NSArray *)findInMOC:(NSManagedObjectContext *)theMOC
    withPredicate_cbd_:(NSPredicate *)predicate
{
    return [self findInMOC:theMOC
                 orderedBy:nil
        withPredicate_cbd_:predicate] ;
}



- (NSArray *)        findInMOC:(NSManagedObjectContext *)theMOC
      withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    return [self findInMOC:theMOC
        withPredicate_cbd_:myPredicate] ;
}






/** Returns objects from the caller class.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause. */

- (NSArray *)findInMOC:(NSManagedObjectContext *)theMOC
             orderedBy:(NSString *)orderBy
    withPredicate_cbd_:(NSPredicate *)predicate
{
    return    [self findInMOC:theMOC
                    orderedBy:orderBy
                       offset:0
                        limit:0
           withPredicate_cbd_:predicate] ;
}


- (NSArray *)      findInMOC:(NSManagedObjectContext *)theMOC
                   orderedBy:(NSString *)orderBy
    withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    return [self findInMOC:theMOC
                 orderedBy:orderBy
        withPredicate_cbd_:myPredicate] ;
}






/** Returns objects from the caller class.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 @param offset the index of the first element to retrieve.
 @param limit the maximum amount of objects to retrieve.
 */

- (NSArray *)      findInMOC:(NSManagedObjectContext *)theMOC
                   orderedBy:(NSString *)orderBy
                      offset:(int)offset
                       limit:(int)limit
    withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    
    return [self findInMOC:theMOC
                 orderedBy:orderBy
                    offset:offset
                     limit:limit
        withPredicate_cbd_:myPredicate] ;
}



- (NSArray *)findInMOC:(NSManagedObjectContext *)theMOC
             orderedBy:(NSString *)orderBy
                offset:(int)offset
                 limit:(int)limit
    withPredicate_cbd_:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.

	[fetchRequest setEntity:self];
	
    // Set the batch size to a suitable number.
    [fetchRequest setFetchLimit:limit];
    [fetchRequest setFetchOffset:offset];
    
    NSArray *sortDescriptors = [NSSortDescriptor sortDescriptorsFromSQLString_cbd_:orderBy];
    
    if (sortDescriptors) {
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
	
    [fetchRequest setPredicate:predicate];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSError *error = nil;
	NSArray *result = [theMOC executeFetchRequest:fetchRequest
                                            error:&error];
    
	if (error) {
		// Manage error executing fetch
	}
    
	return result;
}




#pragma mark - Counting



/** Returns the total amount of the objects from the caller class. */
- (NSUInteger) countforMOC_cbd_:(NSManagedObjectContext *)theMOC
{
    return [self countForMOC:theMOC
           forPredicate_cbd_:nil] ;
}

/** Returns the total amount of the objects from the caller class.
 
 
 
 @param predicate the predicate to filter with. */

- (NSUInteger)      countForMOC:(NSManagedObjectContext *)theMOC
        forPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate * myPredicate ;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap] ;
    va_end(ap);
    
    return [self countForMOC:theMOC
           forPredicate_cbd_:myPredicate] ;
}



- (NSUInteger)countForMOC:(NSManagedObjectContext *)theMOC
        forPredicate_cbd_:(NSPredicate *)predicate
{
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.

	[fetchRequest setEntity:self];
	
    [fetchRequest setPredicate:predicate];
    
    
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSError *error = nil;
	NSUInteger result = [theMOC countForFetchRequest:fetchRequest
                                               error:&error];
    
	if (error) {
		// Manage error executing fetch
	}
	
	return result;
}







#pragma mark - Removing



/** Removes all objects from the caller class. */
- (void) removeAllforMOC_cbd_:(NSManagedObjectContext *)theMOC
{
    for (NSManagedObject * managedObject in [self allInMOC_cbd_:theMOC])
    {
        [managedObject remove_cbd_] ;
    }
}







@end
