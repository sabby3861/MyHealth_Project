//
//  Connection.h
//  iCarAsia
//
//  Created by ashish on 10/09/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@protocol Connect <NSObject>

-(void)connectionDidRecievedResponse:(BOOL)isSuccess withData:(id)data methodName:(NSString*)methodName;
@end

@interface Connection : NSObject

@property (nonatomic, weak) id <Connect> delegate;

+(Connection *)connectionSharedInstance;
-(void)createConnectionWithRequestPath:(NSString *)appendedPath requestType:(NSString *)request dictParams:(NSDictionary *)params;
// Search for users
-(void)searchUserWithRequestPath:(NSString *)urlPath requestType:(NSString *)type  searchKeyword:(NSString *)keyword;
//List all users
-(void)listAllUsersWithRequestPath:(NSString *)urlPath requestType:(NSString *)type;
@end
