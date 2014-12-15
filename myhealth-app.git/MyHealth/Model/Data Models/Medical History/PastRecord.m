//
//  PastRecord.m
//  MyHealth
//
//  Created by Ashish Chhabra on 13/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "PastRecord.h"

@implementation PastRecord
+(PastRecord*)fromDictionary:(NSDictionary*)dictionary
{
    PastRecord *pastRecord = [[PastRecord alloc] init];
    pastRecord.when = dictionary[@"when"];
    pastRecord.yesNo = dictionary[@"yesNo"];
    return pastRecord;
}
@end
