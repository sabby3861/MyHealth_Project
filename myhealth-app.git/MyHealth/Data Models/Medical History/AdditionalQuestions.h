//
//  AdditionalQuestions.h
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "JSONModel.h"

@protocol AdditionalQuestions <NSObject>

@end

@interface AdditionalQuestions : JSONModel
@property (nonatomic, retain) NSString *questionHeading;
@property (nonatomic, retain) NSString *questionToID;
@property (nonatomic, retain) NSString *questionDate;
@property (nonatomic, retain) NSString *awnserText;
@property (nonatomic, retain) NSString *awnserDate;
@property (nonatomic, retain) NSString *doctorID;
@property (nonatomic, retain) NSString *patientID;
+(AdditionalQuestions*)fromDictionary:(NSDictionary*)dictionary;
@end
