//
//  AllergyInfo.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "AllergyInfo.h"

@implementation AllergyInfo
+(AllergyInfo*)fromDictionary:(NSDictionary*)dictionary
{
    AllergyInfo *allergyInfo = [[AllergyInfo alloc] init];
    allergyInfo.result = dictionary[@"result"];
    allergyInfo.title = dictionary[@"title"];
    return allergyInfo;
}
@end
