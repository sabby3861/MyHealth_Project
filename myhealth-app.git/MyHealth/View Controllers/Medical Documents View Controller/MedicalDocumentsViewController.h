//
//  MedicalDocumentsViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 23/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "UIButton+Extentions.h"
@interface MedicalDocumentsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate,UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet UILabel *lbl_title;
@property (nonatomic, retain) IBOutlet UITableView *tblView_medicalHistory;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;
@property (nonatomic, weak) IBOutlet UILabel *mTitle;
@property (nonatomic, weak) IBOutlet UITextField *mSearchField;
@property (nonatomic, strong) NSString *mPathSuffix;
@property (nonatomic, strong) NSString *mFilePathSuffix;
@end
