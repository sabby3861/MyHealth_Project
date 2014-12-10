//
//  RegistrationViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 31/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extentions.h"
#import "SVProgressHUD.h"

@interface RegistrationViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *txtfield_userName;
@property (nonatomic, retain) IBOutlet UITextField *txtfield_lastName;
@property (nonatomic, retain) IBOutlet UITextField *txtfield_userPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtfield_userEmail;
@property (nonatomic, retain) IBOutlet UITextField *txtfield_firstName;
@property (nonatomic, retain) IBOutlet UIButton *btn_uploadImage;
@property (nonatomic, retain) IBOutlet UIButton *btn_register;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@end
