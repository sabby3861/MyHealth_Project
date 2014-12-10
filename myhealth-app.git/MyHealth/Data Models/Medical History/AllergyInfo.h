//
//  AllergyInfo.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol AllergyInfo <NSObject>

@end
@interface AllergyInfo : JSONModel

@property (nonatomic, retain) NSString *result;
@property (nonatomic, retain) NSString *title;
@end
