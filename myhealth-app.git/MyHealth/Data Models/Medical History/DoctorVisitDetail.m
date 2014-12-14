//
//  DoctorVisitDetail.m
//  MyHealth
//
//  Created by Noushad Shah on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "DoctorVisitDetail.h"

@implementation DoctorVisitDetail
+(DoctorVisitDetail*)fromDictionary:(NSDictionary*)dictionary
{
    if ([dictionary allKeys].count>0)
    {
        DoctorVisitDetail *doctorVisitsdetail = [[DoctorVisitDetail alloc] init];
        doctorVisitsdetail.appointmentReason = dictionary[@"appointmentReason"];
        doctorVisitsdetail.comments = dictionary[@"comments"];
        doctorVisitsdetail.date = dictionary[@"date"];
        doctorVisitsdetail.doctorName = dictionary[@"doctorName"];
        doctorVisitsdetail.linkToFilesInAppilication = dictionary[@"linkToFilesInAppilication"];
        doctorVisitsdetail.linkToMedication = dictionary[@"linkToMedication"];
        doctorVisitsdetail.patientID = dictionary[@"patientID"];
        return doctorVisitsdetail;
    }
    else
        return nil;
}
@end
