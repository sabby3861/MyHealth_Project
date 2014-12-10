//
//  IllnessDetails.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "SufferingMembers.h"

@protocol IllnessDetails <NSObject>

@end

@interface IllnessDetails : JSONModel

@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) SufferingMembers *who;
@end
