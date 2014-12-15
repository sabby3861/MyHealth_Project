//
//  LoginViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 30/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UIButton+Extentions.h"
@interface LoginViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *txtField_userName;
@property (nonatomic, retain) IBOutlet UITextField *txtField_userPassword;
@property (nonatomic, retain) IBOutlet UIButton *btn_rememberMe;
@property (nonatomic, retain) IBOutlet UIButton *btn_signUp;
@property (nonatomic, retain) IBOutlet UIButton *btn_login;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
- (IBAction)loginUsingFacebook:(id)sender;
-(IBAction)rememberMe:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vertical_space1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vertical_space2;

@end
