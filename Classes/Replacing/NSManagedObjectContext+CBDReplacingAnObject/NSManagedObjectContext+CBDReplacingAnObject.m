//
//  NSManagedObjectContext+ReplacingAnObject.m
//  CBDCoreDataToolKit
//
//  Created by Colas on 03/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

#import "NSManagedObjectContext+CBDReplacingAnObject.h"

@implementation NSManagedObjectContext (CBDReplacingAnObject)


- (void)replaceThisObject:(NSManagedObject *)theOldObject
             byThisObject:(NSManagedObject *)theNewObject
     excludeRelationships:(NSArray *)namesOfRelationshipsToExclude
        withDeleting_cbd_:(BOOL)withDeleting
{
    if (![theNewObject.entity isKindOfEntity:theOldObject.entity])
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"Beware, you tried to replace anobject by an object of a different entity"] ;
        
        NSLog(@"Attention, vous avez essayé de remplacer un objet par un objet d'entité différente.\nOpération annulée") ;
    }
    
    NSEntityDescription * theEntity = theOldObject.entity ;
    NSDictionary * theRelationships = theEntity.relationshipsByName ;
    
    for (NSString * nameRelationship in theRelationships.allKeys)
    {
        if ([namesOfRelationshipsToExclude containsObject:nameRelationship])
        {
            // do nothing
        }
        else
        {
            NSRelationshipDescription * theCurrentRelationship = theRelationships[nameRelationship] ;
            
            NSRelationshipDescription * theInverseRelationship = theCurrentRelationship.inverseRelationship ;
            
            if (theCurrentRelationship.isToMany == NO)
            {
                /***********************
                 Cas des relations to-one
                 ***********************/
                NSManagedObject * theConnectedObject = [theOldObject valueForKey:theCurrentRelationship.name] ;
                
                /*
                 On fait les liaisons inverses
                 (au cas où CoreData ne s'en sort pas)
                 */
                [self replaceThisObject:theOldObject
                           byThisObject:theNewObject
                     forConnectedObject:theConnectedObject
             byInverseRelationship_cbd_:theInverseRelationship] ;
                
                
                /*
                 On relie le nouvel objet à cet object
                 */
                [theNewObject setValue:theConnectedObject
                                forKey:nameRelationship] ;
                
                
                /*
                 On retire le oldObject de sa relation avec ConnectedObject
                 */
                [theOldObject setValue:nil
                                forKey:nameRelationship] ;
            }
            else
            {
                /***********************
                 Cas des relations to-many
                 ***********************/
                
                id theConnectedObjects = [theOldObject valueForKey:nameRelationship] ;
                
                /*
                 On est obligé de faire une copie de theConnectedObjects
                 car au fur et à mesure qu'on change les relations, c'est ensemble va changer !!
                 */
                
                id theHardConnectedObjects = [theConnectedObjects copy] ;
                
                for (NSManagedObject * connectedObject in theHardConnectedObjects)
                {
                    [self replaceThisObject:theOldObject
                               byThisObject:theNewObject
                         forConnectedObject:connectedObject
                 byInverseRelationship_cbd_:theInverseRelationship] ;
                }
                
                /*
                 On ajoute les connectedObjects aux objets déjà connecté à theNewObject
                 */
                
                if (theCurrentRelationship.isOrdered)
                {
                    NSMutableOrderedSet * theObjectsConnectedToNewObject = [[theNewObject valueForKey:nameRelationship] mutableCopy] ;
                    
                    [theObjectsConnectedToNewObject unionOrderedSet:theConnectedObjects] ;
                    
                    [theNewObject setValue:theObjectsConnectedToNewObject
                                    forKey:nameRelationship] ;
                }
                else
                {
                    NSMutableSet * theObjectsConnectedToNewObject = [[theNewObject valueForKey:nameRelationship] mutableCopy] ;
                    
                    [theObjectsConnectedToNewObject unionSet:theConnectedObjects] ;
                    
                    [theNewObject setValue:theObjectsConnectedToNewObject
                                    forKey:nameRelationship] ;
                }
                
                /*
                 On retire le oldObject de sa relation avec ConnectedObject
                 */
                [theOldObject setValue:nil
                                forKey:nameRelationship] ;
            }
        }
    }
    
    if (withDeleting)
    {
        /*
         On supprime le OldObject
         */
        [theOldObject.managedObjectContext processPendingChanges] ;
        [theOldObject.managedObjectContext deleteObject:theOldObject] ;
        [theOldObject.managedObjectContext processPendingChanges] ;
    }
}





- (void)replaceThisObject:(NSManagedObject *)theOldObject
             byThisObject:(NSManagedObject *)theNewObject
       forConnectedObject:(NSManagedObject *)theConnectedObject
byInverseRelationship_cbd_:(NSRelationshipDescription *)theRelationship
{
    if (theRelationship.isToMany == NO)
    {
        [theConnectedObject setValue:theNewObject
                              forKey:theRelationship.name] ;
    }
    else
    {
        id theConnectedBackObjects ;
        theConnectedBackObjects = [[theConnectedObject valueForKey:theRelationship.name] mutableCopy];
        
        if (theRelationship.isOrdered)
        {
            theConnectedBackObjects = (NSMutableOrderedSet *)theConnectedBackObjects ;
            
            /*
             On remplace l'ancien par le nouveau
             */
            [theConnectedBackObjects removeObject:theOldObject] ;
            [theConnectedBackObjects addObject:theNewObject] ;
            
            /*
             On sette
             */
            [theConnectedObject setValue:theConnectedBackObjects
                                  forKey:theRelationship.name] ;
        }
        else
        {
            theConnectedBackObjects = (NSMutableSet *)theConnectedBackObjects ;
            
            /*
             On remplace l'ancien par le nouveau
             */
            [theConnectedBackObjects removeObject:theOldObject] ;
            [theConnectedBackObjects addObject:theNewObject] ;
            
            /*
             On sette
             */
            [theConnectedObject setValue:theConnectedBackObjects
                                  forKey:theRelationship.name] ;
        }
    }
}


@end
