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

#import "EntityA.h"
#import "EntityB.h"
#import "EntitySelf.h"
#import "Entity1.h"
#import "Entity2.h"
#import "Entity3.h"
#import "EntityAlpha.h"
#import "EntityBeta.h"
#import "EntityGamma.h"

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
    DDLogVerbose(@"Suppressions des anciennes données");
    for (NSManagedObject * obj in [self.theMOC allObjects_cbd_])
    {
        [obj remove_cbd_] ;
    }
    [self.theMOC processPendingChanges] ;
    [self.theMOC save:NULL] ;
}



- (void)createTheDataWithGuilhem:(BOOL)withGuilhem
{
    [self deleteOldData] ;
    
    DDLogVerbose(@"Création des données");
    
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



    
    DDLogVerbose(@"Fetching des personnes");
    
    NSArray * result = [Person allInMOC:self.theMOC
                         orderedBy_cbd_:@"name"] ;
    
    DDLogVerbose(@"%@", result) ;
    
    
    
    
    /*
     Creation of the weird data
     */
    [self createTheWeirdData] ;
    
    
    
    
    /*
     Guilhem
     */
    if (withGuilhem)
    {
        Person * guilhem = [Person createPersonWithName:@"Guilhem"
                                          withBirthYear:1984
                                                 isMale:YES
                                                 forMOC:self.theMOC] ;
        
        City * enVoyage = [City createEntityWithName:@"En voyage"
                                              forMOC:self.theMOC] ;
        
        Company * anar = [Company createEntityWithName:@"Révolutionnaire"
                                                forMOC:self.theMOC] ;

        Family * lattes = [Family createEntityWithName:@"Lattès"
                                                forMOC:self.theMOC] ;
        
        guilhem.family = lattes ;
        
        [guilhem addFriendsObject:colas] ;
        [guilhem addFriendsObject:aurelien] ;
        [guilhem addFriendsObject:ada] ;

        [guilhem addColleaguesObject:colas] ;

        
        guilhem.city = enVoyage ;
        
        
        [guilhem addPreferedCitiesObject:rennes] ;
        guilhem.company = anar ;

        
        anar.city = rennes ;
        
        [enVoyage addLoversObject:colas] ;
        [enVoyage addLoversObject:ada] ;
        [enVoyage addLoversObject:aurelien] ;


        
        self.guilhem = guilhem  ;
    }
    
}







- (void)createTheWeirdData
{
    /*
     Entity A
     */
    EntityA * objectA = [EntityA insertInManagedObjectContext:self.theMOC] ;
    EntityB * objectB = [EntityB insertInManagedObjectContext:self.theMOC] ;

    objectA.objectB = objectB ;
    
    self.objectA = objectA ;
    
    
    /*
     Entity Self
     */
    EntitySelf * objectSelf = [EntitySelf insertInManagedObjectContext:self.theMOC];
    objectSelf.objectSelf = objectSelf ;
    
    self.objectSelf = objectSelf ;
    
    
    /*
     Entity 1
     */
    Entity1 * object1 = [Entity1 insertInManagedObjectContext:self.theMOC];
    Entity2 * object2 = [Entity2 insertInManagedObjectContext:self.theMOC];
    Entity3 * object3 = [Entity3 insertInManagedObjectContext:self.theMOC];

    object1.toObject2 = object2 ;
    object2.toObject3 = object3 ;
    object3.toObject1 = object1 ;
    
    self.object1 = object1 ;
    
    
    /*
     Entity Alpha
     */
    EntityAlpha * objectAlpha1 = [EntityAlpha insertInManagedObjectContext:self.theMOC];
    EntityAlpha * objectAlpha2 = [EntityAlpha insertInManagedObjectContext:self.theMOC];
    EntityAlpha * objectAlpha3 = [EntityAlpha insertInManagedObjectContext:self.theMOC];
    
    objectAlpha1.name = @"1" ;
    objectAlpha2.name = @"2" ;
    objectAlpha3.name = @"3" ;

    
    [objectAlpha1 addFriendsObject:objectAlpha2] ;
    [objectAlpha1 addFriendsObject:objectAlpha3] ;
    [objectAlpha2 addFriendsObject:objectAlpha3] ;
    [objectAlpha3 addFriendsObject:objectAlpha3] ;
    
    
    EntityBeta * objectBeta1 = [EntityBeta insertInManagedObjectContext:self.theMOC];
    EntityBeta * objectBeta2 = [EntityBeta insertInManagedObjectContext:self.theMOC];
    EntityBeta * objectBeta3 = [EntityBeta insertInManagedObjectContext:self.theMOC];
    EntityBeta * objectBeta4 = [EntityBeta insertInManagedObjectContext:self.theMOC];

    objectBeta1.name = @"1" ;
    objectBeta2.name = @"2" ;
    objectBeta3.name = @"3" ;
    objectBeta4.name = @"4" ;

    
    [objectAlpha1 addToBetasObject:objectBeta1];
    [objectAlpha1 addToBetasObject:objectBeta2];
    [objectAlpha1 addToBetasObject:objectBeta3];
    
    [objectAlpha2 addToBetasObject:objectBeta4];


    EntityGamma * objectGamma1 = [EntityGamma insertInManagedObjectContext:self.theMOC];
    EntityGamma * objectGamma2 = [EntityGamma insertInManagedObjectContext:self.theMOC];
    EntityGamma * objectGamma3 = [EntityGamma insertInManagedObjectContext:self.theMOC];
    EntityGamma * objectGamma4 = [EntityGamma insertInManagedObjectContext:self.theMOC];
    
    objectGamma1.name = @"1" ;
    objectGamma2.name = @"2" ;
    objectGamma3.name = @"3" ;
    objectGamma4.name = @"4" ;
    
    [objectBeta1 addToGammasObject:objectGamma1] ;
    [objectBeta1 addToGammasObject:objectGamma2] ;

    [objectBeta2 addToGammasObject:objectGamma2] ;
    [objectBeta2 addToGammasObject:objectGamma4] ;
    [objectBeta2 addToGammasObject:objectGamma3] ;
    
    [objectBeta3 addToGammasObject:objectGamma3] ;
    
    [objectBeta4 addToGammasObject:objectGamma1] ;
    
    [objectGamma1 addToAlphasObject:objectAlpha1] ;
    [objectGamma1 addToAlphasObject:objectAlpha2] ;
    [objectGamma1 addToAlphasObject:objectAlpha3] ;
    
    
    [objectGamma2 addToAlphasObject:objectAlpha1] ;

    
    [objectGamma3 addToAlphasObject:objectAlpha3] ;
    [objectGamma3 addToAlphasObject:objectAlpha2] ;
    
    [objectGamma4 addToAlphasObject:objectAlpha1] ;

    self.objectAlpha = objectAlpha1 ;
    self.objectAlpha_2 = objectAlpha2 ;
}










@end
