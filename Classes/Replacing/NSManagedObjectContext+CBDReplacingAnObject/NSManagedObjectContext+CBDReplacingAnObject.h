//
//  NSManagedObjectContext+ReplacingAnObject.h
//  MyMaths
//
//  Created by Colas on 03/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (CBDReplacingAnObject)

- (void)replaceThisObject:(NSManagedObject *)theOldObject
             byThisObject:(NSManagedObject *)theNewObject
     excludeRelationships:(NSArray *)namesOfRelationshipsToExclude
        withDeleting_cbd_:(BOOL)withDeleting ;

@end
