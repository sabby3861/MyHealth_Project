//
//  MedicalHistoryViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 10/18/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extentions.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface MedicalHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController *picker;
}

@property (nonatomic, retain) IBOutlet UILabel *lbl_title;
@property (nonatomic, retain) IBOutlet UIButton *btn_search;
@property (nonatomic, retain) IBOutlet UITextField *txtField_search;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@property (nonatomic, retain) NSMutableArray *arraySectionRows;
@end
