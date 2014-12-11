//
//  SCLog.m
//  STREETSmart
//
//  Created by Canvasm on 4/16/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import "SCLog.h"

#import <asl.h>

SCLogLevel SCCurrentLogLevel = SCLogLevelInfo;

#if DEBUG

// set default handler for debug mode
SCLogBlock SCLogHandler = ^(NSUInteger logLevel, NSString *fileName, NSUInteger lineNumber, NSString *methodName, NSString *format, ...)
{
	va_list args;
	va_start(args, format);
	
	SCLogMessagev(logLevel, format, args);
	
	va_end(args);
};

#else

// set no default handler for non-DEBUG mode
SCLogBlock SCLogHandler = NULL;

#endif

#pragma mark - Logging Functions

void SCLogSetLoggerBlock(SCLogBlock handler)
{
	SCLogHandler = [handler copy];
}

void SCLogSetLogLevel(SCLogLevel logLevel)
{
	SCCurrentLogLevel = logLevel;
}

void SCLogMessagev(SCLogLevel logLevel, NSString *format, va_list args)
{
	NSString *facility = [[NSBundle mainBundle] bundleIdentifier];
	aslclient client = asl_open(NULL, [facility UTF8String], ASL_OPT_STDERR); // also log to stderr
	
	aslmsg msg = asl_new(ASL_TYPE_MSG);
	asl_set(msg, ASL_KEY_READ_UID, "-1");  // without this the message cannot be found by asl_search
	
	// convert to via NSString, since printf does not know %@
	NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
	
	asl_log(client, msg, logLevel, "%s", [message UTF8String]);
    
	asl_free(msg);
	
	va_end(args);
}

void SCLogMessage(SCLogLevel logLevel, NSString *format, ...)
{
	va_list args;
	va_start(args, format);
	
	SCLogMessagev(logLevel, format, args);
	
	va_end(args);
}

NSArray *SCLogGetMessages(void)
{
	aslmsg query, message;
	int i;
	const char *key, *val;
	
	NSString *facility = [[NSBundle mainBundle] bundleIdentifier];
	
	query = asl_new(ASL_TYPE_QUERY);
	
	// search only for current app messages
	asl_set_query(query, ASL_KEY_FACILITY, [facility UTF8String], ASL_QUERY_OP_EQUAL);
	
	aslresponse response = asl_search(NULL, query);
	
	NSMutableArray *tmpArray = [NSMutableArray array];
	
	while ((message = aslresponse_next(response)))
	{
		NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
		
		for (i = 0; ((key = asl_key(message, i))); i++)
		{
			NSString *keyString = [NSString stringWithUTF8String:(char *)key];
			
			val = asl_get(message, key);
			
			NSString *string = val?[NSString stringWithUTF8String:val]:@"";
			[tmpDict setObject:string forKey:keyString];
		}
		
		[tmpArray addObject:tmpDict];
	}
	
	asl_free(query);
	aslresponse_free(response);
	
	if ([tmpArray count])
	{
		return [tmpArray copy];
	}
	
	return nil;
}

