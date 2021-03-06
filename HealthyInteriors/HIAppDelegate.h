//
//  HIAppDelegate.h
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HICheckListModel.h"
#import "IASKAppSettingsViewController.h"

@interface HIAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, IASKSettingsDelegate>

    @property(strong, nonatomic) UIWindow *window;
    @property(strong, nonatomic) UITabBarController *tabBarController;
    @property(readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
    @property(readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
    @property(readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

    + (void)saveToUserDefaults:(NSString *)key value:(NSString *)valueString;

    + (NSString *)retrieveFromUserDefaults:(NSString *)key;

    - (void)saveContext;

    - (NSURL *)applicationDocumentsDirectory;

@end
