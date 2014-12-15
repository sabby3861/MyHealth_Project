//
//  MedicalHistory.h
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "JSONModel.h"
#import "GeneralInfo.h"
#import "GeneralQuestions.h"
#import "FamilyIllness.h"
#import "AdditionalInfo.h"
#import "PatientPresentHealth.h"
#import "PatientPastHistroy.h"
#import "Medication.h"
#import "DoctorVisits.h"
@interface MedicalHistory : JSONModel
@property (nonatomic, retain) AdditionalInfo *additionalQuestion;
@property (nonatomic, retain) DoctorVisits *doctorVisits;
@property (nonatomic, retain) Medication *medication;

@property (nonatomic, retain) GeneralInfo *info;
@property (nonatomic, retain) GeneralQuestions *patientGeneralQuestion;
@property (nonatomic, retain) FamilyIllness *patientFamilyIllness;

@property (nonatomic, retain) PatientPresentHealth *patientPresentHealth;
@property (nonatomic, retain) PatientPastHistroy *patientPastHistory;
+(MedicalHistory*)fromDictionary:(NSDictionary*)dictionary;
@end
