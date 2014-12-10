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
@interface MedicalHistory : JSONModel

@property (nonatomic, retain) GeneralInfo *info;
@property (nonatomic, retain) GeneralQuestions *questions;
@property (nonatomic, retain) Medication *medication;
@property (nonatomic, retain) AdditionalInfo *additionalInfo;
@property (nonatomic, retain) PatientPresentHealth *patientPresentHealth;
@property (nonatomic, retain) FamilyIllness *patientFamilyIllness;
@property (nonatomic, retain) PatientPastHistroy *patientPastHistory;
@end
