//
//  EmergencyPreviewVC.m
//  MyHealth
//
//  Created by Parvind Bhatt on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "EmergencyPreviewVC.h"

@implementation EmergencyPreviewVC
{
    NSMutableDictionary *emergencyDict;
    NSMutableDictionary *emergencyLabelDict;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"emergencyDict"]) {
        
        emergencyDict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"emergencyDict"] mutableCopy];
        emergencyLabelDict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"emergencyLabelDict"] mutableCopy];
        [self emergencyField];
       
    }
}

- (void)emergencyField{
    int count=0;
    
    if ([emergencyDict objectForKey:@"name"]) {
        [self.label1 setText:[emergencyLabelDict valueForKey:@"namelabel"]];
        [self.textField1 setText:[emergencyDict valueForKey:@"name"]];
        count ++;
    }
    
    if ([emergencyDict objectForKey:@"address"] && count ==1) {
        [self.label2 setText:[emergencyLabelDict valueForKey:@"addresslabel"]];
        [self.textField2 setText:[emergencyDict valueForKey:@"address"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"address"]){
        [self.label1 setText:[emergencyLabelDict valueForKey:@"addresslabel"]];
        [self.textField1 setText:[emergencyDict valueForKey:@"address"]];
        count ++;
    }
    
    if ([emergencyDict objectForKey:@"phone"] && count == 2) {
        [self.label3 setText:[emergencyLabelDict valueForKey:@"phonelabel"]];
        [self.textField3 setText:[emergencyDict valueForKey:@"phone"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"phone"] && count == 1) {
        [self.label2 setText:[emergencyLabelDict valueForKey:@"phonelabel"]];
        [self.textField2 setText:[emergencyDict valueForKey:@"phone"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"phone"]) {
        [self.label1 setText:[emergencyLabelDict valueForKey:@"phonelabel"]];
        [self.textField1 setText:[emergencyDict valueForKey:@"name"]];
        count ++;
    }

    if ([emergencyDict objectForKey:@"ssn"] && count == 3) {
        [self.label4 setText:[emergencyLabelDict valueForKey:@"ssnlabel"]];
        [self.textField4 setText:[emergencyDict valueForKey:@"ssn"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"ssn"] && count == 2) {
        [self.label3 setText:[emergencyLabelDict valueForKey:@"ssnlabel"]];
        [self.textField3 setText:[emergencyDict valueForKey:@"ssn"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"ssn"] && count == 1) {
        [self.label2 setText:[emergencyLabelDict valueForKey:@"ssnlabel"]];
        [self.textField2 setText:[emergencyDict valueForKey:@"ssn"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"ssn"]) {
        [self.label1 setText:[emergencyLabelDict valueForKey:@"ssnlabel"]];
        [self.textField1 setText:[emergencyDict valueForKey:@"ssn"]];
        count ++;
    }
    
    
    if ([emergencyDict objectForKey:@"dob"] && count == 3) {
        [self.label4 setText:[emergencyLabelDict valueForKey:@"doblabel"]];
        [self.textField4 setText:[emergencyDict valueForKey:@"dob"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"dob"] && count == 2) {
        [self.label3 setText:[emergencyLabelDict valueForKey:@"doblabel"]];
        [self.textField3 setText:[emergencyDict valueForKey:@"dob"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"dob"] && count == 1) {
        [self.label2 setText:[emergencyLabelDict valueForKey:@"doblabel"]];
        [self.textField2 setText:[emergencyDict valueForKey:@"dob"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"dob"]) {
        [self.label1 setText:[emergencyLabelDict valueForKey:@"doblabel"]];
        [self.textField1 setText:[emergencyDict valueForKey:@"dob"]];
        count ++;
    }

    
    if ([emergencyDict objectForKey:@"emergency"] && count == 3) {
        [self.label4 setText:[emergencyLabelDict valueForKey:@"emergencylabel"]];
        [self.textField4 setText:[emergencyDict valueForKey:@"emergency"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"emergency"] && count == 2) {
        [self.label3 setText:[emergencyLabelDict valueForKey:@"emergencylabel"]];
        [self.textField3 setText:[emergencyDict valueForKey:@"emergency"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"emergency"] && count == 1) {
        [self.label2 setText:[emergencyLabelDict valueForKey:@"emergencylabel"]];
        [self.textField2 setText:[emergencyDict valueForKey:@"emergency"]];
        count ++;
    }else if ([emergencyDict objectForKey:@"emergency"]) {
        [self.label1 setText:[emergencyLabelDict valueForKey:@"emergencylabel"]];
        [self.textField1 setText:[emergencyDict valueForKey:@"emergency"]];
        count ++;
    }

    if ([emergencyDict count] == 4) {
        return;
    }else  if ([emergencyDict count] == 3) {
        [self.textField4 setHidden:YES];
        [self.icon4 setHidden:YES];
        [self.label4 setHidden:YES];

        return;
    }else if ([emergencyDict count] == 2){
        [self.textField4 setHidden:YES];
        [self.icon4 setHidden:YES];
        [self.label4 setHidden:YES];
        
        [self.textField3 setHidden:YES];
        [self.icon3 setHidden:YES];
        [self.label3 setHidden:YES];
        return;

    }else if ([emergencyDict count] == 1){
        [self.textField4 setHidden:YES];
        [self.icon4 setHidden:YES];
        [self.label4 setHidden:YES];
        
        [self.textField3 setHidden:YES];
        [self.icon3 setHidden:YES];
        [self.label3 setHidden:YES];
        
        [self.textField2 setHidden:YES];
        [self.icon2 setHidden:YES];
        [self.label2 setHidden:YES];
    
        return;
    }

}

-(UIImage*)captureView:(UIView *)yourView {
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [yourView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finishBtnClicked:(id)sender {
    [self.finishBtn setHidden:YES];
    [self.navbarImage setHidden:YES];
    [self.titleImage setHidden:YES];
    
    UIImageWriteToSavedPhotosAlbum([self captureView:self.view], nil, nil, nil);
    [self.finishBtn setHidden:NO];
    [self.navbarImage setHidden:NO];
    [self.titleImage setHidden:NO];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Image saved to photo album." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
