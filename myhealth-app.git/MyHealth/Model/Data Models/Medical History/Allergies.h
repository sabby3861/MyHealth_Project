//
//  Allergies.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "AllergyInfo.h"
#import "AllergyStatus.h"
@protocol Allergies <NSObject>

@end
@interface Allergies : JSONModel
@property (nonatomic, retain) NSMutableArray  *eachFiled;
@property (nonatomic, retain) AllergyStatus  *allergyStatus;
+(Allergies*)fromDictionary:(NSDictionary*)dictionary;
@end
