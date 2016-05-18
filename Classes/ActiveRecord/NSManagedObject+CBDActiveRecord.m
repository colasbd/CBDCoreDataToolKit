//
//  NSManagedObject+CBDActiveRecord.m
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




#import "NSManagedObject+CBDActiveRecord.h"
#import "NSSortDescriptor+CBDTransformSQLToSortDescriptors.h"
#import "NSEntityDescription+CBDActiveRecord.h"







@implementation NSManagedObject (CBDActiveRecord)



//
//
/**************************************/
#pragma mark - nameEntity
/**************************************/


+ (NSString *)nameEntityForMOC_cbd_:(NSManagedObjectContext *)aMOC
{
    /*
     ****************************************
     On essaie de récupérer le nom de l'entité
     ****************************************
     */
    NSString *nameEntity;
    
    SEL selectorNameEntity = sel_registerName("entityName");
    
    if ([(id)[self class] respondsToSelector:selectorNameEntity])
    {
        nameEntity = [(id)[self class] valueForKey:@"entityName"];
        
        return nameEntity;
    }
    
    if (aMOC)
    {
        NSString *potentialNameEntity = NSStringFromClass(self);
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:potentialNameEntity
                                                   inManagedObjectContext:aMOC];
        
        if (entity)
        {
            return potentialNameEntity;
        }
    }

    
    [NSException raise:NSInvalidArgumentException
                format:@"The class %@ does not implement 'entityName'. So, there is no way to know to which entity it is attached", self];
    
    return nil;
    
}






+ (NSEntityDescription *)entityInMOC_cbd_:(NSManagedObjectContext *)theMOC
{
    return [NSEntityDescription entityForName:[self nameEntityForMOC_cbd_:theMOC]
                       inManagedObjectContext:theMOC];
}




#pragma mark - Getting

+ (NSArray *)allInMOC_cbd_:(NSManagedObjectContext *)theMOC
{
    return [self allInMOC:theMOC
           orderedBy_cbd_:nil];
}

+ (NSArray *)allInMOC:(NSManagedObjectContext *)theMOC
       orderedBy_cbd_:(NSString *)orderBy
{
    return [self findInMOC:theMOC
                 orderedBy:orderBy
        withPredicate_cbd_:nil];
}


+ (instancetype)firstInMOC:(NSManagedObjectContext *)theMOC
                      orderedBy:(NSString *)orderBy
             withPredicate_cbd_:(NSPredicate *)predicate
{
    NSArray *objects = [self findInMOC:theMOC
                              orderedBy:orderBy
                     withPredicate_cbd_:predicate];
    
    if ([objects count] > 0)
    {
        return [objects objectAtIndex:0];
    }
    else
    {
        return nil;
    }

}


+ (instancetype)firstInMOC:(NSManagedObjectContext *)theMOC
                      orderedBy:(NSString *)orderBy
       withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate *myPredicate;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap];
    va_end(ap);
    
    return     [self firstInMOC:theMOC
                      orderedBy:orderBy
             withPredicate_cbd_:myPredicate];
}







+ (NSArray *)findInMOC:(NSManagedObjectContext *)theMOC
    withPredicate_cbd_:(NSPredicate *)predicate
{
    return [self findInMOC:theMOC
                 orderedBy:nil
        withPredicate_cbd_:predicate];
}



+ (NSArray *)        findInMOC:(NSManagedObjectContext *)theMOC
      withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate *myPredicate;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap];
    va_end(ap);
    
    return [self findInMOC:theMOC
        withPredicate_cbd_:myPredicate];
}






/** Returns objects from the caller class.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause. */

+ (NSArray *)findInMOC:(NSManagedObjectContext *)theMOC
             orderedBy:(NSString *)orderBy
    withPredicate_cbd_:(NSPredicate *)predicate
{
    return    [self findInMOC:theMOC
                    orderedBy:orderBy
                       offset:0
                        limit:0
           withPredicate_cbd_:predicate];
}


+ (NSArray *)      findInMOC:(NSManagedObjectContext *)theMOC
                   orderedBy:(NSString *)orderBy
    withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate *myPredicate;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap];
    va_end(ap);
    
    return [self findInMOC:theMOC
                 orderedBy:orderBy
        withPredicate_cbd_:myPredicate];
}






/** Returns objects from the caller class.
 
 @param predicate the predicate to filter with.
 @param orderBy an SQL-like order by clause.
 @param offset the index of the first element to retrieve.
 @param limit the maximum amount of objects to retrieve.
 */

+ (NSArray *)      findInMOC:(NSManagedObjectContext *)theMOC
                   orderedBy:(NSString *)orderBy
                      offset:(int)offset
                       limit:(int)limit
    withPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate *myPredicate;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap];
    va_end(ap);
    
    
    return [self findInMOC:theMOC
                 orderedBy:orderBy
                    offset:offset
                     limit:limit
        withPredicate_cbd_:myPredicate];
}



+ (NSArray *)findInMOC:(NSManagedObjectContext *)theMOC
             orderedBy:(NSString *)orderBy
                offset:(int)offset
                 limit:(int)limit
    withPredicate_cbd_:(NSPredicate *)predicate
{
    NSEntityDescription *theEntity = [self entityInMOC_cbd_:theMOC];

    return [theEntity findInMOC:theMOC
                      orderedBy:orderBy
                         offset:offset
                          limit:limit
             withPredicate_cbd_:predicate];
}




#pragma mark - Counting



/** Returns the total amount of the objects from the caller class. */
+ (NSUInteger) countInMOC_cbd_:(NSManagedObjectContext *)theMOC
{
    return [self countInMOC:theMOC
           forPredicate_cbd_:nil];
}

/** Returns the total amount of the objects from the caller class.
 
 
 
 @param predicate the predicate to filter with. */

+ (NSUInteger)      countInMOC:(NSManagedObjectContext *)theMOC
        forPredicateFormat_cbd_:(NSString *)formatString, ...
{
    NSPredicate *myPredicate;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap];
    va_end(ap);

    return [self countInMOC:theMOC
           forPredicate_cbd_:myPredicate];
}



+ (NSUInteger)countInMOC:(NSManagedObjectContext *)theMOC
        forPredicate_cbd_:(NSPredicate *)predicate
{
    NSEntityDescription *theEntity = [self entityInMOC_cbd_:theMOC];

    return [theEntity countInMOC:theMOC
                forPredicate_cbd_:predicate];
}







#pragma mark - Removing



/** Removes the calling object. */
- (void)remove_cbd_
{
    NSManagedObjectContext *theMOC = self.managedObjectContext;
    
    [theMOC deleteObject:self];
    
    NSError *error;
    
    if (![theMOC save:&error])
    {
		//This is a serious error saying the record
		//could not be saved. Advise the user to
		//try again or restart the application.
	}
}


/** Removes all objects from the caller class. */
+ (void)removeAllInMOC_cbd_:(NSManagedObjectContext *)theMOC
{
    for (NSManagedObject *managedObject in [self allInMOC_cbd_:theMOC])
    {
        [managedObject remove_cbd_];
    }
}





#pragma mark - Refetching


/** Refetches the object from the specified managed object context. */
- (instancetype) refetch_cbd_
{
    return [self.managedObjectContext objectWithID:self.objectID];
}





//
//
/**************************************/
#pragma mark - Finding similar objects
/**************************************/



- (NSArray *)findSimilarObjectsForAttributes:(NSArray *)arrayOfNamesOfAttributes
                            forRelationships:(NSArray *)arrayOfNamesOfRelationships
          withAttributesOrRelationships_cbd_:(NSDictionary *)dicoOfFixedAttributesOrRelationships
{
    return           [self findInMOC:self.managedObjectContext
         similarObjectsForAttributes:arrayOfNamesOfAttributes
                    forRelationships:arrayOfNamesOfAttributes
  withAttributesOrRelationships_cbd_:dicoOfFixedAttributesOrRelationships];
}



- (NSArray *)               findInMOC:(NSManagedObjectContext *)aDifferentMOC
          similarObjectsForAttributes:(NSArray *)arrayOfNamesOfAttributes
                     forRelationships:(NSArray *)arrayOfNamesOfRelationships
   withAttributesOrRelationships_cbd_:(NSDictionary *)dicoOfFixedAttributesOrRelationships
{
    NSMutableArray *arrayOfPredicates = [@[] mutableCopy];
    
    [dicoOfFixedAttributesOrRelationships enumerateKeysAndObjectsUsingBlock:
     ^(NSString *nameAttributeOrRel, id valueAttributeOrRel, BOOL *stop)
     {
         NSPredicate *myPred = [NSPredicate predicateWithFormat:@"%K == %@", nameAttributeOrRel, valueAttributeOrRel];
         [arrayOfPredicates addObject:myPred];
     }];
    
    
    NSPredicate *globalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:arrayOfPredicates];
    
    return           [self findInMOC:aDifferentMOC
         similarObjectsForAttributes:arrayOfNamesOfAttributes
                    forRelationships:arrayOfNamesOfRelationships
        withAdditionalPredicate_cbd_:globalPredicate];

}




- (NSArray *)findSimilarObjectsForAttributes:(NSArray *)arrayOfNamesOfAttributes
                            forRelationships:(NSArray *)arrayOfNamesOfRelationships
                withAdditionalPredicate_cbd_:(NSPredicate *)additionnaryPredicate
{
    return         [self findInMOC:self.managedObjectContext
       similarObjectsForAttributes:arrayOfNamesOfAttributes
                  forRelationships:arrayOfNamesOfRelationships
      withAdditionalPredicate_cbd_:additionnaryPredicate];
}




- (NSArray *)findSimilarObjectsForAttributes:(NSArray *)arrayOfNamesOfAttributes
                            forRelationships:(NSArray *)arrayOfNamesOfRelationships
          withAdditionalPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(3, 4)
{
    NSPredicate *myPredicate;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap];
    va_end(ap);

    return [self findSimilarObjectsForAttributes:arrayOfNamesOfAttributes
                                forRelationships:arrayOfNamesOfRelationships
                    withAdditionalPredicate_cbd_:myPredicate];
}




- (NSArray *)               findInMOC:(NSManagedObjectContext *)aDifferentMOC
          similarObjectsForAttributes:(NSArray *)arrayOfNamesOfAttributes
                     forRelationships:(NSArray *)arrayOfNamesOfRelationships
         withAdditionalPredicate_cbd_:(NSPredicate *)additionnaryPredicate
{
    /*
     Computing the predicate
     */
    NSMutableArray *arrayOfPredicates = [@[] mutableCopy];
    
    for (NSString *nameAttribute in arrayOfNamesOfAttributes)
    {
        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"%K == %@", nameAttribute, [self valueForKey:nameAttribute]];
        [arrayOfPredicates addObject:myPredicate];
    }
    
    for (NSString *nameRelationship in arrayOfNamesOfRelationships)
    {
        NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"%K == %@", nameRelationship, [self valueForKey:nameRelationship]];
        [arrayOfPredicates addObject:myPredicate];
    }
    
    [arrayOfPredicates addObject:additionnaryPredicate];
    
    
    NSPredicate *globalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:arrayOfPredicates];
    
    NSString *sortingString = [arrayOfNamesOfAttributes componentsJoinedByString:@", "];
    
    return [self.entity findInMOC:aDifferentMOC
                        orderedBy:sortingString
               withPredicate_cbd_:globalPredicate];
}



- (NSArray *)               findInMOC:(NSManagedObjectContext *)aDifferentMOC
          similarObjectsForAttributes:(NSArray *)arrayOfNamesOfAttributes
                     forRelationships:(NSArray *)arrayOfNamesOfRelationships
   withAdditionalPredicateFormat_cbd_:(NSString *)formatString, ... NS_FORMAT_FUNCTION(4, 5);
{
    NSPredicate *myPredicate;
    
    va_list ap;
    va_start(ap, formatString);
    
    myPredicate = [NSPredicate predicateWithFormat:formatString
                                         arguments:ap];
    va_end(ap);

    return        [self findInMOC:aDifferentMOC
      similarObjectsForAttributes:arrayOfNamesOfAttributes
                 forRelationships:arrayOfNamesOfRelationships
     withAdditionalPredicate_cbd_:myPredicate];
}





@end
