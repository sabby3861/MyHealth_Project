//
//  IllnessDetails.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "IllnessDetails.h"

@implementation IllnessDetails

-(id)init
{
    self = [super init];
    if (self) {
        
        self.who = (id)[SufferingMembers new];
    }
    return self;
}
@end
