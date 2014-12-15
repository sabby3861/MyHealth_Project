//
//  MedicalHistoryCustomCell.h
//  MyHealth
//
//  Created by Ashish Chhabra on 10/18/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalHistoryCustomCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *imgView_heart;
@property (nonatomic, retain) IBOutlet UIButton *btn_check;
@property (nonatomic, retain) IBOutlet UILabel *lbl_heading;
@property (nonatomic, retain) IBOutlet UITextField *txtfield_value;
@end
