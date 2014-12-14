//
//  EmergencyViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extentions.h"
@interface EmergencyViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *ssnTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobTextField;
@property (weak, nonatomic) IBOutlet UITextField *emergencyTextField;
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *ssnButton;
@property (weak, nonatomic) IBOutlet UIButton *dobButton;
@property (weak, nonatomic) IBOutlet UIButton *emergencyButton;
- (IBAction)emergencyBtnClicked:(UIButton *)sender;

@end
