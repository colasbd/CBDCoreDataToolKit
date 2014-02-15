//
//  NSEntityDescription+CBDMiscMethods.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//
#import <CoreData/CoreData.h>
#import "NSEntityDescription+CBDMiscMethods.h"


NSString* const CBDKeyDescriptionAttribute = @"CBDKeyDescriptionAttribute";
NSString* const CBDKeyDescriptionToOneRelationship = @"CBDKeyDescriptionToOneRelationship";
NSString* const CBDKeyDescriptionToManyNonOrderedRelationship = @"CBDKeyDescriptionToManyNonOrderedRelationship";
NSString* const CBDKeyDescriptionToManyOrderedRelationship = @"CBDKeyDescriptionToManyOrderedRelationship" ;
NSString* const CBDKeyUnmatchedKey = @"CBDKeyUnmatchedKey" ;





@implementation NSEntityDescription (CBDMiscMethods)


//
//
/**************************************/
#pragma mark - Classifying properties
/**************************************/

- (NSDictionary *)dispatchedAttributesAndRelationshipsFrom_cbd_:(NSArray *)namesOfAttributesOrRelationships
{
    NSMutableArray * arrayAttributes = [@[] mutableCopy] ;
    NSMutableArray * arrayToOneRelationships = [@[] mutableCopy] ;
    NSMutableArray * arrayNonOrderedToManyRelationships = [@[] mutableCopy] ;
    NSMutableArray * arrayOrderedToManyRelationships = [@[] mutableCopy] ;
    NSMutableArray * arrayExcludedKeys = [@[] mutableCopy] ;
    
    NSDictionary * dicoRelationships = self.relationshipsByName ;
    NSDictionary * dicoAttributes = self.attributesByName ;
    
    for (NSString * nameAttributeOrRelationship in namesOfAttributesOrRelationships)
    {
        if ([[dicoAttributes allKeys] containsObject:nameAttributeOrRelationship])
        {
            [arrayAttributes addObject:nameAttributeOrRelationship] ;
        }
        else if ([[dicoRelationships allKeys] containsObject:nameAttributeOrRelationship])
        {
            NSRelationshipDescription * theCurrentRelationship ;
            theCurrentRelationship = dicoRelationships[nameAttributeOrRelationship] ;
            
            if (theCurrentRelationship.isToMany)
            {
                if (theCurrentRelationship.isOrdered)
                {
                    [arrayOrderedToManyRelationships addObject:nameAttributeOrRelationship] ;
                }
                else
                {
                    [arrayNonOrderedToManyRelationships addObject:nameAttributeOrRelationship] ;
                }
            }
            else
            {
                [arrayToOneRelationships addObject:nameAttributeOrRelationship] ;
            }
        }
        else
        {
            [arrayExcludedKeys addObject:nameAttributeOrRelationship] ;
        }
    }
    
    
    /*
     NSString* const CBDKeyDescriptionAttribute = @"attributes";
     NSString* const CBDKeyDescriptionToOneRelationship = @"toOneRelationships";
     NSString* const CBDKeyDescriptionToManyNonOrderedRelationship = @"toManyNonOrderedRelationships";
     NSString* const CBDKeyDescriptionToManyOrderedRelationship = @"toManyOrderedRelationship" ;
     NSString* const CBDKeyUnmatchedKey = @"unmatchedKey" ;
     */
    return @{CBDKeyDescriptionAttribute : arrayAttributes,
             CBDKeyDescriptionToOneRelationship : arrayToOneRelationships,
             CBDKeyDescriptionToManyNonOrderedRelationship : arrayNonOrderedToManyRelationships,
             CBDKeyDescriptionToManyOrderedRelationship : arrayOrderedToManyRelationships,
             CBDKeyUnmatchedKey : arrayExcludedKeys} ;
}




- (NSDictionary *)dispatchedRelationshipsFrom_cbd_:(NSSet *)setOfRelationshipDescriptions
{
    NSDictionary * dico = [self dispatchedAttributesAndRelationshipsFrom_cbd_:[[setOfRelationshipDescriptions allObjects] valueForKey:@"name" ]] ;
    
    return @{CBDKeyDescriptionToOneRelationship :
                 [self __relationshipsFromTheirNames_cbd_:dico[CBDKeyDescriptionToOneRelationship]],
             
             CBDKeyDescriptionToManyNonOrderedRelationship :
                 [self __relationshipsFromTheirNames_cbd_:dico[CBDKeyDescriptionToManyNonOrderedRelationship]],
             
             CBDKeyDescriptionToManyOrderedRelationship :
                 [self __relationshipsFromTheirNames_cbd_:dico[CBDKeyDescriptionToManyOrderedRelationship]],
             
             CBDKeyUnmatchedKey :
                 dico[CBDKeyUnmatchedKey]} ;
}


- (NSSet *)__relationshipsFromTheirNames_cbd_:(NSArray *)arrayOfNames
{
    NSMutableArray * result = [[NSMutableArray alloc] init] ;
    
    for (NSString * name in arrayOfNames)
    {
        NSRelationshipDescription * relation = self.relationshipsByName[name] ;
        
        if (relation)
        {
            [result addObject:self.relationshipsByName[name]] ;
        }
    }
    
    return [NSSet setWithArray:result] ;
}


- (NSDictionary *)dispatchedRelationships_cbd_
{
    return [self dispatchedRelationshipsFrom_cbd_:[NSSet setWithArray:[self.relationshipsByName allKeys]]] ;
}


//
//
/**************************************/
#pragma mark - Comparing entities
/**************************************/


- (BOOL)isKindOfEntityWithName_cbd_:(NSString *)nameEntity
{    
    NSEntityDescription * entity = self.managedObjectModel.entitiesByName[nameEntity] ;
    
    return [self isKindOfEntity:entity] ;
}



- (NSSet *)parentEntitiesAmong_cbd_:(NSSet *)setOfEntities
{
    NSMutableSet * result = [[NSMutableSet alloc] init] ;
    
    for (NSEntityDescription * entity in setOfEntities)
    {
        if ([self isKindOfEntity:entity])
        {
            [result addObject:entity] ;
        }
    }

    return result ;
}

- (BOOL)inheritsFromSomeEntityAmong_cbd_:(NSSet *)setOfEntities
{
    return ([[self parentEntitiesAmong_cbd_:setOfEntities] count] != 0) ;
}


@end
