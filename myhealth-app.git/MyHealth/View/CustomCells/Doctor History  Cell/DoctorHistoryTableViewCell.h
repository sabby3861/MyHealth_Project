//
//  DoctorHistoryTableViewCell.h
//  MyHealth
//
//  Created by Ashish Chhabra on 10/18/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorHistoryTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIView *viewBg;
@property (nonatomic, retain) IBOutlet UIImageView *imgView_user;
@property (nonatomic, retain) IBOutlet UIImageView *imgView_bg;
@property (nonatomic, retain) IBOutlet UIImageView *imgView_doctor;

@property (nonatomic, retain) IBOutlet UILabel *lbl_name;
@property (nonatomic, retain) IBOutlet UILabel *lbl_specialist;
@property (nonatomic, retain) IBOutlet UILabel *lbl_experience;
@property (nonatomic, retain) IBOutlet UILabel *lbl_landmark;
@end
