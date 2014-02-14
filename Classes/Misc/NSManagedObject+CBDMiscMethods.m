//
//  NSEntityDescription+CBDMiscMethods.m
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import "NSManagedObject+CBDMiscMethods.h"

@implementation NSManagedObject (CBDMiscMethods)

- (BOOL)isCompatibleWith_cbd_:(NSEntityDescription *)entity
{
    return [self.entity isKindOfEntity:entity] ;
}


- (NSSet *)setValueForRelationship_cbd_:(NSRelationshipDescription *)relationship
{
    if (![self.entity isKindOfEntity:relationship.entity])
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"The relationship %@ does not apply for %@", relationship, self] ;
    }
    
    if (![self valueForKey:relationship.name])
    {
        return [NSSet set] ;
    }
    
    if (!relationship.isToMany)
    {
        return [NSSet setWithObject:[self valueForKey:relationship.name]] ;
    }
    else
    {
        if (relationship.isOrdered)
        {
            return [((NSOrderedSet *)[self valueForKey:relationship.name]) set] ;
        }
        else
        {
            return [self valueForKey:relationship.name] ;
        }
    }
}


@end
