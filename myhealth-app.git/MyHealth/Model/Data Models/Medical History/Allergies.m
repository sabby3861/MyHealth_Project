//
//  Allergies.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "Allergies.h"

@implementation Allergies
+(Allergies*)fromDictionary:(NSDictionary*)dictionary
{
    Allergies *allergies = [[Allergies alloc] init];
    NSMutableArray *eachfiledAllergies=[Allergies fromArray:[dictionary objectForKey:@"eachFiled"]];
    allergies.eachFiled = eachfiledAllergies;
    allergies.allergyStatus=[AllergyStatus getObject:[dictionary objectForKey:@"status"]];
    return allergies;
}

+(NSMutableArray*)fromArray:(NSMutableArray*)arr
{
    NSMutableArray *allergyArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[arr count]; i++)
        [allergyArray addObject:[AllergyInfo fromDictionary:[arr objectAtIndex:i]]];
    return allergyArray;
}
@end
