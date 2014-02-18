//
//  CreaterOfTheData.h
//  MyToyAppForCoreData
//
//  Created by Colas on 07/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import <Foundation/Foundation.h>





//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - Classes utilisées
/**************************************/
//
@class Person ;
@class EntityA, Entity1, EntitySelf, EntityAlpha ;







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATION DES CONSTANTES
/**************************************/
//
//extern NSString* const <#exempleDeConstante#> ;







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATION PUBLIQUE : properties
/**************************************/
@interface DataCreater : NSObject
//
//
/**************************************/
#pragma mark Properties de paramétrage
/**************************************/


//
//
/**************************************/
#pragma mark Properties strong
/**************************************/
@property (nonatomic, strong) Person* ada ;
@property (nonatomic, strong) Person* guilhem ;
@property (nonatomic, strong) EntityA * objectA ;
@property (nonatomic, strong) EntitySelf * objectSelf ;
@property (nonatomic, strong) Entity1 * object1 ;
@property (nonatomic, strong) EntityAlpha * objectAlpha ;
@property (nonatomic, strong) EntityAlpha * objectAlpha_2 ;


//
//
/**************************************/
#pragma mark Properties-référence
/**************************************/
@property (nonatomic, weak) NSManagedObjectContext * theMOC ;

//
//
/**************************************/
#pragma mark Properties read only
/**************************************/


//
//
/**************************************/
#pragma mark Properties de convenance
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
#pragma mark - DÉCLARATION PUBLIQUE : méthodes
/**************************************/

- (id)initForMOC:(NSManagedObjectContext *)aMOC ;
- (void)createTheDataWithGuilhem:(BOOL)withGuilhem ;

@end
