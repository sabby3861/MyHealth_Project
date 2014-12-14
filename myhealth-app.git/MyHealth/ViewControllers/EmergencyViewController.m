//
//  EmergencyViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController
{
    NSMutableDictionary *statusDict;
    NSMutableDictionary *emergencyDict;
    NSMutableDictionary *emergencyLabelDict;

    UIColor *placeholdercolor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    placeholdercolor = [UIColor colorWithRed:25.0/255.0 green:139.0/255.0 blue:210.0/255.0 alpha:1.0];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"statusDict"]) {
        statusDict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"statusDict"] mutableCopy];
        emergencyDict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"emergencyDict"] mutableCopy];
        emergencyLabelDict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"emergencyLabelDict"] mutableCopy];

    }else{
        statusDict = [[NSMutableDictionary alloc] init];
        emergencyDict = [[NSMutableDictionary alloc] init];
        emergencyLabelDict = [[NSMutableDictionary alloc] init];

        for (int i = 101; i<107; i++) {
            [statusDict setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",i]];
        }
     
    }
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    // Do any additional setup after loading the view.
    [self setEmergencyBtnStatus];
    [self setPlaceholderText];
}
#pragma setEmergencyBtnStatus
#pragma done by parvind
- (void)setEmergencyBtnStatus{
    
    if ([[statusDict valueForKey:@"101"] boolValue])
        [self.nameButton setSelected:YES];
    else
        [self.nameButton setSelected:NO];
    
    if ([[statusDict valueForKey:@"102"] boolValue])
        [self.addressButton setSelected:YES];
    else
        [self.addressButton setSelected:NO];
    
    if ([[statusDict valueForKey:@"103"] boolValue])
        [self.phoneButton setSelected:YES];
    else
        [self.phoneButton setSelected:NO];
    
    if ([[statusDict valueForKey:@"104"] boolValue])
        [self.ssnButton setSelected:YES];
    else
        [self.ssnButton setSelected:NO];
    
    if ([[statusDict valueForKey:@"105"] boolValue])
        [self.dobButton setSelected:YES];
    else
        [self.dobButton setSelected:NO];
    
    if ([[statusDict valueForKey:@"106"] boolValue])
        [self.emergencyButton setSelected:YES];
    else
        [self.emergencyButton setSelected:NO];

    
    if ([emergencyDict objectForKey:@"name"])
        [self.nameTextField setText:[emergencyDict valueForKey:@"name"]];
    
    if ([emergencyDict objectForKey:@"address"])
        [self.addressTextField setText:[emergencyDict valueForKey:@"address"]];

    if ([emergencyDict objectForKey:@"phone"])
        [self.phoneTextField setText:[emergencyDict valueForKey:@"phone"]];

    if ([emergencyDict objectForKey:@"ssn"])
        [self.ssnTextField setText:[emergencyDict valueForKey:@"ssn"]];

    if ([emergencyDict objectForKey:@"dob"])
        [self.dobTextField setText:[emergencyDict valueForKey:@"dob"]];
    
    if ([emergencyDict objectForKey:@"emergency"])
        [self.emergencyTextField setText:[emergencyDict valueForKey:@"emergency"]];

}

#pragma setPlaceholderText
#pragma done by parvind
- (void)setPlaceholderText{
    if ([self.nameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.nameTextField.placeholder attributes:@{NSForegroundColorAttributeName: placeholdercolor}];
        
          self.addressTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.addressTextField.placeholder attributes:@{NSForegroundColorAttributeName: placeholdercolor}];
        
          self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.phoneTextField.placeholder attributes:@{NSForegroundColorAttributeName: placeholdercolor}];
        
          self.ssnTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.ssnTextField.placeholder attributes:@{NSForegroundColorAttributeName: placeholdercolor}];
        
          self.dobTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.dobTextField.placeholder attributes:@{NSForegroundColorAttributeName: placeholdercolor}];
        
          self.emergencyTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.emergencyTextField.placeholder attributes:@{NSForegroundColorAttributeName: placeholdercolor}];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma emergencyBtnClicked
#pragma done by parvind

- (IBAction)emergencyBtnClicked:(UIButton *)sender {
    if (sender.tag == 107){
        [self performSegueWithIdentifier:@"emerg_prev" sender:self];
        return;

    }
    
    if (sender.selected){
        
        [statusDict setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        [sender setSelected:NO];

        if (sender.tag == 101) {
            [emergencyDict removeObjectForKey:@"name"];
            [emergencyLabelDict removeObjectForKey:@"namelabel"];

        }else if (sender.tag == 102) {
            [emergencyDict removeObjectForKey:@"address"];
            [emergencyLabelDict removeObjectForKey:@"addresslabel"];

        }else if (sender.tag == 103) {
            [emergencyDict removeObjectForKey:@"phone"];
            [emergencyLabelDict removeObjectForKey:@"phonelabel"];

        }else if (sender.tag == 104) {
            [emergencyDict removeObjectForKey:@"ssn"];
            [emergencyLabelDict removeObjectForKey:@"ssnlabel"];

        }else if (sender.tag == 105) {
            [emergencyDict removeObjectForKey:@"dob"];
            [emergencyLabelDict removeObjectForKey:@"doblabel"];

        }else if (sender.tag == 106) {
            [emergencyDict removeObjectForKey:@"emergency"];
            [emergencyLabelDict removeObjectForKey:@"emergencylabel"];

        }

       
    } else {
        
        if ([emergencyDict count]>3) {
            return;
        }else {
            [statusDict setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            [sender setSelected:YES];
            
            if (sender.tag == 101) {
                [emergencyDict setObject:self.nameTextField.text forKey:@"name"];
                [emergencyLabelDict setObject:@"Name" forKey:@"namelabel"];
            }else if (sender.tag == 102) {
                [emergencyDict setObject:self.addressTextField.text forKey:@"address"];
                [emergencyLabelDict setObject:@"Address" forKey:@"addresslabel"];

            }else if (sender.tag == 103) {
                [emergencyDict setObject:self.phoneTextField.text forKey:@"phone"];
                [emergencyLabelDict setObject:@"Phone number" forKey:@"phonelabel"];

            }else if (sender.tag == 104) {
                [emergencyDict setObject:self.ssnTextField.text forKey:@"ssn"];
                [emergencyLabelDict setObject:@"Social security number" forKey:@"ssnlabel"];

            }else if (sender.tag == 105) {
                [emergencyDict setObject:self.dobTextField.text forKey:@"dob"];
                [emergencyLabelDict setObject:@"DOB" forKey:@"doblabel"];

            }else if (sender.tag == 106) {
                [emergencyDict setObject:self.emergencyTextField.text forKey:@"emergency"];
                [emergencyLabelDict setObject:@"Emergency contact number" forKey:@"emergencylabel"];

            }
        }
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setObject:emergencyDict forKey:@"emergencyDict"];
    [[NSUserDefaults standardUserDefaults] setObject:statusDict forKey:@"statusDict"];

    [[NSUserDefaults standardUserDefaults] setObject:emergencyLabelDict forKey:@"emergencyLabelDict"];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
