//
//  IllnessDetails.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "IllnessDetails.h"

@implementation IllnessDetails
+(IllnessDetails*)fromDictionary:(NSDictionary*)dictionary
{
    IllnessDetails *illnessDetails = [[IllnessDetails alloc] init];
    illnessDetails.answer=dictionary[@"answer"];
    illnessDetails.who = (id)[SufferingMembers fromDictionary:dictionary[@"who"]];
    return illnessDetails;
}
@end
