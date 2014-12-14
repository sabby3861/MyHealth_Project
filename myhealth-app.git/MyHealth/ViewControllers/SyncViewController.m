//
//  SyncViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "SyncViewController.h"
#import "AppDelegate.h"

//Google Drive
static NSString *const kKeychainItemNameGoogleDrive = @"Google Drive Quickstart";
static NSString *const kClientIDGoogleDrive = @"1070355413473-4rek2vlqll2bbh9u1nd4pv12b1gj1dp3.apps.googleusercontent.com";
static NSString *const kClientSecretGoogleDrive = @"9obaBYPQalOXYnPPSjizHdBP";

//One Drive
static NSString *const kClientIDOneDrive = @"0000000048134B65";
static NSString *const kClientSecretOneDrive = @"bqUKE23WZb3mvQ5sqctZTBP88hgqcmFW";

@interface SyncViewController ()<DBRestClientDelegate,LiveAuthDelegate, LiveOperationDelegate,LiveUploadOperationDelegate>
{
    UIAlertView *waitIndicator ;
}

@end

@implementation SyncViewController
@synthesize liveClient;

#pragma mark - ViewLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.uploadImage.image=[[AppDelegate sharedAppDelegate]theDocImage];
    switch (self.whichPlatform)
    {
        case 0:
        {
            //Dropbox
            if (![[DBSession sharedSession] isLinked])
                [[DBSession sharedSession] linkFromController:self];
            self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
            self.restClient.delegate = self;
        }
        break;
        case 1:
        {
            //One Drive
            self.liveClient = [[LiveConnectClient alloc] initWithClientId:kClientIDOneDrive scopes:[NSArray arrayWithObjects:@"wl.signin",@"wl.basic",@"wl.skydrive_update", nil] delegate:self userState:@"initialize"];
        }
        break;
        case 2:
        {
            //iCloud
            [self showAlert:@"iCloud" message:@"Coming Soon..."];
        }
        break;
        case 3:
        {
            //Google Drive
            self.driveService = [[GTLServiceDrive alloc] init];
            self.driveService.authorizer = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemNameGoogleDrive
                                                                                                 clientID:kClientIDGoogleDrive
                                                                                             clientSecret:kClientSecretGoogleDrive];
            if (![self isAuthorized])
            {
                // Not yet authorized, request authorization and push the login UI onto the navigation stack.
                [self presentViewController:[self createAuthController] animated:YES completion:nil];
            }

        }
        break;
        default:
        break;
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

-(IBAction)uploadPhoto:(UIButton*)sender
{
    switch (self.whichPlatform)
    {
        case 0:
        {
            // Write a file to the local documents directory
            NSString *text = @"Hello world.";
            NSString *filename = @"working-draft.txt";
            NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *localPath = [localDir stringByAppendingPathComponent:filename];
            [text writeToFile:localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            // Upload file to Dropbox
            NSString *destDir = @"/";
            [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:localPath];
        }
        break;
        case 1:
        {
            NSData *imgdata = UIImagePNGRepresentation(self.uploadImage.image);
            NSString *filename = @"doctor.jpg";
            [self.liveClient uploadToPath:@"me/skydrive" fileName:filename data:imgdata overwrite:LiveUploadRename delegate:self userState:@"Upoading"];
            waitIndicator= [self showWaitIndicator:@"Uploading to One Drive"];
        }
        break;
        case 2:
        {
            //iCloud
        }
            break;
        case 3:
        {
            //Google Drive
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"'Quickstart Uploaded File ('EEEE MMMM d, YYYY h:mm a, zzz')"];
            
            GTLDriveFile *file = [GTLDriveFile object];
            file.title = [dateFormat stringFromDate:[NSDate date]];
            file.descriptionProperty = @"Uploaded from the Google Drive iOS Quickstart";
            file.mimeType = @"image/png";
            
            NSData *imgdata = UIImagePNGRepresentation(self.uploadImage.image);
            GTLUploadParameters *uploadParameters = [GTLUploadParameters uploadParametersWithData:imgdata MIMEType:file.mimeType];
            GTLQueryDrive *query = [GTLQueryDrive queryForFilesInsertWithObject:file
                                                               uploadParameters:uploadParameters];
            
            waitIndicator = [self showWaitIndicator:@"Uploading to Google Drive"];
            
            [self.driveService executeQuery:query
                          completionHandler:^(GTLServiceTicket *ticket,
                                              GTLDriveFile *insertedFile, NSError *error) {
                              [waitIndicator dismissWithClickedButtonIndex:0 animated:YES];
                              if (error == nil)
                              {
                                  NSLog(@"File ID: %@", insertedFile.identifier);
                                  [self showAlert:@"Google Drive" message:@"File Uploaded!"];
                              }
                              else
                              {
                                  NSLog(@"An error occurred: %@", error);
                                  [self showAlert:@"Google Drive" message:@"Sorry, an error occurred!"];
                              }
                          }];
        }
        default:
        break;
    }
}

-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DropBox

#pragma mark - DBRestClient Delegates
- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata
{
    
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
    
    NSLog(@"File upload failed with error: %@", error);
}

#pragma mark - One Drive

#pragma mark - LiveAuth Delegates
- (void)authCompleted:(LiveConnectSessionStatus) status
              session:(LiveConnectSession *) session
            userState:(id) userState
{
    if (status !=LiveAuthConnected)
    {
        if ([userState isEqual:@"initialize"])
        {
            @try
            {
                [liveClient login:self
                           scopes:[NSArray arrayWithObjects:@"wl.signin",@"wl.basic",@"wl.skydrive_update", nil]
                         delegate:self
                        userState:@"login"];
            }
            @catch(id ex)
            {
            }
        }
    }
}

- (void)authFailed:(NSError *) error
         userState:(id)userState
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                    message: [NSString stringWithFormat:@"Error: %@", [error localizedDescription]]
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

#pragma mark - LiveUploadOperation Delegates
- (void) liveOperationSucceeded:(LiveOperation *)operation
{
    [waitIndicator dismissWithClickedButtonIndex:0 animated:YES];
    [self showAlert:@"One Drive" message:@"File uploaded!"];
    //
    //    NSString *fileId = [operation.result objectForKey:@"id"];
    //    NSString *fileName = [operation.result objectForKey:@"name"];
    //    NSString *fileDescription = [operation.result objectForKey:@"description"];
    //    NSString *fileSize = [operation.result objectForKey:@"size"];
    //    self.infoLabel.text = [NSString stringWithFormat:
    //                           @"File Properties:\n"
    //                           @"\tId. %@\n"
    //                           @"\tName. %@\n"
    //                           @"\tDescription. %@\n"
    //                           @"\tSize. %@\n"
    //                           , fileId,
    //                           fileName,
    //                           fileDescription,
    //                           fileSize];
}

- (void) liveOperationFailed:(NSError *)error
                   operation:(LiveOperation*)operation
{
    [waitIndicator dismissWithClickedButtonIndex:0 animated:YES];
    [self showAlert:@"One Drive" message:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]]];
}

#pragma mark - One Drive

#pragma mark - GTMOAuth2Authentication Delegates
// Helper to check if user is authorized
- (BOOL)isAuthorized
{
    return [((GTMOAuth2Authentication *)self.driveService.authorizer) canAuthorize];
}

// Creates the auth controller for authorizing access to Google Drive.
- (GTMOAuth2ViewControllerTouch *)createAuthController
{
    GTMOAuth2ViewControllerTouch *authController;
    authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDriveFile
                                                                clientID:kClientIDGoogleDrive
                                                            clientSecret:kClientSecretGoogleDrive
                                                        keychainItemName:kKeychainItemNameGoogleDrive
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

// Handle completion of the authorization process, and updates the Drive service
// with the new credentials.
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error
{
    if (error != nil)
    {
        [self showAlert:@"Authentication Error" message:error.localizedDescription];
        self.driveService.authorizer = nil;
    }
    else
        self.driveService.authorizer = authResult;
}

#pragma mark NSCoding

#define kVersionKey @"Version"
#define kPhotoKey @"Photo"

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:1 forKey:kVersionKey];
    NSData * photoData = UIImagePNGRepresentation(self.uploadImage.image);
    [encoder encodeObject:photoData forKey:kPhotoKey];
}

#pragma mark - Custom Methods
- (UIAlertView*)showWaitIndicator:(NSString *)title
{
    UIAlertView *progressAlert;
    progressAlert = [[UIAlertView alloc] initWithTitle:title
                                               message:@"Please wait..."
                                              delegate:nil
                                     cancelButtonTitle:nil
                                     otherButtonTitles:nil];
    [progressAlert show];
    
    UIActivityIndicatorView *activityView;
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.center = CGPointMake(progressAlert.bounds.size.width / 2,
                                      progressAlert.bounds.size.height - 45);
    
    [progressAlert addSubview:activityView];
    [activityView startAnimating];
    return progressAlert;
}

- (void)showAlert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle: title
                                       message: message
                                      delegate: nil
                             cancelButtonTitle: @"OK"
                             otherButtonTitles: nil];
    [alert show];
}
@end
