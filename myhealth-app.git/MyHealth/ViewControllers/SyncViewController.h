//
//  SyncViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MobileCoreServices/MobileCoreServices.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"

#import <DropboxSDK/DropboxSDK.h>
#import <LiveSDK/LiveConnectClient.h>

@interface SyncViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *uploadImage;
@property (assign, nonatomic) NSInteger whichPlatform;

@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@property (nonatomic, strong) DBRestClient *restClient;

@property (nonatomic, retain) GTLServiceDrive *driveService;

@property (strong, nonatomic) LiveConnectClient *liveClient;
@end
