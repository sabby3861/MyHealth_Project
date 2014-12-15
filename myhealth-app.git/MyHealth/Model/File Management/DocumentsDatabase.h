//
//  DocumentsDatabase.h
//  MyHealth
//
//  Created by Sanjay Chauhan on 13/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentsDatabase : NSObject

@property (nonatomic,weak) NSString *theDirectoryPath;

+(DocumentsDatabase *) sharedInstance;
- (NSString *)getPrivateDocsDir;
- (NSMutableArray *)loadMyHealthDocs;
@end
