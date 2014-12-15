//
//  NoteDetails.h
//  MyHealth
//
//  Created by Ashish Chhabra on 05/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol NoteDetails <NSObject>
@end

@interface NoteDetails : JSONModel

@property (nonatomic, retain) NSString *doctorID;
@property (nonatomic, retain) NSString *noteCeatedDate;
@property (nonatomic, retain) NSString *noteID;
@property (nonatomic, retain) NSString *noteStatus;
@property (nonatomic, retain) NSString *noteText;
@property (nonatomic, retain) NSString *patientID;
@end
