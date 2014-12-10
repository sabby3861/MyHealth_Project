//
//  IllnessTyoe.m
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "IllnessType.h"

@implementation IllnessType

-(id)init
{
    self = [super init];
    if (self) {
        
        self.alcoholism = [IllnessDetails new];
        self.allergy = [IllnessDetails new];
        self.asthma = [IllnessDetails new];
        self.cancerOf = [IllnessDetails new];
        self.diabetes = [IllnessDetails new];
        self.easyBleeding = [IllnessDetails new];
        self.gout = [IllnessDetails new];
        self.heartTrouble = [IllnessDetails new];
        self.highBloodFats = [IllnessDetails new];
        self.highBloodPressure = [IllnessDetails new];
        self.jaundice = [IllnessDetails new];
        self.obesity = [IllnessDetails new];
        self.psychiatricIllness = [IllnessDetails new];
        self.tuberculosis = [IllnessDetails new];
        self.stroke = [IllnessDetails new];
    }
    
    return self;
}
@end
