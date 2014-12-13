//
//  NSString+SCPaths.m
//  STREETSmart
//
//  Created by Sanjay Chauhan on 4/22/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import "NSString+SCPaths.h"

@implementation NSString (SCPaths)
#pragma mark Standard Paths
/**
 Current time stamp method
 @returns current time stamp
 */
+ (NSString*)getCurrentTimeString
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}


/**
 Cache directory method
 @returns cache directory to save files
 */
+ (NSString*)getCacheDirectory
{
    //return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Voice"];
}

+ (BOOL)createFile:(NSString *)filepath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        if (![[NSFileManager defaultManager] createFileAtPath:filepath contents:nil attributes:nil]) {
            NSLog(@"Could not create file \"%@\". Error's code: %d. Error's message: %s", filepath, errno, strerror(errno));
            
            
            return NO;
        }
        else {
            NSLog(@"File \"%@\" successfully created.", filepath);
        }
    } else {
        NSLog(@"File \"%@\" already exist.", filepath);
    }
    
    return YES;
}

+ (unsigned long long)fileSize:(NSString *)path
{
    return  [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
}


/**
 File Exists at path method
 @param _path
 @returns yes or no
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:_path];
}

/**
 delete file at path
 @param _path
 @returns yes or no
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path
{
    _path=[NSString getPathByFileName:_path];
    return [[NSFileManager defaultManager] removeItemAtPath:_path error:nil];
}



/**
 Get path by file name method
 @param _fileName
 @param _type
 @returns file directory path
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString* fileDirectory = [[[NSString getLibraryPath]stringByAppendingPathComponent:_fileName]stringByAppendingPathExtension:_type];
    return fileDirectory;
}

/**
 Get path by file name method
 @param _fileName
 @returns directory path
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName{
    NSString* fileDirectory = [[NSString getLibraryPath]stringByAppendingPathComponent:_fileName];
    return fileDirectory;
}



+ (NSString *)cachesPath
{
	static dispatch_once_t onceToken;
	static NSString *cachedPath;
	
	dispatch_once(&onceToken, ^{
		cachedPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
	});
	
	return cachedPath;
}

+ (NSString *)documentsPath
{
	static dispatch_once_t onceToken;
	static NSString *cachedPath;
    
	dispatch_once(&onceToken, ^{
		cachedPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	});
    
	return cachedPath;
}

+ (NSString *)getLibraryPath
{
    static dispatch_once_t onceToken;
    static NSString *libraryPath;
    
    dispatch_once(&onceToken, ^{
        libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        libraryPath = [libraryPath stringByAppendingPathComponent:@"Private Documents"];

    });
    
    return libraryPath;
}



/////////////////////////////////
#pragma mark Temporary Paths

+ (NSString *)temporaryPath
{
	static dispatch_once_t onceToken;
	static NSString *cachedPath;
	
	dispatch_once(&onceToken, ^{
		cachedPath = NSTemporaryDirectory();
	});
	
	return cachedPath;
}


+(NSMutableArray*)theDirectoryArray{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    //NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents"]];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:[NSString getLibraryPath]];
    while (file = [dirEnum nextObject]) [results addObject:file];
    return results;
}

+(NSMutableArray*)loadAllDirectories{
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString getLibraryPath]
                                                                        error:NULL];
    __block NSMutableArray *mp3Files = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"mp3"]) {
            [mp3Files addObject:[[NSString getLibraryPath] stringByAppendingPathComponent:filename]];
        }
        NSLog(@"The file name \n\n%@",filename);
    }];
    return mp3Files;
}


+ (void)scanPath:(NSString *) sPath {
    
    BOOL isDir;
    
    /*
    int counter;
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sPath error:NULL];
    for (counter = 0; counter < (int)[directoryContent count]; counter++)
    {
        NSLog(@"File At No %d: %@", (counter + 1), [directoryContent objectAtIndex:counter]);
    }
    */
    
    [[NSFileManager defaultManager] fileExistsAtPath:sPath isDirectory:&isDir];
    
    if(isDir)
    {
        NSArray *contentOfDirectory=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:sPath error:NULL];
        
        NSUInteger contentcount = [contentOfDirectory count];
        int i;
        for(i=0;i<contentcount;i++)
        {
            NSString *fileName = [contentOfDirectory objectAtIndex:i];
            NSString *path = [sPath stringByAppendingFormat:@"%@%@",@"/",fileName];
            
            
            if([[NSFileManager defaultManager] isDeletableFileAtPath:path])
            {
                NSLog(@"Here is path %@",path);

                [self scanPath:path];
            }
        }
        
    }
    else
    {
        NSString *msg=[NSString stringWithFormat:@"%@",sPath];
        NSLog(@"Here is %@",msg);
    }
}



+ (NSString *)pathForTemporaryFile
{
	CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
	NSString *tmpPath = [[NSString temporaryPath] stringByAppendingPathComponent:(__bridge NSString *)newUniqueIdString];
	CFRelease(newUniqueId);
	CFRelease(newUniqueIdString);
	
	return tmpPath;
}

#pragma mark Working with Paths

- (NSString *)pathByIncrementingSequenceNumber
{
	NSString *baseName = [self stringByDeletingPathExtension];
	NSString *extension = [self pathExtension];
	
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\(([0-9]+)\\)$" options:0 error:NULL];
	__block NSInteger sequenceNumber = 0;
	
	[regex enumerateMatchesInString:baseName options:0 range:NSMakeRange(0, [baseName length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
		
		NSRange range = [match rangeAtIndex:1]; // first capture group
		NSString *substring= [self substringWithRange:range];
		
		sequenceNumber = [substring integerValue];
		*stop = YES;
	}];
	
	NSString *nakedName = [baseName pathByDeletingSequenceNumber];
	
	if ([extension isEqualToString:@""])
	{
		return [nakedName stringByAppendingFormat:@"(%d)", (int)sequenceNumber+1];
	}
	
	return [[nakedName stringByAppendingFormat:@"(%d)", (int)sequenceNumber+1] stringByAppendingPathExtension:extension];
}

- (NSString *)pathByDeletingSequenceNumber
{
	NSString *baseName = [self stringByDeletingPathExtension];
	
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\([0-9]+\\)$" options:0 error:NULL];
	__block NSRange range = NSMakeRange(NSNotFound, 0);
	
	[regex enumerateMatchesInString:baseName options:0 range:NSMakeRange(0, [baseName length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop) {
		
		range = [match range];
		
		*stop = YES;
	}];
	
	if (range.location != NSNotFound)
	{
		return [self stringByReplacingCharactersInRange:range withString:@""];
	}
	
	return self;
}




/************** Another Method Supports ******************/

NSString *NSDocumentsFolder()
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

NSString *NSLibraryFolder()
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents"];
}

NSString *NSTmpFolder()
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

NSString *NSBundleFolder()
{
    return [[NSBundle mainBundle] bundlePath];
}

NSString *NSDCIMFolder()
{
    return @"/var/mobile/Media/DCIM";
}


+ (NSString *) pathForItemNamed: (NSString *) fname inFolder: (NSString *) path
{
    NSString *file;
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file lastPathComponent] isEqualToString:fname])
            return [path stringByAppendingPathComponent:file];
    return nil;
}

+ (NSString *) pathForDocumentNamed: (NSString *) fname
{
    return [NSString pathForItemNamed:fname inFolder:NSDocumentsFolder()];
}

+ (NSString *) pathForBundleDocumentNamed: (NSString *) fname
{
    return [NSString pathForItemNamed:fname inFolder:NSBundleFolder()];
}

+ (NSArray *) filesInFolder: (NSString *) path
{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
    {
        BOOL isDir;
        [[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:file] isDirectory: &isDir];
        if (!isDir) [results addObject:file];
    }
    return results;
}

// Case insensitive compare, with deep enumeration
+ (NSArray *) pathsForItemsMatchingExtension: (NSString *) ext inFolder: (NSString *) path
{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame)
            [results addObject:[path stringByAppendingPathComponent:file]];
    return results;
}

+ (NSArray *) pathsForDocumentsMatchingExtension: (NSString *) ext
{
    return [NSString pathsForItemsMatchingExtension:ext inFolder:NSDocumentsFolder()];
}

// Case insensitive compare
+ (NSArray *) pathsForBundleDocumentsMatchingExtension: (NSString *) ext
{
    return [NSString pathsForItemsMatchingExtension:ext inFolder:NSBundleFolder()];
}


@end
