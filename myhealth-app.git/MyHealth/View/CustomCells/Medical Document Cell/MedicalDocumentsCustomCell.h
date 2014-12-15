//
//  MedicalDocumentsCustomCell.h
//  MyHealth
//
//  Created by Ashish Chhabra on 23/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface MedicalDocumentsCustomCell : MGSwipeTableCell

@property (nonatomic, retain) IBOutlet UIImageView *imgView_bg;
@property (nonatomic, retain) IBOutlet UIImageView *mDocImageView;
@property (nonatomic, retain) IBOutlet UILabel *theFolderName;
@end
