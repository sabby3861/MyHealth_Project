//
//  MedicalHistoryCustomCell.m
//  MyHealth
//
//  Created by Ashish Chhabra on 10/18/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "MedicalHistoryCustomCell.h"

@implementation MedicalHistoryCustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)checkBoxAction:(UIButton*)sender
{
    if ([UIImagePNGRepresentation([sender imageForState:UIControlStateNormal]) isEqualToData:UIImagePNGRepresentation([UIImage imageNamed:@"button_checkboxempty.png"])])
    {
        [sender setImage:[UIImage imageNamed:@"button_checkboxfilled.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"button_checkboxempty.png"] forState:UIControlStateNormal];
    }
}
@end
