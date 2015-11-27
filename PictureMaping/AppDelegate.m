//
//  AppDelegate.m
//  PictureMaping
//
//  Created by Alexey on 11/15/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "AppDelegate.h"
#import "PicturesViewController.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = [tabBarController.viewControllers firstObject];
    PicturesViewController *picturesVC = (PicturesViewController *)[navigationController.viewControllers firstObject];
    
    picturesVC.managedObjectContext = self.managedObjectContext;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"AIzaSyB2lY4l7ecHS40kTDfitqJr7u16XKk5ovY"];
    
    return YES;
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil)
        return _managedObjectModel;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil)
        return _managedObjectContext;
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (!coordinator)
        return nil;
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil)
        return _persistentStoreCoordinator;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DataModel.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application`s saved data.";
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application`s saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        NSError *error = nil;
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolver error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end