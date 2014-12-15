//
//  DoctorVisitDetail.h
//  MyHealth
//
//  Created by Noushad Shah on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
@protocol DoctorVisitDetail <NSObject>

@end
@interface DoctorVisitDetail : JSONModel

@property (nonatomic, retain) NSString *appointmentReason;
@property (nonatomic, retain) NSString *comments;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *doctorName;
@property (nonatomic, retain) NSString *linkToFilesInAppilication;
@property (nonatomic, retain) NSString *linkToMedication;
@property (nonatomic, retain) NSString *patientID;
+(DoctorVisitDetail*)fromDictionary:(NSDictionary*)dictionary;
@end
