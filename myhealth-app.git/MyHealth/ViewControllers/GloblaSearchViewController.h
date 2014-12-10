//
//  GloblaSearchViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorHistoryTableViewCell.h"
#import "UIButton+Extentions.h"
@interface GloblaSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tblView_globalSearch;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@end
