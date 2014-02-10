//
//  CreaterOfTheData.m
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
#import "DataCreater.h"


/*
 Classes modèle
 */
#import "Person.h"
#import "Pet.h"
#import "City.h"
#import "Company.h"
#import "Family.h"

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
@interface DataCreater ()

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
@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLÉMENTATION
/**************************************/
@implementation DataCreater



//
//
/**************************************/
#pragma mark - init
/**************************************/

- (id)initForMOC:(NSManagedObjectContext *)aMOC
{
    self = [super init] ;
    
    if (self)
    {
        self.theMOC = aMOC ;
    }
    
    return self ;
}


//
//
/**************************************/
#pragma mark - Création des données
/**************************************/


- (void)deleteOldData
{
    /*
     ********************************
     Requête Core Data
     ********************************
     */
    NSManagedObjectContext * myContext = self.theMOC ;
    NSFetchRequest * myRequest = [NSFetchRequest fetchRequestWithEntityName:@"EntityWithName"];
    
    NSError *error ;
    
    /****
     Résultat de la requête
     ****/
    NSArray * result  = [myContext executeFetchRequest:myRequest
                                                 error:&error] ;
    
    NSLog(@"Anciennes données :\n%@", result) ;
    
    /*
     ********************************
     Fin Requête Core Data
     ********************************
     */
    
    NSLog(@"Suppressions des anciennes données");
    for (NSManagedObject * obj in self.theMOC.registeredObjects)
    {
        [self.theMOC deleteObject:obj] ;
    }
    [self.theMOC processPendingChanges] ;
    [self.theMOC save:NULL] ;
}



- (void)createTheData
{
    [self deleteOldData] ;
    
    NSLog(@"Création des données");
    
    /*
     Personnes
     */
    Person * colas = [Person createPersonWithName:@"Colas"
                                    withBirthYear:1981
                                           isMale:YES
                                           forMOC:self.theMOC] ;
    
    Person * ada = [Person createPersonWithName:@"Ada"
                                    withBirthYear:1983
                                           isMale:NO
                                           forMOC:self.theMOC] ;
    
    self.ada = ada ;
    
    Person * marion = [Person createPersonWithName:@"Marion"
                                    withBirthYear:1979
                                           isMale:NO
                                           forMOC:self.theMOC] ;
    
    Person * claude = [Person createPersonWithName:@"Claude"
                                    withBirthYear:1949
                                           isMale:YES
                                           forMOC:self.theMOC] ;
    
    Person * chantal = [Person createPersonWithName:@"Chantal"
                                    withBirthYear:1948
                                           isMale:NO
                                           forMOC:self.theMOC] ;
    
    Person * aurelien = [Person createPersonWithName:@"Aurélien"
                                    withBirthYear:1979
                                           isMale:YES
                                           forMOC:self.theMOC] ;
    
    Person * jpouille = [Person createPersonWithName:@"JPouille"
                                    withBirthYear:1981
                                           isMale:YES
                                           forMOC:self.theMOC] ;
    
    Person * galia = [Person createPersonWithName:@"Galia"
                                    withBirthYear:0
                                           isMale:NO
                                           forMOC:self.theMOC] ;
    
    Person * dominique = [Person createPersonWithName:@"Dominique"
                                    withBirthYear:0
                                           isMale:YES
                                           forMOC:self.theMOC] ;

    Person * laetitia = [Person createPersonWithName:@"Laetitia"
                                    withBirthYear:0
                                           isMale:NO
                                           forMOC:self.theMOC] ;
    
    
    
    /*
     Pets
     */
    
    Pet * jojo = [Pet createEntityWithName:@"Jojo"
                                  forMOC:self.theMOC] ;
    
    Pet * blacky = [Pet createEntityWithName:@"Blacky"
                                    forMOC:self.theMOC] ;
    
    
    /*
     Liens gens-pets
     */
    [colas addPetsObject:jojo] ;
    [galia addPetsObject:blacky] ;
    
    
    /*
     Familles
     */
    
    Family * bardavid = [Family createEntityWithName:@"Bardavid"
                                              forMOC:self.theMOC] ;
    
    Family * chevillard = [Family createEntityWithName:@"Chevillard"
                                              forMOC:self.theMOC] ;
    
    Family * ackerman = [Family createEntityWithName:@"Ackerman"
                                              forMOC:self.theMOC] ;
    
    Family * martinou = [Family createEntityWithName:@"Martinou"
                                              forMOC:self.theMOC] ;
    
    Family * bruneton = [Family createEntityWithName:@"Bruneton"
                                              forMOC:self.theMOC] ;
    
    Family * zecchini = [Family createEntityWithName:@"Zecchini"
                                              forMOC:self.theMOC] ;
    
    Family * paini = [Family createEntityWithName:@"Païni"
                                            forMOC:self.theMOC] ;
    
    
    /*
     Lien entre personnes/pets et famille
     */
    
    colas.family = bardavid ;
    marion.family = bardavid ;
    claude.family = bardavid ;
    jojo.family = bardavid ;
    
    chantal.family = chevillard ;
    
    ada.family = ackerman ;
    galia.family = ackerman ;
    blacky.family = ackerman ;
    
    jpouille.family = bruneton ;
    
    aurelien.family = martinou ;
    
    laetitia.family = zecchini ;
    
    dominique.family = paini ;
    
    
    /*
     Villes
     */
    City * paris = [City createEntityWithName:@"Paris"
                                       forMOC:self.theMOC] ;
    
    City * rennes = [City createEntityWithName:@"Rennes"
                                       forMOC:self.theMOC] ;
    
    City * nyc = [City createEntityWithName:@"New York"
                                       forMOC:self.theMOC] ;
    
    City * bruxelles = [City createEntityWithName:@"Bruxelles"
                                       forMOC:self.theMOC] ;
    
    City * lille = [City createEntityWithName:@"Lille"
                                       forMOC:self.theMOC] ;
    
    City * moscou = [City createEntityWithName:@"Moscou"
                                       forMOC:self.theMOC] ;
    
    City * ivry = [City createEntityWithName:@"Ivry"
                                        forMOC:self.theMOC] ;
    
    /*
     Lien entre les villes et les gens
     */
    
    NSArray * parisian = @[colas,
                           ada,
                           claude,
                           chantal,
                           marion,
                           galia,
                           dominique,
                           jpouille,
                           laetitia] ;
    
    for (Person* person in parisian)
    {
        person.city = paris ;
    }
    
    aurelien.city = bruxelles ;
    
    
    /*
     Villes préférées
     */
    
    [colas addPreferedCitiesObject:rennes] ;
    [colas addPreferedCitiesObject:bruxelles] ;
    [colas addPreferedCitiesObject:nyc] ;
    [colas addPreferedCitiesObject:lille] ;
    [colas addPreferedCitiesObject:paris] ;
    [colas addPreferedCitiesObject:moscou] ;
    
    [ada addPreferedCitiesObject:nyc] ;
    [ada addPreferedCitiesObject:paris] ;
    [ada addPreferedCitiesObject:rennes] ;
    [ada addPreferedCitiesObject:moscou] ;
    
    [aurelien addPreferedCitiesObject:bruxelles] ;
    [aurelien addPreferedCitiesObject:rennes] ;
    
    [marion addPreferedCitiesObject:lille] ;
    [marion addPreferedCitiesObject:rennes] ;
    [marion addPreferedCitiesObject:paris] ;

    [laetitia addPreferedCitiesObject:nyc] ;
    [laetitia addPreferedCitiesObject:paris] ;
    
    [galia addPreferedCitiesObject:moscou] ;
    [galia addPreferedCitiesObject:paris] ;
    
    [claude addPreferedCitiesObject:paris] ;
    [chantal addPreferedCitiesObject:paris] ;


    
    /*
     Entreprises
     */
    
    Company * poleEmploi = [Company createEntityWithName:@"Pôle Emploi"
                                                  forMOC:self.theMOC] ;
    
    Company * independant = [Company createEntityWithName:@"Indépendant"
                                                  forMOC:self.theMOC] ;
    
    Company * cnrs = [Company createEntityWithName:@"CNRS"
                                                  forMOC:self.theMOC] ;
    
    Company * retraite = [Company createEntityWithName:@"Retraite"
                                                  forMOC:self.theMOC] ;
    
    Company * université = [Company createEntityWithName:@"Université"
                                                  forMOC:self.theMOC] ;

    
    Company * bibli = [Company createEntityWithName:@"Bibliothèque"
                                                  forMOC:self.theMOC] ;
    
    
    Company * educNat = [Company createEntityWithName:@"Éducation Nationale"
                                                  forMOC:self.theMOC] ;
    
    
    /*
     Lien company - villes
     */
    
    cnrs.city = ivry ;
    université.city = paris ;
    bibli.city = bruxelles ;
    educNat.city = paris ;
    
    
    

/*
 Lien Entreprise-gens
 */
    
    colas.company = poleEmploi ;
    
    claude.company = independant ;
    dominique.company = independant ;
    
    chantal.company = retraite ;
    
    marion.company = educNat ;
    
    jpouille.company = université ;

    aurelien.company = bibli ;
    
    ada.company = cnrs ;
    laetitia.company = cnrs ;
    
    galia.company = independant ;
    
    /*
     Collegues
     */
    [ada addColleaguesObject:dominique] ;
    [ada addColleaguesObject:laetitia] ;
    [galia addColleaguesObject:claude] ;
    [colas addColleaguesObject:jpouille] ;
    
    /*
     Amis
     */
    [colas addFriendsObject:ada] ;
    [colas addFriendsObject:jpouille] ;
    [colas addFriendsObject:aurelien] ;

    [ada addFriendsObject:colas] ;
    [ada addFriendsObject:aurelien] ;
    [ada addFriendsObject:laetitia] ;
    [ada addFriendsObject:jpouille] ;
    [ada addFriendsObject:marion] ;
    
    [marion addFriendsObject:aurelien] ;
    [marion addFriendsObject:ada] ;

    [aurelien addFriendsObject:colas] ;
    [aurelien addFriendsObject:ada] ;
    [aurelien addFriendsObject:jpouille] ;
    [aurelien addFriendsObject:marion] ;

    [jpouille addFriendsObject:colas] ;
    [jpouille addFriendsObject:aurelien] ;
    
    [laetitia addFriendsObject:ada] ;
    [dominique addFriendsObject:ada] ;



    
    NSLog(@"Fetching des personnes");
    
    NSArray * result = [Person allInMOC:self.theMOC
                         orderedBy_cbd_:@"name"] ;
    
    NSLog(@"%@", result) ;
    
}


















@end
