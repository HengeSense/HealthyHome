//
//  HIAppDelegate.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListsTableViewController.h"
#import "HICheckListTemplateManager.h"
#import "FindInfoViewController.h"
#import "IASKSettingsReader.h"
#import "HIFavouritesTableViewController.h"
#import "HIIntroViewController.h"

@interface HIAppDelegate (/*private*/)
    @property(nonatomic, strong) HICheckListTemplateManager *templateManager;

@end

@implementation HIAppDelegate

    @synthesize managedObjectContext = _managedObjectContext;
    @synthesize managedObjectModel = _managedObjectModel;
    @synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingDidChange:) name:kIASKAppSettingChanged object:nil];

        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

        self.templateManager = [[HICheckListTemplateManager alloc] init];

        [self setTheme];

        UINavigationController *checkListsTab;
        UINavigationController *settingsTab;
        UINavigationController *findTab;
        UINavigationController *favouritesTab;

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

            //Checklists

            HICheckListsTableViewController *checkListsController = [[HICheckListsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            checkListsController.managedObjectContext = self.managedObjectContext;
            checkListsController.templateDelegate = self.templateManager;

            checkListsTab = [[UINavigationController alloc] initWithRootViewController:checkListsController];
            checkListsTab.tabBarItem.image = [UIImage imageNamed:@"library"];
            checkListsTab.tabBarItem.title = @"My Checklists";

            //Find

            FindInfoViewController *findController = [[FindInfoViewController alloc] initWithNibName:@"FindInfoView" bundle:nil];
            findController.title = @"Search Tips";
            findController.managedObjectContext = self.managedObjectContext;
            findController.templateDelegate = self.templateManager;

            findTab = [[UINavigationController alloc] initWithRootViewController:findController];
            findTab.tabBarItem.image = [UIImage imageNamed:@"search"];

            //Favourites

            HIFavouritesTableViewController *favouritesController = [[HIFavouritesTableViewController alloc] initWithStyle:UITableViewStyleGrouped managedObjectContext:self.managedObjectContext];
            favouritesController.title = @"Favourite Tips";
            favouritesController.templateDelegate = self.templateManager;

            favouritesTab = [[UINavigationController alloc] initWithRootViewController:favouritesController];
            favouritesTab.tabBarItem.image = [UIImage imageNamed:@"favorite"];

            //Settings

            IASKAppSettingsViewController *settingsController = [[IASKAppSettingsViewController alloc] init];

            settingsController.title = NSLocalizedString(@"Settings", @"Settings");
            settingsController.delegate = self;
            settingsController.showCreditsFooter = NO;
            settingsController.showDoneButton = NO;

            settingsTab = [[UINavigationController alloc] initWithRootViewController:settingsController];
            settingsTab.tabBarItem.image = [UIImage imageNamed:@"settings"];

        } else {

        }

        self.tabBarController = [[UITabBarController alloc] init];
        self.tabBarController.viewControllers = @[checkListsTab, findTab, favouritesTab, settingsTab];
        self.window.rootViewController = self.tabBarController;

        [application setStatusBarStyle:UIStatusBarStyleBlackTranslucent];

        [self.window makeKeyAndVisible];

        //get the intro version lst displayed
        NSString * introVersion = [HIAppDelegate retrieveFromUserDefaults:@"introVersion"];
        int introVersionNum = [introVersion intValue];

        NSString * bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        int bundleVersionNum = [bundleVersion intValue];

        if (bundleVersion > introVersion) {
            HIIntroViewController * introViewController = [[HIIntroViewController alloc] init];
            introViewController.displaySkipButton = YES;
            [self.window.rootViewController presentViewController:introViewController animated:YES completion:nil];
            [HIAppDelegate saveToUserDefaults:@"introVersion" value:bundleVersion];
        }

        return YES;
    }

    - (void)awakeFromNib {
        //BOOL enabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"AutoConnect"];
    }

#pragma mark kIASKAppSettingChanged notification

    - (void)setTheme {
        NSString *currentTheme = [HIAppDelegate retrieveFromUserDefaults:@"theme"];
        if ([currentTheme isEqualToString:@"0"]) {
            currentTheme = @"default";
        }

        [PXEngine styleSheetFromFilePath:[[NSBundle mainBundle] pathForResource:currentTheme ofType:@"css"]
                              withOrigin:PXStylesheetOriginApplication];

        [PXEngine applyStylesheets];
        [PXEngine currentApplicationStylesheet].monitorChanges = YES;
        NSLog(@"%@", [PXEngine currentApplicationStylesheet].filePath);
    }

    - (void)settingDidChange:(NSNotification *)notification {
        NSLog(@"%@", notification.object);
        if ([notification.object isEqual:@"theme"]) {

            [self setTheme];

        }
    }

    - (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController *)sender {

    }

    - (void)settingsViewController:(id)sender buttonTappedForKey:(NSString*)key
    {

        if ([key isEqualToString:@"tutorial"]) {

            HIIntroViewController * introViewController = [[HIIntroViewController alloc] init];
            introViewController.displaySkipButton = NO;
             [((UIViewController *)sender).navigationController pushViewController:introViewController animated:YES];

        }
    }
    - (NSString*) settingsViewController:(id<IASKViewController>)settingsViewController
             mailComposeBodyForSpecifier:(IASKSpecifier*) specifier
    {
        NSLog(@"%@", [specifier.specifierDict objectForKey:@"tellafriend"]);



        NSMutableString *returnString=[[NSMutableString alloc] init];
        [returnString appendString:@"Check out this new Healthy Home App I found, it has some great tips.\n\n"];
        [returnString appendString:@"<a href=\"https://itunes.apple.com/us/app/healthy-home/id665863480?ls=1&mt=8\" target=\"itunes_store\">Healthy Home App</a>"];

        return returnString;

    }

    - (void)saveContext {
        NSError *error = nil;
        NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
        if (managedObjectContext != nil) {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    - (NSManagedObjectContext *)managedObjectContext {
        if (_managedObjectContext != nil) {
            return _managedObjectContext;
        }

        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
        return _managedObjectContext;
    }

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
    - (NSManagedObjectModel *)managedObjectModel {
        if (_managedObjectModel != nil) {
            return _managedObjectModel;
        }
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HealthyInteriors" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        return _managedObjectModel;
    }

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
    - (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
        if (_persistentStoreCoordinator != nil) {
            return _persistentStoreCoordinator;
        }

        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HealthyInteriors.sqlite"];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.

             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.


             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]

             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}

             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

        return _persistentStoreCoordinator;
    }

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
    - (NSURL *)applicationDocumentsDirectory {
        return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    }

    - (void)applicationWillResignActive:(UIApplication *)application {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    - (void)applicationDidEnterBackground:(UIApplication *)application {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    - (void)applicationWillEnterForeground:(UIApplication *)application {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    - (void)applicationDidBecomeActive:(UIApplication *)application {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    - (void)applicationWillTerminate:(UIApplication *)application {
        // Saves changes in the application's managed object context before the application terminates.
        [self saveContext];
    }

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark - NSUserDefaults methods (from: http://greghaygood.com/2009/03/09/updating-nsuserdefaults-from-settingsbundle)

    + (void)saveToUserDefaults:(NSString *)key value:(NSString *)valueString {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

        if (standardUserDefaults) {
            [standardUserDefaults setObject:valueString forKey:key];
            [standardUserDefaults synchronize];
        } else {
            NSLog(@"Unable to save %@ = %@ to user defaults", key, valueString);
        }
    }

    + (NSString *)retrieveFromUserDefaults:(NSString *)key {
        return [HIAppDelegate retrieveFromUserDefaults:key withPlist:@"Root.plist"];
    }

    + (NSString *)retrieveFromUserDefaults:(NSString *)key withPlist:(NSString *)plist {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *val = nil;

        if (standardUserDefaults)
            val = [standardUserDefaults objectForKey:key];

        if (val == nil) {
            //Get the bundle path
            NSString *bPath = [[NSBundle mainBundle] bundlePath];
            NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
            NSString *plistFile = [settingsPath stringByAppendingPathComponent:plist];

            //Get the Preferences Array from the dictionary
            NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
            NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];

            //Loop through the array
            NSDictionary *item;
            for (item in preferencesArray) {
                //Get the key of the item.
                NSString *keyValue = [item objectForKey:@"Key"];


                //Get the default value specified in the plist file.
                id defaultValue = [item objectForKey:@"DefaultValue"];

                //            NSLog(@"user defaults may not have been loaded from Settings.bundle ... %@", defaultValue);

                if (keyValue && defaultValue) {
                    [standardUserDefaults setObject:defaultValue forKey:keyValue];
                    if ([keyValue compare:key] == NSOrderedSame)
                        val = defaultValue;
                }
            }
            [standardUserDefaults synchronize];
        }
        return val;
    }

@end
