//
//  DoctorVisits.h
//  MyHealth
//
//  Created by Ashish Chhabra on 07/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "DoctorVisitDetail.h"

@protocol DoctorVisits <NSObject>

@end
@interface DoctorVisits : JSONModel
@property (nonatomic, retain) NSMutableArray *doctorVisitArray;
+(DoctorVisits*)getObject:(NSMutableArray*)arr;
@end
