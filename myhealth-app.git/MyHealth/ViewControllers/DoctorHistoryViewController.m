//
//  DoctorHistoryViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 10/18/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "DoctorHistoryViewController.h"
#import "DoctorProfileViewController.h"
#import "DoctorHistoryTableViewCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "DoctorListing.h"
@interface DoctorHistoryViewController ()<UITextFieldDelegate>
{
    DoctorHistoryTableViewCell *cell;
    DoctorListing *model;
}
@end

@implementation DoctorHistoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tblView_doctorHistory registerNib:[UINib nibWithNibName:@"DoctorHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];

    [self getDoctorListing];
    
    model = [[DoctorListing alloc] init];
    // Do any additional setup after loading the view.
    _lbl_title.font = [UIFont fontWithName:@"Oswald-Regular" size:15];
    _btn_cancel.hidden = YES;
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    [_btn_cancel setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    [_btn_search setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* {
        bioInfo = asdfasdf;
        createdDate = "2014-11-02 19:17:35";
        doctorCity1 = test11;
        doctorCity2 = test22;
        doctorCity3 = test33;
        doctorCountry1 = test1111;
        doctorCountry2 = test2222;
        doctorCountry3 = test3333;
        doctorID = 1;
        doctorImage = "http://myhealth.brillisoft.net/upload_files/profile/1/IMG_0067.JPG";
        doctorPic = "";
        doctorRating =     {
            getDoctingRating = "3.80";
            getTotalRate = 5;
        };
        doctorStreetAddress1 = test1;
        doctorStreetAddress2 = test2;
        doctorStreetAddress3 = test3;
        doctorstate1 = test111;
        doctorstate2 = test222;
        doctorstate3 = test333;
        email = "praveensharma011089@gmail.com";
        experience = asdf;
        firstName = praveen;
        lastName = sharma;
        medicalCouncilRegNo = asdfa2312sdaf;
        memberDoctorsID = 2;
        memberID = 2;
        note = asdf;
        phoneNumber = 0;
        skill = asdf;
        specialization = asdf;
        username = pra;
    }*/
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ((indexPath.row == 0)) {
        
        //cell.viewBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
        cell.viewBg.backgroundColor = [UIColor clearColor];
        cell.viewBg.frame = CGRectMake(0, 7, 320, 64);
        
    } else {
        
        cell.viewBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_doctorspecial_middle.png"]];
    }
    cell.imgView_doctor.layer.cornerRadius = 23.0f;
    cell.imgView_doctor.layer.masksToBounds = YES;
    [cell.imgView_doctor setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[model.arrayListing objectAtIndex:indexPath.row] valueForKey:@"doctorImage"]]]]];
    
    [cell.lbl_name setFont:[UIFont fontWithName:@"Oswald-Regular" size:15]];
    [cell.lbl_experience setFont:[UIFont fontWithName:@"Oswald-Light" size:10]];
    [cell.lbl_landmark setFont:[UIFont fontWithName:@"Oswald-Light" size:9]];
    cell.lbl_name.text = [[[model.arrayListing objectAtIndex:indexPath.row] valueForKey:@"firstName"] uppercaseString];
    NSString *experience = [NSString stringWithFormat:@"%@, %@ YEARS",[[model.arrayListing objectAtIndex:indexPath.row] valueForKey:@"specialization"],[[model.arrayListing objectAtIndex:indexPath.row] valueForKey:@"experience"]];
   
    cell.lbl_experience.text = [experience uppercaseString];
    cell.lbl_landmark.text = [[[model.arrayListing objectAtIndex:indexPath.row] valueForKey:@"doctorCity1"] uppercaseString];
    cell.lbl_experience.textColor = [UIColor colorWithRed:21.0f/255.0f green:119.0f/255.0f blue:179.0f/255.0f alpha:1.0];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.arrayListing.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 70;
    }
    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DoctorProfileViewController *viewCtrl = [storyboard instantiateViewControllerWithIdentifier:@"DoctorProfileViewController"];
    viewCtrl.docInfo = [model.arrayListing objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}
// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getDoctorListing
{
    [MBProgressHUD showHUDAddedTo:_tblView_doctorHistory animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"pageNo": @"1"};
    [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/getAllDoctors?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:_tblView_doctorHistory animated:YES];
        model.arrayListing = [[responseObject valueForKey:@"DoctorData"] valueForKey:@"doctorDetail"];
        [_tblView_doctorHistory reloadData];
        
        NSLog(@"JSON: %@", model);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:_tblView_doctorHistory animated:YES];
        NSLog(@"Error: %@", error);
    }];
}
-(IBAction)cancelSearch:(id)sender
{
    _txtField_search.text = @"Find a doctor...";
    _btn_cancel.hidden = YES;
    _btn_search.hidden = NO;
    [self getDoctorListing];
}
-(IBAction)searchDoctor:(id)sender
{
    
    if ((_txtField_search.text.length == 0) || [_txtField_search.text isEqualToString:@"Find a doctor..."]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter some keyword to begin searching." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } else {
        
        _btn_cancel.hidden = NO;
        _btn_search.hidden = YES;
        
        [MBProgressHUD showHUDAddedTo:_tblView_doctorHistory animated:YES];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:_txtField_search.text forKey:@"search"];
        [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/searchDoctor?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Response-->>%@",responseObject);
            [MBProgressHUD hideAllHUDsForView:_tblView_doctorHistory animated:YES];
            
            model.arrayListing = [[responseObject valueForKey:@"DoctorData"] valueForKey:@"doctorDetail"];
            [_tblView_doctorHistory reloadData];
            if (model.arrayListing.count) {
                
                [_tblView_doctorHistory reloadData];
                
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideAllHUDsForView:_tblView_doctorHistory animated:YES];
            NSLog(@"Error: %@", error);
        }];
    }
    
}
#pragma mark —  UITextField Methods 
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@"Find a doctor..."]) {
        
        _txtField_search.text = @"";
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = @"Find a doctor...";
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
