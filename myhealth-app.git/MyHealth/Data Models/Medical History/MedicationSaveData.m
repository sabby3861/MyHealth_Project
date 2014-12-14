//
//  MedicationSaveData.m
//  MyHealth
//
//  Created by Noushad Shah on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "MedicationSaveData.h"

@implementation MedicationSaveData
+(MedicationSaveData*)fromDictionary:(NSDictionary*)dictionary
{
    if ([dictionary allKeys].count>0)
    {
        MedicationSaveData *medicalSavedData = [[MedicationSaveData alloc] init];
        medicalSavedData.date = dictionary[@"date"];
        medicalSavedData.dateEnded = dictionary[@"dateEnded"];
        medicalSavedData.dateStarted = dictionary[@"dateStarted"];
        medicalSavedData.dose = dictionary[@"dose"];
        medicalSavedData.howAndHowOftenYouTakeTheMedication = dictionary[@"howAndHowOftenYouTakeTheMedication"];
        medicalSavedData.linksToFilesInApplication = dictionary[@"linksToFilesInApplication"];
        medicalSavedData.medication = dictionary[@"medication"];
        medicalSavedData.patientID = dictionary[@"patientID"];
        medicalSavedData.prescriber = dictionary[@"prescriber"];
        medicalSavedData.reasonOfTaking = dictionary[@"reasonOfTaking"];
        return medicalSavedData;
    }
    else
        return nil;
}
@end
