//
//  DoctorVisits.h
//  MyHealth
//
//  Created by Ashish Chhabra on 07/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol DoctorVisits <NSObject>

@end
@interface DoctorVisits : JSONModel

@property (nonatomic, retain) NSString *appointmentReason;
@property (nonatomic, retain) NSString *comments;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *doctorName;
@property (nonatomic, retain) NSString *linkToFilesInAppilication;
@property (nonatomic, retain) NSString *linkToMedication;
@property (nonatomic, retain) NSString *patientID;

@end
