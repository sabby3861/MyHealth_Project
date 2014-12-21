//
//  AddDocumentsViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 25/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "AddDocumentsViewController.h"
#import "CustomIOS7AlertView.h"
#import "AddDocCustomCell.h"
#import "DocumentsDatabase.h"
#import "NSString+SCPaths.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface AddDocumentsViewController ()<CustomIOS7AlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    AddDocCustomCell *cell;
    UILabel *addLable;
    NSArray * directoryContents;
    UITableView *tblView_paths;
    UITextField *_txtField_folderName;
    
    UIActionSheet *actionSheet;
    UIImagePickerController *picker;
    NSData *imageData;
    NSString *imageName;
    __block NSString *theImageName;
    
    CustomIOS7AlertView *customAlert;
    CustomIOS7AlertView *addFilesAlert;

}
@end

@implementation AddDocumentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents"]];
    while (file = [dirEnum nextObject]) [results addObject:file];
    CFShow((__bridge CFTypeRef)(results));
    
    NSLog(@"The Directories are %@",[NSString theDirectoryArray]);
    
    NSLog(@"Files in folders are %@",[NSString filesInFolder:[NSString stringWithFormat:@"%@",[NSString getLibraryPath]]]);
    
    [NSString scanPath:[NSString getLibraryPath]];
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [NSString getLibraryPath];//[paths objectAtIndex:0];
    NSError * error;
    directoryContents =  [[NSFileManager defaultManager]
                          contentsOfDirectoryAtPath:documentsDirectory error:&error];
    
    NSLog(@"directoryContents ====== %@",directoryContents);
    /***** Added by Sanjay for test ****/
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory
                                                                        error:NULL];
    NSMutableArray *mp3Files = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        NSLog(@"files are %@",filename);
        if ([extension isEqualToString:@"mp3"]) {
            [mp3Files addObject:[documentsDirectory stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory  error:nil];
    NSLog(@"Sub directories are %@",filePathsArray);
    /**************  Test *********************/
    NSLog(@"Documents are %@",[[DocumentsDatabase sharedInstance]loadMyHealthDocs]);
    
    
    
    
    
    [self.tblView_add registerNib:[UINib nibWithNibName:@"AddDocCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    // Do any additional setup after loading the view.
    
#if TARGET_IPHONE_SIMULATOR
    // where are you?
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
#endif
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  UITableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblView_paths) {
        
        UITableViewCell *pathCell = [tableView dequeueReusableCellWithIdentifier:@"PathCell"];
        if (!pathCell) {
            
            pathCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PathCell"];
            pathCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //[[directoryContents objectAtIndex:indexPath.row] isEqualToString:@".DS_Store"]
    
        pathCell.textLabel.text = [directoryContents objectAtIndex:indexPath.row];
        
        return pathCell;
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
        if ((indexPath.row == 0)) {
            
            cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_connecttop.png"]];
            
        } else {
            
            cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_connectmiddle.png"]];
        }
        return  cell;

    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tblView_paths) {
        
        return directoryContents.count;
        
    } else {
        
        return 20;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblView_paths) {
        
        return 30;
    }
    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _txtField_folderName.text = [directoryContents objectAtIndex:indexPath.row];
}
// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)createFolder:(id)sender
{
    
    /*if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] isEqualToString:@"LoggedIn"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please login to add a note." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }*/
    
    customAlert = [[CustomIOS7AlertView alloc] init];
    customAlert.tag = 100;
    customAlert.delegate = self;
    [customAlert setButtonTitles:[NSMutableArray arrayWithObjects:@"Add", @"Cancel", nil]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
    addLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 250, 30)];
    addLable.text = @"Add Folder";
    addLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:addLable];
    
    _txtField_folderName = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 200, 30)];
    _txtField_folderName.placeholder = @"Folder Name";
    [view addSubview:_txtField_folderName];
    
    /*tblView_paths = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 250, 200)];
    tblView_paths.delegate = self;
    tblView_paths.dataSource = self;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSError * error;
    directoryContents =  [[NSFileManager defaultManager]
                          contentsOfDirectoryAtPath:documentsDirectory error:&error];
    
    NSLog(@"directoryContents ====== %@",directoryContents);
    [tblView_paths reloadData];
    
    [view addSubview:tblView_paths];*/
   
    [customAlert setContainerView:view];
    [customAlert show];

}
#pragma mark  CustomIOS7AlertView
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [NSString getLibraryPath];// [paths objectAtIndex:0];
        NSError * error;
        
        if ([addLable.text isEqualToString:@"Add file under folder"]) {
            
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",_txtField_folderName.text]];
            
                if (imageData) {
                    
                    NSString *filePath = [dataPath stringByAppendingPathComponent:theImageName];
                    [imageData writeToFile:filePath atomically:YES];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Media added successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [customAlert close];
                }
            
        } else {
            
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",_txtField_folderName.text]];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
                
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Folder created successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Folder allready exist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
        
    }
   
    [alertView close];
}
-(IBAction)fetchFolders:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSError * error;
    directoryContents =  [[NSFileManager defaultManager]
                          contentsOfDirectoryAtPath:documentsDirectory error:&error];
    
    NSLog(@"directoryContents ====== %@",directoryContents);
    [_tblView_add reloadData];
    
    
    /***** Added by Sanjay for test ****/
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory
                                                                        error:NULL];
    NSMutableArray *mp3Files = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        NSLog(@"files are %@",filename);
        if ([extension isEqualToString:@"mp3"]) {
            [mp3Files addObject:[documentsDirectory stringByAppendingPathComponent:filename]];
        }
    }];
    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory  error:nil];
    NSLog(@"Sub directories are %@",filePathsArray);
}
-(IBAction)deleteFolder:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",_txtField_name.text]];
    [[NSFileManager defaultManager] removeItemAtPath:dataPath error:nil];
}
-(IBAction)writeTextFile
{
    NSError *error;
    // Create file manager
    //NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:@"Documents"];
    
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",_txtField_name.text]];
    
    NSLog(@"string to write:%@",_txtField_text.text);
    // Write to the file
    [_txtField_text.text writeToFile:filePath atomically:YES
                            encoding:NSUTF8StringEncoding error:&error];
}
-(IBAction)AddFile:(id)sender
{
    
    /*if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] isEqualToString:@"LoggedIn"]) {
     
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please login to add a note." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alert show];
     return;
     }*/
    
    addFilesAlert = [[CustomIOS7AlertView alloc] init];
    addFilesAlert.tag = 101;
    addFilesAlert.delegate = self;
    [addFilesAlert setButtonTitles:[NSMutableArray arrayWithObjects:@"Add", @"Cancel", nil]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    addLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 250, 30)];
    addLable.text = @"Add file under folder";
    addLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:addLable];
    
    _txtField_folderName = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 100, 30)];
    _txtField_folderName.placeholder = @"Folder Name";
    _txtField_folderName.userInteractionEnabled = NO;
    [view addSubview:_txtField_folderName];
    
    tblView_paths = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 250, 100)];
    tblView_paths.delegate = self;
    tblView_paths.dataSource = self;
    
    /*
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSError * error;
    directoryContents =  [[NSFileManager defaultManager]
                          contentsOfDirectoryAtPath:documentsDirectory error:&error];
    */
    
    //NSString *documentsDirectory = [NSString getLibraryPath];
    directoryContents= [NSString loadAllDirectoriesandFiles];
    NSLog(@"directoryContents ====== %@",directoryContents);
    [tblView_paths reloadData];
    
    [view addSubview:tblView_paths];
    
    UIButton *btn_addMedia = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 100, 40)];
    btn_addMedia.backgroundColor = [UIColor redColor];
    [btn_addMedia addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [btn_addMedia setTitle:@"Media" forState:UIControlStateNormal];
    [view addSubview:btn_addMedia];
    
    UIButton *btn_addNote = [[UIButton alloc] initWithFrame:CGRectMake(130, 200, 100, 40)];
    btn_addNote.backgroundColor = [UIColor greenColor];
    //[btn_addNote addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [btn_addNote setTitle:@"Add Note" forState:UIControlStateNormal];
    [view addSubview:btn_addNote];
    
    [addFilesAlert setContainerView:view];
    [addFilesAlert show];
    
}
#pragma mark-  Image Picker
-(IBAction)uploadPhoto:(id)sender
{
    //_uploadImage = YES;
    customAlert.hidden = YES;
    addFilesAlert.hidden=YES;
   
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Upload Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:([UIScreen mainScreen].bounds.size.height <= 568 ?nil:@"Cancel") otherButtonTitles:@"Camera",@"Gallery", nil];
    [actionSheet showInView:[self.view window]];
}

// Get image from gallery-->>
-(void) getPhotoFromGallery
{
    [customAlert close];
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
        
        [customAlert close];
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
   
    NSURL *assetURL = [editingInfo objectForKey:UIImagePickerControllerReferenceURL];
    theImageName = nil;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:assetURL resultBlock:^(ALAsset *asset)  {
        theImageName = asset.defaultRepresentation.filename;
        NSLog(@"imageName File Name is %@",theImageName);
    } failureBlock:nil];
    
    NSURL *imagePath = [editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"];
    imageName = [imagePath lastPathComponent];
    NSLog(@"imageName Name is %@",imageName);
    
    //_uploadImage = YES;
    imageData  = UIImageJPEGRepresentation(image, 1);
    //[_btn_uploadImage setImage:[self generatePhotoThumbnail:[editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"]] forState:UIControlStateNormal];
    //_btn_uploadImage.contentMode=UIViewContentModeScaleToFill;
    [self dismissViewControllerAnimated:YES completion:nil];
    [customAlert show];
    addFilesAlert.hidden=NO;

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
@end
