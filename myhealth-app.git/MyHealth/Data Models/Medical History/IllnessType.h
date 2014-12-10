//
//  IllnessTyoe.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "IllnessDetails.h"
@protocol IllnessType <NSObject>

@end

@interface IllnessType : JSONModel

@property (nonatomic, retain) IllnessDetails *alcoholism;
@property (nonatomic, retain) IllnessDetails *allergy;
@property (nonatomic, retain) IllnessDetails *asthma;
@property (nonatomic, retain) IllnessDetails *cancerOf;
@property (nonatomic, retain) IllnessDetails *diabetes;
@property (nonatomic, retain) IllnessDetails *easyBleeding;
@property (nonatomic, retain) IllnessDetails *gout;
@property (nonatomic, retain) IllnessDetails *heartTrouble;
@property (nonatomic, retain) IllnessDetails *highBloodFats;
@property (nonatomic, retain) IllnessDetails *highBloodPressure;
@property (nonatomic, retain) IllnessDetails *jaundice;
@property (nonatomic, retain) IllnessDetails *obesity;
@property (nonatomic, retain) IllnessDetails *other;
@property (nonatomic, retain) IllnessDetails *psychiatricIllness;
@property (nonatomic, retain) IllnessDetails *stroke;
@property (nonatomic, retain) IllnessDetails *tuberculosis;
@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) NSString *date;

@end
