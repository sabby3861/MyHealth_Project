//
//  Constants.h
//  STREETSmartApp
//
//  Created by Sanjay Chauhan on 16/04/14.
//
//

#import "SCLog.h"





/** DEFINE MACRO FOR INTERFACE **/
#define DEFINE(name,purpose)  \
@interface name(purpose) \


/** DEFINING MACRO FOR IMPLEMENTATION **/
#define IMPLEMENT(name,purpose)  \
@implementation name(purpose)      \




/** Float: Portrait Screen Height **/
#define SCREEN_HEIGHT_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.height )

/** Float: Portrait Screen Width **/
#define SCREEN_WIDTH_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.width )

/** Float: Landscape Screen Height **/
#define SCREEN_HEIGHT_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.width )

/** Float: Landscape Screen Width **/
#define SCREEN_WIDTH_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.height )

/** CGRect: Portrait Screen Frame **/
#define SCREEN_FRAME_PORTRAIT ( CGRectMake( 0, 0, SCREEN_WIDTH_PORTRAIT , SCREEN_HEIGHT_PORTRAIT ) )

/** CGRect: Landscape Screen Frame **/
#define SCREEN_FRAME_LANDSCAPE ( CGRectMake( 0, 0, SCREEN_WIDTH_LANDSCAPE , SCREEN_HEIGHT_LANDSCAPE ) )

/** Float: Screen Scale **/
#define SCREEN_SCALE ([[UIScreen mainScreen] scale ] )

/** CGSize: Screen Size Portrait **/
#define SCREEN_SIZE_PORTRIAT ( CGSizeMake( SCREEN_WIDTH_PORTRAIT * SCREEN_SCALE , SCREEN_HEIGHT_PORTRAIT * SCREEN_SCALE ) )

/** CGSize: Screen Size Landscape **/
#define SCREEN_SIZE_LANDSCAPE ( CGSizeMake( SCREEN_WIDTH_LANDSCAPE * SCREEN_SCALE , SCREEN_HEIGHT_LANDSCAPE * SCREEN_SCALE ) )

/** Get Start Time **/
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];

/** Get End Time **/
#define END_TIMER(msg) 	NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);



#if DEBUG==1
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK	CMLog(@"%s", __PRETTY_FUNCTION__);
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) 	NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);
#else
#define CMLog(format, ...)
#define MARK
#define START_TIMER
#define END_TIMER(msg)
#endif
/*
 Just add this to your Debug target setting
 
 OTHER_CFLAGS = -DDEBUG=1
 and this to your Release target setting:
 
 OTHER_CFLAGS = -DDEBUG=0
 */

#ifdef DEBUG
//here we run application through xcode (either simulator or device). You usually place some test code here (e.g. hardcoded login-passwords)
#else
//this is a real application downloaded from appStore
#endif



/** LOAD IMAGE WITH THE IMAGE NAME **/
#define LOAD_IMAGE(__IMAGE_NAME__) [UIImage imageNamed:__IMAGE_NAME__]



#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0 && !defined (GM_DONT_USE_ARC_WEAK_FEATURE)
#define gm_weak   weak
#define __gm_weak __weak
#define gm_nil(x)

#else
#define gm_weak   unsafe_unretained
#define __gm_weak __unsafe_unretained
#define gm_nil(x) x = nil
#endif




#define MessageFontSize                      16


/** DEFINE ATTRIBUTE FOR YOUR FUNCTION **/
#define EXPORT __attribute__((visibility("default")))
// Always export the following function.
//EXPORT int MyFunction1();


/**
 * THIS HELPTS US TO DEFINE ATTRIBUTE FOR YOUR FUNCTION.
 * USE THIS WITH YOUR FUNCTION.
 */
#define MYDEPRECATED_METHOD __attribute__((deprecated))



/**
 * THIS HELPS US TO DEFINE THE SHARED QUEUE.
 * CALL THIS IN YOUR GCD.
 */
#define sharedQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define NSStubLog()                             NSLog(@"%s", __PRETTY_FUNCTION__)¹




/**
 * THIS HELPS US TO DEFINE THE BUNDLE PATH.
 * Call this in your class and see the magic.
 */
#ifndef PX_IMAGE_PATH
#define PX_IMAGE_PATH(name)  [[NSBundle mainBundle]pathForResource:name ofType:@"png"]
#endif


/**
 * THIS HELPS US TO DEFINE THE APPLICATION DELEGATE.
 * CALL THE OBJECT TO ACCESS DELEGATE IN YOUR APPLICATION.
 */
#define kappDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]


/**
 * THIS HIDES THE NAVIGATION BAR
 *
 */
#ifndef PX_HIDENAVIGATIONBAR
#define PX_HIDENAVIGATIONBAR  self.navigationController.navigationBarHidden=YES;
#endif

/**
 * THIS UNHIDES THE NAVIGATION BAR
 *
 */
#ifndef PX_UNHIDENAVIGATIONBAR
#define PX_UNHIDENAVIGATIONBAR  self.navigationController.navigationBarHidden=NO;
#endif



/**
 * THIS POP THE VIEW CONTROLLER
 *
 */
#ifndef SS_POPVIEWCONTROLLER
#define SS_POPVIEWCONTROLLER [self.navigationController popViewControllerAnimated:YES];
#endif


/**
 * This helps to define color for your status bar.
 * Call this in your class and see the magic.
 */
#define BARTYPE_BLACKOPAQUE [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque]


/**
 * THIS ALLOCS BUTTON WITH THE SPECIFIED FRAME
 * BUTTONS.
 */
#ifndef SS_IMAGEVIEW_N_FRAME
#define SS_IMAGEVIEW_N_FRAME(x,y,w,h) [[UIImageView alloc] initWithFrame:CGRectMake(x,y,w,h)];
#endif


/**
 * THIS DEFINES NIB OF YOUR TABLE VIEW CELL.
 * JUST PASS THE NIB TO OWNER OF CELL.
 */
#ifndef PX_LOADNIB
#define PX_LOADNIB(nib) [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil]
#endif



/**
 * THIS DEFINES BOLD FONT FOR YOUR CONTROLS.
 * JUST PASS THE FONT SIZE.
 */
#ifndef PX_BOLDFONT
#define PX_BOLDFONT(font) [UIFont boldSystemFontOfSize:font]
#endif


/**
 * THIS DEFINES TITLE FOR YOUR BUTTON.
 * YOU CAN CALL THIS IN YOUR CLASS TO DEFINE TITLE FOR BUTTONS.
 */
#ifndef PX_BUTTONTITLE
#define PX_BUTTONTITLE(button,title) [button setTitle:title forState:UIControlStateNormal];
#endif


/**
 * THIS DEFINES ACTION FOR SELECTOR WITH AND THE FRAME FOR YOUR BUTTON.
 * YOU CAN CALL THIS IN YOUR CLASS TO DEFINE ACTIONS FOR BUTTONS.
 */
#ifndef PX_BUTTONACTION
#define PX_BUTTONACTION(button,selector) [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside]
#endif


/**
 * THIS DEFINES BACKGROUND IMAGE FOR YOUR BUTTON.
 * YOU CAN CALL THIS IN YOUR CLASS TO DEFINE IMAGE FOR BUTTONS.
 */
#ifndef PX_BUTTON_IMAGE
#define PX_BUTTON_IMAGE(button,image) [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
#endif


/**
 * THIS ALLOCS BUTTON WITH THE SPECIFIED FRAME
 * BUTTONS.
 */
#ifndef PX_CUSTOMBUTTON_N_FRAME
#define PX_CUSTOMBUTTON_N_FRAME(x,y,w,h) [[UIButton buttonWithType:UIButtonTypeCustom] initWithFrame:CGRectMake(x,y,w,h)];
#endif


/**
 * THIS ALLOCS AUTORELEASE CUSTOM BUTTON
 *
 */
#ifndef PX_CUSTOMBUTTON
#define PX_CUSTOMBUTTON [UIButton buttonWithType:UIButtonTypeCustom];
#endif



/**
 * THIS ALLOCS BUTTON WITH THE SPECIFIED FRAME
 * BUTTONS.
 */
#ifndef PX_BUTTON_N_FRAME
#define PX_BUTTON_N_FRAME(x,y,w,h) [[UIButton alloc] initWithFrame:CGRectMake(x,y,w,h)];
#endif

/**
 * THIS helps to define boundary of your contorls or frame.
 * Simply pass all the 4 co ordinates to set the frame of your view.
 */
#ifndef PX_SETFRAME
#define PX_SETFRAME(x,y,w,h) CGRectMake(x,y,w,h)
#endif


/**
 * This defines custom view for your bar button item.
 * Pass the custom view as parameter.
 */
#ifndef PX_CUSTOMBARBUTTON
#define PX_CUSTOMBARBUTTON(view) [[UIBarButtonItem alloc] initWithCustomView:view]
#endif




/**
 * This helps to define background color for your view.
 * call this and pass the color which you want for your view.
 */
#ifndef SS_BACKGROUNDCOLOR
#define SS_BACKGROUNDCOLOR(aColor) [UIColor aColor]
#endif



/**
 * This defines image and selector for you bar button.
 * Pass image and selector with action.
 */
#define IMGBUTTON(FILENAME, SELECTOR) [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:FILENAME] style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define showAlert(format, ...) myShowAlert(__LINE__, (char *)__FUNCTION__, format, ##__VA_ARGS__)


/**
 * This defines Add style bar button for your view.
 * Just pass the selector for you bar button.
 */
#define ADD_BARBUTTON(SELECTOR) [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:SELECTOR]



/**
 * This defines Done style bar button for your view.
 * Just pass the selector for you bar button.
 */
#define DONE_BARBUTTON(SELECTOR) [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:SELECTOR]


/**
 * This defines Cancel style bar button for your view.
 * Just pass the selector for you bar button.
 */
#define CANCEL_BARBUTTON(SELECTOR) [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:SELECTOR]


/**
 * This defines Save style bar button for your view.
 * Just pass the selector for you bar button.
 */
#define SAVE_BARBUTTON(SELECTOR) [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:SELECTOR]



/**
 * This defines color properties for you view with RGB component.
 * Just pass RGB of the color.
 */
#ifndef PX_RGBCOLOR
#define PX_RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#endif

#ifndef PX_RGBACOLOR
#define SS_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif




/**
 * This defines font for your control titles or texts.
 * Just pass font size and type.
 */
#define  SS_FONT(fontType,fontSize) [UIFont fontWithName:fontType size: fontSize]


/**
 * This helps to check your device version.
 * Just call this.
 */
#define IOS_OLDER_THAN_6 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] < 6.0 )
#define IOS_NEWER_OR_EQUAL_TO_6 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 6.0 )




/**
 * This gets the string value from your rect.
 * Just pass the frame.
 */
#define RSTRING(X) NSStringFromCGRect(X)



/**
 * This helps to set image for your view.
 * Just pass the image.
 */
#define SETIMAGE(X) [(UIImageView *)self.view setImage:X];


/**
 * This helps to find button subview with tag.
 * Just pass the view and tag.
 */
#define CELLBUTTON_WITH_TAG(CELL,X) (UIButton *)[CELL viewWithTag:X];


/**
 * This helps to resign your text fields.
 * Just pass the the textfield or textview object.
 */
#define SS_RESIGNFIRSTRESPONDER(inputView)  [inputView resignFirstResponder];


/**
 * This helps to become first responder text fields.
 * Just pass the the textfield or textview object.
 */
#define SS_BECOMEFIRSTRESPONDER(inputView)  [inputView becomeFirstResponder];


/**
 * This helps to get the textfield object by its tag value.
 * Just pass the the tag value.
 */
#define SS_TEXTFIELDWITH_TAG(tag)  (UITextField *)[self.view viewWithTag:tag];




