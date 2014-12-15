//
//  GlobalVariables.m
//  iCarAsia
//
//  Created by ashish on 16/09/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables

@synthesize AppToken = _AppToken;
+(GlobalVariables *) sharedInstance
{
    static GlobalVariables *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[GlobalVariables alloc] init];
    });
    
    return instance;
}
-(id)init
{
    self = [super init];
    if (self) {
       
        _AppToken = nil;
    }
    return self;
}


@end
