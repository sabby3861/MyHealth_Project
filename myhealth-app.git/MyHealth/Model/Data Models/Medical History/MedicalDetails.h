//
//  MedicalDetails.h
//  MyHealth
//
//  Created by Noushad Shah on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "MedicationSaveData.h"

@protocol MedicalDetails <NSObject>

@end

@interface MedicalDetails : JSONModel
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *dataFor;
@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) MedicationSaveData *savedData;
+(MedicalDetails*)fromDictionary:(NSDictionary*)dictionary;
@end
