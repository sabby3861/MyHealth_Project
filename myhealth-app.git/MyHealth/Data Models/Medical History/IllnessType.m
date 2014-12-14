//
//  IllnessTyoe.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "IllnessType.h"
@implementation IllnessType
+(IllnessType*)fromDictionary:(NSDictionary*)dictionary
{
    IllnessType *illnessType = [[IllnessType alloc] init];
    illnessType.diabetes=[IllnessDetails fromDictionary:[dictionary objectForKey:@"diabetes"]];
    illnessType.highBloodPressure=[IllnessDetails fromDictionary:[dictionary objectForKey:@"highBloodPressure"]];
    illnessType.stroke=[IllnessDetails fromDictionary:[dictionary objectForKey:@"stroke"]];
    illnessType.heartTrouble=[IllnessDetails fromDictionary:[dictionary objectForKey:@"heartTrouble"]];
    illnessType.easyBleeding=[IllnessDetails fromDictionary:[dictionary objectForKey:@"easyBleeding"]];
    illnessType.jaundice=[IllnessDetails fromDictionary:[dictionary objectForKey:@"jaundice"]];
    illnessType.alcoholism = [IllnessDetails fromDictionary:[dictionary objectForKey:@"alcoholism"]];
    illnessType.tuberculosis=[IllnessDetails fromDictionary:[dictionary objectForKey:@"tuberculosis"]];
    illnessType.obesity=[IllnessDetails fromDictionary:[dictionary objectForKey:@"obesity"]];
    illnessType.gout=[IllnessDetails fromDictionary:[dictionary objectForKey:@"gout"]];
    illnessType.asthma=[IllnessDetails fromDictionary:[dictionary objectForKey:@"asthma"]];
    illnessType.psychiatricIllness=[IllnessDetails fromDictionary:[dictionary objectForKey:@"psychiatricIllness"]];
    illnessType.allergy=[IllnessDetails fromDictionary:[dictionary objectForKey:@"allergy"]];
    illnessType.highBloodFats=[IllnessDetails fromDictionary:[dictionary objectForKey:@"highBloodFats"]];
    illnessType.cancerOf=[IllnessDetails fromDictionary:[dictionary objectForKey:@"cancerOf"]];
    illnessType.other=[IllnessDetails fromDictionary:[dictionary objectForKey:@"other"]];
    illnessType.patientID=[dictionary objectForKey:@"patientID"];
    illnessType.date=[dictionary objectForKey:@"date"];
    
    illnessType.illnessTypeArray=[[NSMutableArray alloc]init];
    [illnessType.illnessTypeArray addObject:illnessType.diabetes];
    [illnessType.illnessTypeArray addObject: illnessType.highBloodPressure];
    [illnessType.illnessTypeArray addObject:illnessType.stroke];
    [illnessType.illnessTypeArray addObject:illnessType.heartTrouble];
    [illnessType.illnessTypeArray addObject:illnessType.easyBleeding];
    [illnessType.illnessTypeArray addObject: illnessType.jaundice];
    [illnessType.illnessTypeArray addObject:illnessType.alcoholism];
    [illnessType.illnessTypeArray addObject: illnessType.tuberculosis];
    [illnessType.illnessTypeArray addObject: illnessType.obesity];
    [illnessType.illnessTypeArray addObject: illnessType.gout];
    [illnessType.illnessTypeArray addObject:illnessType.asthma];
    [illnessType.illnessTypeArray addObject:illnessType.psychiatricIllness];
    [illnessType.illnessTypeArray addObject:illnessType.allergy];
    [illnessType.illnessTypeArray addObject:illnessType.highBloodFats];
    [illnessType.illnessTypeArray addObject:illnessType.cancerOf];
    [illnessType.illnessTypeArray addObject:illnessType.other];
    [illnessType.illnessTypeArray addObject:illnessType.patientID];
    [illnessType.illnessTypeArray addObject:illnessType.date];
    return illnessType;
}
@end
