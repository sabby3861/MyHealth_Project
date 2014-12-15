//
//  Degree.m
//  MyHealth
//
//  Created by Ashish Chhabra on 05/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "Degree.h"

@implementation Degree

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.doctorEducation = (id)[NSMutableArray new];
    }
    return self;
    
}
@end
