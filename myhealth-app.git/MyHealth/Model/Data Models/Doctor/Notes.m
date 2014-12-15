//
//  Notes.m
//  MyHealth
//
//  Created by Ashish Chhabra on 05/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "Notes.h"

@implementation Notes

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.arrayNotes = (id)[NSMutableArray new];
    }
    return self;
}
@end
