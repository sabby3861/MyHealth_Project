//
//  CommentListing.m
//  MyHealth
//
//  Created by Ashish Chhabra on 02/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "CommentListing.h"

@implementation CommentListing

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.arrayComments = (id)[NSMutableArray new];
    }
    return self;
    
}
@end
