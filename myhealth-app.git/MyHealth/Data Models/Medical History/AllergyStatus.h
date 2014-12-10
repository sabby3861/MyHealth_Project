//
//  AllergyStatus.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol AllergyStatus <NSObject>

@end
@interface AllergyStatus : JSONModel

@property (nonatomic, retain) NSString *yesNo;

@end
