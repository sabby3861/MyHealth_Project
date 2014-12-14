//
//  Medication.m
//  MyHealth
//
//  Created by Ashish Chhabra on 07/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "Medication.h"

@implementation Medication

+(Medication*)getObject:(NSMutableArray*)arr
{
    Medication *medicationInfo=[[Medication alloc]init];
    medicationInfo.medicationArray=[Medication fromArray:arr];
    return medicationInfo;
}

+(NSMutableArray*)fromArray:(NSMutableArray*)arr
{
    NSMutableArray *infoArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[arr count]; i++)
        [infoArray addObject:[MedicalDetails fromDictionary:[arr objectAtIndex:i]]];
    return infoArray;
}
@end
