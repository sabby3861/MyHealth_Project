//
//  PastRecord.h
//  MyHealth
//
//  Created by Ashish Chhabra on 13/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@protocol PastRecord <NSObject>

@end

@interface PastRecord : JSONModel
@property (nonatomic, retain) NSString *when;
@property (nonatomic, retain) NSString *yesNo;
+(PastRecord*)fromDictionary:(NSDictionary*)dictionary;
@end
