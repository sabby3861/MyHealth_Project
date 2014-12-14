//
//  MedicationSaveData.h
//  MyHealth
//
//  Created by Noushad Shah on 14/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@interface MedicationSaveData : JSONModel
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *dateEnded;
@property (nonatomic, retain) NSString *dateStarted;
@property (nonatomic, retain) NSString *dose;
@property (nonatomic, retain) NSString *howAndHowOftenYouTakeTheMedication;
@property (nonatomic, retain) NSString *linksToFilesInApplication;
@property (nonatomic, retain) NSString *medication;
@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) NSString *prescriber;
@property (nonatomic, retain) NSString *reasonOfTaking;
+(MedicationSaveData*)fromDictionary:(NSDictionary*)dictionary;

@end
