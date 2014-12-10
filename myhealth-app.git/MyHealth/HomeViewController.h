//
//  ViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 10/14/14.
//  Copyright (c) 2014 HealthApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIButton+Extentions.h"
@interface HomeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView_AppMenu;
@property (nonatomic, retain) IBOutlet UIButton *btn_login;
//-(IBAction)loginApp:(id)sender;
@end

