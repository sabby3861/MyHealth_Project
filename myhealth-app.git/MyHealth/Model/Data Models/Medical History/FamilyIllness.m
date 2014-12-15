//
//  FamilyIllness.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "FamilyIllness.h"

@implementation FamilyIllness
+(FamilyIllness*)fromDictionary:(NSDictionary*)dictionary
{
    FamilyIllness *familyIllness = [[FamilyIllness alloc] init];
    familyIllness.patientFamilyIllness = [IllnessType fromDictionary:dictionary];
    return familyIllness;
}
@end
