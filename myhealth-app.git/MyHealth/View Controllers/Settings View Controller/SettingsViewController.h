//
//  SettingsViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extentions.h"
@interface SettingsViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@property (nonatomic, retain) IBOutlet UIButton *termsBtn;
- (IBAction)termsBtnClicked:(id)sender;
@end
