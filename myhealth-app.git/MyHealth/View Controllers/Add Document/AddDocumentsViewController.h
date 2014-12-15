//
//  AddDocumentsViewController.h
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extentions.h"
@interface AddDocumentsViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *tblView_add;
@property (nonatomic, retain) IBOutlet UIButton *btn_back;

@property (nonatomic, retain) IBOutlet UITextField *txtField_name;
@property (nonatomic, retain) IBOutlet UITextField *txtField_text;

-(IBAction)createFolder:(id)sender;
-(IBAction)fetchFolders:(id)sender;
-(IBAction)deleteFolder:(id)sender;
@end
