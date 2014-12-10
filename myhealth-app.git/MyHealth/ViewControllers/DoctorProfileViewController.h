//
//  DoctorProfileViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 20/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extentions.h"
#import "DoctorInfo.h"
#import "CommentListing.h"
#import "Degree.h"
#import "Notes.h"

@interface DoctorProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tblView_profile;

@property (nonatomic, retain) IBOutlet UILabel *lbl_title;
@property (nonatomic, retain) IBOutlet UILabel *lbl_name;
@property (nonatomic, retain) IBOutlet UILabel *lbl_specialist;
@property (nonatomic, retain) IBOutlet UILabel *lbl_experience;
@property (nonatomic, retain) IBOutlet UILabel *lbl_landmark;
@property (nonatomic, retain) CommentListing *comments;
@property (nonatomic, retain) DoctorInfo *docInfo;
@property (nonatomic, retain) Degree *degreeArray;
@property (nonatomic, retain) Notes *docNotes;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;


@property (nonatomic, retain) UIButton *btn_star1;
@property (nonatomic, retain) UIButton *btn_star2;
@property (nonatomic, retain) UIButton *btn_star3;
@property (nonatomic, retain) UIButton *btn_star4;
@property (nonatomic, retain) UIButton *btn_star5;
@end
