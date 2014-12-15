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
#import "ShareViewController.h"
#import "MoveDocumentViewController.h"

#import "AppDelegate.h"


#define ShareViewControllerSI @"ShareViewController"

@interface MedicalDocumentsViewController ()
{
    MedicalDocumentsCustomCell *cell;
    NSMutableArray *theDocumentList;
    NSMutableArray *filteredArray;
    
}

@property (nonatomic, weak) NSString *thePreviousFilePath;
@end

@implementation MedicalDocumentsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tblView_medicalHistory registerNib:[UINib nibWithNibName:@"MedicalDocumentsCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    [self.tblView_medicalHistory setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view.
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Search documents..." attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:63.0/255.0 green:170.0/255.0 blue:247/255.0 alpha:1] }];
    self.mSearchField.attributedPlaceholder = str;
    
    /*** Update the TableView once your view is loaded ***/
    NSLog(@"the values are %@",[NSString getDirectoriesandFilesinFolder:[NSString getLibraryPath]]);
    theDocumentList=[[NSMutableArray alloc]init];
    //[theDocumentList addObject:[NSString getDirectoriesandFilesinFolder:[NSString getLibraryPath]]];
    [theDocumentList addObject:[NSString getDirectoriesandFilesinFolder:[[NSString getLibraryPath]stringByAppendingPathComponent:self.mPathSuffix]]];
    filteredArray=[[NSMutableArray alloc]init];
    
    [filteredArray addObjectsFromArray:[theDocumentList objectAtIndex:0]];
    NSLog(@"The Doc Array is %@",theDocumentList);
    NSLog(@"filteredArray Array is %@",filteredArray);
    NSLog(@"The Doc Array at index 0 %@",[theDocumentList objectAtIndex:0]);
    
    /** Adding Original Values to Filtered Array for search **/
    theDocumentList=[theDocumentList objectAtIndex:0];
    self.mTitle.text=self.mPathSuffix.length>0 ?self.mPathSuffix:@"Documents";
    self.thePreviousFilePath=self.mPathSuffix;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    NSLog(@"SPath is %@",self.mPathSuffix);
    NSLog(@"SPath Previus is %@",self.thePreviousFilePath);
    
     NSLog(@"On ViewWillAppear %@",[NSString getDirectoriesandFilesinFolder:[[NSString getLibraryPath]stringByAppendingPathComponent:self.mPathSuffix]]);
    //[self.tblView_medicalHistory reloadData];

    
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
    NSLog(@"Value at index is %@",[[theDocumentList objectAtIndex:indexPath.row]valueForKey:@"name"]);
    //cell.theFolderName.text=[NSString stringWithFormat:@"%@",[[[DocumentsDatabase sharedInstance]loadMyHealthDocs] objectAtIndex:indexPath.row]];
    cell.theFolderName.text=[NSString stringWithFormat:@"%@",[[theDocumentList objectAtIndex:indexPath.row]valueForKey:@"name"]];
    
    //if ([[[[[DocumentsDatabase sharedInstance]loadMyHealthDocs] objectAtIndex:indexPath.row]pathExtension]length]>1) {
    if ([[[[theDocumentList objectAtIndex:indexPath.row]valueForKey:@"name"]pathExtension]length]>1) {
        cell.mDocImageView.image=[UIImage imageNamed:@"icon_file.png"];
    }
    else{
        cell.mDocImageView.image=[UIImage imageNamed:@"icon_doc.png"];
    }
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [[[DocumentsDatabase sharedInstance]loadMyHealthDocs]count];// 20;
    return [theDocumentList count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == nil)
        return;
    self.mPathSuffix=[[theDocumentList valueForKey:@"name"] objectAtIndex:indexPath.row];
    if ([self.theDocumentsCount count] == 0) {
        // Do nothing, there are no items in the list. We don't want to download a file that doesn't exist (that'd cause a crash)
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MedicalDocumentsViewController *viewCrtl = [storyboard instantiateViewControllerWithIdentifier:@"MedicalDocumentsViewController"];
        viewCrtl.title = [[theDocumentList valueForKey:@"name"] objectAtIndex:indexPath.row];//[subpath lastPathComponent];
        viewCrtl.mPathSuffix=[[theDocumentList valueForKey:@"name"] objectAtIndex:indexPath.row];
        NSLog(@"path extension is %@",self.mPathSuffix);
        [self.navigationController pushViewController:viewCrtl animated:YES];
    }
}

-(NSMutableArray*)theDocumentsCount{
    return [NSString getDirectoriesandFilesinFolder:[[NSString getLibraryPath]stringByAppendingPathComponent:self.mPathSuffix]];
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
    ShowAlertViewWithMessage(@"Deleted", self);
    //[NSString deleteFileAtPath:[[[DocumentsDatabase sharedInstance]loadMyHealthDocs] objectAtIndex:theIndexPath.row]];
    //[NSString deleteFileAtPath:[[NSString theDirectoryArray] objectAtIndex:theIndexPath.row]];
    
    
    /*** Added these lines, to update the datasource ***/
    /*[filteredArray removeAllObjects];
     [theDocumentList removeAllObjects];
     */
    //[NSString deleteFileAtPath:[[theDocumentList valueForKey:@"Path"] objectAtIndex:theIndexPath.row]];
    
    NSLog(@"Value is %@",[[NSString theDirectoryArray] objectAtIndex:theIndexPath.row]);

    
    //[NSString deleteFileAtPath:[[theDocumentList objectAtIndex:theIndexPath.row]valueForKey:@"Path"]];

    [NSString deleteFileOrDirectoryAtPath:[[theDocumentList objectAtIndex:theIndexPath.row]valueForKey:@"Path"]];

    
    
    NSString *theFileName=[NSString stringWithFormat:@"%@",[[theDocumentList objectAtIndex:theIndexPath.row]valueForKey:@"name"]];
    NSLog(@"theFileName Path is %@",theFileName);
    NSLog(@"Selected Path is %@",self.mPathSuffix);
    theDocumentList=[[NSMutableArray alloc]init];
    filteredArray=[[NSMutableArray alloc]init];
    [theDocumentList addObjectsFromArray:[NSString getDirectoriesandFilesinFolder:[[NSString getLibraryPath]stringByAppendingPathComponent:theFileName]]];
    [filteredArray addObjectsFromArray:theDocumentList];
    /*** Added these lines, to update the datasource ***/
    //[theDocumentList removeObjectAtIndex:theIndexPath.row];
    [self.tblView_medicalHistory reloadData];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([theDocumentList count]==0) {
        SS_POPVIEWCONTROLLER;
    }
}
NSUInteger theIndex;

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
    NSLog(@"File attribute at path are %@",currentDitionary);
    
    
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
    
    
    
    
    NSURL* dirURL = [[[fileMgr URLsForDirectory:NSLibraryDirectory
                                      inDomains:NSUserDomainMask] objectAtIndex:0]
                     URLByAppendingPathComponent:@"Private Documents"];
    NSArray *contentOfMyFolder = [[NSFileManager defaultManager]
                                  contentsOfDirectoryAtURL:dirURL
                                  includingPropertiesForKeys:@[NSURLContentModificationDateKey, NSURLLocalizedNameKey,NSURLIsDirectoryKey]
                                  options:NSDirectoryEnumerationSkipsHiddenFiles
                                  error:nil];
    //int count=0;
    for (NSURL *item in contentOfMyFolder) {
        NSNumber *isDir;
        NSError *error;
        /*NSString *fileName = [contentOfMyFolder objectAtIndex:count];
         NSLog(@"File Name is %@",fileName);
         count++;*/
        NSString *fileName;
        [item getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
        NSLog(@"fileName %@", fileName);
        
        
        
        if ([item getResourceValue:&isDir forKey:NSURLIsDirectoryKey error:&error]) {
            if ([isDir boolValue]) {
                NSLog(@"%@ is a directory", item);
            } else {
                NSLog(@"%@ is a file", item);
            }
            NSString* filename = [item lastPathComponent];
            NSLog(@"Main Name is %@ ", filename);
            
        } else {
            NSLog(@"error: %@", error);
        }
    }
    
    NSMutableArray *array= [NSString loadAllDirectoriesandFiles];
    NSLog(@"array is %@",array);
    [self arrayOfFoldersInFolder:[NSString getLibraryPath]];
    //ShowAlertViewWithMessage(@"More Options", nil);
    NSLog(@"theDocumentList is %@",[[theDocumentList valueForKey:@"Path"]objectAtIndex:theIndexPath.row]);
    UIImage *theDocImage=[self theDocumentImageAtPath:[[theDocumentList valueForKey:@"Path"]objectAtIndex:theIndexPath.row]];
    NSLog(@"Image object is %@",theDocImage);
    [[AppDelegate sharedAppDelegate]setTheDocImage:[self theDocumentImageAtPath:[[theDocumentList valueForKey:@"Path"]objectAtIndex:theIndexPath.row]]];
    theIndex=theIndexPath.row;
    ShowOptionsSheet(self);
    
}

-(UIImage*)theDocumentImageAtPath:(NSString*)filePath{
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

-(void)actionSheet:(UIActionSheet *)actionSheeet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0){
        
        MoveDocumentViewController *moveDocumentVC = [[[AppDelegate sharedAppDelegate]theMainStoryBoard] instantiateViewControllerWithIdentifier:MOVEDOCUMENT_VIEW];
        moveDocumentVC.mPathSuffix = [[theDocumentList valueForKey:@"name"] objectAtIndex:theIndex];//[subpath lastPathComponent];
        //viewCrtl.mPathSuffix=[[theDocumentList valueForKey:@"name"] objectAtIndex:theIndex];
        //moveDocumentVC.mPathSuffix=self.thePreviousFilePath;
        NSLog(@"path extension is %@",self.mPathSuffix);
        [self.navigationController pushViewController:moveDocumentVC animated:YES];
        
        
    } else if (buttonIndex == 1){
        //UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ShareViewController *shareVC = [[[AppDelegate sharedAppDelegate]theMainStoryBoard] instantiateViewControllerWithIdentifier:ShareViewControllerSI];
        [self.navigationController pushViewController:shareVC animated:YES];
        //[self.navigationController presentViewController:shareVC animated:YES completion:nil];
        
    } else {
        
        [actionSheeet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}


-(NSArray*)arrayOfFoldersInFolder:(NSString*) folder {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray* files = [fm contentsOfDirectoryAtPath:folder error:nil];
    NSMutableArray *directoryList = [NSMutableArray arrayWithCapacity:10];
    
    for(NSString *file in files) {
        NSString *path = [folder stringByAppendingPathComponent:file];
        BOOL isDir = NO;
        [fm fileExistsAtPath:path isDirectory:(&isDir)];
        if(isDir) {
            [directoryList addObject:file];
        }
    }
    NSLog(@"Folders are %@",directoryList);
    return directoryList;
}


-(void)filterDataWithSegmentValueChanged:(NSString*)theValue{
    NSPredicate *predicate1 =[NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionForKeyPath:@"MeasureCategory"]
                                                                rightExpression:[NSExpression expressionForConstantValue:theValue]
                                                                       modifier:NSDirectPredicateModifier
                                                                           type:NSEqualToPredicateOperatorType
                                                                        options:0];
    
    //NSArray *result = [self.unfilteredMetricsDataSource filteredArrayUsingPredicate:predicate1];
    //[theDocumentList addObjectsFromArray:result];
  
}


#pragma mark  -  TextField Delegate Methods -
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
    
    [theDocumentList removeAllObjects];
    [theDocumentList addObjectsFromArray:filteredArray];
    @try{
        [self.tblView_medicalHistory reloadData];
    }
    @catch(NSException *e){
        
    }
    //    [searchBar resignFirstResponder];
    searchBar.text = @"";
    
    
}

BOOL isFiltered;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [theDocumentList  removeAllObjects];// remove all data that belongs to previous search
    if([textField.text isEqualToString:@""]||textField.text==nil){
        [theDocumentList addObjectsFromArray:filteredArray];
        [self.tblView_medicalHistory  reloadData];
        return YES;
    }
    
    NSInteger counter = 0;
    for(NSDictionary *name in filteredArray)
    {
        NSString *searchStr=[NSString stringWithFormat:@"%@",[name objectForKey:@"name"]];
        NSRange nameRange = [searchStr rangeOfString:textField.text options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [theDocumentList addObject:name];
        }
        else{
            
        }
        
        counter++;
    }
    [self.tblView_medicalHistory  reloadData];
    return YES;
    /*
    if(textField.text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        
        for (NSDictionary* fileName in theDocumentList)
        {
            NSRange nameRange = [[fileName valueForKey:@"name"] rangeOfString:textField.text options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [[fileName valueForKey:@"name"] rangeOfString:textField.text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [filteredTableData addObject:fileName];
            }
        }
    }
    NSLog(@"filtered array is %@",filteredTableData);
    [self.tblView_medicalHistory reloadData];
    return YES;*/
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [theDocumentList removeAllObjects];
    [theDocumentList addObjectsFromArray:filteredArray];
    @try{
        [self.tblView_medicalHistory reloadData];
    }
    @catch(NSException *e){
        
    }
    //    [searchBar resignFirstResponder];
    textField.text=@"";
    [textField resignFirstResponder];
    return YES;
}



UIKIT_STATIC_INLINE UIActionSheet * ShowOptionsSheet(id delegate){
    UIActionSheet *theOptionsSheet = [[UIActionSheet alloc] initWithTitle:@"MyHealth" delegate:delegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:([UIScreen mainScreen].bounds.size.height <= 568 ?nil:@"Cancel") otherButtonTitles:@"Move",@"Share", nil];
    __weak MedicalDocumentsViewController *selfObject=delegate;
    [theOptionsSheet showInView:[selfObject.view window]];
    return theOptionsSheet;
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
