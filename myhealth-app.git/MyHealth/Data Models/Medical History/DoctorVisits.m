//
//  DoctorVisits.m
//  MyHealth
//
//  Created by Ashish Chhabra on 07/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "DoctorVisits.h"

@implementation DoctorVisits

+(DoctorVisits*)getObject:(NSMutableArray*)arr
{
    DoctorVisits *doctorVisitInfo=[[DoctorVisits alloc]init];
    doctorVisitInfo.doctorVisitArray=[DoctorVisits fromArray:arr];
    return doctorVisitInfo;
}

+(NSMutableArray*)fromArray:(NSMutableArray*)arr
{
    NSMutableArray *questAnsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[arr count]; i++)
        [questAnsArray addObject:[DoctorVisitDetail fromDictionary:[arr objectAtIndex:i]]];
    return questAnsArray;
}

@end
