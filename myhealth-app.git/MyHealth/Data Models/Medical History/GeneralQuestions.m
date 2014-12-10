//
//  Illness.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "GeneralQuestions.h"

@implementation GeneralQuestions

-(id)init
{
    self = [super init];

    if (self) {
        
        self.Allergies = [Allergies new];
    }
    
    return self;
}
@end
