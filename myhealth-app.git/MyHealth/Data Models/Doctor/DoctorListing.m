//
//  DoctorListing.m
//  MyHealth
//
//  Created by Ashish Chhabra on 02/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "DoctorListing.h"

@implementation DoctorListing

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.arrayListing = (id)[NSMutableArray new];
    }
    return self;
}
@end
