//
//  MedicalHistory.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "MedicalHistory.h"

@implementation MedicalHistory

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.info = (id)[GeneralInfo new];
        self.questions = (id)[GeneralQuestions new];
        self.patientFamilyIllness = (id)[FamilyIllness new];
        self.medication = (id)[Medication new];
        self.additionalInfo = (id)[AdditionalInfo new];
        self.patientPresentHealth = (id)[PatientPresentHealth new];
        self.patientPastHistory = (id)[PatientPastHistroy new];
    }
    return self;
}
@end
