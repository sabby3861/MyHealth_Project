//
//  DoctorInfo.h
//  MyHealth
//
//  Created by Ashish Chhabra on 02/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol DoctorInfo <NSObject>
@end

@interface DoctorInfo : JSONModel

@property (nonatomic, retain) NSString *bioInfo;
@property (nonatomic, retain) NSString *createdDate;
@property (nonatomic, retain) NSString *doctorCity1;
@property (nonatomic, retain) NSString *doctorCity2;
@property (nonatomic, retain) NSString *doctorCity3;
@property (nonatomic, retain) NSString *doctorCountry1;
@property (nonatomic, retain) NSString *doctorCountry2;
@property (nonatomic, retain) NSString *doctorCountry3;
@property (nonatomic, retain) NSString *doctorID;
@property (nonatomic, retain) NSString *doctorPic;
@property (nonatomic, retain) NSString *doctorStreetAddress1;
@property (nonatomic, retain) NSString *doctorStreetAddress2;
@property (nonatomic, retain) NSString *doctorStreetAddress3;
@property (nonatomic, retain) NSString *doctorTotalRating;
@property (nonatomic, retain) NSString *doctorstate1;
@property (nonatomic, retain) NSString *doctorstate2;
@property (nonatomic, retain) NSString *doctorstate3;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *experience;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *medicalCouncilRegNo;
@property (nonatomic, retain) NSString *memberDoctorsID;
@property (nonatomic, retain) NSString *memberID;
@property (nonatomic, retain) NSString *note;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *skill;
@property (nonatomic, retain) NSString *specialization;
@property (nonatomic, retain) NSString *username;



@end
