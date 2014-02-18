//
//  MyApplicationHelper.h
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
@class ThePeopleViewerController, DataCreater, TheCompaniesViewerController, TheCityViewerController;








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
@interface MyApplicationHelper : NSObject
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
@property (nonatomic, strong) ThePeopleViewerController * thePeopleWC ;
@property (nonatomic, strong) TheCompaniesViewerController * theCompaniesWC ;
@property (nonatomic, strong) TheCityViewerController * theCitiesWC ;

@property (nonatomic, strong) DataCreater * dataCreater ;
@property (nonatomic, strong) DataCreater * secondaryDataCreater ;

@property (nonatomic, strong) NSManagedObjectContext * secondaryMOC ;
@property (nonatomic, readonly) NSManagedObjectContext * firstMOC ;

//
//
/**************************************/
#pragma mark Properties-référence
/**************************************/


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

- (void)showPeopleWindow ;
- (void)showCompaniesWindow ;
- (void)showCitiesWindow ;
- (void)reloadAllDatas ;
- (void)replaceAdaByDoudou ;
- (void)replacePartiallyAdaByDoudou ;
- (void)printInfosInLog ;
- (void)removeMoscowLovers ;
- (void)reinitialize ;

- (void)testMagicalRecord ;
- (void)testTheSecondaryMOC ;
- (void)compareObjects ;


- (void)createTheSecondaryMOC ;


- (void)testImport ;

@end
