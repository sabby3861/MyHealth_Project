//
//  Allergies.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "Allergies.h"

@implementation Allergies

-(id)init
{
    self = [super init];
    
    if (self) {
        
        self.eachFiled = (id)[AllergyInfo new];
    }
    return self;
}
@end
