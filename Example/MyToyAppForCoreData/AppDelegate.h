//
//  AppDelegate.h
//  MyToyAppForCoreData
//
//  Created by Colas on 06/02/2014.
//  Copyright (c) 2014 Colas. All rights reserved.
//

@class MyApplicationHelper ;

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (nonatomic, strong) MyApplicationHelper * myApplicationHelper ;

- (IBAction)saveAction:(id)sender;

@end
