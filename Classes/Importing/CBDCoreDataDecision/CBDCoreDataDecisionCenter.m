// Template created By Colas Bardavid
// Copyright (c) 2014 Colas. All rights reserved.
//
//  CBDCoreDataDecisionCenter.m
//  Pods
//
//  Created by Colas on 17/02/2014.
//
//

//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPORTS
/**************************************/
#import "CBDCoreDataDecisionCenter.h"
#import "CBDCoreDataDecisionUnit.h"









/**********************************************************************
 **********************************************************************
 *****************           PARAMETERS            ********************
 **********************************************************************
 **********************************************************************/


/*
 If there is a conflict (a key is asked to be included and ignored), ignore wins if this BOOL is YES
 */
const BOOL ignoreWinsOverInclude = YES ;



/**********************************************************************
 **********************************************************************/









//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - PRIVATE HEADER
/**************************************/
@interface CBDCoreDataDecisionCenter ()





@property (nonatomic, strong, readwrite)NSMutableDictionary * decisionUnitsByEntity ;

@property (nonatomic, readwrite) CBDCoreDataDecisionType decisionType ;



@end












//
//
/****************************************************************************/
/****************************************************************************/
/**************************************/
#pragma mark - IMPLEMENTATION
/**************************************/
@implementation CBDCoreDataDecisionCenter



//
//
/**************************************/
#pragma mark - Init Methods
/**************************************/


- (id)initWithType:(CBDCoreDataDecisionType)decisionType
{
    self = [super init] ;
    
    if (self)
    {
        _decisionUnitsByEntity = [[NSMutableDictionary alloc] init] ;
        _decisionType = decisionType ;
    }
    
    return self ;
}


- (id)initWithSemiFacilitatingType
{
    return [self initWithType:CBDCoreDataDecisionTypeSemiFacilitating] ;
}

- (id)initWithDemandingType
{
    return [self initWithType:CBDCoreDataDecisionTypeDemanding] ;
}

- (id)initWithFacilitatingType
{
    return [self initWithType:CBDCoreDataDecisionTypeFacilitating] ;
}

- (id)copyWithZone:(NSZone *)zone
{
    CBDCoreDataDecisionCenter * newCenter = [[CBDCoreDataDecisionCenter allocWithZone:zone] initWithType:self.decisionType] ;
    
    newCenter.decisionUnitsByEntity = self.decisionUnitsByEntity ;
    
    return newCenter ;
}

//
//
/**************************************/
#pragma mark - Managing DecisionUnits and entities
/**************************************/


- (NSArray *)decisionUnits
{
    return [self.decisionUnitsByEntity allValues] ;
}


- (NSArray *)registeredEntities
{
    return [self.decisionUnits valueForKey:@"entity"] ;
}


- (void)addDecisionUnit:(CBDCoreDataDecisionUnit *)aDecisionUnit
{
    NSEntityDescription * entity = aDecisionUnit.entity ;
    
    if (![[self.decisionUnitsByEntity allKeys] containsObject:entity.name])
    {
        self.decisionUnitsByEntity[entity.name] = aDecisionUnit ;
    }
    else
    {
        CBDCoreDataDecisionUnit * theExistingUnit = self.decisionUnitsByEntity[entity.name] ;
        
        [theExistingUnit mergeWith:aDecisionUnit] ;
    }
}





- (CBDCoreDataDecisionUnit *)defaultDecisionUnitFor:(NSEntityDescription *)entity
{
    switch (self.decisionType)
    {
        case CBDCoreDataDecisionTypeFacilitating:
        {
            return [[CBDCoreDataDecisionUnit alloc] initWithIgnoringEntity:entity] ;
            break;
        }
            
        case CBDCoreDataDecisionTypeSemiFacilitating:
        {
            return [[CBDCoreDataDecisionUnit alloc] initSemiExhaustiveFor:entity] ;
            break;
        }
            
        case CBDCoreDataDecisionTypeDemanding:
        {
            return [[CBDCoreDataDecisionUnit alloc] initExhaustiveFor:entity] ;
            break;
        }
            
        default:
            return nil ;
            break;
    }
}








- (void)removeAllDecisionUnits
{
    self.decisionUnitsByEntity = [[NSMutableDictionary alloc] init] ;
}



- (void)removeDecisionUnitFor:(NSEntityDescription *)entity
{
    [self.decisionUnitsByEntity removeObjectForKey:entity.name] ;
}





//
//
/**************************************/
#pragma mark - the DecisionUnits : how they impact the entities
/**************************************/







- (BOOL)shouldIgnore:(NSEntityDescription *)entity
{
    return [[self getInfosFor:entity][CBDCoreDataDiscriminatorGetInfoShouldIgnore] boolValue] ;
}




/*
 The keys use for the dictionnary
 */
NSString * const   CBDCoreDataDiscriminatorGetInfoAttributesToInclude = @"CBDCoreDataDiscriminatorGetInfoAttributesToInclude" ;
NSString * const   CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude = @"CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude" ;
NSString * const   CBDCoreDataDiscriminatorGetInfoAttributesToIgnore = @"CBDCoreDataDiscriminatorGetInfoAttributesToIgnore" ;
NSString * const   CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore = @"CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore" ;
NSString * const   CBDCoreDataDiscriminatorGetInfoShouldIgnore = @"CBDCoreDataDiscriminatorGetInfoShouldIgnore" ;
NSString * const   CBDCoreDataDiscriminatorGetInfoExplicitelyIncluded = @"CBDCoreDataDiscriminatorGetInfoExplicitelyIncluded" ;

NSString * const   CBDCoreDataDiscriminatorGenericInclude = @"CBDCoreDataDiscriminatorGenericInclude" ;
NSString * const   CBDCoreDataDiscriminatorGenericIgnore = @"CBDCoreDataDiscriminatorGenericIgnore" ;



/*
 This method gets the infos recursively on entity.superentity
 */
- (NSDictionary *)getInfosFor:(NSEntityDescription *)entity
{
    /*
     The nil-case
     */
    if (!entity)
    {
        return nil ;
    }
    
    
    
    /*
     The getInfos dico for the registered decisionUnit of the current entity
     */
    NSDictionary * getInfosForTheRegisteredDecisionUnit ;
    getInfosForTheRegisteredDecisionUnit = [self dicoGetInfoFrom:self.decisionUnitsByEntity[entity.name]
                                             explicitelyIncluded:YES] ;
    
    /*
     The getInfos dico for the default decisionUnit of the current entity
     */
    NSDictionary * getInfosForTheDefaultDecisionUnit ;
    getInfosForTheDefaultDecisionUnit = [self dicoGetInfoFrom:[self defaultDecisionUnitFor:entity]
                                          explicitelyIncluded:NO] ;
    
    /*
     The getInfos of the parent
     */
    NSDictionary * getInfosForSuperentity ;
    getInfosForSuperentity = [self getInfosFor:entity.superentity] ;
   
    
    
    
    
    /*
     We sort the getInfos dicos by importance
     */
    NSMutableArray * infosInImportanceOrder = [[NSMutableArray alloc] init] ;
    
    
    infosInImportanceOrder[0] = getInfosForTheRegisteredDecisionUnit?:[NSNull null] ;
    
    if ([getInfosForSuperentity[CBDCoreDataDiscriminatorGetInfoExplicitelyIncluded] boolValue])
    {
        infosInImportanceOrder[1] = getInfosForSuperentity?:[NSNull null] ;
        infosInImportanceOrder[2] = getInfosForTheDefaultDecisionUnit?:[NSNull null] ;
    }
    else
    {
        infosInImportanceOrder[1] = getInfosForTheDefaultDecisionUnit?:[NSNull null] ;
        infosInImportanceOrder[2] = getInfosForSuperentity?:[NSNull null] ;
    }
    
    
    
    
    /*
     Merging the info
     */
    NSMutableSet * resultSetAttributesToInclude = [[NSMutableSet alloc] init] ;
    NSMutableSet * resultSetRelationshipsToInclude = [[NSMutableSet alloc] init] ;
    NSMutableSet * resultSetAttributesToIgnore = [[NSMutableSet alloc] init] ;
    NSMutableSet * resultSetRelationshipsToIgnore = [[NSMutableSet alloc] init] ;
    
    
    
    /*
     Attributes and relationships
     */
    NSDictionary * result ;
    result = [self mergeArrayOfDicos:infosInImportanceOrder] ;
  
    resultSetAttributesToInclude = result[CBDCoreDataDiscriminatorGetInfoAttributesToInclude] ;
    resultSetAttributesToIgnore = result[CBDCoreDataDiscriminatorGetInfoAttributesToIgnore] ;
    
    resultSetRelationshipsToInclude = result[CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude] ;
    resultSetRelationshipsToIgnore = result[CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore] ;
    
    
    
    // Removing duplicates : elements that are both in ToInclude and ToIgnore
    if (ignoreWinsOverInclude)
    {
        [resultSetAttributesToInclude minusSet:resultSetAttributesToIgnore] ;
        [resultSetRelationshipsToInclude minusSet:resultSetRelationshipsToIgnore] ;
    }
    else
    {
        [resultSetAttributesToIgnore minusSet:resultSetAttributesToInclude] ;
        [resultSetRelationshipsToIgnore minusSet:resultSetRelationshipsToInclude] ;
    }
    
    
    /*
     Should ignore and explicitely included
     */
    BOOL explicitelyIncluded = [[self registeredEntities] containsObject:entity] ;
    BOOL shouldIgnore = ([getInfosForTheRegisteredDecisionUnit[CBDCoreDataDiscriminatorGetInfoShouldIgnore] boolValue]
                         ||
                         [getInfosForTheDefaultDecisionUnit[CBDCoreDataDiscriminatorGetInfoShouldIgnore] boolValue]
                         ||
                         [getInfosForSuperentity[CBDCoreDataDiscriminatorGetInfoShouldIgnore] boolValue]) ;

    
    return @{CBDCoreDataDiscriminatorGetInfoAttributesToInclude : resultSetAttributesToInclude,
             CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude : resultSetRelationshipsToInclude,
             CBDCoreDataDiscriminatorGetInfoAttributesToIgnore : resultSetAttributesToIgnore,
             CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore : resultSetRelationshipsToIgnore,
             CBDCoreDataDiscriminatorGetInfoShouldIgnore : @(shouldIgnore),
             CBDCoreDataDiscriminatorGetInfoExplicitelyIncluded : @(explicitelyIncluded)
             } ;
    
}





- (NSDictionary *)dicoGetInfoFrom:(CBDCoreDataDecisionUnit *)aDecisionUnit
              explicitelyIncluded:(BOOL)explicitelyIncluded
{
    if (!aDecisionUnit)
    {
        return nil ;
    }
    
    return @{CBDCoreDataDiscriminatorGetInfoAttributesToInclude : aDecisionUnit.nameAttributesToUse,
             CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude : aDecisionUnit.relationshipDescriptionsToUse,
             CBDCoreDataDiscriminatorGetInfoAttributesToIgnore : aDecisionUnit.nameAttributesToIgnore,
             CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore : aDecisionUnit.relationshipDescriptionsToIgnore,
             CBDCoreDataDiscriminatorGetInfoShouldIgnore : @(aDecisionUnit.shouldBeIgnored),
             CBDCoreDataDiscriminatorGetInfoExplicitelyIncluded : @(explicitelyIncluded)
             } ;
}



- (NSDictionary *)dicoIncludeVSIgnoreForAttributesFrom:(NSDictionary *)theGetInfoDictionnary
{
    if (!theGetInfoDictionnary)
    {
        return nil ;
    }
    
    return @{CBDCoreDataDiscriminatorGenericInclude : theGetInfoDictionnary[CBDCoreDataDiscriminatorGetInfoAttributesToInclude],
             CBDCoreDataDiscriminatorGenericIgnore : theGetInfoDictionnary[CBDCoreDataDiscriminatorGetInfoAttributesToIgnore]} ;
}



- (NSDictionary *)dicoIncludeVSIgnoreForRelationshipsFrom:(NSDictionary *)theGetInfoDictionnary
{
    if (!theGetInfoDictionnary)
    {
        return nil ;
    }
    
    return @{CBDCoreDataDiscriminatorGenericInclude : theGetInfoDictionnary[CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude],
             CBDCoreDataDiscriminatorGenericIgnore : theGetInfoDictionnary[CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore]} ;
}



- (NSDictionary *)mergeAttributesAndRelationshipsFromMaster:(NSDictionary *)masterInfo
                                                   andSlave:(NSDictionary *)slaveInfo
{
    NSDictionary * mergingAttributes = [self mergeTheIncludeVSIgnoreFromMaster:[self dicoIncludeVSIgnoreForAttributesFrom:masterInfo]
                                                                      andSlave:[self dicoIncludeVSIgnoreForAttributesFrom:slaveInfo]] ;
    
    NSDictionary * mergingRelationships = [self mergeTheIncludeVSIgnoreFromMaster:[self dicoIncludeVSIgnoreForRelationshipsFrom:masterInfo]
                                                                      andSlave:[self dicoIncludeVSIgnoreForRelationshipsFrom:slaveInfo]] ;
    
    return @{CBDCoreDataDiscriminatorGetInfoAttributesToInclude : mergingAttributes[CBDCoreDataDiscriminatorGenericInclude],
             CBDCoreDataDiscriminatorGetInfoAttributesToIgnore : mergingAttributes[CBDCoreDataDiscriminatorGenericIgnore],
             CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude : mergingRelationships[CBDCoreDataDiscriminatorGenericInclude],
             CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore : mergingRelationships[CBDCoreDataDiscriminatorGenericIgnore]} ;
}




- (NSDictionary *)mergeTheIncludeVSIgnoreFromMaster:(NSDictionary *)masterInfo
                                           andSlave:(NSDictionary *)slaveInfo
{
    NSSet * masterInclude = [NSSet setWithSet:masterInfo[CBDCoreDataDiscriminatorGenericInclude]] ;
    NSSet * masterIgnore = [NSSet setWithSet:masterInfo[CBDCoreDataDiscriminatorGenericIgnore]] ;

    NSSet * slaveInclude = [NSSet setWithSet:slaveInfo[CBDCoreDataDiscriminatorGenericInclude]] ;
    NSSet * slaveIgnore = [NSSet setWithSet:slaveInfo[CBDCoreDataDiscriminatorGenericIgnore]] ;
    
    NSMutableSet * resultInclude  ;
    NSMutableSet * resultIgnore ;
    
    NSMutableSet * auxSet ;
    
    resultInclude = [NSMutableSet setWithSet:masterInclude] ;
    auxSet = [NSMutableSet setWithSet:slaveInclude] ;
    [auxSet minusSet:masterIgnore] ;
    [resultInclude unionSet:auxSet] ;
    
    resultIgnore = [NSMutableSet setWithSet:masterIgnore] ;
    auxSet = [NSMutableSet setWithSet:slaveIgnore] ;
    [auxSet minusSet:masterInclude] ;
    [resultIgnore unionSet:auxSet] ;
    
    return @{CBDCoreDataDiscriminatorGenericInclude : resultInclude,
             CBDCoreDataDiscriminatorGenericIgnore : resultIgnore} ;
}





- (NSDictionary *)mergeArrayOfDicos:(NSArray *)arrayOfDicos
{
    NSDictionary * result ;
    
    NSUInteger nb = [arrayOfDicos count] ;
    
    if (nb == 0)
    {
        return nil ;
    }
    
    result = (arrayOfDicos[0] != [NSNull null])?arrayOfDicos[0]:nil ;
    
    if (nb > 0)
    {
        for (int i = 1 ; i < nb ; i++)
        {
            result = [self mergeAttributesAndRelationshipsFromMaster:result
                                                            andSlave:(arrayOfDicos[i] != [NSNull null])?arrayOfDicos[i]:nil] ;
        }
    }
    
    return result ;
}




- (NSSet *)attributesFor:(NSEntityDescription *)entity
{
    return [self getInfosFor:entity][CBDCoreDataDiscriminatorGetInfoAttributesToInclude] ;
}


- (NSSet *)relationshipsFor:(NSEntityDescription *)entity ;
{
    return [self getInfosFor:entity][CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude] ;
}








@end
