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
#import "TheCityViewerController.h"


/*
 Classes modèle
 */
#import "Person.h"
#import "City.h"
#import "Pet.h"
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
@interface TheCityViewerController ()

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
@property (weak) IBOutlet NSTableView *tableViewInhabitants;
@property (weak) IBOutlet NSTableView *tableViewLovers;
@property (weak) IBOutlet NSTableView *tableViewCompanies;



@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/
@implementation TheCityViewerController



//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/

- (id)init
{
    self = [super initWithWindowNibName:@"TheCityViewerController"];
    if (self)
    {
        NSSortDescriptor * nameSortDescr = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                         ascending:YES] ;
        self.sortDescriptors = @[nameSortDescr] ;
    }
    return self;
}



- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
    return @"Villes" ;
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

+ (NSSet *)keyPathsForValuesAffectingSelectedPerson
{
    return [NSSet setWithObject:@"arrayController.selection"] ;
}


- (City *)selectedCity
{
    id selectedCity = self.arrayController.selection ;
    
    if ([selectedCity valueForKey:@"self"] == NSNoSelectionMarker)
    {
        return nil ;
    }
    else
    {
        return [selectedCity valueForKey:@"self"] ;
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
    [self.arrayController fetch:@"Person"] ;
    
    [self.mainTableView reloadData] ;
}

- (void)reloadOtherTableViews
{
    [self.tableViewInhabitants reloadData] ;
    [self.tableViewLovers reloadData] ;
    [self.tableViewCompanies reloadData] ; 
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
    
    if (!self.selectedCity)
    {
        return 0 ;
    }
    
    switch (tableView.tag)
    {
            
        case 1:
            return [self.selectedCity.inhabitants count] ;
            break;
            
        case 2:
            return [self.selectedCity.lovers count] ;
            break;
            
        case 3:
            return [self.selectedCity.companies count] ;
            break;
            
//        case 4:
//            return [self.selectedPerson.pets count] ;
//            break;
//            
//        case 5:
//            return [self.selectedPerson.colleagues count] ;
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
            Person *inhabitant = [[self.selectedCity.inhabitants allObjects] objectAtIndex:row] ;
            return inhabitant.name ;
        }
            break;

        case 2:
        {
            Person * lover = [[self.selectedCity.lovers allObjects] objectAtIndex:row] ;
                    return lover.name ;
        }
            break;
            
        case 3:
        {
            Company * company = [[self.selectedCity.companies allObjects] objectAtIndex:row] ;
            return company.name ;
        }
            break;
            
//        case 4:
//        {
//            Pet * pet = [[self.selectedPerson.pets allObjects] objectAtIndex:row] ;
//            return pet.name ;
//        }
//            break;
//            
//        case 5:
//        {
//            Pet * pet = [[self.selectedPerson.colleagues allObjects] objectAtIndex:row] ;
//            return pet.name ;
//        }
//            break;
            
        default:
            return @"" ;
            break;
    }
}


@end
