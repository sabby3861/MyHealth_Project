//
//  MenuCustomCollectionViewCell.h
//  Doctor App
//
//  Created by Ashish Chhabra on 3/8/14.
//  Copyright (c) 2014 Ashish Chhabra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCustomCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UILabel *lbl_menuItem;
@property (nonatomic, retain) IBOutlet UILabel *lbl_menuItemInfo;
@property (nonatomic, retain) IBOutlet UIButton *btn_menuItem;
@property (nonatomic, retain) IBOutlet UIImageView *imgView_item;
@end
