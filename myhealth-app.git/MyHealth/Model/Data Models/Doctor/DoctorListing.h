//
//  DoctorListing.h
//  MyHealth
//
//  Created by Ashish Chhabra on 02/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "DoctorInfo.h"
@interface DoctorListing : JSONModel

@property (nonatomic, retain) NSMutableArray <DoctorInfo> *arrayListing;

@end
