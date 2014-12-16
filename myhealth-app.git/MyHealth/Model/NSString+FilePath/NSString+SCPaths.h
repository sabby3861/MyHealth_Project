//
//  NSString+SCPaths.h
//  STREETSmart
//
//  Created by Canvasm on 4/22/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PathHelper.h"


@interface NSString (SCPaths)
/**-------------------------------------------------------------------------------------
 @name Getting Standard Paths
 ---------------------------------------------------------------------------------------
 */

/** Determines the path to the Library/Caches folder in the current application's sandbox.
 
 The return value is cached on the first call.
 
 @return The path to the app's Caches folder.
 */
+ (NSString *)cachesPath;


/** Determines the path to the Documents folder in the current application's sandbox.
 
 The return value is cached on the first call.
 
 @return The path to the app's Documents folder.
 */
+ (NSString *)documentsPath;


+ (NSString *)getLibraryPath;


/**-------------------------------------------------------------------------------------
 @name Getting Temporary Paths
 ---------------------------------------------------------------------------------------
 */

/** Determines the path for temporary files in the current application's sandbox.
 
 The return value is cached on the first call. This value is different in Simulator than on the actual device. In Simulator you get a reference to /tmp wheras on iOS devices it is a special folder inside the application folder.
 
 @return The path to the app's folder for temporary files.
 */
+ (NSString *)temporaryPath;


/** Creates a unique filename that can be used for one temporary file or folder.
 
 The returned string is different on every call. It is created by combining the result from temporaryPath with a unique UUID.
 
 @return The generated temporary path.
 */
+ (NSString *)pathForTemporaryFile;


/**-------------------------------------------------------------------------------------
 @name Working with Paths
 ---------------------------------------------------------------------------------------
 */

/** Appends or Increments a sequence number in brackets
 
 If the receiver already has a number suffix then it is incremented. If not then (1) is added.
 
 @return The incremented path
 */
- (NSString *)pathByIncrementingSequenceNumber;


/** Removes a sequence number in brackets
 
 If the receiver number suffix then it is removed. If not the receiver is returned.
 
 @return The modified path
 */
- (NSString *)pathByDeletingSequenceNumber;

+ (BOOL)deleteFileAtPath:(NSString*)_path;
+(BOOL)deleteFileOrDirectoryAtPath:(NSString*)theFilePath;


+(NSMutableArray*)theDirectoryArray;
+(NSMutableArray*)loadDirectoriesOnly;
+(NSArray*)arrayOfFoldersInFolder:(NSString*)folder;

+ (void)scanPath:(NSString *) sPath;
+(NSMutableArray*)loadAllDirectoriesandFiles;
+(NSMutableArray*)getDirectoriesandFilesinFolder:(NSString*)dirPath;

+ (NSArray *) filesInFolder: (NSString *) path;








/** @name 读取 */
/**
 加载文件
 @param path 文件路径
 @return NSObject 文件中的数据
 */
+ (NSObject *)loadDataFromPath:(NSString *)path ;

/**
 异步加载文件
 @param path 文件路径
 @param callback 加载完成后回调
 @return BOOL 同步返回文件是否存在
 */
+ (BOOL)asyncLoadDataFromPath:(NSString *)path callback:(void(^)(NSObject *data))callback;

/** @name 写入 */
/**
 存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 @return NSData 文件中的数据
 */
+ (BOOL)saveData:(NSObject *)data withPath:(NSString *)path;

/**
 异步存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 @param callback 存储完成后回调
 @return NSData 文件中的数据
 */
+ (void)asyncSaveData:(NSObject *)data withPath:(NSString *)path callback:(void(^)(BOOL succeed))callback;


/**
 存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 @param fileName 文件名
 @return NSData 文件中的数据
 */
+ (BOOL)saveData:(NSObject *)data withPath:(NSString *)path fileName:(NSString *)fileName;


/**
 异步存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 @param fileName 文件名
 @param callback 完成后的回调
 @return NSData 文件中的数据
 */
+ (void)asyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             fileName:(NSString *)fileName
             callback:(void(^)(BOOL succeed))callback;

/** @name 删除 */
/**
 删除文件
 @param path 文件路径
 @return 是否删除成功
 */
+ (BOOL)removeFileAtPath:(NSString *)path;

/**
 删除文件目录和目录下的所有文件
 @param path 文件目录路径
 @param condition 文件删除条件判断
 @return 无
 */
+ (void)removeFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;

+ (void)asyncRemoveDirectoryAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
/**
 删除文件目录和目录下的所有文件
 @param path 文件目录路径
 @param condition 文件删除条件判断
 @return 无
 */
+ (void)asyncRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;

typedef enum
{
    MyNSString = 0,
    MyNSMutableString = 1,
    MyNSData = 2,
    MyNSMutableData = 3,
    MyNSArray = 4,
    MyNSMutableArray = 5,
    MyNSDictionary = 6,
    MyNSMutableDictionary = 7
    
}DataType;
+(BOOL)writeAppendToFile:(NSString *)fileFullPath fromObject:(NSObject *)object;
+(id)readFromFile:(NSString *)fileFullPath toObject:(DataType)dataType;
;
@end
