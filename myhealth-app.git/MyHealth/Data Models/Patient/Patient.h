//
//  Patient.h
//  MyHealth
//
//  Created by Ashish Chhabra on 03/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "PatientDetails.h"
@interface Patient : JSONModel

@property (nonatomic, retain) NSMutableDictionary <PatientDetails> *userDetails;
@end
