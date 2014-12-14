//
//  Illness.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "GeneralQuestions.h"
@implementation GeneralQuestions
+(GeneralQuestions*)fromDictionary:(NSDictionary*)dictionary
{
    if ([dictionary allKeys].count>0)
    {
        GeneralQuestions *generalQuestions = [[GeneralQuestions alloc] init];
        generalQuestions.bloodPressure = dictionary[@"bloodPressure"];
        generalQuestions.bloodResult = dictionary[@"bloodResult"];
        generalQuestions.bloodType = dictionary[@"bloodType"];
        generalQuestions.date = dictionary[@"date"];
        generalQuestions.patientID = dictionary[@"patientID"];
        generalQuestions.weight = dictionary[@"weight"];
        generalQuestions.yesNo = dictionary[@"yesNo"];
        generalQuestions.Allergies = [Allergies fromDictionary:dictionary[@"Allergies"]];
        return generalQuestions;
    }
    else
        return nil;
}
@end
