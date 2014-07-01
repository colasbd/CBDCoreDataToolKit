// Template created By Colas Bardavid
// Copyright (c) 2014 Colas. All rights reserved.
//
//  CBDEnhancedCloner.h
//  Pods
//
//  Created by Colas on 17/06/2014.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>




//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - Used Classes
/**************************************/
//
@class CBDCoreDataDecisionCenter ;








//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DECLARATION OF CONSTANTS
/**************************************/
//
//extern NSString* const <#example of a constant#> ;







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - ENUMS
/**************************************/
//
//typedef NS_ENUM(NSInteger, <#example of ENUM#>)
//{
//    <#example of ENUM#>Item1,
//    <#example of ENUM#>Item2,
//    <#example of ENUM#>Item3,
//    <#example of ENUM#>Count
//};





//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - PUBLIC HEADER : properties
/**************************************/
@interface CBDEnhancedCloner : NSObject
//
//
/**************************************/
#pragma mark Properties used as parameters for the instance
/**************************************/


//
//
/**************************************/
#pragma mark Strong Properties
/**************************************/
@property (nonatomic, strong, readwrite) CBDCoreDataDecisionCenter * decisionCenter ;

//
//
/**************************************/
#pragma mark Scalar types Properties
/**************************************/


//
//
/**************************************/
#pragma mark Weak Properties
/**************************************/


//
//
/**************************************/
#pragma mark Read-only Properties
/**************************************/
@property (nonatomic, strong, readonly) NSManagedObjectContext * sourceMOC ;
@property (nonatomic, strong, readonly) NSManagedObjectContext * targetMOC ;


//
//
/**************************************/
#pragma mark Convenience Properties
/**************************************/


//
//
/**************************************/
#pragma mark IBOutlets
/**************************************/







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - PUBLIC HEADER : methods
/**************************************/


- (instancetype)initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
                    withTargetMOC:(NSManagedObjectContext *)targetMOC
               withDecisionCenter:(CBDCoreDataDecisionCenter *)decisionCenter ;


- (void)cloneObjects:(NSArray *)arrayOfObjects
          usingCache:(NSDictionary *)cache
      isAsynchronous:(BOOL)isAsynchronous
withCompletionHandler:(void (^)(NSDictionary * newCache))completionBlock ;


- (NSManagedObject *)cloneObject:(NSManagedObject *)sourceObject
                      usingCache:(NSMutableDictionary *)mutableCache ;

@end
