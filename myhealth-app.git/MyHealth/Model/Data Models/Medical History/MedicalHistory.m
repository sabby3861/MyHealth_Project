//
//  MedicalHistory.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "MedicalHistory.h"

@implementation MedicalHistory

-(id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

+(MedicalHistory*)fromDictionary:(NSDictionary*)dictionary
{
    MedicalHistory *medicalHistory = [[MedicalHistory alloc] init];
    
    if ([dictionary objectForKey:@"additionalQuestion"])
    {
        NSMutableArray  *additionalQuestionArr=[dictionary objectForKey:@"additionalQuestion"];
        if (additionalQuestionArr.count>0)
            medicalHistory.additionalQuestion = (id)[AdditionalInfo getObject:additionalQuestionArr];
    }

    if ([dictionary objectForKey:@"doctorVisit"])
    {
        //arrays are empty, add code later
        NSMutableArray  *doctorVisitArr=[dictionary objectForKey:@"doctorVisit"];
        if (doctorVisitArr.count>0)
            medicalHistory.doctorVisits = (id)[DoctorVisits getObject:doctorVisitArr];
    }
    if ([dictionary objectForKey:@"medication"])
    {
        //arrays are empty, add code later
        NSMutableArray  *medicationArr=[dictionary objectForKey:@"medication"];
                if (medicationArr.count>0)
                    medicalHistory.medication = (id)[Medication getObject:medicationArr];
    }
    if ([dictionary objectForKey:@"patientFamilyIllness"])
    {
        NSDictionary *patientFamilyiIlnessDict=[dictionary objectForKey:@"patientFamilyIllness"];
        medicalHistory.patientFamilyIllness = (id)[FamilyIllness fromDictionary:patientFamilyiIlnessDict];
    }
    if ([dictionary objectForKey:@"patientGeneralQuestion"])
    {
        NSDictionary *generalQuestionDict=[dictionary objectForKey:@"patientGeneralQuestion"];
        medicalHistory.patientGeneralQuestion= (id)[GeneralQuestions fromDictionary:generalQuestionDict];
    }
    
    if ([dictionary objectForKey:@"patientPastHistory"])
    {
        NSDictionary *patientPastHistoryDict=[dictionary objectForKey:@"patientPastHistory"];
        medicalHistory.patientPastHistory = (id)[PatientPastHistroy fromDictionary:patientPastHistoryDict];
    }
    
    if ([dictionary objectForKey:@"patientPresentHealth"])
    {
        NSDictionary *patientPresentHistoryDict=[dictionary objectForKey:@"patientPresentHealth"];
        medicalHistory.patientPresentHealth = (id)[PatientPresentHealth fromDictionary:patientPresentHistoryDict];
    }
    if ([dictionary objectForKey:@"patientGeneralInfo"])
    {
        NSDictionary *generalInfoDict=[dictionary objectForKey:@"patientGeneralInfo"];
        medicalHistory.info = (id)[GeneralInfo fromDictionary:generalInfoDict];
    }
    
    
 
  
    
      return medicalHistory;
}
@end
