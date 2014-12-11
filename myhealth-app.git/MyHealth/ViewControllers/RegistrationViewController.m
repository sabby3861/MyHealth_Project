//
//  RegistrationViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 31/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Connection.h"
#import "Macros.h"
@interface RegistrationViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UIActionSheet *actionSheet;
    UIImagePickerController *picker;
    NSData *imageData;
}
@end

@implementation RegistrationViewController
BOOL keyboardIsShown;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    _btn_register.layer.cornerRadius = 5.0f;
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    // Do any additional setup after loading the view.
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    keyboardIsShown = NO;

    if ([[UIScreen mainScreen ] bounds ].size.height != 568) {
        self.vertical_space1.constant -=5;
        self.vertical_space2.constant -=5;
        self.vertical_space3.constant -=5;
        self.vertical_space4.constant -=5;
        self.vertical_space5.constant -=5;
        self.vertical_space6.constant -=5;

    }
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 170);
    
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
    viewFrame.size.height -= (keyboardSize.height - 170);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view  endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(IBAction)registerUser:(id)sender
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
    
    if (imageData) {
        
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // ---- Start Registering ----
        
        [SVProgressHUD showWithStatus:@"Registering..."
                             maskType:SVProgressHUDMaskTypeGradient];
        [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/create_user?" parameters:tempDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:@"user_image" fileName:@"newImage.jpeg" mimeType:@"image/jpeg"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"Success: %@", responseObject);
            if (![[responseObject valueForKey:@"status"] isEqualToString:@"error"]) {
                
                [[NSUserDefaults standardUserDefaults] setValue:@"manual" forKey:@"login"];
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [SVProgressHUD dismiss];
                
                NSLog(@"JSON: %@", responseObject);
                NSLog(@"user details:%@",((AppDelegate *)[UIApplication sharedApplication].delegate).patient);
                [self.navigationController popViewControllerAnimated:YES];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Registered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please upload photo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
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
    _btn_uploadImage.layer.cornerRadius = 40.0;
    imageData  = UIImageJPEGRepresentation(image, 1);
    [_btn_uploadImage setImage:[self generatePhotoThumbnail:[editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"]] forState:UIControlStateNormal];
    _btn_uploadImage.contentMode=UIViewContentModeScaleToFill;
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
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
