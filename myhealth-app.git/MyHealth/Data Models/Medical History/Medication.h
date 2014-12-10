//
//  Medication.h
//  MyHealth
//
//  Created by Ashish Chhabra on 07/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@interface Medication : JSONModel

@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *dateEnded;
@property (nonatomic, retain) NSString *dateStarted;
@property (nonatomic, retain) NSString *dose;
@property (nonatomic, retain) NSString *howAndHowOftenYouTakeTheMedication;
@property (nonatomic, retain) NSString *linksToFilesInApplication;
@property (nonatomic, retain) NSString *medication;
@end
