//
//  AdditionalInfo.m
//  WorkSpace
//
//  Created by ashish on 06/11/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "AdditionalInfo.h"

@implementation AdditionalInfo

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.arrayQuestions = (id)[NSMutableArray new];
    }
    return self;
}
+(AdditionalInfo*)getObject:(NSMutableArray*)arr
{
    AdditionalInfo *additionalInfo=[[AdditionalInfo alloc]init];
    additionalInfo.arrayQuestions=[AdditionalInfo fromArray:arr];
    return additionalInfo;
}

+(NSMutableArray*)fromArray:(NSMutableArray*)arr
{
    NSMutableArray *questAnsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[arr count]; i++)
        [questAnsArray addObject:[AdditionalQuestions fromDictionary:[arr objectAtIndex:i]]];
    return questAnsArray;
}

@end
