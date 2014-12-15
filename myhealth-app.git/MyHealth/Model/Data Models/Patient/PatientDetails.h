//
//  PatientDetails.h
//  MyHealth
//
//  Created by Ashish Chhabra on 03/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol PatientDetails <NSObject>

@end

@interface PatientDetails : JSONModel

@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) NSString *user_email;
@property (nonatomic, retain) NSString *user_image;
@property (nonatomic, retain) NSString *user_name;

@end
