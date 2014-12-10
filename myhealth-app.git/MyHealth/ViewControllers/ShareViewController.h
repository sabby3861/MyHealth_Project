//
//  ShareViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//
enum sharePlatform
{
    dropBox = 0,
    oneDrive,
    iCloud,
    googleDrive
}sharePlatform;

#import <UIKit/UIKit.h>
#import "UIButton+Extentions.h"
@interface ShareViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *tblView_share;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@end
