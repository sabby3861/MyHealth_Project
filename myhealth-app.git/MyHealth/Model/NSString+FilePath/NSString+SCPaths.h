//
//  NSString+SCPaths.h
//  STREETSmart
//
//  Created by Canvasm on 4/22/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import <Foundation/Foundation.h>

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
+(NSMutableArray*)theDirectoryArray;
+(NSMutableArray*)loadDirectoriesOnly;
+(NSArray*)arrayOfFoldersInFolder:(NSString*)folder;

+ (void)scanPath:(NSString *) sPath;
+(NSMutableArray*)loadAllDirectoriesandFiles;
+(NSMutableArray*)getDirectoriesandFilesinFolder:(NSString*)dirPath;

+ (NSArray *) filesInFolder: (NSString *) path;

@end
