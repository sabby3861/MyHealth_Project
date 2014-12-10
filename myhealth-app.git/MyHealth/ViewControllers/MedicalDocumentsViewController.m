//
//  MedicalDocumentsViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 23/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "MedicalDocumentsViewController.h"
#import "MedicalDocumentsCustomCell.h"
#import "MGSwipeButton.h"

@interface MedicalDocumentsViewController ()
{
    MedicalDocumentsCustomCell *cell;
}
@end

@implementation MedicalDocumentsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tblView_medicalHistory registerNib:[UINib nibWithNibName:@"MedicalDocumentsCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    // Do any additional setup after loading the view.
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
    cell.delegate = self;
    if ((indexPath.row == 0)) {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
        
    } else {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_doctorspecial_middle.png"]];
    }
    
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark -  MGSwipeTableCell Delegate

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    return YES;
}

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    expansionSettings.buttonIndex = 0;
    
    if (direction == MGSwipeDirectionLeftToRight) {
       
        
    }
    else {
        
        //expansionSettings.fillOnTrigger = YES;
        expansionSettings.fillOnTrigger = NO;
        cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
        
        expansionSettings.threshold = 1.1;
        
        CGFloat padding = 15;
        
        MGSwipeButton * trash = [MGSwipeButton buttonWithTitle:@"Trash" backgroundColor:[UIColor clearColor] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {
         
            return YES;
        }];
        [trash setBackgroundImage:[UIImage imageNamed:@"button_delete.png"] forState:UIControlStateNormal];
        [trash setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        MGSwipeButton * flag = [MGSwipeButton buttonWithTitle:@"Flag" backgroundColor:[UIColor clearColor] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {
            
            return YES;
        }];
        
        [flag setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [flag setBackgroundImage:[UIImage imageNamed:@"button_move.png"] forState:UIControlStateNormal];
        return @[trash, flag];
    }
    
    return nil;
    
}
// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
