//
//  SSConstants.h
//  STREETSmart
//
//  Created by Canvasm on 4/16/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSConstants : NSObject



/**
 *  Contants for All StroyBoard Scenes
 *  Access the scenes by their name.
 */
FOUNDATION_EXPORT NSString *const MAIN_STORYBOARD;

FOUNDATION_EXPORT BOOL m_Is_Store_Closed;

/**
 *  Defining Constant for Sub Channel
 *  @abstract We are declaring as Extern to use it another class.
 */
FOUNDATION_EXPORT NSString *DOCUMENTADDED_NOTIFICATION;

/**
 *  Defining Rep Id as Extern, we would set its value when Rep Logs in.
 *  @abstract We are declaring as Extern to use it another class.
 */
FOUNDATION_EXPORT NSString *LOGGEDIN_REP_ID;

/**
 *  Defining Suburb as Extern, we would set its value FOR MOVEDOCUMENT VIEW CONTROLLER.
 *  @abstract We are declaring as Extern to use it another class.
 */
FOUNDATION_EXPORT NSString *MOVEDOCUMENT_VIEW;

/**
 *  Defining Server Name as Extern, we would set its value when Rep Logs in.
 *  @abstract We are declaring as Extern to use it another class.
 */
FOUNDATION_EXPORT NSString *SERVER_NAME;



@end
