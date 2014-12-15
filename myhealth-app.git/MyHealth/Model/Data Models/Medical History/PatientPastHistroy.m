//
//  PatientPastHistroy.m
//  MyHealth
//
//  Created by Ashish Chhabra on 13/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "PatientPastHistroy.h"

@implementation PatientPastHistroy
+(PatientPastHistroy*)fromDictionary:(NSDictionary*)dictionary
{
    PatientPastHistroy *patientPastHistory = [[PatientPastHistroy alloc] init];
    patientPastHistory.pataintInHospital=[PastRecord fromDictionary:[dictionary objectForKey:@"pataintInHospital"]];
    patientPastHistory.colonoscopy=[PastRecord fromDictionary:[dictionary objectForKey:@"colonoscopy"]];
    patientPastHistory.bloodTransfusion=[PastRecord fromDictionary:[dictionary objectForKey:@"bloodTransfusion"]];
    patientPastHistory.tetanusShot=[PastRecord fromDictionary:[dictionary objectForKey:@"tetanusShot"]];
    patientPastHistory.pneumoniaShot=[PastRecord fromDictionary:[dictionary objectForKey:@"pneumoniaShot"]];
    patientPastHistory.fluShot=[PastRecord fromDictionary:[dictionary objectForKey:@"fluShot"]];
    patientPastHistory.pregnantW=[PastRecord fromDictionary:[dictionary objectForKey:@"pregnantW"]];
    patientPastHistory.PAPSmear=[PastRecord fromDictionary:[dictionary objectForKey:@"PAPSmear"]];
    patientPastHistory.mammogram=[PastRecord fromDictionary:[dictionary objectForKey:@"mammogram"]];
    patientPastHistory.patientID=[dictionary objectForKey:@"patientID"];
    patientPastHistory.date=[dictionary objectForKey:@"date"];
    
    patientPastHistory.patientPastHealthArray=[[NSMutableArray alloc]init];
    [patientPastHistory.patientPastHealthArray addObjectsFromArray:[NSArray arrayWithObjects:
                                                                    patientPastHistory.pataintInHospital,
                                                                    patientPastHistory.colonoscopy,
                                                                    patientPastHistory.bloodTransfusion,
                                                                    patientPastHistory.tetanusShot,
                                                                    patientPastHistory.pneumoniaShot,
                                                                    patientPastHistory.fluShot,
                                                                    patientPastHistory.pregnantW,
                                                                    patientPastHistory.PAPSmear,
                                                                    patientPastHistory.mammogram,
                                                                    patientPastHistory.patientID,
                                                                    patientPastHistory.date,nil]];
    return patientPastHistory;
}
@end
