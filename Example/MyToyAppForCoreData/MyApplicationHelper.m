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
#import "Family.h"
#import "EntityA.h"
#import "EntitySelf.h"
#import "Entity1.h"
#import "EntityAlpha.h"
#import "Company.h"


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
@property (nonatomic, strong) Person *firstAda ;
@property (nonatomic, strong) Person *secondAda ;

@property (nonatomic, strong) EntityA *firstObjectA ;
@property (nonatomic, strong) EntityA *secondObjectA ;

@property (nonatomic, strong) EntitySelf *firstObjectSelf ;
@property (nonatomic, strong) EntitySelf *secondObjectSelf ;

@property (nonatomic, strong) Entity1 *firstObject1 ;
@property (nonatomic, strong) Entity1 *secondObject1 ;

@property (nonatomic, strong) EntityAlpha *firstObjectAlpha ;
@property (nonatomic, strong) EntityAlpha *secondObjectAlpha ;

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
        self.dataCreater = [[DataCreater alloc] initForMOC:self.theDelegate.managedObjectContext] ;
        
        [self.dataCreater createTheDataWithGuilhem:NO] ;
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
        DDLogVerbose(@"%@", person) ;
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
    [self.dataCreater createTheDataWithGuilhem:NO] ;
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
    
    [self.theDelegate.managedObjectContext replaceThisObject:self.dataCreater.ada
                                                byThisObject:self.doudou
                                        excludeRelationships:nil
                                           withDeleting_cbd_:YES] ;
    
    [self reloadAllDatas] ;
}


- (void)replacePartiallyAdaByDoudou
{
    [self createDoudou] ;
    
    [self.theDelegate.managedObjectContext replaceThisObject:self.dataCreater.ada
                                                byThisObject:self.doudou
                                        excludeRelationships:@[@"colleagues"]
                                           withDeleting_cbd_:NO] ;
    [self reloadAllDatas] ;
}

- (void)createDoudou
{
    if (!self.doudou)
    {
        self.doudou = [Person createPersonWithName:@"Doudou"
                                     withBirthYear:2002
                                            isMale:NO
                                            forMOC:self.theDelegate.managedObjectContext] ;
    }
    
}






//
//
/**************************************/
#pragma mark - Secondary MOC
/**************************************/

- (NSManagedObjectContext *)firstMOC
{
    return self.theDelegate.managedObjectContext ;
}


- (void)createTheSecondaryMOC
{
    /*
     Création d'un MOC associé
     */
    NSManagedObjectContext * auxMOC = [[NSManagedObjectContext alloc] init] ;
    [auxMOC setPersistentStoreCoordinator:self.theDelegate.persistentStoreCoordinator] ;
    
    self.secondaryMOC = auxMOC ;
}


- (void)testTheSecondaryMOC
{
    [self testTheSecondaryMOCWithGuilhem:NO];
}


- (void)testTheSecondaryMOCWithGuilhem:(BOOL)withGuilhem
{
    [self createTheSecondaryMOC] ;
    
    self.secondaryDataCreater = [[DataCreater alloc] initForMOC:self.secondaryMOC] ;
    [self.secondaryDataCreater createTheDataWithGuilhem:withGuilhem] ;
    
    self.firstAda = self.dataCreater.ada ;
    self.secondAda = self.secondaryDataCreater.ada ;
    
    self.firstObjectA = self.dataCreater.objectA ;
    self.secondObjectA = self.secondaryDataCreater.objectA ;
    
    self.firstObject1 = self.dataCreater.object1 ;
    self.secondObject1 = self.secondaryDataCreater.object1 ;
    
    self.firstObjectSelf = self.dataCreater.objectSelf ;
    self.secondObjectSelf = self.secondaryDataCreater.objectSelf ;
    
    self.firstObjectAlpha = self.dataCreater.objectAlpha ;
    self.secondObjectAlpha = self.secondaryDataCreater.objectAlpha ;
    
    
    DDLogDebug(@"Test d'une égalité pure. \n Ada1 = Ada2 ? %@", (self.firstAda == self.secondAda)?@"YES":@"NO");
    DDLogInfo(@"Ada 1 (%@) : %@",self.firstAda.objectID ,self.firstAda) ;
    DDLogInfo(@"Ada 2 (%@) : %@",self.secondAda.objectID ,self.secondAda) ;
    
}





//
//
/**************************************/
#pragma mark - Comparing entities
/**************************************/



- (void)compareObjects
{
    if (!self.firstAda)
    {
        [self testTheSecondaryMOCWithGuilhem:NO] ;
    }
    
    /*
     Compare the Two entities
     */
    NSEntityDescription * firstEntityPerson = [Person entityInMOC_cbd_:self.firstMOC] ;
    NSEntityDescription * secondEntityPerson = [Person entityInMOC_cbd_:self.secondaryMOC] ;
    
    DDLogDebug(@"TEST !!! firstEntityPerson = secondEntityPerson ? %@", (firstEntityPerson == secondEntityPerson)?@"YES":@"NO");
    DDLogInfo(@"%@ and %@", firstEntityPerson, secondEntityPerson) ;
    
    
    DDLogInfo(@"The attributes of Person are: %@", firstEntityPerson.attributeKeys) ;
    
    CBDCoreDataDecisionUnit * firstUnit ;
    firstUnit = [[CBDCoreDataDecisionUnit alloc] initForEntity:firstEntityPerson
                                               usingAttributes:@[@"name", @"isMale", @"birthYear"]
                                              andRelationships:@[@"family"]] ;
    
    
    NSEntityDescription * entityFamily = [Family entityInMOC_cbd_:self.firstMOC] ;
    
    
    CBDCoreDataDecisionUnit * secondUnit ;
    secondUnit = [[CBDCoreDataDecisionUnit alloc] initForEntity:entityFamily
                                                usingAttributes:@[@"name"]
                                               andRelationships:nil] ;
    
    
    
    // Cas intéressant à retester !!!
    //    CBDCoreDataDiscriminatorUnit * secondUnit ;
    //    secondUnit = [[CBDCoreDataDiscriminatorUnit alloc] initForEntity:firstEntityPerson
    //                                        withDiscriminationAttributes:@[@"name"]
    //                                     withDiscriminationRelationships:@[@"family"]] ;
    
    
    CBDCoreDataDecisionCenter * center = [[CBDCoreDataDecisionCenter alloc] initWithDemandingType] ;
    [center addDecisionUnit:firstUnit] ;
    [center addDecisionUnit:secondUnit] ;
    
    CBDCoreDataDiscriminator * myDiscriminator ;
    myDiscriminator = [[CBDCoreDataDiscriminator alloc] initWithDecisionCenter:center] ;
    

    //[myDiscriminator removeAllDiscriminatorUnits] ;
    //[myDiscriminator chooseDemandingType] ;
    
    BOOL result ;
    
    
    /*
     Comparing Ada and Doudou
     */
    DDLogWarn(@"Comparing Ada and Doudou") ;
    [self createDoudou] ;
    
    
    [myDiscriminator flushTheCache] ;
    result = [myDiscriminator isSourceObject:self.firstAda
                           similarToTargetObject:self.doudou] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for Ada and Doudou is: %@", result?@"YES":@"NO") ;
    
    
    
    //    /*
    //     Modifying Ada1
    //     */
    //    self.firstAda.isMaleValue = YES ;
    //
    //    result = [myDiscriminator isThisSourceObject:self.firstAda
    //                           similarToTargetObject:self.secondAda] ;
    //
    //    DDLogInfo(@"The result of the CBDDiscriminator for the Ada1 (male) and Ada2 is: %@", result?@"YES":@"NO") ;
    //    DDLogVerbose(@"Ada1 : %@", self.firstAda) ;
    //    DDLogVerbose(@"Ada2 : %@", self.secondAda) ;
    
    
    
    //********************** HERE
    
    
    DDLogInfo(@"We remove all the DiscriminatorUnits");
    [myDiscriminator.decisionCenter removeAllDecisionUnits] ;
    [myDiscriminator shouldLog:NO] ;
    
    
    
    
    /*
     Comparing Colas and Ada2
     */
    DDLogWarn(@"Comparing Colas and Ada2") ;
    Person * Colas = [Person firstInMOC:self.theDelegate.managedObjectContext
                              orderedBy:@"name"
               withPredicateFormat_cbd_:@"name == %@", @"Colas"] ;
    
    
    result = [myDiscriminator isSourceObject:Colas
                           similarToTargetObject:self.secondAda] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between Colas and Ada2 is: %@", result?@"YES":@"NO") ;
    
    
    
    
    
    /*
     Comparing Ada1 and Ada2
     */
    DDLogWarn(@"Comparing Ada1 and Ada2") ;
    [myDiscriminator flushTheCache] ;
    result = [myDiscriminator isSourceObject:self.firstAda
                           similarToTargetObject:self.secondAda] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between Ada1 and Ada2 is: %@", result?@"YES":@"NO") ;
    
    
    
    
    /*
     Comparing weird objects
     */
    DDLogWarn(@"Comparing weird objects") ;
    [myDiscriminator flushTheCache] ;
    result = [myDiscriminator isSourceObject:self.firstObjectA
                           similarToTargetObject:self.secondObjectA] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between ObjectA1 and ObjectA2 is: %@", result?@"YES":@"NO") ;
    
    
    
    
    [myDiscriminator flushTheCache] ;
    result = [myDiscriminator isSourceObject:self.firstObjectSelf
                           similarToTargetObject:self.secondObjectSelf] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between ObjectSelf1 and ObjectSelf2 is: %@", result?@"YES":@"NO") ;
    
    
    [myDiscriminator flushTheCache] ;
    result = [myDiscriminator isSourceObject:self.firstObject1
                           similarToTargetObject:self.secondObject1] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between Object1_1 and Object1_2 is: %@", result?@"YES":@"NO") ;
    
    
    [myDiscriminator flushTheCache] ;
    //[myDiscriminator shouldLog:YES];
    
    NSEntityDescription * entityName = [EntityWithName entityInMOC_cbd_:self.firstMOC] ;
    //    NSEntityDescription * entityAlpha = [EntityAlpha entityInMOC_cbd_:self.firstMOC] ;
    
    CBDCoreDataDecisionUnit * unit= [[CBDCoreDataDecisionUnit alloc]  initForEntity:entityName
                                                                 ignoringAttributes:@[@"name"]
                                                                   andRelationships:nil] ;
    [myDiscriminator.decisionCenter addDecisionUnit:unit] ;
    
    result = [myDiscriminator isSourceObject:self.firstObjectAlpha
                           similarToTargetObject:self.secondObjectAlpha] ;
    //    DDLogWarn(@"%@", [myDiscriminator attributesToCheckFor:entityAlpha]) ;
    //    DDLogWarn(@"%@", [myDiscriminator attributesToCheckFor:entityName]) ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between ObjectAlpha_1 and ObjectAlpha_2 is: %@", result?@"YES":@"NO") ;
    //[myDiscriminator logTheCache] ;
    
    
    [myDiscriminator.decisionCenter removeAllDecisionUnits] ;
    [myDiscriminator flushTheCache] ;
    [myDiscriminator shouldLog:NO];
    result = [myDiscriminator isSourceObject:self.firstObjectAlpha
                           similarToTargetObject:self.secondaryDataCreater.objectAlpha_2] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between ObjectAlpha_1 and ObjectAlpha2_2 is (they should be different): %@", result?@"YES":@"NO") ;
    
    
    
    
    /*
     Comparing Ada1 and Ada2 after the removal of Moscow
     */
    DDLogWarn(@"Comparing Ada1 and Ada2 after the removal of Moscow") ;
    City * moscou = [City firstInMOC:self.theDelegate.managedObjectContext
                           orderedBy:@"name"
            withPredicateFormat_cbd_:@"name == %@", @"Moscou"] ;
    
    DDLogInfo(@"%@", moscou) ;
    
    [moscou remove_cbd_] ;
    
    [myDiscriminator flushTheCache] ;
    result = [myDiscriminator isSourceObject:self.firstAda
                           similarToTargetObject:self.secondAda] ;
    
    DDLogInfo(@"The result of the CBDDiscriminator for demanding discrimination between Ada1 (sans Moscou) and Ada2 is: %@", result?@"YES":@"NO") ;
    
    
    
    
    /*
     Testing fetching the objects quasi-similar
     */
    DDLogWarn(@"Testing the predicate") ;
    
    
    DDLogWarn(@"%@",[myDiscriminator.decisionCenter attributesFor:[Person entityInMOC_cbd_:self.firstMOC]]) ;
    
    NSPredicate * myPredicate = [myDiscriminator predicateToFindObjectsVirtuallySimilarTo:self.firstAda
                                                                       withPredicateDepth:1] ;
    
    
    
    DDLogVerbose(@"The predicate is %@", myPredicate) ;
    //
    //    DDLogWarn(@"%@", [myPredicate evaluateWithObject:self.firstAda]?@"YES":@"NO") ;
    
    
    NSPredicate * longPred = [NSPredicate predicateWithFormat:@"#self.name == 'Ada' AND #self.isMale == 0 AND #self.birthYear == 1983 AND ((#self.company.name == 'CNRS' AND (#self.company.employees.@count == 2)) AND (#self.city.name == 'Paris' AND (#self.city.companies.@count == 2 AND #self.city.inhabitants.@count == 9 AND #self.city.lovers.@count == 7)) AND (#self.family.name == 'Ackerman' AND (#self.family.members.@count == 2 AND #self.family.pets.@count == 1))) AND (#self.pets.@count == 0 AND #self.colleagues.@count == 2 AND #self.peopleWhoHaveMeAsAFriend.@count == 5) AND (#self.friends.@count == 5 AND ((((self.friends)[0]).name == 'Colas' AND ((self.friends)[0]).isMale == 1 AND ((self.friends)[0]).birthYear == 1981 AND (((self.friends)[0]).pets.@count == 1 AND ((self.friends)[0]).colleagues.@count == 1 AND ((self.friends)[0]).peopleWhoHaveMeAsAFriend.@count == 3) AND (((self.friends)[0]).friends.@count == 3 AND ((self.friends)[0]).preferedCities.@count == 6)) AND (((self.friends)[1]).name == 'Aurélien' AND ((self.friends)[1]).isMale == 1 AND ((self.friends)[1]).birthYear == 1979 AND (((self.friends)[1]).pets.@count == 0 AND ((self.friends)[1]).colleagues.@count == 0 AND ((self.friends)[1]).peopleWhoHaveMeAsAFriend.@count == 4) AND (((self.friends)[1]).friends.@count == 4 AND ((self.friends)[1]).preferedCities.@count == 2)) AND (((self.friends)[2]).name == 'Laetitia' AND ((self.friends)[2]).isMale == 0 AND ((self.friends)[2]).birthYear == 0 AND (((self.friends)[2]).pets.@count == 0 AND ((self.friends)[2]).colleagues.@count == 1 AND ((self.friends)[2]).peopleWhoHaveMeAsAFriend.@count == 1) AND (((self.friends)[2]).friends.@count == 1 AND ((self.friends)[2]).preferedCities.@count == 2)) AND (((self.friends)[3]).name == 'JPouille' AND ((self.friends)[3]).isMale == 1 AND ((self.friends)[3]).birthYear == 1981 AND (((self.friends)[3]).pets.@count == 0 AND ((self.friends)[3]).colleagues.@count == 1 AND ((self.friends)[3]).peopleWhoHaveMeAsAFriend.@count == 3) AND (((self.friends)[3]).friends.@count == 2 AND ((self.friends)[3]).preferedCities.@count == 0)) AND (((self.friends)[4]).name == 'Marion' AND ((self.friends)[4]).isMale == 0 AND ((self.friends)[4]).birthYear == 1979 AND (((self.friends)[4]).pets.@count == 0 AND ((self.friends)[4]).colleagues.@count == 0 AND ((self.friends)[4]).peopleWhoHaveMeAsAFriend.@count == 2) AND (((self.friends)[4]).friends.@count == 2 AND ((self.friends)[4]).preferedCities.@count == 3))) AND #self.preferedCities.@count == 4 AND ((((self.preferedCities)[0]).name == 'New York' AND (((self.preferedCities)[0]).companies.@count == 0 AND ((self.preferedCities)[0]).inhabitants.@count == 0 AND ((self.preferedCities)[0]).lovers.@count == 3)) AND (((self.preferedCities)[1]).name == 'Paris' AND (((self.preferedCities)[1]).companies.@count == 2 AND ((self.preferedCities)[1]).inhabitants.@count == 9 AND ((self.preferedCities)[1]).lovers.@count == 7)) AND (((self.preferedCities)[2]).name == 'Rennes' AND (((self.preferedCities)[2]).companies.@count == 0 AND ((self.preferedCities)[2]).inhabitants.@count == 0 AND ((self.preferedCities)[2]).lovers.@count == 4)) AND (((self.preferedCities)[3]).name == 'Moscou' AND (((self.preferedCities)[3]).companies.@count == 0 AND ((self.preferedCities)[3]).inhabitants.@count == 0 AND ((self.preferedCities)[3]).lovers.@count == 3))))"];
    
    
    
    DDLogVerbose(@"The predicate is %@", longPred) ;
    
    DDLogWarn(@"%@", [longPred evaluateWithObject:self.firstAda]?@"YES":@"NO") ;
    
    
}






//
//
/**************************************/
#pragma mark - Create and import a new Person
/**************************************/
/// @name <#argument#>


- (void)testImport
{
    [self testTheSecondaryMOCWithGuilhem:YES] ;
    

    CBDCoreDataDecisionCenter *decisionCenterForDiscrimination = [[CBDCoreDataDecisionCenter alloc] initWithSemiFacilitatingType] ;
    
    CBDCoreDataDecisionCenter *decisionCenterForCopying = [[CBDCoreDataDecisionCenter alloc] initWithDemandingType] ;
    
    
//    
//    CBDCoreDataDecisionUnit * discriminatorUnit ;
//    discriminatorUnit = [[CBDCoreDataDecisionUnit alloc] initForEntity:[Person entityInManagedObjectContext:self.secondaryMOC]
//                                                                        usingAttributes:@[@"name", @"birthYear", @"isMale"]
//                                                                       andRelationships:nil] ;
//    
//    CBDCoreDataDecisionUnit * discriminatorUnit2 ;
//    discriminatorUnit2 = [[CBDCoreDataDecisionUnit alloc] initForEntity:[Company entityInManagedObjectContext:self.secondaryMOC]
//                                                                         usingAttributes:@[@"name"]
//                                                                        andRelationships:nil] ;
//    
//    CBDCoreDataDecisionUnit * discriminatorUnit3 ;
//    discriminatorUnit3 = [[CBDCoreDataDecisionUnit alloc] initForEntity:[City entityInManagedObjectContext:self.secondaryMOC]
//                                                                         usingAttributes:@[@"name"]
//                                                                        andRelationships:nil] ;
    
    // [discriminator addDiscriminatorUnit:discriminatorUnit] ;
    // [discriminator addDiscriminatorUnit:discriminatorUnit2] ;
    // [discriminator addDiscriminatorUnit:discriminatorUnit3] ;
    
    //[discriminator chooseSemiFacilitatingType] ;
    
    DDLogWarn(@"Personnes virtuellement similaires à Ada");
    //DDLogVerbose(@"%@", [discriminator predicateToFindObjectsVirtuallySimilarTo:self.secondAda]);
//    NSArray * aalo = [discriminator objectsVirtuallySimilarTo:self.secondAda
//                                           withPredicateDepth:0
//                                                        inMOC:self.firstMOC] ;
//    
//    Person * allo = [discriminator firstSimilarObjectTo:self.secondAda
//                                                  inMOC:self.firstMOC] ;
    
//    DDLogVerbose(@"Première personne similaire à Ada : %@", allo) ;
//    DDLogVerbose(@"%@", aalo) ;
    
    
//    CBDCoreDataImporter * importer = [[CBDCoreDataImporter alloc] initWithSourceMOC:self.secondaryMOC
//                                                                          targetMOC:self.firstMOC
//                                                                  withDiscriminator:discriminator] ;
    
    CBDCoreDataImporter * importer = [[CBDCoreDataImporter alloc] initWithDecisionCenterForDiscrimination:decisionCenterForDiscrimination
                                                                                withDecisionCenterForCopy:decisionCenterForCopying
                                                                                            withSourceMOC:self.secondaryMOC
                                                                                                targetMOC:self.firstMOC] ;
//    [importer import:self.secondAda
////  copyAlsoAttributes:nil
////copyAlsoRelationships:@[@"friends", @"company", @"city", @"family"]
////     excludeEntities:nil
//     ] ;
    
    [importer shouldLog:YES deepLog:NO] ;
    
    BOOL result = [importer.discriminator isSourceObject:self.firstAda
                         similarToTargetObject:self.secondAda] ;
    DDLogDebug(@"ALORS ? Ada1 = Ada 2 %@", BOOL_STR(result)) ;
    
    [importer import:self.secondaryDataCreater.guilhem
//  copyAlsoAttributes:nil
//copyAlsoRelationships:@[@"friends", @"company", @"city", @"family"]
//     excludeEntities:nil
     ] ;
    
    [self reloadAllDatas] ;
    
    DDLogVerbose(@"MOC 1 : %@", [Person allInMOC_cbd_:self.firstMOC]) ;
    DDLogVerbose(@"MOC 2 : %@", [Person allInMOC_cbd_:self.secondaryMOC]) ;
    
}



//
//
/**************************************/
#pragma mark - Testing Magical Record
/**************************************/



- (void)testMagicalRecord
{
    /*
     To initialize
     */
    //[MagicalRecord initialize] ;
    //[MagicalRecord class] ;
    
    
    /*
     To fetch
     */
    //NSArray * result = [Person MR_findAllInContext:self.theDelegate.managedObjectContext] ;
    
    //    DDLogDebug(@"Test of MagicalRecord");
    //    DDLogDebug(@"SO ? %@", result) ;
}











@end
