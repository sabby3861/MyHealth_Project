//
//  Degree.h
//  MyHealth
//
//  Created by Ashish Chhabra on 05/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "DegreeDetails.h"
@interface Degree : JSONModel

@property (nonatomic, retain) NSMutableArray <DegreeDetails> *doctorEducation;

@end
