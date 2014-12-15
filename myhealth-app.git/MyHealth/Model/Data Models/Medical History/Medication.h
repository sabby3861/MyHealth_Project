//
//  Medication.h
//  MyHealth
//
//  Created by Ashish Chhabra on 07/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "MedicalDetails.h"

@interface Medication : JSONModel
@property (nonatomic, retain) NSMutableArray *medicationArray;
+(Medication*)getObject:(NSMutableArray*)arr;
@end
