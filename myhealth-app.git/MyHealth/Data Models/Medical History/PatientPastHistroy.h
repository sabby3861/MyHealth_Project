//
//  PatientPastHistroy.h
//  MyHealth
//
//  Created by Ashish Chhabra on 13/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "PastRecord.h"

@protocol PatientPastHistroy <NSObject>

@end

@interface PatientPastHistroy : JSONModel

@property (nonatomic, retain) PastRecord *PAPSmear;
@property (nonatomic, retain) PastRecord *bloodTransfusion;
@property (nonatomic, retain) PastRecord *colonoscopy;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) PastRecord *fluShot;
@property (nonatomic, retain) PastRecord *mammogram;
@property (nonatomic, retain) PastRecord *pataintInHospital;
@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) PastRecord *pneumoniaShot;
@property (nonatomic, retain) PastRecord *pregnantW;
@property (nonatomic, retain) PastRecord *tetanusShot;

@end
