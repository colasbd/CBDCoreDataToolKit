//
//  NSManagedObject+Clone.h
//  MyMaths
//
//  Created by Colas on 07/05/13.
//  Copyright (c) 2013 Colas. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (CBDClone)

- (NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context
                    withCopiedCache:(NSMutableDictionary *)alreadyCopied
                     exludeEntities:(NSArray *)namesOfEntitiesToExclude
             excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude ;


- (NSManagedObject *)cloneToContext:(NSManagedObjectContext *)context
                exludeEntities_cbd_:(NSArray *)namesOfEntitiesToExclude;


- (NSManagedObject *)cloneToContext:(NSManagedObjectContext *)context
                     exludeEntities:(NSArray *)namesOfEntitiesToExclude
             excludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude ;


- (void) fillInAttributesFrom:(NSManagedObject *)sourceObject
        exludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude ;


- (NSManagedObject *)cloneOnlyAttribuesToContext:(NSManagedObjectContext *)context
                           exludeAttributes_cbd_:(NSArray *)namesOfAttributesToExclude ;



@end