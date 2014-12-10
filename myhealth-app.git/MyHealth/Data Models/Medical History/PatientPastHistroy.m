//
//  PatientPastHistroy.m
//  MyHealth
//
//  Created by Ashish Chhabra on 13/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "PatientPastHistroy.h"

@implementation PatientPastHistroy

-(id)init
{
    self = [super init];
    if (self) {
        
        self.PAPSmear = (id)[PastRecord new];
        self.bloodTransfusion = (id)[PastRecord new];
        self.colonoscopy = (id)[PastRecord new];
        self.fluShot = (id)[PastRecord new];
        self.mammogram = (id)[PastRecord new];
        self.pneumoniaShot = (id)[PastRecord new];
        self.pregnantW = (id)[PastRecord new];
        self.tetanusShot = (id)[PastRecord new];
        
    }
    return self;
}
@end
