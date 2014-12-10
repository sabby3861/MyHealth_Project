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
@interface LoginViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

-(void)handleFBSessionStateChangeWithNotification:(NSNotification *)notification;

//-(void)hideUserInfo:(BOOL)shouldHide;
@end

@implementation LoginViewController

- (void)viewDidLoad {
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
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"username"] && [[NSUserDefaults standardUserDefaults] valueForKey:@"password"]) {
        
        _txtField_userName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
        _txtField_userPassword.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    }

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"remember"] isEqualToString:@"YES"]) {
        
        _btn_rememberMe.selected = YES;
        
    } else {
        
        _btn_rememberMe.selected = NO;
    }
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"refresh"];
}
-(void)viewDidDisappear:(BOOL)animated
{
    
}
-(IBAction)signIn:(id)sender
{
    if (_txtField_userName.text.length == 0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the user name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        _btn_rememberMe.selected = NO;
        
    } else if (_txtField_userPassword.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        _btn_rememberMe.selected = NO;
        
    } else {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
        [tempDictionary setValue:_txtField_userName.text forKeyPath:@"user_name"];
        [tempDictionary setValue:_txtField_userPassword.text forKeyPath:@"user_password"];
        [tempDictionary setValue:@"1" forKeyPath:@"user_type"];
        
        [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/get_login?" parameters:tempDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [[NSUserDefaults standardUserDefaults] setValue:@"manual" forKey:@"login"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"JSON: %@", responseObject);
            ((AppDelegate *)[UIApplication sharedApplication].delegate).patient = [[responseObject valueForKey:@"user_details"] objectAtIndex:0];
            NSLog(@"user details:%@",((AppDelegate *)[UIApplication sharedApplication].delegate).patient);
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"Error: %@", error);
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Facebook login methods
- (IBAction)loginUsingFacebook:(id)sender {
    if ([FBSession activeSession].state != FBSessionStateOpen &&
        [FBSession activeSession].state != FBSessionStateOpenTokenExtended) {
        
        [self.appDelegate openActiveSessionWithPermissions:@[@"public_profile", @"email"] allowLoginUI:YES];
        
    }
    else{
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
    if (!error) {
        // In case that there's not any error, then check if the session opened or closed.
        if (sessionState == FBSessionStateOpen) {
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
                                      else{
                                          NSLog(@"%@", [error localizedDescription]);
                                      }
                                  }];
            
            
        }
        else if (sessionState == FBSessionStateClosed || sessionState == FBSessionStateClosedLoginFailed){
            // A session was closed or the login was failed. Update the UI accordingly.
           
        }
    }
    else{
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
    if (_txtField_userName.text.length && _txtField_userPassword.text.length) {
        
        if (!sender.selected) {
            
            [[NSUserDefaults standardUserDefaults] setValue:_txtField_userName.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setValue:_txtField_userPassword.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"remember"];
            sender.selected = YES;
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"remember"];
            sender.selected = NO;
        }
                
        
    } else if (_txtField_userName.text.length == 0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the user name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"remember"];
        _btn_rememberMe.selected = NO;
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"remember"];
        _btn_rememberMe.selected = NO;
    }
    
}
-(IBAction)registerFacebookUser:(id )userDetails
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    [tempDictionary setValue:[userDetails valueForKey:@"first_name"] forKeyPath:@"firstName"];
    [tempDictionary setValue:[userDetails valueForKey:@"last_name"] forKeyPath:@"lastName"];
    [tempDictionary setValue:@"facebook" forKeyPath:@"user_password"];
    [tempDictionary setValue:[userDetails valueForKey:@"email"] forKeyPath:@"user_email"];
    [tempDictionary setValue:@"" forKeyPath:@"user_name"];
    [tempDictionary setValue:@"2" forKeyPath:@"user_type"];
    [tempDictionary setValue:[userDetails valueForKey:@"id"] forKeyPath:@"user_fb_id"];
    [tempDictionary setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forKeyPath:@"user_device_token"];
    [tempDictionary setValue:[[[userDetails valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"] forKey:@"user_image"];
    
    [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/create_user?" parameters:tempDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[NSUserDefaults standardUserDefaults] setValue:[userDetails valueForKey:@"email"] forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setValue:@"facebook" forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] setValue:@"facebook" forKey:@"login"];
        [[NSUserDefaults standardUserDefaults] setValue:[userDetails valueForKey:@"id"]  forKey:@"fb_id"];
        
        NSLog(@"Success: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Response-->>%@",operation.responseString);
        NSLog(@"Success: %@", error);
    }];
    
    
}
@end
