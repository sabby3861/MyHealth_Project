//
//  AllergyStatus.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "AllergyStatus.h"

@implementation AllergyStatus
+(AllergyStatus*)getObject:(NSDictionary*)dictionary
{
    AllergyStatus *allergyStatus = [[AllergyStatus alloc] init];
    allergyStatus.yesNo=[dictionary objectForKey:@"yesNo"];
    return allergyStatus;
}
@end
