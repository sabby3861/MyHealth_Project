//
//  UIAlertView+Helpers.h
//  STREETSmart
//
//  Created by Canvasm on 4/16/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Helpers)

/**
 *  .Declaring Function to show Alert View.
 */
UIKIT_STATIC_INLINE UIAlertView * ShowAlertView(NSString *title, NSString *message,id delegate);


/**
 *  .Implementing Function to show Alert View.
 *  .Just Pass the Message,title and the delegate to which you want
 **/
UIKIT_STATIC_INLINE UIAlertView * ShowAlertView(NSString *title, NSString *message, id delegate){
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    return alert;
}


/**
 *  .Declaring Function to show Alert View.
 */
//UIKIT_STATIC_INLINE UIAlertView * ShowAlertWithMessage(NSString *message,id delegate);


/**
 *  .Implementing Function to show Alert View.
 *  .Just Pass the Message,title and the delegate to which you want
 **/
UIKIT_STATIC_INLINE UIAlertView * ShowAlertWithMessage(NSString *message, id delegate){
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"MyHealth" message:message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    return alert;
}



/**
 *  .Declaring Function to show Alert View Cancel Button.
 */
UIKIT_STATIC_INLINE UIAlertView * ShowAlertViewWithCancelButton(NSString *title, NSString *message,id delegate);


/**
 *  .Implementing Function to show Alert View with cancel button.
 *  .Just Pass the Message,title and the delegate to which you want
 **/
UIKIT_STATIC_INLINE UIAlertView * ShowAlertViewWithCancelButton(NSString *title, NSString *message, id delegate){
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    [alert show];
    return alert;
}

/**
 *  .Declaring Function to show Alert View.
 */
UIKIT_STATIC_INLINE UIAlertView * SHOW_ALERT_WITH_TEXTFIELD(NSString *title, NSString *message,id delegate);


/**
 *  .Implementing Function to show Alert View.
 *  .Just Pass the Message,title and the delegate to which you want to assing
 **/
UIKIT_STATIC_INLINE UIAlertView * SHOW_ALERT_WITH_TEXTFIELD(NSString *title, NSString *message, id delegate){
    UIAlertView *textAlert = [[UIAlertView alloc] initWithTitle:@"Aleph3" message:message delegate:delegate cancelButtonTitle:@"Done" otherButtonTitles:nil];
    textAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [textAlert show];
    return textAlert;
}




/**
 *  .Declaring Function to show Alert View on Network Error.
 */
UIKIT_STATIC_INLINE UIAlertView * SHOW_NETWORK_ALERT(id delegate);


/**
 *  .Implementing Function to show Alert View When ther is no Network or error in Network.
 *  .Just Pass the delegate to which you want to assing
 **/
UIKIT_STATIC_INLINE UIAlertView * SHOW_NETWORK_ALERT(id delegate){
    UIAlertView *textAlert = [[UIAlertView alloc] initWithTitle:@"STREETSmart" message:@"No internet connectivity" delegate:delegate cancelButtonTitle:@"Done" otherButtonTitles:nil];
    [textAlert show];
    return textAlert;
}

/**
 *  .Implementing Function to show Alert View.
 *  .Just Pass the Message,title and the delegate to which you want an tag value
 **/
UIKIT_STATIC_INLINE UIAlertView * Show_ALERT_WITH_TAG(NSString *title, NSString *message, id delegate ,int TAG_VAL){
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.tag = TAG_VAL;
    [alert show];
    return alert;
}

@end
