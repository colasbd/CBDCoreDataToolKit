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
#import "ThePeopleViewerController.h"


/*
 Classes modèle
 */
#import "Person.h"
#import "City.h"
#import "Pet.h"
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
@interface ThePeopleViewerController ()

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
@property (weak) IBOutlet NSTableView *tableViewFriends;
@property (weak) IBOutlet NSTableView *tableViewCities;
@property (weak) IBOutlet NSTableView *tableViewFriendsBis;
@property (weak) IBOutlet NSTableView *tableViewPets;
@property (weak) IBOutlet NSTableView *tableViewColleagues;



@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/
@implementation ThePeopleViewerController



//
//
/**************************************/
#pragma mark - Méthodes d'initialisation
/**************************************/

- (id)init
{
    self = [super initWithWindowNibName:@"ThePeopleViewerController"];
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
    return @"Personnes" ;
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


- (Person *)selectedPerson
{
    id selectedPerson = self.arrayController.selection ;
    
    if ([selectedPerson valueForKey:@"self"] == NSNoSelectionMarker)
    {
        return nil ;
    }
    else
    {
        return [selectedPerson valueForKey:@"self"] ;
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
    
    [self willChangeValueForKey:@"selectedPerson"];
    [self didChangeValueForKey:@"selectedPerson"] ;
    
    [self.mainTableView reloadData] ;
}

- (void)reloadOtherTableViews
{
    [self.tableViewFriends reloadData] ;
    [self.tableViewFriendsBis reloadData] ;
    [self.tableViewCities reloadData] ;
    [self.tableViewPets reloadData] ;
    [self.tableViewColleagues reloadData] ;
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
    if (!self.selectedPerson)
    {
        return 0 ;
    }
    
    switch (tableView.tag)
    {
        case 1:
            return [self.selectedPerson.friends count] ;
            break;
            
        case 2:
            return [self.selectedPerson.peopleWhoHaveMeAsAFriend count] ;
            break;
            
        case 3:
            return [self.selectedPerson.preferedCities count] ;
            break;
            
        case 4:
            return [self.selectedPerson.pets count] ;
            break;
            
        case 5:
            return [self.selectedPerson.colleagues count] ;
            break;
            
        default:
            return 0 ;
            break;
    }
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (!self.selectedPerson)
    {
        return @"" ;
    }
    
    switch (tableView.tag)
    {
        case 1:
        {
                Person *friend = [self.selectedPerson.friends objectAtIndex:row] ;
                return friend.name ;
        }
            break;

        case 2:
        {
            Person * friendBis = [[self.selectedPerson.peopleWhoHaveMeAsAFriend allObjects] objectAtIndex:row] ;
                    return friendBis.name ;
        }
            break;
            
        case 3:
        {
            City * city = [self.selectedPerson.preferedCities objectAtIndex:row] ;
            return city.name ;
        }
            break;
            
        case 4:
        {
            Pet * pet = [[self.selectedPerson.pets allObjects] objectAtIndex:row] ;
            return pet.name ;
        }
            break;
            
        case 5:
        {
            Pet * pet = [[self.selectedPerson.colleagues allObjects] objectAtIndex:row] ;
            return pet.name ;
        }
            break;
            
        default:
            return @"" ;
            break;
    }
}


@end
