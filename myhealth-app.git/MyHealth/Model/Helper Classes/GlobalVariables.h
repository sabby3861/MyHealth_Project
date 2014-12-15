//
//  GlobalVariables.h
//  iCarAsia
//
//  Created by ashish on 16/09/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject
{
    NSString *AppToken;
}
@property (nonatomic, strong) NSString *AppToken;
+ (GlobalVariables *)sharedInstance;
@end
