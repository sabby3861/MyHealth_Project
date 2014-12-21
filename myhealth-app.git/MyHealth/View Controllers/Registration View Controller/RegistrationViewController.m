//
//  RegistrationViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 31/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppDelegate.h"
#import "Connection.h"
#import "Macros.h"
#import "SSTextFieldValidation.h"
#import "UIAlertView+Helpers.h"


@interface RegistrationViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UIActionSheet *actionSheet;
    UIImagePickerController *picker;
    NSData *imageData;
}
@end

@implementation RegistrationViewController
BOOL keyboardIsShown;

#pragma mark - ˚ VIEWLIFECYCLE ˚
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    _btn_register.layer.cornerRadius = 5.0f;
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    // Do any additional setup after loading the view.
    
    // register for keyboard notifications
    /*[[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];
     // register for keyboard notifications
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification
     object:self.view.window];
     
     //[[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardFrameDidChange:)
     name:UIKeyboardDidChangeFrameNotification object:nil];*/
    keyboardIsShown = NO;
    
    if ([[UIScreen mainScreen ] bounds ].size.height != 568) {
        self.vertical_space1.constant -=5;
        self.vertical_space2.constant -=5;
        self.vertical_space3.constant -=5;
        self.vertical_space4.constant -=5;
        self.vertical_space5.constant -=5;
        self.vertical_space6.constant -=5;
        
    }
    
    self.txtfield_userPassword.secureTextEntry=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

CGFloat animatedDistance;

#pragma mark - ˚ TEXTFIELD DELEGATES ˚
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    genericTextField=textField;
    static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
    static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
    static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
    static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 192;
    static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;
    //In iOS 7, for iPad it is 402 for Landscape and 314 for Portrait
    
    CGRect textFieldRect;
    CGRect viewRect;
    
    textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
    viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
    
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame;
    
    viewFrame= self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.2;
    CGRect viewFrame;
    
    viewFrame= self.view .frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
    //return YES;
}

#pragma mark - ˚ KEYBOARD METHODS ˚

-(void)keyboardFrameDidChange:(NSNotification*)notification{
    /* NSDictionary* info = [notification userInfo];
     
     CGRect kKeyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
     
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationBeginsFromCurrentState:YES];
     [self.view setFrame:CGRectMake(0, kKeyBoardFrame.origin.y-self.view.frame.size.height, 320, self.view.frame.size.height)];
     [UIView commitAnimations];
     */
    
    NSDictionary *info = [notification userInfo];
//    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardFrame = [kbFrame CGRectValue];
//    CGFloat height = keyboardFrame.size.height;
    CGRect kKeyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view setFrame:CGRectMake(0, kKeyBoardFrame.origin.y-self.view.frame.size.height, 320, self.view.frame.size.height)];
        [self.view setNeedsLayout];
    }];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height -100);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height -100);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

#pragma mark - ˚ UITOUCHES METHOD ˚

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view  endEditing:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

UIKIT_STATIC_INLINE UIAlertView * ShowAlertViewWithMessage(NSString *message, id delegate){
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"MyHealth" message:message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    return alert;
}


-(BOOL)validateEmailAddress
{
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:NULL];
    NSArray *matches = [detector matchesInString:self.txtfield_userEmail.text options:0 range:NSMakeRange(0, self.txtfield_userEmail.text.length)];
    for (NSTextCheckingResult *match in matches) {
        if (match.resultType == NSTextCheckingTypeLink &&
            [match.URL.absoluteString rangeOfString:@"mailto:"].location != NSNotFound) {
            return true;
        }
    }
    return false;
}
-(IBAction)registerUser:(id)sender
{
    [genericTextField resignFirstResponder];
    if ([[self.txtfield_firstName.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        ShowAlertViewWithMessage(@"Please enter first name", nil);
    else if ([[self.txtfield_lastName.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        ShowAlertViewWithMessage(@"Please enter last name", nil);
    else if ([[self.txtfield_userName.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        ShowAlertViewWithMessage(@"Please enter user name", nil);
    else if ([[self.txtfield_userEmail.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        ShowAlertViewWithMessage(@"Please enter user email", nil);
    else if(self.validateEmailAddress==0)
        ShowAlertViewWithMessage(@"Invalid email address", nil);
    else if ([[self.txtfield_userPassword.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        ShowAlertViewWithMessage(@"Please enter user password", nil);
    else if([[self.txtfield_userPassword.text stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0 && [[self.txtfield_userPassword.text stringByTrimmingCharactersInSet:
                                                                                     [NSCharacterSet whitespaceAndNewlineCharacterSet]] length]<6)
        ShowAlertViewWithMessage(@"Password should be 6 digits in length", nil);
    else if (!imageData){
        ShowAlertViewWithMessage(@"Please select the image", nil);
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
        [tempDictionary setValue:_txtfield_firstName.text forKeyPath:@"firstName"];
        [tempDictionary setValue:_txtfield_lastName.text forKeyPath:@"lastName"];
        [tempDictionary setValue:_txtfield_userPassword.text forKeyPath:@"user_password"];
        [tempDictionary setValue:_txtfield_userEmail.text forKeyPath:@"user_email"];
        [tempDictionary setValue:_txtfield_userName.text forKeyPath:@"user_name"];
        [tempDictionary setValue:@"1" forKeyPath:@"user_type"];
        [tempDictionary setValue:@"0" forKeyPath:@"user_fb_id"];
        [tempDictionary setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forKeyPath:@"user_device_token"];
        
        if (imageData)
        {
            // ---- Start Registering ----
            [SVProgressHUD showWithStatus:@"Registering..."
                                 maskType:SVProgressHUDMaskTypeGradient];
            [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/create_user?" parameters:tempDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
            {
                [formData appendPartWithFileData:imageData name:@"user_image" fileName:@"newImage.jpeg" mimeType:@"image/jpeg"];
            }
            success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 [SVProgressHUD dismiss];
                  NSLog(@"Success: %@", responseObject);
                  if ([[responseObject valueForKey:@"status"] isEqualToString:@"success"])
                  {
                        [[NSUserDefaults standardUserDefaults] setValue:@"manual" forKey:@"loginType"];
                      [[NSUserDefaults standardUserDefaults] synchronize];

                      ((AppDelegate *)[UIApplication sharedApplication].delegate).patient = [[responseObject valueForKey:@"user_details"] objectAtIndex:0];

                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyHealth" message:@"Registered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                      [alert show];
                   }
                 else if ([[responseObject valueForKey:@"status"] isEqualToString:@"error"])
                 {
                     ShowAlertViewWithMessage([NSString stringWithFormat:@"%@",[responseObject valueForKey:@"msg"]], nil);
                 }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"Error: %@", error);
            }];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please upload photo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

#pragma mark-  Image Picker
-(IBAction)uploadPhoto:(id)sender
{
    //_uploadImage = YES;
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Upload Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:([UIScreen mainScreen].bounds.size.height <= 568 ?nil:@"Cancel") otherButtonTitles:@"Camera",@"Gallery", nil];
    [actionSheet showInView:[self.view window]];
}

// Get image from gallery-->>
-(void) getPhotoFromGallery
{
    picker = [[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}
// Get image from camera-->>
-(void) getImagesFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        
        picker =nil;
        picker =[[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType =UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        // _uploadImage = NO;
        UIAlertView * alert = nil;
        alert= [[UIAlertView alloc] initWithTitle:@"" message:@"Camera not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

// After picking the image dismiss the controller-->>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    //_uploadImage = YES;
    _btn_uploadImage.layer.masksToBounds=YES;
    _btn_uploadImage.layer.cornerRadius = 37.0;
    imageData  = UIImageJPEGRepresentation(image, 1);
    [_btn_uploadImage setImage:[self generatePhotoThumbnail:[editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"]] forState:UIControlStateNormal];
    _btn_uploadImage.contentMode=UIViewContentModeScaleAspectFit;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheeet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    
    if(buttonIndex == 0){
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.showsCameraControls = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        } else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Unavailable" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
            
        }
        
    } else if (buttonIndex == 1){
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
        
        [actionSheeet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
- (UIImage *)generatePhotoThumbnail:(UIImage *)image
{
    CGImageRef imgRef = image.CGImage;
    
    //    CGFloat width = CGImageGetWidth(imgRef);
    //    CGFloat height = CGImageGetHeight(imgRef);
    
    CGFloat width =_btn_uploadImage.frame.size.width;// 100.0;
    CGFloat height = _btn_uploadImage.frame.size.height;// 100.0;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
    
}
#pragma mark -  UIActionSheet delegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   if([alertView.message isEqualToString:@"Registered successfully."])
          [self.navigationController popViewControllerAnimated:YES];
}
@end
