//
//  Patient.m
//  MyHealth
//
//  Created by Ashish Chhabra on 03/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "Patient.h"

@implementation Patient

-(id)init
{
    self = [super init];
    
    if (self) {
        
        self.userDetails = (id)[NSMutableArray new];
    }
    return self;
}
@end
