//
//  TermsViewController.m
//  MyHealth
//
//  Created by Parvind Bhatt on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "TermsViewController.h"

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.termsLabel setText:@"Terms & Conditions Governing The Use\n Of The MyHealth Mobile Application\n\n Terms Of Use"];
    
    [self.termsDescrLabel setText:@"Downloading, installing, and using the pkshr mobile application (''MyHealth'' or ''the app'' or ''the software'') shall constitute the acceptance of the terms and conditions,limitations of liability, and privacy policy outlined this page,as updated from time to time, which shall remain in effect until terminated by BrilliSoft LLC and MQD BV (collectively referred to as ''The Developers'').We recommend that you periodically review this page.\n\n Pkshr requires cellular or wireless network connectivity to share pictures with other users, send emails - such as support emails,posting to social networks,notifications and so on. The Developers have no control over said network"];
}

-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
