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

- (id)copy
{
    CBDCoreDataDecisionCenter * newCenter = [[CBDCoreDataDecisionCenter alloc] initWithType:self.decisionType] ;
    
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





- (CBDCoreDataDecisionUnit *)defaultDiscriminationUnitFor:(NSEntityDescription *)entity
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
NSString * const   CBDCoreDataDiscriminatorGetInfoCount = @"CBDCoreDataDiscriminatorGetInfoCount" ;



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
     The default discriminationUnit
     */
    CBDCoreDataDecisionUnit * defaultDiscriminationUnit ;
    defaultDiscriminationUnit = [self defaultDiscriminationUnitFor:entity] ;
    
    
    
    /*
     The current discriminationUnit
     */
    CBDCoreDataDecisionUnit * discriminationUnit ;
    
    
    if ([self.registeredEntities containsObject:entity])
    {
        discriminationUnit = self.decisionUnitsByEntity[entity.name] ;
    }
    else
    {
        discriminationUnit = [self defaultDiscriminationUnitFor:entity] ;
    }
    
    
    
    /*
     The info of the parent
     */
    NSDictionary * infoOfSuperentity ;
    BOOL shouldIgnoreForParent ;
    
    infoOfSuperentity = [self getInfosFor:entity.superentity] ;
    shouldIgnoreForParent = [infoOfSuperentity[CBDCoreDataDiscriminatorGetInfoShouldIgnore] boolValue] ;
    
    
    
    
    
    /*
     Merging the info
     */
    NSMutableSet * resultSetAttributesToInclude = [[NSMutableSet alloc] init] ;
    NSMutableSet * resultSetRelationshipsToInclude = [[NSMutableSet alloc] init] ;
    NSMutableSet * resultSetAttributesToIgnore = [[NSMutableSet alloc] init] ;
    NSMutableSet * resultSetRelationshipsToIgnore = [[NSMutableSet alloc] init] ;
    NSNumber * shouldIgnore ;
    
    
    // AttributesToInclude
    [resultSetAttributesToInclude unionSet:defaultDiscriminationUnit.nameAttributesToUse] ;
    [resultSetAttributesToInclude unionSet:infoOfSuperentity[CBDCoreDataDiscriminatorGetInfoAttributesToInclude]] ;
    
    if (!ignoreWinsOverInclude)
    {
        [resultSetAttributesToInclude minusSet:discriminationUnit.nameAttributesToIgnore] ;
    }
    [resultSetAttributesToInclude unionSet:discriminationUnit.nameAttributesToUse] ;


    
    
    // AttributesToIgnore
    [resultSetAttributesToIgnore unionSet:defaultDiscriminationUnit.nameAttributesToIgnore] ;
    [resultSetAttributesToIgnore unionSet:infoOfSuperentity[CBDCoreDataDiscriminatorGetInfoAttributesToIgnore]] ;
    
    if (ignoreWinsOverInclude)
    {
        [resultSetAttributesToIgnore minusSet:discriminationUnit.nameAttributesToUse] ;
    }
    [resultSetAttributesToIgnore unionSet:discriminationUnit.nameAttributesToIgnore] ;
    

    
    
    // RelatioshipsToInclude
    [resultSetRelationshipsToInclude unionSet:defaultDiscriminationUnit.relationshipDescriptionsToUse] ;
    [resultSetRelationshipsToInclude unionSet:infoOfSuperentity[CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude]] ;
    
    if (!ignoreWinsOverInclude)
    {
        [resultSetRelationshipsToInclude minusSet:discriminationUnit.relationshipDescriptionsToIgnore] ;
    }
    [resultSetRelationshipsToInclude unionSet:discriminationUnit.relationshipDescriptionsToUse] ;

    
    // RelatioshipsToIgnore
    [resultSetRelationshipsToIgnore unionSet:defaultDiscriminationUnit.relationshipDescriptionsToIgnore] ;
    [resultSetRelationshipsToIgnore unionSet:infoOfSuperentity[CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore]] ;
    
    if (ignoreWinsOverInclude)
    {
        [resultSetRelationshipsToIgnore minusSet:discriminationUnit.relationshipDescriptionsToUse] ;
    }
    [resultSetRelationshipsToIgnore unionSet:discriminationUnit.relationshipDescriptionsToIgnore] ;
    
    
    
    // ShouldIgnore
    if (discriminationUnit.shouldBeIgnored)
    {
        shouldIgnore = @YES ;
    }
    else
    {
        shouldIgnore = @(shouldIgnoreForParent) ;
    }
    
    
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
    
    

    
    return @{CBDCoreDataDiscriminatorGetInfoAttributesToInclude : resultSetAttributesToInclude,
             CBDCoreDataDiscriminatorGetInfoRelationshipsToInclude : resultSetRelationshipsToInclude,
             CBDCoreDataDiscriminatorGetInfoAttributesToIgnore : resultSetAttributesToIgnore,
             CBDCoreDataDiscriminatorGetInfoRelationshipsToIgnore : resultSetRelationshipsToIgnore,
             CBDCoreDataDiscriminatorGetInfoShouldIgnore : shouldIgnore,
             } ;
    
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
