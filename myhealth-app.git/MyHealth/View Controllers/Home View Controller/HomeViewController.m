//
//  ViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 10/14/14.
//  Copyright (c) 2014 HealthApp. All rights reserved.
//

#import "HomeViewController.h"
#import "DoctorHistoryViewController.h"
#import "MenuCustomCollectionViewCell.h"
#import "MedicalHistoryViewController.h"
#import "MedicalDocumentsViewController.h"
#import "WYPopoverController.h"
#import "SettingsViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "PathHelper.h"
#import "NSString+SCPaths.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface HomeViewController ()<WYPopoverControllerDelegate,UIAlertViewDelegate>
{
    MenuCustomCollectionViewCell *customCollectionViewCell;
    WYPopoverController *popoverController;
    NSMutableArray *arrayMenuItems;
    NSMutableArray *arrayMenuItemInfo;
    NSMutableArray *arrayItemImages;
    UIButton *btn_menu;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    UIImage *theImage=[UIImage imageNamed:@"icon_file@2x.png"];
    NSData *theData=UIImagePNGRepresentation(theImage);
    NSString *path = [[PathHelper documentDirectoryPath] stringByAppendingPathComponent:@"icon_file@2x.png"];
    
    NSDictionary *dic = @{@"1":@"2",@"3":@"4",@"5":@"6"};
    [NSString asyncSaveData:theData withPath:path callback:^(BOOL succeed) {
        if (succeed) {
            NSLog(@"Succcess");
        }
        [NSString asyncLoadDataFromPath:path
                               callback:^(NSObject *data) {
                                   NSLog(@"Data%@",data);
                                   NSLog(@"Path is %@",path);
                                   UIImageView *theImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
                                   theImageView.image=[UIImage imageWithData:data];
                                   [self.view addSubview:theImageView];
                                   /*
                                   [NSString removeFileAtPath:[PathHelper documentDirectoryPath] condition:^BOOL(NSDictionary *fileInfo) {
                                       NSLog(@"File info is %@",fileInfo);
                                       return  true;
                                   }];*/
                                   /*
                                   [NSString asyncRemoveDirectoryAtPath:[PathHelper documentDirectoryPath] condition:^BOOL(NSDictionary *fileInfo) {
                                       NSLog(@"File info is %@",fileInfo);
                                       return  true;
                                   }];
                                   
                               }];
        NSLog(@"开始读取...");
    }];
    NSLog(@"开始写入...");
    */
    
    
    /*
    [NSString writeAppendToFile:path fromObject:theData];
    UIImageView *theImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    theImageView.image=[UIImage imageWithData:[NSString readFromFile:path toObject:2]];
    [self.view addSubview:theImageView];
    */
    arrayMenuItems = [[NSMutableArray alloc]init];
    [arrayMenuItems addObject:@"MEDICAL\nHISTORY"];
    [arrayMenuItems addObject:@"DOCTOR\nDIRECTORY"];
    [arrayMenuItems addObject:@"MEDICAL\nDOCUMENTS"];
    [arrayMenuItems addObject:@"MYHEALTH\nSETTING"];
    
    arrayMenuItemInfo = [[NSMutableArray alloc] init];
    [arrayMenuItemInfo addObject:@"MY MEDICAL\nINFORMATION"];
    [arrayMenuItemInfo addObject:@"FIND, RATE,\nRECOMMEND DOCTORS"];
    [arrayMenuItemInfo addObject:@"DOCUMENTS, RESULTS,\n AND REPORTS"];
    [arrayMenuItemInfo addObject:@"VIEW & CHANGE\nAPP SETTINGS"];
    
    arrayItemImages = [[NSMutableArray alloc] init];
    [arrayItemImages addObject:@"icon_medicalhistory.png"];
    [arrayItemImages addObject:@"icon_doctordirectory.png"];
    [arrayItemImages addObject:@"icon_medicaldocs.png"];
    [arrayItemImages addObject:@"icon_settings.png"];
    
    [_collectionView_AppMenu registerNib:[UINib nibWithNibName:@"MenuCustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MenuCustomCollectionViewCell"];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"username"] && [[NSUserDefaults standardUserDefaults] valueForKey:@"password"] && [[NSUserDefaults standardUserDefaults] valueForKey:@"remember"]) {
        
        _btn_login.hidden = YES;
        
        btn_menu = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_menu.frame = CGRectMake(20, 30, 30, 30);
        btn_menu.layer.cornerRadius = 15.0f;
        btn_menu.layer.masksToBounds = YES;
        [btn_menu addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_menu];
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"refresh"] isEqualToString:@"YES"]) {
            
            [self loginAppAutomatically];
        }
        
    }
    else if ([[AppDelegate sharedAppDelegate]isUserLoggedIn]==1) {
        _btn_login.hidden = YES;
        btn_menu = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_menu.frame = CGRectMake(20, 30, 30, 30);
        btn_menu.layer.cornerRadius = 15.0f;
        btn_menu.layer.masksToBounds = YES;
        [btn_menu addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_menu];
        [self loginAppAutomatically];
    }
    else {
        
        _btn_login.hidden = NO;
        btn_menu.hidden = YES;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UICollectionView Methods
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCustomCollectionViewCell" forIndexPath:indexPath];
    
    [customCollectionViewCell.lbl_menuItem setFont:[UIFont fontWithName:@"Oswald-Regular" size:15]];
    [customCollectionViewCell.lbl_menuItemInfo setFont:[UIFont fontWithName:@"Oswald-Light" size:10]];
    customCollectionViewCell.lbl_menuItem.text = [arrayMenuItems objectAtIndex:indexPath.row];
    customCollectionViewCell.lbl_menuItemInfo.text = [arrayMenuItemInfo objectAtIndex:indexPath.row];
    customCollectionViewCell.imgView_item.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImage *image = [UIImage imageNamed:[arrayItemImages objectAtIndex:indexPath.row]];
    [customCollectionViewCell.imgView_item setImage:image];
    
    return customCollectionViewCell;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSLog(@"Index Path-->>%ld",(long)indexPath.row);
    if ((indexPath.row == 0)) {
        
        UIViewController *viewCrtl = [storyboard instantiateViewControllerWithIdentifier:@"MedicalHistoryViewController"];
        [self.navigationController pushViewController:viewCrtl animated:YES];
        
    } else if (indexPath.row == 1){
        
        UIViewController *viewCrtl = [storyboard instantiateViewControllerWithIdentifier:@"DoctorHistoryViewController"];
        [self.navigationController pushViewController:viewCrtl animated:YES];
    } else if (indexPath.row == 2){
        
        UIViewController *viewCrtl = [storyboard instantiateViewControllerWithIdentifier:@"MedicalDocumentsViewController"];
        [self.navigationController pushViewController:viewCrtl animated:YES];
    } else if (indexPath.row == 3){
        
        UIViewController *viewCrtl = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        [self.navigationController pushViewController:viewCrtl animated:YES];
    }
    
}
-(void)loginAppAutomatically
{
    _btn_login.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"refresh"];
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SVProgressHUD showWithStatus:@""
                         maskType:SVProgressHUDMaskTypeNone];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    [tempDictionary setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"] forKeyPath:@"user_name"];
    [tempDictionary setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"password"] forKeyPath:@"user_password"];
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] isEqualToString:@"facebook"]) {
        
        [tempDictionary setValue:@"1" forKeyPath:@"user_type"];
        
    } else {
        
        [tempDictionary setValue:@"2" forKeyPath:@"user_type"];
        [tempDictionary setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"fb_id"] forKeyPath:@"user_fb_id"];
    }
    
    [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/get_login?" parameters:tempDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"LoggedIn" forKey:@"login"];
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        [SVProgressHUD dismiss];
        NSLog(@"JSON: %@", responseObject);
        if ([[responseObject valueForKey:@"status"] isEqualToString:@"error"]) {
            
            _btn_login.hidden = NO;
            btn_menu.hidden = YES;
            
        } else {
            
            btn_menu.hidden = NO;
            _btn_login.hidden = YES;
            
        }
        [btn_menu setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[responseObject valueForKey:@"user_details"] objectAtIndex:0] valueForKey:@"user_image"]]]] forState:UIControlStateNormal];
        ((AppDelegate *)[UIApplication sharedApplication].delegate).patient = [[responseObject valueForKey:@"user_details"] objectAtIndex:0];
        NSLog(@"user details:%@",((AppDelegate *)[UIApplication sharedApplication].delegate).patient);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        [SVProgressHUD dismiss];
         NSLog(@"Response-->>%@",operation.responseString);
        NSLog(@"Error: %@", error);
    }];
}
#pragma mark - Popover Delegates
- (IBAction)showPopover:(UIButton *)sender
{
    UIViewController *controller = [[UIViewController alloc] init];
    popoverController = [[WYPopoverController alloc] initWithContentViewController:controller];
    
   //controller.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    popoverController.delegate = self;

    popoverController.theme = [WYPopoverTheme theme];
    
    
    WYPopoverBackgroundView *appearance = [WYPopoverBackgroundView appearance];
    [appearance setTintColor:[UIColor orangeColor]];
    controller.preferredContentSize = CGSizeMake(200, 30);
    
    UIButton *btn_profile = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_profile.frame = CGRectMake(0, 0, 100, 30);
    btn_profile.titleLabel.font = [UIFont fontWithName:@"Oswald-Regular" size:15];
    btn_profile.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [btn_profile setTitle:@"Profile" forState:UIControlStateNormal];
    [controller.view addSubview:btn_profile];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 1, 300)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *btn_logout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_logout setTitle:@"Logout" forState:UIControlStateNormal];
    btn_logout.titleLabel.font = [UIFont fontWithName:@"Oswald-Regular" size:15];
    [btn_logout addTarget:self action:@selector(logOutApp) forControlEvents:UIControlEventTouchUpInside];
    btn_logout.frame = CGRectMake(101, 0, 100, 30);
    btn_logout.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [controller.view addSubview:btn_logout];
    
    [popoverController presentPopoverFromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, 30, 30) inView:self.view permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}
-(void)logOutApp
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Do you really want to logout app." delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"remember"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        _btn_login.hidden = NO;
        btn_menu.hidden = YES;
        [popoverController dismissPopoverAnimated:YES];
    }
}
@end
