//
//  AdditionalInfo.h
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "JSONModel.h"
#import "AdditionalQuestions.h"
@interface AdditionalInfo : JSONModel

@property (nonatomic, retain) NSMutableArray <AdditionalQuestions> *arrayQuestions;
@end
