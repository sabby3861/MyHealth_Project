//
//  FamilyIllness.h
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "JSONModel.h"
#import "IllnessType.h"
@protocol FamilyIllness <NSObject>
@end
@interface FamilyIllness : JSONModel

@property (nonatomic, retain) IllnessType *patientFamilyIllness;

@end
