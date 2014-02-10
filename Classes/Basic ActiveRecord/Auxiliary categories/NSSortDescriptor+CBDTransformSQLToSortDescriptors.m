//
//  NSSortDescriptor+CBDTransformSQLToSortDescriptors.m
//  MyCBDCoreDataToolKit
//
//  Created by Colas on 10/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import "NSSortDescriptor+CBDTransformSQLToSortDescriptors.h"




@interface NSString (VPPCoreData)

- (NSString *) trim_vpp_cbd_;

@end

@implementation NSString (VPPCoreData)

- (NSString *) trim_vpp_cbd_
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end




typedef enum {
    CBDCoreDataSortingInvalid = -1,
    CBDCoreDataSortingAscending = 0,
    CBDCoreDataSortingDescending = 1
} CBDCoreDataSorting;





@implementation NSSortDescriptor (CBDTransformSQLToSortDescriptors)



//
//
/**************************************/
#pragma mark - Méthodes pour obtenir les sorts descriptors
/**************************************/


+ (NSArray *) sortDescriptorsFromSQLString_cbd_:(NSString *)string
{
    NSArray *components = [string componentsSeparatedByString:@","];
    
    NSArray *descriptors = [self parseComponents_cbd_:components];
    
    return descriptors;
}


+ (NSArray *) parseComponents_cbd_:(NSArray *)components
{
    NSMutableArray *descriptors = [NSMutableArray array];
    
    for (NSString *component in components)
    {
        NSSortDescriptor *descriptor = [self parseComponent_cbd_:component];
        
        if (descriptor)
        {
            [descriptors addObject:descriptor];
        }
    }
    
    return [descriptors count] > 0 ? descriptors : nil;
}


+ (NSSortDescriptor *) parseComponent_cbd_:(NSString *)component
{
    NSString *trimmedComponent = [component trim_vpp_cbd_];
    
    NSArray *parts = [trimmedComponent componentsSeparatedByString:@" "];
    
    NSString *key;
    
    NSString *ascending = nil;
    switch ([parts count]) {
        case 2:
            ascending = [parts objectAtIndex:1];
        case 1:
            key = [parts objectAtIndex:0];
            return [self sortDescriptorByKey:key
                              ascending_cbd_:ascending];
            
        default:
            return nil;
    }
}


+ (NSSortDescriptor *) sortDescriptorByKey:(NSString *)keyRaw
                            ascending_cbd_:(NSString *)ascendingString
{
    NSString *key = [keyRaw trim_vpp_cbd_];
    
    CBDCoreDataSorting sorting = [self ascendingFromString_cbd_:ascendingString];
    if (sorting == CBDCoreDataSortingInvalid) {
        return nil;
    }
    
    BOOL ascendingBool = [self boolFromSorting_cbd_:sorting];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascendingBool];
    
    return descriptor;
}





+ (CBDCoreDataSorting) ascendingFromString_cbd_:(NSString *)ascendingRaw
{
    NSString *ascending = nil;
    if (ascendingRaw)
    {
        ascending = [ascendingRaw trim_vpp_cbd_];
    }
    
    if (ascending && ![@"" isEqual:ascending]) {
        if ([@"desc" isEqualToString:ascending]
            || [@"NO" isEqualToString:ascending]) {
            return CBDCoreDataSortingDescending;
        }
        if ([@"asc" isEqualToString:ascending]
            || [@"YES" isEqualToString:ascending]) {
            return CBDCoreDataSortingAscending;
        }
        return CBDCoreDataSortingInvalid;
    }
    
    return CBDCoreDataSortingAscending;
}

+ (BOOL) boolFromSorting_cbd_:(CBDCoreDataSorting)sorting
{
    switch (sorting) {
        case CBDCoreDataSortingDescending:
            return NO;
        default:
            return YES;
    }
}


@end
