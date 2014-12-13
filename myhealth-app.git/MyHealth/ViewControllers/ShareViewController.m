//
//  ShareViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareCustomCell.h"
#import "SyncViewController.h"

@interface ShareViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ShareCustomCell *cell;
    NSMutableArray *arrayShareType;
    NSMutableArray *arrayImages;
}
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self.tblView_share registerNib:[UINib nibWithNibName:@"ShareCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    
    arrayShareType = [[NSMutableArray alloc] init];
    [arrayShareType addObject:@"Dropbox"];
    [arrayShareType addObject:@"One Drive"];
    [arrayShareType addObject:@"iCloud"];
    [arrayShareType addObject:@"Google Drive"];
    
    arrayImages = [[NSMutableArray alloc] init];
    [arrayImages addObject:@"icon_connectdropbox.png"];
    [arrayImages addObject:@"icon_connectonedrive.png"];
    [arrayImages addObject:@"icon_connecticloud.png"];
    [arrayImages addObject:@"icon_connectonedrive.png"];
    
    _tblView_share.scrollEnabled = NO;
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([self isModal]) {
        
        //        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        SyncViewController *viewCtrl = [stinitWithNibName:@"SyncViewController" bundle:nil];
        //        [self.navigationController pushViewController:viewCtrl animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
    
    if ((indexPath.row == 0)) {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
        
    } else {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_doctorspecial_middle.png"]];
    }
    cell.lbl_source.text = [arrayShareType objectAtIndex:indexPath.row];
    [cell.imgView setImage:[UIImage imageNamed:[arrayImages objectAtIndex:indexPath.row]]];
    cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case dropBox:
        {
            UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SyncViewController *viewCtrl = [stroryboard instantiateViewControllerWithIdentifier:@"SyncViewController"];
            viewCtrl.whichPlatform=dropBox;
            [self.navigationController pushViewController:viewCtrl animated:YES];
        }
            break;
        case oneDrive:
        {
            UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SyncViewController *viewCtrl = [stroryboard instantiateViewControllerWithIdentifier:@"SyncViewController"];
            viewCtrl.whichPlatform=oneDrive;
            [self.navigationController pushViewController:viewCtrl animated:YES];
        }
            break;
        case iCloud:
        {
            UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SyncViewController *viewCtrl = [stroryboard instantiateViewControllerWithIdentifier:@"SyncViewController"];
            viewCtrl.whichPlatform=iCloud;
            [self.navigationController pushViewController:viewCtrl animated:YES];
        }
            break;
        case googleDrive:
        {
            UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SyncViewController *viewCtrl = [stroryboard instantiateViewControllerWithIdentifier:@"SyncViewController"];
            viewCtrl.whichPlatform=googleDrive;
            [self.navigationController pushViewController:viewCtrl animated:YES];
        }
        default:
        break;
    }
}

// Navigate Back
-(IBAction)navigateback:(id)sender
{
    if(self.isModal)
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    else
        [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  DropBox Methods
-(void)syncAppFilesAndFolersWithDropbox
{
    
}
- (BOOL)isModal {
    if([self presentingViewController])
        return YES;
    if([[self presentingViewController] presentedViewController] == self)
        return YES;
    if([[[self navigationController] presentingViewController] presentedViewController] == [self navigationController])
        return YES;
    if([[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]])
        return YES;
    
    return NO;
}
@end
