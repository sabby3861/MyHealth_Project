//
//  AdditionalQuestions.h
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "JSONModel.h"

@protocol AdditionalQuestions <NSObject>

@end

@interface AdditionalQuestions : JSONModel

@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *answer;
@end
