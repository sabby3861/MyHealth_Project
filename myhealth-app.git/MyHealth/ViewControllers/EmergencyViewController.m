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
    UIColor *placeholdercolor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    placeholdercolor = [UIColor colorWithRed:25.0/255.0 green:139.0/255.0 blue:210.0/255.0 alpha:1.0];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"statusDict"]) {
        statusDict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"statusDict"] mutableCopy];
    }else{
        statusDict = [[NSMutableDictionary alloc] init];
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
    if (sender.tag == 107)
        return;
    
    if (sender.selected){
        [statusDict setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        [sender setSelected:NO];
    } else {
        [statusDict setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        [sender setSelected:YES];
    }
    
    NSLog(@"%@",statusDict);
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setObject:statusDict forKey:@"statusDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
