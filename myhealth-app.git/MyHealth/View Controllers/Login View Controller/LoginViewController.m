//
//  LoginViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 30/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Connection.h"
#import "Macros.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SCLog.h"
#import "HomeViewController.h"
@interface LoginViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

-(void)handleFBSessionStateChangeWithNotification:(NSNotification *)notification;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Observe for the custom notification regarding the session state change.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleFBSessionStateChangeWithNotification:)
                                                 name:@"SessionStateChangeNotification"
                                               object:nil];
    
    // Initialize the appDelegate property.
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Initially hide all the user info subviews.
    
    _btn_login.layer.cornerRadius = 5.0;
    _btn_signUp.layer.cornerRadius = 5.0;
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"remember"] isEqualToString:@"YES"])
    {
        _btn_rememberMe.selected = YES;
        _txtField_userName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
        _txtField_userPassword.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    }
    else
    {
        _btn_rememberMe.selected = NO;
        _txtField_userName.text=@"";
        _txtField_userPassword.text=@"";
    }
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"refresh"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    if ([[UIScreen mainScreen ] bounds ].size.height != 568)
    {
        self.vertical_space1.constant -=10;
        self.vertical_space2.constant -=5;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    
}

-(IBAction)signIn:(id)sender
{
    if ([[_txtField_userName.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the user name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        _btn_rememberMe.selected = NO;
        
    }
    else if ([_txtField_userPassword.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        _btn_rememberMe.selected = NO;
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Logging In..."
                             maskType:SVProgressHUDMaskTypeNone];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
        [tempDictionary setValue:_txtField_userName.text forKeyPath:@"user_name"];
        [tempDictionary setValue:_txtField_userPassword.text forKeyPath:@"user_password"];
        [tempDictionary setValue:@"1" forKeyPath:@"user_type"];
        
        [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/get_login?" parameters:tempDictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            [SVProgressHUD dismiss];
            NSLog(@"JSON: %@", responseObject);

            if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
            {
                [[NSUserDefaults standardUserDefaults] setValue:_txtField_userName.text forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] setValue:_txtField_userPassword.text forKey:@"password"];
                
                [[NSUserDefaults standardUserDefaults] setValue:@"manual" forKey:@"loginType"];
                [[NSUserDefaults standardUserDefaults] setValue:@"LoggedIn" forKey:@"login"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                ((AppDelegate *)[UIApplication sharedApplication].delegate).patient = [[responseObject valueForKey:@"user_details"] objectAtIndex:0];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"MyHealth" message:@"Login Failed, Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
            [SVProgressHUD dismiss];
            NSLog(@"Error: %@", error);
        }];
    }
}

#pragma mark-  Text Field Delegate Method  -
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark-  Touch Method  -
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view  endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Facebook login methods
- (IBAction)loginUsingFacebook:(id)sender
{
    if ([FBSession activeSession].state != FBSessionStateOpen &&
        [FBSession activeSession].state != FBSessionStateOpenTokenExtended) {
        
        [self.appDelegate openActiveSessionWithPermissions:@[@"public_profile", @"email"] allowLoginUI:YES];
    }
    else
    {
        // Close an existing session.
        [[FBSession activeSession] closeAndClearTokenInformation];
        // Update the UI.
    }
}

#pragma mark - Private method implementation

-(void)handleFBSessionStateChangeWithNotification:(NSNotification *)notification{
    // Get the session, state and error values from the notification's userInfo dictionary.
    NSDictionary *userInfo = [notification userInfo];
    
    FBSessionState sessionState = [[userInfo objectForKey:@"state"] integerValue];
    NSError *error = [userInfo objectForKey:@"error"];
    
    
    // Handle the session state.
    // Usually, the only interesting states are the opened session, the closed session and the failed login.
    if (!error)
    {
        // In case that there's not any error, then check if the session opened or closed.
        if (sessionState == FBSessionStateOpen)
        {
            // The session is open. Get the user information and update the UI.
            
            //            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            //
            //                if (!error) {
            //                    NSLog(@"%@", result);
            //                }
            //
            //            }];
            
            
            [FBRequestConnection startWithGraphPath:@"me"
                                         parameters:@{@"fields": @"first_name, last_name, picture.type(normal), email"}
                                         HTTPMethod:@"GET"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                      if (!error) {
                                          // Set the use full name.
                                          NSLog(@"Result-->%@",result);
                                          
                                          [self registerFacebookUser:result];
                                          // Set the e-mail address.
                                          
                                          
                                          // Make the user info visible
                                          // Stop the activity indicator from animating and hide the status label.
                                      }
                                      else
                                      {
                                          NSLog(@"%@", [error localizedDescription]);
                                      }
                                  }];
        }
        else if (sessionState == FBSessionStateClosed || sessionState == FBSessionStateClosedLoginFailed)
        {
            // A session was closed or the login was failed. Update the UI accordingly.
        }
    }
    else
    {
        // In case an error has occurred, then just log the error and update the UI accordingly.
        NSLog(@"Error: %@", [error localizedDescription]);
    }
}

// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)rememberMe:(UIButton *)sender
{
    if ([[_txtField_userName.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0&&[[_txtField_userName.text stringByTrimmingCharactersInSet:                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0)
     {
          if (!sender.selected)
          {
                 [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"remember"];
                 sender.selected = YES;
            }
           else
           {
            
                  [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"remember"];
                  sender.selected = NO;
            }
         [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([_txtField_userName.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the user name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"remember"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        _btn_rememberMe.selected = NO;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"remember"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        _btn_rememberMe.selected = NO;
    }
}

-(IBAction)registerFacebookUser:(id )userDetails
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    /////////need to check//////////
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    [tempDictionary setValue:[userDetails valueForKey:@"first_name"] forKeyPath:@"firstName"];
    [tempDictionary setValue:[userDetails valueForKey:@"last_name"] forKeyPath:@"lastName"];
    [tempDictionary setValue:@"facebook" forKeyPath:@"user_password"];
    [tempDictionary setValue:[userDetails valueForKey:@"email"] forKeyPath:@"user_email"];
    [tempDictionary setValue:[userDetails valueForKey:@"first_name"] forKeyPath:@"user_name"];//need to check
    [tempDictionary setValue:@"2" forKeyPath:@"user_type"];
    [tempDictionary setValue:[userDetails valueForKey:@"id"] forKeyPath:@"user_fb_id"];
    [tempDictionary setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forKeyPath:@"user_device_token"];
    [tempDictionary setValue:[[[userDetails valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"] forKey:@"user_image"];
    
    [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/create_user?" parameters:tempDictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        SCLogDebug(@"Success: %@", responseObject);

        if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
        {
            [[NSUserDefaults standardUserDefaults] setValue:[userDetails valueForKey:@"email"] forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setValue:@"facebook" forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setValue:@"facebook" forKey:@"loginType"];
            [[NSUserDefaults standardUserDefaults] setValue:@"LoggedIn" forKey:@"login"];
            [[NSUserDefaults standardUserDefaults] setValue:[userDetails valueForKey:@"id"]  forKey:@"fb_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            ((AppDelegate *)[UIApplication sharedApplication].delegate).patient = [[responseObject valueForKey:@"user_details"] objectAtIndex:0];

            HomeViewController *viewCtrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.navigationController pushViewController:viewCtrl animated:YES];
        }
        else if ([[responseObject valueForKey:@"status"] isEqualToString:@"error"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"MyHealth" message:@"Login Failed, Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        SCLogDebug(@"Response-->>%@",operation.responseString);
        SCLogDebug(@"Success: %@", error);
    }];
}
@end
