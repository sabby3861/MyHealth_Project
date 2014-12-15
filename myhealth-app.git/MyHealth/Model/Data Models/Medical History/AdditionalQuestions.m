//
//  AdditionalQuestions.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "AdditionalQuestions.h"

@implementation AdditionalQuestions
+(AdditionalQuestions*)fromDictionary:(NSDictionary*)dictionary
{
    AdditionalQuestions *additionalQues = [[AdditionalQuestions alloc] init];
    additionalQues.questionHeading = dictionary[@"questionHeading"];
    additionalQues.questionToID = dictionary[@"questionToID"];
    additionalQues.questionDate = dictionary[@"questionDate"];
    additionalQues.awnserText = dictionary[@"awnserText"];
    additionalQues.awnserDate = dictionary[@"awnserDate"];
    additionalQues.doctorID = dictionary[@"doctorID"];
    additionalQues.patientID = dictionary[@"patientID"];
    return additionalQues;
}
@end
