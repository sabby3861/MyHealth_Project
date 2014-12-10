//
//  Connection.m
//  iCarAsia
//
//  Created by ashish on 10/09/14.
//  Copyright (c) 2014 Xicom. All rights reserved.
//

#import "Connection.h"
#import "AppDelegate.h"
#import "GlobalVariables.h"
#import "Macros.h"
@implementation Connection
{
    GlobalVariables *globalVar;
}
+(Connection *)connectionSharedInstance
{
    static Connection *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Connection alloc] init];
    });
    return sharedInstance;
}
-(void)createConnectionWithRequestPath:(NSString *)path requestType:(NSString *)type dictParams:(NSDictionary *)params
{
    // Generating complete URL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,path]];
    
    //Set up request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    // Setting HTTP - Body
    NSMutableDictionary *dicBody = [[NSMutableDictionary alloc] init];
    [dicBody setValue:[UIDevice currentDevice].model forKeyPath:@"device_type"];
    [dicBody setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"version"];
    [dicBody setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forKeyPath:@"user_device_token"];
    
    [request setHTTPMethod:@"POST"];
    
    [self sendRequestToServerWithRequest:request];
    
}
-(void)sendRequestToServerWithRequest:(NSMutableURLRequest *)request
{
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        globalVar = [GlobalVariables sharedInstance];
    
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            globalVar.AppToken = [responseObject valueForKey:@"token"];
        });
        
        [self.delegate connectionDidRecievedResponse:YES withData:responseObject methodName:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}
// Search for users
-(void)searchUserWithRequestPath:(NSString *)urlPath requestType:(NSString *)type  searchKeyword:(NSString *)keyword
{
    NSURL *url;
    
    // Generating complete URL
    if ([keyword rangeOfString:@"@"].location==NSNotFound) {
        
         url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?full_name=%@",BASE_URL,urlPath,keyword]];
    } else {
        
         url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?email=%@",BASE_URL,urlPath,keyword]];
    }
    
    //Set up request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSLog(@"Token-->>%@",globalVar.AppToken);
    // Setting request header
    [request setValue:globalVar.AppToken forHTTPHeaderField:@"token"];
    [request setHTTPMethod:type];
    
    [self sendRequestToServerWithRequest:request];
   
}
//List all users
-(void)listAllUsersWithRequestPath:(NSString *)urlPath requestType:(NSString *)type
{
    // Generating complete URL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,urlPath]];
    
    //Set up request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSLog(@"Token -->>%@",globalVar.AppToken);
    // Setting request header
    [request setValue:globalVar.AppToken forHTTPHeaderField:@"token"];
    
    [request setHTTPMethod:type];
    
    [self sendRequestToServerWithRequest:request];
}
@end
