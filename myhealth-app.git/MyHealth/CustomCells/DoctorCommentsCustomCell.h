//
//  DoctorCommentsCustomCell.h
//  MyHealth
//
//  Created by Ashish Chhabra on 23/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorCommentsCustomCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *imgView_user;
@property (nonatomic, retain) IBOutlet UIImageView *higylighter;
@property (nonatomic, retain) IBOutlet UILabel *lbl_name;
@property (nonatomic, retain) IBOutlet UILabel *lbl_text;
@end
