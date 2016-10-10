//
//  CBDCoreDataImporter.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

//
//

#import "CBDCoreDataImporter.h"



/*
 Moteur
 */
#import "CBDCoreDataDiscriminator.h"
#import "CBDCoreDataDecisionCenter.h"


/*
 Categories
 */
#import "NSEntityDescription+CBDActiveRecord.h"
#import "NSManagedObject+CBDClone.h"
#import "NSManagedObjectContext+CBDActiveRecord.h"












@interface CBDCoreDataImporter ()


/**************************************/
#pragma mark Properties strong
/**************************************/
@property (nonatomic)BOOL shouldLog;


@property (nonatomic, strong)NSMutableDictionary *cache;

@property (nonatomic, strong, readwrite)CBDCoreDataDiscriminator *discriminator;

@property (nonatomic, strong, readwrite)CBDCoreDataDecisionCenter *decisionCenterForCopy;



/**************************************/
#pragma mark Properties-référence
/**************************************/
@property (nonatomic, weak)NSManagedObjectContext *sourceMOC;
@property (nonatomic, weak)NSManagedObjectContext *targetMOC;


@end














@implementation CBDCoreDataImporter


/**************************************/
#pragma mark - Initialisation methods
/**************************************/


- (instancetype)initWithDiscriminator:(CBDCoreDataDiscriminator *)discriminator
             andDecisionCenterForCopy:(CBDCoreDataDecisionCenter *)decisionCenterForCopy
                        withSourceMOC:(NSManagedObjectContext *)sourceMOC
                            targetMOC:(NSManagedObjectContext *)targetMOC
{
    self = [super init];
    
    if (self)
    {
        _shouldLog = NO;
        _cache = [[NSMutableDictionary alloc] init];
        _sourceMOC = sourceMOC;
        _targetMOC = targetMOC;
        _decisionCenterForCopy = decisionCenterForCopy;
        _discriminator = discriminator;
    }
    
    return self;
}



- (instancetype)initWithDecisionCenterForDiscrimination:(CBDCoreDataDecisionCenter *)decisionCenterForDescriminating
                              withDecisionCenterForCopy:(CBDCoreDataDecisionCenter *)decisionCenterForCopying
                                          withSourceMOC:(NSManagedObjectContext *)sourceMOC
                                              targetMOC:(NSManagedObjectContext *)targetMOC
{
    CBDCoreDataDiscriminator *newDiscriminator;
    newDiscriminator = [[CBDCoreDataDiscriminator alloc] initWithDecisionCenter:decisionCenterForDescriminating];
    self.discriminator = newDiscriminator;
    
    return [self   initWithDiscriminator:newDiscriminator
                andDecisionCenterForCopy:decisionCenterForCopying
                           withSourceMOC:sourceMOC
                               targetMOC:targetMOC];
}




- (instancetype)initWithSourceMOC:(NSManagedObjectContext *)sourceMOC
                        targetMOC:(NSManagedObjectContext *)targetMOC
{
    CBDCoreDataDecisionCenter *centerForCopy;
    CBDCoreDataDecisionCenter *centerForDiscriminating;
    
    centerForCopy = [[CBDCoreDataDecisionCenter alloc] initWithDemandingType];
    centerForDiscriminating = [[CBDCoreDataDecisionCenter alloc] initWithSemiFacilitatingType];
    
    return [[CBDCoreDataImporter alloc] initWithDecisionCenterForDiscrimination:centerForDiscriminating
                                                      withDecisionCenterForCopy:centerForCopy
                                                                  withSourceMOC:sourceMOC
                                                                      targetMOC:targetMOC];
}







//
//
/**************************************/
#pragma mark - Managing the cache
/**************************************/


- (void)flushTheCache
{
    self.cache = [[NSMutableDictionary alloc] init];
}





//
//
/**************************************/
#pragma mark - Loggin
/**************************************/



- (void)shouldLog:(BOOL)shouldLog
          deepLog:(BOOL)deepLog
{
    self.shouldLog = shouldLog;
    [self.discriminator shouldLog:deepLog];
}




//
//
/**************************************/
#pragma mark - Import : core method
/**************************************/





- (NSManagedObject *) import:(NSManagedObject *)objectToImport
{
    if (self.shouldLog)
    {
        NSLog(@"Importing %@", objectToImport);
    }
    /*
     We exclude the nil case
     */
    if (!objectToImport)
    {
        return nil;
    }
    
    
    
    /*
     First : we look in the cache
     */
    
    if ([[self.cache allKeys] containsObject:objectToImport.objectID])
    {
        if (self.shouldLog)
        {
            NSLog(@"Object already in the cache.");
        }
        return self.cache[objectToImport.objectID];
    }
    
    
    
    NSEntityDescription *entity = objectToImport.entity;

    
    
    /*
     We test if the object is ALREADY in the targetMOC
     (modulo similarity)
     */
    NSManagedObject *firstSimilarObject = [self.discriminator firstSimilarObjectTo:objectToImport
                                                                              inMOC:self.targetMOC];
    
    if (firstSimilarObject)
    {
        if (self.shouldLog)
        {
            NSLog(@"No need to import, there is a similar object in the targetMOC.");
        }
        
        /*
         We cache it
         */
        self.cache[objectToImport.objectID] = firstSimilarObject;
        return firstSimilarObject;
    }
    
    
    
    /*
     ELSE : we create it
     and we had it to the cache
     */
    NSManagedObject *objectImported = [entity createInMOC_cbd_:self.targetMOC];
    self.cache[objectToImport.objectID] = objectImported;
    
    
    NSMutableArray *attributesToInclude = [[[self.decisionCenterForCopy attributesFor:entity] allObjects] mutableCopy];
    
    /*
     First : we deal with the attributes
     */
    [objectImported fillInAttributesFrom:objectToImport
                     onlyAttributes_cbd_:attributesToInclude];
    
    if (self.shouldLog)
    {
        NSLog(@"Creation of a new object %@ in the target MOC for the import.", objectImported);
    }
    
    
    /*
     Second, we deal with Relationships
     */
    for (NSRelationshipDescription *relation in [self.decisionCenterForCopy relationshipsFor:entity])
    {
        if (![self.decisionCenterForCopy shouldIgnore:relation.destinationEntity])
        {
            if (!relation.isToMany)
            {
                /*
                 To-one relationships
                 */
                [objectImported setValue:[self import:[objectToImport valueForKey:relation.name]]
                                  forKey:relation.name];
            }
            else if (!relation.isOrdered)
            {
                /*
                 To-many non-ordered relationships
                 */
                NSMutableSet *newSet = [[NSMutableSet alloc] init];
                
                for (NSManagedObject *obj in [objectToImport valueForKey:relation.name])
                {
                    [newSet addObject:[self import:obj]];
                }
                
                [objectImported setValue:newSet
                                  forKey:relation.name];
                
            }
            else
            {
                /*
                 To-many ordered relationships
                 */
                
                NSMutableOrderedSet *newSet = [[NSMutableOrderedSet alloc] init];
                
                for (NSManagedObject *obj in [objectToImport valueForKey:relation.name])
                {
                    [newSet addObject:[self import:obj]];
                }
                
                [objectImported setValue:newSet
                                  forKey:relation.name];
            }
        }
    }
    
    return objectImported;
}



@end
