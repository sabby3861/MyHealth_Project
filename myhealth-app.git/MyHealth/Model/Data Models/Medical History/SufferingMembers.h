//
//  SufferingMembers.h
//  MyHealth
//
//  Created by Ashish Chhabra on 14/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol SufferingMembers <NSObject>
@end

@interface SufferingMembers : JSONModel

@property (nonatomic, retain) NSString *dad;
@property (nonatomic, retain) NSString *dadsMomDad;
@property (nonatomic, retain) NSString *mom;
@property (nonatomic, retain) NSString *momsMomDad;
+(SufferingMembers*)fromDictionary:(NSDictionary*)dictionary;
@end
