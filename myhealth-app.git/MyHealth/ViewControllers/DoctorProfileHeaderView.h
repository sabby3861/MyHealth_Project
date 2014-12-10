//
//  DoctorProfile.h
//  MyHealth
//
//  Created by Ashish Chhabra on 21/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DoctorProfileHeaderView : UIView

@property (nonatomic, retain) IBOutlet UIImageView *imgView_doctor;
@property (nonatomic, retain) IBOutlet UIButton *btn_contact;
@property (nonatomic, retain) IBOutlet UIButton *btn_directions;
@property (nonatomic, retain) IBOutlet UIButton *btn_recommend;

@property (nonatomic, retain) IBOutlet UILabel *lbl_name;
@property (nonatomic, retain) IBOutlet UILabel *lbl_specialist;
@property (nonatomic, retain) IBOutlet UILabel *lbl_rating;
@property (nonatomic, retain) IBOutlet UILabel *lbl_landmark;
@end
