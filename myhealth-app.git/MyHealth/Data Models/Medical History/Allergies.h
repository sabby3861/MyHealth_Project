//
//  Allergies.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "AllergyInfo.h"

@protocol Allergies <NSObject>

@end
@interface Allergies : JSONModel

@property (nonatomic, retain) NSMutableArray <AllergyInfo> *eachFiled;
@end
