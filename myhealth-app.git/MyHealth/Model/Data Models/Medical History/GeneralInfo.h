//
//  GeneralInfo.h
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "JSONModel.h"

@protocol GeneralInfo <NSObject>

@end

@interface GeneralInfo : JSONModel
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *ssn;
@property (nonatomic, retain) NSString *dob;
@property (nonatomic, retain) NSString *emergencyContact;
@property (nonatomic, retain) NSString *sex;
+(GeneralInfo*)fromDictionary:(NSDictionary*)dictionary;
@end
