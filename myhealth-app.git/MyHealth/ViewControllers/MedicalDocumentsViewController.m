//
//  MedicalDocumentsViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 23/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "MedicalDocumentsViewController.h"
#import "MedicalDocumentsCustomCell.h"
#import "MGSwipeButton.h"
#import "DocumentsDatabase.h"
#import "NSString+SCPaths.h"


@interface MedicalDocumentsViewController ()
{
    MedicalDocumentsCustomCell *cell;
}
@end

@implementation MedicalDocumentsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tblView_medicalHistory registerNib:[UINib nibWithNibName:@"MedicalDocumentsCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    [self.tblView_medicalHistory setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view.
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
    cell.delegate = self;
    if ((indexPath.row == 0)) {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
        
    } else {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_doctorspecial_middle.png"]];
    }
    cell.theFolderName.text=[NSString stringWithFormat:@"%@",[[[DocumentsDatabase sharedInstance]loadMyHealthDocs] objectAtIndex:indexPath.row]];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DocumentsDatabase sharedInstance]loadMyHealthDocs]count];// 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark -  MGSwipeTableCell Delegate

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    return YES;
}

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    
    __weak MedicalDocumentsViewController * me = self;

    swipeSettings.transition = MGSwipeTransitionBorder;
    expansionSettings.buttonIndex = 0;
    
    if (direction == MGSwipeDirectionLeftToRight) {
       
        
    }
    else {
        
        //expansionSettings.fillOnTrigger = YES;
        expansionSettings.fillOnTrigger = NO;
        cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
        
        expansionSettings.threshold = 1.1;
        
        CGFloat padding = 15;
        
        MGSwipeButton * trash = [MGSwipeButton buttonWithTitle:@"Trash" backgroundColor:[UIColor clearColor] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {
         
            NSIndexPath * indexPath = [me.tblView_medicalHistory indexPathForCell:sender];
            [me deleteOption:indexPath];
            return YES;
        }];
        [trash setBackgroundImage:[UIImage imageNamed:@"button_delete.png"] forState:UIControlStateNormal];
        [trash setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        MGSwipeButton * flag = [MGSwipeButton buttonWithTitle:@"Flag" backgroundColor:[UIColor clearColor] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {
            NSIndexPath * indexPath = [me.tblView_medicalHistory indexPathForCell:sender];
            [me showMoreOption:indexPath];
            return YES;
        }];
        
        [flag setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [flag setBackgroundImage:[UIImage imageNamed:@"button_move.png"] forState:UIControlStateNormal];
        return @[trash, flag];
    }
    
    return nil;
    
}

-(void)deleteOption:(NSIndexPath*)theIndexPath{
    ShowAlertViewWithMessage(@"Deleted", nil);
    //[NSString deleteFileAtPath:[[[DocumentsDatabase sharedInstance]loadMyHealthDocs] objectAtIndex:theIndexPath.row]];
    [NSString deleteFileAtPath:[[NSString theDirectoryArray] objectAtIndex:theIndexPath.row]];
    [self.tblView_medicalHistory reloadData];
    
}
-(void)showMoreOption:(NSIndexPath*)theIndexPath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSString *sharedDirectory=@"/Users/Shared";
    NSString *sharedDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents"];
    NSError *error=nil;
    NSArray *listOfFiles=[fileManager contentsOfDirectoryAtPath:sharedDirectory error:&error];
    if(!error)
        NSLog(@"Contents of shared Directory: %@",listOfFiles);
    NSArray *listOfSubPaths=[fileManager subpathsOfDirectoryAtPath:sharedDirectory error:&error];
    if(!error)
        NSLog(@"Sub Paths of shared Direcotry :%@",listOfSubPaths);
    
    
    NSDictionary *currentDitionary = [fileManager attributesOfItemAtPath: sharedDirectory error: nil];
    NSLog(@"Files are %@",currentDitionary);
    NSFileManager *fileMgr;
    NSString *entry;
    NSString *documentsDir;
    NSDirectoryEnumerator *enumerator;
    BOOL isDirectory;
    
    // Create file manager
    fileMgr = [NSFileManager defaultManager];
    
    // Path to documents directory
    documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents"];
    
    // Change to Documents directory
    [fileMgr changeCurrentDirectoryPath:documentsDir];
    
    // Enumerator for docs directory
    enumerator = [fileMgr enumeratorAtPath:documentsDir];
    
    // Get each entry (file or folder)
    while ((entry = [enumerator nextObject]) != nil)
    {
        // File or directory
        if ([fileMgr fileExistsAtPath:entry isDirectory:&isDirectory] && isDirectory)
            NSLog (@"Directory - %@", entry);
        else
            NSLog (@"  File - %@", entry);
    }
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
   /* NSString* file1 = [documentsPath stringByAppendingPathComponent:@"Private Documents"];
                       
    NSURL *dirURL=[NSURL URLWithString:file1];
    NSArray *contentOfMyFolder = [[NSFileManager defaultManager]
                                  contentsOfDirectoryAtURL:dirURL
                                  includingPropertiesForKeys:@[NSURLContentModificationDateKey, NSURLLocalizedNameKey]
                                  options:NSDirectoryEnumerationSkipsHiddenFiles
                                  error:nil];
    for (NSURL *item in contentOfMyFolder) {
        NSNumber *isDir;
        NSError *error;
        if ([item getResourceValue:&isDir forKey:NSURLIsDirectoryKey error:&error]) {
            if ([isDir boolValue]) {
                NSLog(@"%@ is a directory", item);
            } else {
                NSLog(@"%@ is a file", item);
            }
        } else {
            NSLog(@"error: %@", error);
        }
    }
    */
    
    
    ShowAlertViewWithMessage(@"More Options", nil);
}

UIKIT_STATIC_INLINE UIAlertView * ShowAlertViewWithMessage(NSString *message, id delegate){
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"MyHealth" message:message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    return alert;
}

// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
