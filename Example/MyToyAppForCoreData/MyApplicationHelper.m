//
//  MyApplicationHelper.m
//  MyToyAppForCoreData
//
//  Created by Colas on 07/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPORTS
/**************************************/
#import "MyApplicationHelper.h"
#import "AppDelegate.h"

/*
 Classes modèle
 */
#import "Person.h"
#import "City.h"

/*
 Moteur
 */
#import "DataCreater.h"

/*
 Singletons
 */


/*
 Vues
 */
#import "ThePeopleViewerController.h"
#import "TheCompaniesViewerController.h"
#import "TheCityViewerController.h"
/*
 Catégories
 */
#import "NSManagedObjectContext+CBDReplacingAnObject.h"
#import "NSManagedObject+CBDActiveRecord.h"

/*
 Autres
 */







//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - INSTANCIATION DES CONSTANTES
/**************************************/
//
//NSString* const <#exempleDeConstante#> = @"Exemple de constante";









//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - DÉCLARATIONS PRIVÉES
/**************************************/
@interface MyApplicationHelper ()

//#pragma mark -
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
@property (nonatomic, strong) Person *doudou ;

//
//
/**************************************/
#pragma mark Properties-référence
/**************************************/
@property (nonatomic, readonly) AppDelegate * theDelegate ;

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
@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/
@implementation MyApplicationHelper



//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/

- (id)init
{
    self = [super init] ;
    
    if (self)
    {
        self.thePeopleWC = [[ThePeopleViewerController alloc] init] ;
        self.theCompaniesWC = [[TheCompaniesViewerController alloc] init] ;
        self.theCitiesWC = [[TheCityViewerController alloc] init] ;
        self.theDataCreater = [[DataCreater alloc] initForMOC:self.theDelegate.managedObjectContext] ;
        
        [self.theDataCreater createTheData] ;
    }
    
    return self ;
}





//
//
/**************************************/
#pragma mark - Properties de convénience
/**************************************/

- (AppDelegate *)theDelegate
{
    return [NSApplication sharedApplication].delegate ;
}


//
//
/**************************************/
#pragma mark - Fenêtres
/**************************************/


- (void)showPeopleWindow
{
    [self.thePeopleWC showWindow:self] ;
}

- (void)showCompaniesWindow
{
    [self.theCompaniesWC showWindow:self] ; 
}

- (void)showCitiesWindow
{
    [self.theCitiesWC showWindow:self] ;
}

- (void)reloadAllDatas
{
    [self.theCompaniesWC reloadData] ;
    [self.thePeopleWC reloadData] ;
}






//
//
/**************************************/
#pragma mark - Impressions des infos dans la log
/**************************************/



- (void)printInfosInLog
{
    NSArray * allPeople ;
    
    allPeople = [Person allInMOC:self.theDelegate.managedObjectContext
                  orderedBy_cbd_:@"name"] ;
    
    for (Person * person in allPeople)
    {
        NSLog(@"%@", person) ;
    }
}







//
//
/**************************************/
#pragma mark - Testing fetching further
/**************************************/


- (void)removeMoscowLovers
{
    City * moscow = [City firstInMOC:self.theDelegate.managedObjectContext
                           orderedBy:nil
            withPredicateFormat_cbd_:@"name == %@", @"Moscou"] ;
    
    NSArray * moscowLovers = [Person findInMOC:self.theDelegate.managedObjectContext
                      withPredicateFormat_cbd_:@"%@ IN preferedCities", moscow] ;
    
    for (Person * person in moscowLovers)
    {
        [person remove_cbd_] ;
    }
    
    [self reloadAllDatas] ;
}




//
//
/**************************************/
#pragma mark - Reinitilization
/**************************************/


- (void)reinitialize
{
    [self.theDataCreater createTheData] ;
    [self reloadAllDatas] ;
}



//
//
/**************************************/
#pragma mark - Test des méthodes de remplacement
/**************************************/


- (void)replaceAdaByDoudou
{
    [self createDoudou] ;
    
    [self.theDelegate.managedObjectContext replaceThisObject:self.theDataCreater.ada
                                                byThisObject:self.doudou
                                        excludeRelationships:nil
                                                withDeleting_cbd_:YES] ;
    
    [self reloadAllDatas] ;
}


- (void)replacePartiallyAdaByDoudou
{
    [self createDoudou] ;
    
    [self.theDelegate.managedObjectContext replaceThisObject:self.theDataCreater.ada
                                                byThisObject:self.doudou
                                        excludeRelationships:@[@"colleagues"]
                                                withDeleting_cbd_:NO] ;
    [self reloadAllDatas] ;
}

- (void)createDoudou
{
    self.doudou = [Person createPersonWithName:@"Doudou"
                                 withBirthYear:2002
                                        isMale:NO
                                        forMOC:self.theDelegate.managedObjectContext] ;
}

@end
