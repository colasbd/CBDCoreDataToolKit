// Template created By Colas Bardavid
// Copyright (c) 2014 Colas. All rights reserved.
//
//  CBDCoreDataDecisionCenter.h
//  Pods
//
//  Created by Colas on 17/02/2014.
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
@class CBDCoreDataDecisionUnit ;








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
@interface CBDCoreDataDecisionCenter : NSObject
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




#pragma mark - Managing the decision centers
/// @name Managing the decision centers

/**
The discriminatorUnits composing the instance
*/
@property (nonatomic, readonly)NSArray * discriminatorUnits ;


/**
The entities explicitely registered by the instance for discriminating
 */
@property (nonatomic, readonly)NSArray * registeredEntities ;


/**
 To perform a discrimination, one should tell the CBDCoreDataDiscriminator upon which criteria the discrimination will be done.

So, you should DiscriminatorUnits if you want to precise to the engine upon which criteria you want the discrimination to be done.
 */
- (void)addDiscriminatorUnit:(CBDCoreDataDecisionUnit *)aDiscriminatorUnit ;



/**
 Remove all the DiscriminatorUnits.
 */
- (void)removeAllDiscriminatorUnits ;



/**
 Remove the DiscriminatorUnit for entity
 */
- (void)removeDiscriminatorUnitFor:(NSEntityDescription *)entity ;








//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - PUBLIC HEADER : methods
/**************************************/

@end
