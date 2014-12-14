//
//  SufferingMembers.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "SufferingMembers.h"

@implementation SufferingMembers
+(SufferingMembers*)fromDictionary:(NSDictionary*)dictionary
{
    SufferingMembers *sufferingMembers = [[SufferingMembers alloc] init];
    sufferingMembers.dad=dictionary[@"dad"];
    sufferingMembers.dadsMomDad=dictionary[@"dadsMomDad"];
    sufferingMembers.mom=dictionary[@"mom"];
    sufferingMembers.momsMomDad= dictionary[@"momsMomDad"];
    return sufferingMembers;
}
@end
