//
//  GeneralInfo.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "GeneralInfo.h"

@implementation GeneralInfo
-(id)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

+(GeneralInfo*)fromDictionary:(NSDictionary*)dictionary
{
    if ([dictionary allKeys].count>0)
    {
        GeneralInfo *generalInfo = [[GeneralInfo alloc] init];
        generalInfo.name = dictionary[@"name"];
        generalInfo.address = dictionary[@"address"];
        generalInfo.phone = dictionary[@"phone"];
        generalInfo.ssn = dictionary[@"ssn"];
        generalInfo.dob = dictionary[@"dob"];
        generalInfo.emergencyContact = dictionary[@"emergencyContact"];
        generalInfo.sex = dictionary[@"sex"];
        return generalInfo;
    }
    else
        return nil;
}
@end
