//
//  DegreeDetails.h
//  MyHealth
//
//  Created by Ashish Chhabra on 05/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol DegreeDetails <NSObject>

@end

@interface DegreeDetails : JSONModel

@property (nonatomic, retain) NSString *educationType;
@property (nonatomic, retain) NSString *educationCollage;
@property (nonatomic, retain) NSString *educationDescription;
@property (nonatomic, retain) NSString *doctorEducationID;
@property (nonatomic, retain) NSString *educationName;
@property (nonatomic, retain) NSString *educationIn;
@property (nonatomic, retain) NSString *doctorID;
@property (nonatomic, retain) NSString *status;

@end
