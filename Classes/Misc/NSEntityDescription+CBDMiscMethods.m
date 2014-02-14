//
//  NSEntityDescription+CBDMiscMethods.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//
#import <CoreData/CoreData.h>
#import "NSEntityDescription+CBDMiscMethods.h"


NSString* const CBDKeyDescriptionAttribute = @"attributes";
NSString* const CBDKeyDescriptionToOneRelationship = @"toOneRelationships";
NSString* const CBDKeyDescriptionToManyNonOrderedRelationship = @"toManyNonOrderedRelationships";
NSString* const CBDKeyDescriptionToManyOrderedRelationship = @"toManyOrderedRelationship" ;
NSString* const CBDKeyUnmatchedKey = @"unmatchedKey" ;

@implementation NSEntityDescription (CBDMiscMethods)


//
//
/**************************************/
#pragma mark - Classifying properties
/**************************************/

- (NSDictionary *)classifyAttributesAndRelationships_cbd_:(NSArray *)namesOfAttributesOrRelationships
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
