//
//  NSEntityDescription+CBDConnectedEntities.h
//  Pods
//
//  Created by Colas on 21/02/2014.
//
//

#import <CoreData/CoreData.h>

@interface NSEntityDescription (CBDConnectedEntities)

/**
 @return The Set of entities that are connected to instance entity.
 */
- (NSSet *)connectedEntities ;

@end
