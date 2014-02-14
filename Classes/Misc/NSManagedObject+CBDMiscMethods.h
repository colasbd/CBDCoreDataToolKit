//
//  NSEntityDescription+CBDMiscMethods.h
//  Pods
//
//  Created by Colas on 12/02/2014.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (CBDMiscMethods)

/**
 Checks if the entity of self is a subentity of the given entity.
 */
- (BOOL)isCompatibleWith_cbd_:(NSEntityDescription *)entity ;

/**
 Whether the associated value is an NSOrderdSet or an NSSet or an Object, this method returns an NSSet !!
 
 In the case of a to-one relationship, this methods returns a set with one object.
 
 Returns an empty set if the value for the key is nil.
 */
- (NSSet *)setValueForRelationship_cbd_:(NSRelationshipDescription *)relationship ;
@end
