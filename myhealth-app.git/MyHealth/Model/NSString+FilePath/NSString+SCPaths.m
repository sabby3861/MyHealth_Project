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

+(BOOL)deleteFileOrDirectoryAtPath:(NSString*)theFilePath{
    NSMutableString *filePath=[NSMutableString stringWithString:theFilePath];// assume we have this
    // Remove prefix string:
    NSString *prefix = [NSString getLibraryPath];
    NSRange range = [filePath rangeOfString:prefix options:NSAnchoredSearch range:NSMakeRange(0, filePath.length) locale:nil];
    if (range.location != NSNotFound) {
        [filePath deleteCharactersInRange:range];
    }
    NSLog(@"Here is the main path %@",filePath);
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    filePath=[NSMutableString stringWithString:[NSString getPathByFileName:filePath]];
    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
    NSLog(@"Path to file: %@", filePath);
    NSLog(@"File exists: %d", fileExists);
    NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:filePath]);
    if (fileExists)
    {
        BOOL success = [fileManager removeItemAtPath:filePath error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
        return success;
    }
    return NO;
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

/*. This Methods Loads the Folders, without the hidden files
 *. This will help to eliminate the hidden files.
 *. @return NSMutableArray containing the folder names
 *. @author Sanjay Chauhan
 .*/
+(NSMutableArray*)loadDirectoriesOnly{
    NSDirectoryEnumerator *dirEnumerator = [[NSFileManager defaultManager] enumeratorAtURL:[NSURL fileURLWithPath:[NSString getLibraryPath]] includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLNameKey, NSURLIsDirectoryKey,nil] options:NSDirectoryEnumerationSkipsSubdirectoryDescendants  errorHandler:nil];
    NSMutableArray *theArray=[NSMutableArray array];
    
    for (NSURL *theURL in dirEnumerator) {
        // Retrieve the file name. From NSURLNameKey, cached during the enumeration.
        NSString *fileName;
        [theURL getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
        // Retrieve whether a directory. From NSURLIsDirectoryKey, also
        // cached during the enumeration.
        NSNumber *isDirectory;
        [theURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
        
        if([isDirectory boolValue] == NO)
        {
            [theArray addObject: fileName];
        }
    }
    return theArray;
}

/*. This Methods Loads All Directories and Files
 *. This will help to eliminate the hidden files.
 *. @return NSArray containing the folder names
 *. @author Sanjay Chauhan
 .*/
+(NSMutableArray*)loadAllDirectoriesandFiles{
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString getLibraryPath]
                                                                        error:NULL];
    __block NSMutableArray *mp3Files = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"mp3"]) {
            [mp3Files addObject:[[NSString getLibraryPath] stringByAppendingPathComponent:filename]];
        }
        if(![filename hasPrefix:@"."]) {
            //The file is hidden
            [mp3Files addObject:filename];
        }
        NSLog(@"The file name \n\n%@",filename);
    }];
    return mp3Files;
}

+(NSMutableArray*)getDirectoriesandFilesinFolder:(NSString*)dirPath{
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath
                                                                        error:NULL];
    __block NSMutableDictionary *theDirList;// = [[NSMutableDictionary alloc] init];
    __block NSMutableArray *theDirArray = [[NSMutableArray alloc] init];
    __block NSUInteger count=0;
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        /*if ([extension isEqualToString:@"mp3"]) {
            //[mp3Files addObject:[[NSString getLibraryPath] stringByAppendingPathComponent:filename]];
        }*/
        if(![filename hasPrefix:@"."]) {
            NSString *key= extension.length>1 ? @"file" :@"directory";
            theDirList = [[NSMutableDictionary alloc] init];
            //[theDirList setValue:filename forKey:key];
            theDirList[@"type"]=key;
            
            //theDirList[@"name"]=filename;
            [theDirList setObject:[NSString stringWithFormat:@"%@",filename] forKey:@"name"];

            NSString *path = [dirPath stringByAppendingFormat:@"%@%@",@"/",filename];
            
            //theDirList[@"Path"]=path;
            [theDirList setObject:[NSString stringWithFormat:@"%@",path] forKey:@"Path"];
            
            
            //theDirArray[count]=theDirList;
            [theDirArray insertObject:theDirList atIndex:count];
            count++;

            
            NSLog(@"The theDirArray \n\n%@",theDirArray);
            NSLog(@"The theDirList \n\n%@",theDirList);
        }
        NSLog(@"The file name \n\n%@",filename);
    }];
    return theDirArray;
}

/*. This Methods Loads the Folders inside folder, without the hidden files
 *. This will help to eliminate the hidden files.
 *. @return NSArray containing the folder names
 *. @author Sanjay Chauhan
 .*/
+(NSArray*)arrayOfFoldersInFolder:(NSString*) folder {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray* files = [fm contentsOfDirectoryAtPath:folder error:nil];
    NSMutableArray *directoryList = [NSMutableArray arrayWithCapacity:10];
    
    for(NSString *file in files) {
        NSString *path = [folder stringByAppendingPathComponent:file];
        BOOL isDir = NO;
        [fm fileExistsAtPath:path isDirectory:(&isDir)];
        if(isDir) {
            [directoryList addObject:file];
        }
    }
    NSLog(@"Folders are %@",directoryList);
    return directoryList;
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
                NSLog(@"Main name is path %@",[path lastPathComponent]);

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




/****************/
+ (BOOL)isDirectoryAtPath:(NSString *)path
{
    if ([path hasSuffix:@".DS_Store"])
    {
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = YES;
    BOOL exists = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    return exists;
}

+ (BOOL)isFileAtPath:(NSString *)path
{
    if ([path hasSuffix:@".DS_Store"])
    {
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    return [fileManager fileExistsAtPath:path isDirectory:&isDir];
}


+ (NSData *)contentOfFileAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *content = [fileManager contentsAtPath:path];
    return content;
}
/*
+ (UIImage *)imageAtFilePath:(NSString *)path
{
    NSData *imageData = [self contentOfFileAtPath:path];
    return [UIImage imageWithData:imageData];
}
*/


#pragma mark - Private Methods -
static dispatch_queue_t _dispathQueue;
+ (dispatch_queue_t)defaultQueue
{
    if (!_dispathQueue) {
        _dispathQueue = dispatch_queue_create("MyHealth.FileManager", NULL);
    }
    return _dispathQueue;
}
+ (dispatch_queue_t)defaultQueue:(dispatch_queue_attr_t)theBlock
{
    if (!_dispathQueue) {
        _dispathQueue = dispatch_queue_create("MyHealth.FileManager", theBlock);
    }
    return _dispathQueue;
}
#pragma mark - Public Methods -


+ (NSObject *)loadDataFromPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];;
}

+ (BOOL)asyncLoadDataFromPath:(NSString *)path callback:(void(^)(NSObject *data))callback
{
    BOOL fileExist = [self fileExistsAtPath:path];
    dispatch_async([self defaultQueue], ^{
        NSObject *data = [self loadDataFromPath:path];
        callback(data);
    });
    return fileExist;
}

#pragma mark - 存储数据
+ (BOOL)saveData:(NSObject *)data withPath:(NSString *)path
{
    if ([PathHelper createPathIfNecessary:[path stringByDeletingLastPathComponent]])
    {
        return [NSKeyedArchiver archiveRootObject:data toFile:path];
    }
    return NO;
}

+ (void)asyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             callback:(void(^)(BOOL succeed))callback
{
    dispatch_async([self defaultQueue], ^{
        BOOL succeed = [self saveData:data withPath:path];
        callback(succeed);
    });
}

+ (BOOL)saveData:(NSObject *)data
        withPath:(NSString *)path
        fileName:(NSString *)fileName
{
    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
    return [self saveData:data withPath:fullPath];
}

+ (void)asyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             fileName:(NSString *)fileName
             callback:(void(^)(BOOL succeed))callback
{
    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
    [self asyncSaveData:data withPath:fullPath callback:callback];
}

#pragma mark - 删除
+ (BOOL)removeFileAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL succeed = [fileManager removeItemAtPath:path error:&error];
    return succeed;
}
+ (void)asyncRemoveDirectoryAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition
{
  
   
    dispatch_async([self defaultQueue:condition], ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSDictionary *fileInfo = [fileManager attributesOfItemAtPath:path error:nil];
        if (condition(fileInfo)) {
            BOOL succeed = [fileManager removeItemAtPath:path error:&error];
        }
    });
}


+ (void)removeFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerate = [fm enumeratorAtPath:path];
    for (NSString *fileName in enumerate)
    {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        NSDictionary *fileInfo = [fm attributesOfItemAtPath:filePath error:nil];
        if (condition(fileInfo)) {
            [fm removeItemAtPath:filePath error:nil];
        }
    }
}

+ (void)asyncRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
{
    dispatch_async([self defaultQueue], ^{
        [self removeFileAtPath:path condition:condition];
    });
}





+(id)readFromFile:(NSString *)fileFullPath toObject:(DataType)dataType
{
    id mId = nil;
    switch (dataType)
    {
        case MyNSString:
        {
            NSError *error = nil;
            mId = [NSString stringWithContentsOfFile:fileFullPath encoding:NSUTF8StringEncoding error:&error];
        }
            break;
        case MyNSMutableString:
        {
            NSError *error = nil;
            mId = [NSString stringWithContentsOfFile:fileFullPath encoding:NSUTF8StringEncoding error:&error];
        }
            break;
        case MyNSArray:
        {
            mId = [NSArray arrayWithContentsOfFile:fileFullPath];
        }
            break;
        case MyNSMutableArray:
        {
            mId = [NSMutableArray arrayWithContentsOfFile:fileFullPath];
        }
            break;
        case MyNSDictionary:
        {
            mId = [NSDictionary dictionaryWithContentsOfFile:fileFullPath];
        }
            break;
        case MyNSMutableDictionary:
        {
            mId = [NSMutableDictionary dictionaryWithContentsOfFile:fileFullPath];
        }
            break;
        case MyNSData:
        {
            NSError *error = nil;
            mId = [NSData dataWithContentsOfFile:fileFullPath options:NSDataReadingMapped error:&error];
        }
            break;
        case MyNSMutableData:
        {
            NSError *error = nil;
            mId = [NSMutableData dataWithContentsOfFile:fileFullPath options:NSDataReadingMapped error:&error];
        }
            break;
            
        default:
            break;
    }
    
    return mId;
}

+(BOOL)writeAppendToFile:(NSString *)fileFullPath fromObject:(NSObject *)object
{
    BOOL flag = NO;
    NSData *data = nil;
    NSFileHandle *outFile = nil;
    @try
    {
        outFile = [NSFileHandle fileHandleForWritingAtPath:fileFullPath];
        
        //找到并定位到outFile的末尾位置（在此后追加文件）
        [outFile seekToEndOfFile];
        
        //将object的这些字符串，数组，data，字典等数据追加到文件中
        if ([object isKindOfClass:[NSString class]])
        {
            NSString *content = (NSString *)object;
            data = [content dataUsingEncoding:NSUTF8StringEncoding];
            [outFile writeData:data];
        }
        else if ([object isKindOfClass:[NSArray class]])
        {
            NSArray *array = (NSArray *)object;
            data = [NSKeyedArchiver archivedDataWithRootObject:array];
            [outFile writeData:data];
        }
        else if ([object isKindOfClass:[NSData class]])
        {
            data = (NSData *)object;
            [outFile writeData:data];
        }
        else if ([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dictionary = (NSDictionary *)object;
            NSMutableData *mData = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver= [[NSKeyedArchiver alloc]initForWritingWithMutableData:mData];
            
            //获取字典的所有key值
            NSArray *arrayKeys = [dictionary allKeys];
            for (NSString *key in arrayKeys)
            {
                [archiver encodeObject:dictionary forKey: key];
                [archiver finishEncoding];
            }
            [outFile writeData:mData];
            
        }
        flag = YES;
    }
    @catch (NSException *exception)
    {
        flag = NO;
    }
    @finally
    {
        if (!outFile) {
            [outFile closeFile];
        }
        
    }
    
    return flag;
}



@end
