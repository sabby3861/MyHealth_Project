//
//  SCLog.h
//  STREETSmart
//
//  Created by Canvasm on 4/16/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import <Foundation/Foundation.h>

// block signature called for each log statement
typedef void (^SCLogBlock)(NSUInteger logLevel, NSString *fileName, NSUInteger lineNumber, NSString *methodName, NSString *format, ...);


// internal variables needed by macros
extern SCLogBlock SCLogHandler;
extern NSUInteger SCCurrentLogLevel;

/**
 There is a macro for each ASL log level:
 
 - SCLogEmergency (0)
 - SCLogAlert (1)
 - SCLogCritical (2)
 - SCLogError (3)
 - SCLogWarning (4)
 - SCLogNotice (5)
 - SCLogInfo (6)
 - SCLogDebug (7)
 */

/**
 Constants for log levels used by SCLog
 */
typedef NS_ENUM(NSUInteger, SCLogLevel)
{
	/**
	 Log level for *emergency* messages
	 */
	SCLogLevelEmergency = 0,
	
	/**
	 Log level for *alert* messages
	 */
	SCLogLevelAlert     = 1,
	
	/**
	 Log level for *critical* messages
	 */
	SCLogLevelCritical  = 2,
	
	/**
	 Log level for *error* messages
	 */
	SCLogLevelError     = 3,
	
	/**
	 Log level for *warning* messages
	 */
	SCLogLevelWarning   = 4,
	
	/**
	 Log level for *notice* messages
	 */
	SCLogLevelNotice    = 5,
	
	/**
	 Log level for *info* messages. This is the default log level for SCLog.
	 */
	SCLogLevelInfo      = 6,
	
	/**
	 Log level for *debug* messages
	 */
	SCLogLevelDebug     = 7
};

/**
 @name Logging Functions
 */

/**
 Sets the block to be executed for messages with a log level less or equal the currently set log level
 @param logBlock
 */
void SCLogSetLoggerBlock(SCLogBlock handler);

/**
 Modifies the current log level
 @param logLevel The ASL log level (0-7) to set, lower numbers being more important
 */
void SCLogSetLogLevel(NSUInteger logLevel);

/**
 Variant of SCLogMessage that takes a va_list.
 @param logLevel The SCLogLevel for the message
 @param format The log message format
 @param args The va_list of arguments
 */
void SCLogMessagev(SCLogLevel logLevel, NSString *format, va_list args);

/**
 Same as `NSLog` but allows for setting a message log level
 @param logLevel The SCLogLevel for the message
 @param format The log message format and optional variables
 */
void SCLogMessage(SCLogLevel logLevel, NSString *format, ...);

/**
 Retrieves the log messages currently available for the running app
 @returns an `NSArray` of `NSDictionary` entries
 */
NSArray *SCLogGetMessages(void);

/**
 @name Macros
 */

// log macro for error level (0)
#define SCLogEmergency(format, ...) SCLogCallHandlerIfLevel(SCLogLevelEmergency, format, ##__VA_ARGS__)

// log macro for error level (1)
#define SCLogAlert(format, ...) SCLogCallHandlerIfLevel(SCLogLevelAlert, format, ##__VA_ARGS__)

// log macro for error level (2)
#define SCLogCritical(format, ...) SCLogCallHandlerIfLevel(SCLogLevelCritical, format, ##__VA_ARGS__)

// log macro for error level (3)
#define SCLogError(format, ...) SCLogCallHandlerIfLevel(SCLogLevelError, format, ##__VA_ARGS__)

// log macro for error level (4)
#define SCLogWarning(format, ...) SCLogCallHandlerIfLevel(SCLogLevelWarning, format, ##__VA_ARGS__)

// log macro for error level (5)
#define SCLogNotice(format, ...) SCLogCallHandlerIfLevel(SCLogLevelNotice, format, ##__VA_ARGS__)

// log macro for info level (6)
#define SCLogInfo(format, ...) SCLogCallHandlerIfLevel(SCLogLevelInfo, format, ##__VA_ARGS__)

// log macro for debug level (7)
#define SCLogDebug(format, ...) SCLogCallHandlerIfLevel(SCLogLevelDebug, format, ##__VA_ARGS__)

// macro that gets called by individual level macros
#define SCLogCallHandlerIfLevel(logLevel, format, ...) \
if (SCLogHandler && SCCurrentLogLevel>=logLevel) SCLogHandler(logLevel, SCLogSourceFileName, SCLogSourceLineNumber, SCLogSourceMethodName, format, ##__VA_ARGS__)

// helper to get the current source file name as NSString
#define SCLogSourceFileName [[NSString stringWithUTF8String:__FILE__] lastPathComponent]

// helper to get current method name
#define SCLogSourceMethodName [NSString stringWithUTF8String:__PRETTY_FUNCTION__]

// helper to get current line number
#define SCLogSourceLineNumber __LINE__