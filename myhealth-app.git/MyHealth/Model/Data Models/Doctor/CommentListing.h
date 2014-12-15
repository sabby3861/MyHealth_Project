//
//  CommentListing.h
//  MyHealth
//
//  Created by Ashish Chhabra on 02/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "Comments.h"
@interface CommentListing : JSONModel

@property (nonatomic, retain) NSMutableArray <Comments> *arrayComments;
@end
