//
//  AppDelegate.h
//  MyHealth
//
//  Created by Ashish Chhabra on 10/18/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FacebookSDK/FacebookSDK.h>
#import <DropboxSDK/DropboxSDK.h>
#import "Patient.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) Patient *patient;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString *currentaddress;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)openActiveSessionWithPermissions:(NSArray *)permissions allowLoginUI:(BOOL)allowLoginUI;

@end

