//
//  ThePeopleViewerController.m
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
#import "TheCompaniesViewerController.h"


/*
 Classes modèle
 */
#import "Person.h"
#import "City.h"
#import "Company.h"
/*
 Moteur
 */


/*
 Singletons
 */


/*
 Vues
 */


/*
 Catégories
 */


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
@interface TheCompaniesViewerController ()

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


//
//
/**************************************/
#pragma mark Properties-référence
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
@property (strong) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet NSTableView *mainTableView;
@property (weak) IBOutlet NSTableView *tableViewEmployees;



@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/
@implementation TheCompaniesViewerController



//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/

- (id)init
{
    self = [super initWithWindowNibName:@"TheCompaniesViewerController"];
    if (self) {
        // Initialization code here.
    }
    return self;
}



- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
    return @"Entreprises" ;
}


//
//
/**************************************/
#pragma mark - Méthodes delegate
/**************************************/


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    [self reloadMainTableView] ;
}





//
//
/**************************************/
#pragma mark - Properties de convénience
/**************************************/

+ (NSSet *)keyPathsForValuesAffectingSelectedCompany
{
    return [NSSet setWithObject:@"arrayController.selection"] ;
}


- (Person *)selectedCompany
{
    id selectedCompany = self.arrayController.selection ;
    
    if ([selectedCompany valueForKey:@"self"] == NSNoSelectionMarker)
    {
        return nil ;
    }
    else
    {
        return [selectedCompany valueForKey:@"self"] ;
    }
}






//
//
/**************************************/
#pragma mark - Reloading
/**************************************/

- (void)reloadData
{
    [self reloadMainTableView] ;
    [self reloadOtherTableViews] ;
}

- (void)reloadMainTableView
{
    [self.arrayController fetch:@"Company"] ;
    
    [self.mainTableView reloadData] ;
}

- (void)reloadOtherTableViews
{
    [self.tableViewEmployees reloadData] ;
}



//
//
/**************************************/
#pragma mark - Méthodes delegate
/**************************************/


- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [self reloadOtherTableViews] ;
}




//
//
/**************************************/
#pragma mark - Méthodes datasource
/**************************************/

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if (!self.selectedCompany)
    {
        return 0 ;
    }
    
    switch (tableView.tag)
    {
        case 1:
            return [self.selectedCompany.employees count] ;
            break;
            
//        case 2:
//            return [self.selectedPerson.peopleWhoHaveMeAsAFriend count] ;
//            break;
//            
//        case 3:
//            return [self.selectedPerson.preferedCities count] ;
//            break;
//            
//        case 4:
//            return [self.selectedPerson.pets count] ;
//            break;
            
        default:
            return 0 ;
            break;
    }
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    switch (tableView.tag)
    {
        case 1:
        {
            Person *employee = [[self.selectedCompany.employees allObjects] objectAtIndex:row] ;
            return employee.name ;
        }
            break;

//        case 2:
//        {
//            Person * friendBis = [[self.selectedPerson.peopleWhoHaveMeAsAFriend allObjects] objectAtIndex:row] ;
//                    return friendBis.name ;
//        }
//            break;
//            
//        case 3:
//        {
//            City * city = [self.selectedPerson.preferedCities objectAtIndex:row] ;
//            return city.name ;
//        }
//            break;
//            
//        case 4:
//        {
//            Pet * pet = [[self.selectedPerson.pets allObjects] objectAtIndex:row] ;
//            return pet.name ;
//        }
//            break;
            
        default:
            return @"" ;
            break;
    }
}


@end
