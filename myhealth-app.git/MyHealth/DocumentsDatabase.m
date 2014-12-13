//
//  DocumentsDatabase.m
//  MyHealth
//
//  Created by Sanjay Chauhan on 13/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "DocumentsDatabase.h"

@implementation DocumentsDatabase

+(DocumentsDatabase *) sharedInstance
{
    static DocumentsDatabase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[DocumentsDatabase alloc] init];
    });
    
    return instance;
}


- (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}

- (NSMutableArray *)loadMyHealthDocs {
    
    // Get private docs dir
    NSString *documentsDirectory = [self getPrivateDocsDir];
    NSLog(@"Loading bugs from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Create ScaryBugDoc for each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        /*if ([file.pathExtension compare:@"scarybug" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            ScaryBugDoc *doc = [[ScaryBugDoc alloc] initWithDocPath:fullPath];
            [retval addObject:doc];
        }*/
        [retval addObject:file];
        NSLog(@"Files in folders are %@",file);
    }
    
    return retval;
    
}

@end
