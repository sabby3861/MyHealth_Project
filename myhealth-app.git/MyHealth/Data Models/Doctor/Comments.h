//
//  Comments.h
//  MyHealth
//
//  Created by Ashish Chhabra on 02/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol Comments <NSObject>

@end

@interface Comments : JSONModel

@property (nonatomic, retain) NSString *commentID;
@property (nonatomic, retain) NSString *commentText;
@property (nonatomic, retain) NSString *createdDate;
@property (nonatomic, retain) NSString *doctorID;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *user_email;
@property (nonatomic, retain) NSString *user_image;
@end
