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
#import "SCLog.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) Patient *patient;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString *currentaddress;
@property (strong, nonatomic) UIImage *theDocImage;
@property (strong, nonatomic) NSString *pathOfSharingItem;
//@property (assign, nonatomic) BOOL isUserLoggedIn;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)openActiveSessionWithPermissions:(NSArray *)permissions allowLoginUI:(BOOL)allowLoginUI;



/**
  *  Class Method to get the Application Delegate Object.
  *  This delegate is shared among all classes.
  * .@param nil
  **/
+(AppDelegate*)sharedAppDelegate;

//-(NSString*)mSetDateFormat:(NSString*)dateToBeConverted;


/**
  *  Method to get the rootviewcontroller.
  *  You will get the rootviewcontroller of window at any time you call this.
  * .@param nil
  **/
-(UINavigationController*)theRootNavigationController;

/**
  *  Method Declaration to get the Main StoryBoard Object.
  *  It will return you the UIStoryboard Object.
  * .@param nil
  **/
-(UIStoryboard*)theMainStoryBoard;

@end

