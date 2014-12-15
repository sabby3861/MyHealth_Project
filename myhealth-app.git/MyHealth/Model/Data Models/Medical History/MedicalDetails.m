//
//  MedicalDetails.m
//  MyHealth
//
//  Created by Noushad Shah on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "MedicalDetails.h"

@implementation MedicalDetails
-(id)init
{
    self = [super init];
    if (self) {
  
        self.savedData = [MedicationSaveData new];
    }
    
    return self;
}

+(MedicalDetails*)fromDictionary:(NSDictionary*)dictionary
{
    if ([dictionary allKeys].count>0)
    {
        MedicalDetails *medicalDetails = [[MedicalDetails alloc] init];
        medicalDetails.ID = dictionary[@"ID"];
        medicalDetails.dataFor = dictionary[@"dataFor"];
        medicalDetails.patientID = dictionary[@"patientID"];
        medicalDetails.savedData = [MedicationSaveData fromDictionary:dictionary[@"savedData"]];
        return medicalDetails;
    }
    else
        return nil;
}

@end
