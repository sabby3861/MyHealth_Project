//
//  Illness.h
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "JSONModel.h"
#import "Allergies.h"
@protocol GeneralQuestions <NSObject>
@end

@interface GeneralQuestions : JSONModel
@property (nonatomic, retain) NSString *bloodPressure;
@property (nonatomic, retain) NSString *bloodResult;
@property (nonatomic, retain) NSString *bloodType;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) NSString *weight;
@property (nonatomic, retain) NSString *yesNo;
@property (nonatomic, retain) Allergies *Allergies;
+(GeneralQuestions*)fromDictionary:(NSDictionary*)dictionary;
@end
