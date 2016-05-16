//
//  NSEntityDescription+CBDConnectedEntities.m
//  Pods
//
//  Created by Colas on 21/02/2014.
//
//

#import "NSEntityDescription+CBDConnectedEntities.h"

@implementation NSEntityDescription (CBDConnectedEntities)


- (NSSet *)connectedEntities
{
    NSMutableSet * result = [NSMutableSet setWithObject:self];
    
    for (NSRelationshipDescription * relationship in [self.relationshipsByName allValues])
    {
        NSEntityDescription * currentEntity = relationship.entity;
        
        if (![result containsObject:currentEntity])
        {
            [result unionSet:[currentEntity connectedEntities]];
        }
    }
             
    return result;
}

@end
