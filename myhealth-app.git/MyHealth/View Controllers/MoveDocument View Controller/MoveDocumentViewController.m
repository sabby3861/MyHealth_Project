//
//  MoveDocumentViewController.m
//  MyHealth
//
//  Created by Sanjay Chauhan on 16/12/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "MoveDocumentViewController.h"
#import "MedicalDocumentsCustomCell.h"
#import "Constants.h"
#import "NSString+SCPaths.h"
#import "SCLog.h"
#import "AppDelegate.h"
#import "SSConstants.h"


@interface MoveDocumentViewController (){
    MedicalDocumentsCustomCell *cell;
    NSMutableArray *theDocumentList;
//[fileManager moveItemAtPath:myPath toPath:myNewPath error:NULL];
}
@property (weak, nonatomic) IBOutlet UILabel *theTitle;
@property (weak, nonatomic) IBOutlet UITableView *theDocumentTableView;
- (IBAction)theBackButtonClicked:(UIButton *)sender;
- (IBAction)moveFolderAction:(UIBarButtonItem *)sender;
- (IBAction)createFolderAction:(UIBarButtonItem *)sender;

@end

@implementation MoveDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.theTitle.text=self.mPathSuffix.length>0 ?self.mPathSuffix:@"MyHealth";

    SCLogDebug(@"The Suffix is %@",self.mPathSuffix);
    [self.theDocumentTableView registerNib:[UINib nibWithNibName:@"MedicalDocumentsCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    NSLog(@"the values are %@",[NSString getDirectoriesandFilesinFolder:[NSString getLibraryPath]]);
    theDocumentList=[[NSMutableArray alloc]init];
    //[theDocumentList addObject:[NSString getDirectoriesandFilesinFolder:[NSString getLibraryPath]]];
    
    if([self.mPathSuffix pathExtension])
        [theDocumentList addObjectsFromArray:[NSString getDirectoriesandFilesinFolder:[[NSString getLibraryPath]stringByDeletingPathExtension]]];
    else
        [theDocumentList addObjectsFromArray:[NSString getDirectoriesandFilesinFolder:[[NSString getLibraryPath]stringByAppendingPathComponent:self.mPathSuffix]]];
        
        
}
- (IBAction)theBackButtonClicked:(UIButton *)sender{
    SS_POPVIEWCONTROLLER;
}

- (IBAction)moveFolderAction:(UIBarButtonItem *)sender {
    [NSString asyncMoveFileAtPath:self.mfileAtPath toPath:self.mPathSuffix condition:^(BOOL succeed) {
        NSLog(@"Result %d",succeed);
    }];
}

- (IBAction)createFolderAction:(UIBarButtonItem *)sender {
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSFileManager defaultManager] setDelegate:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //self.shareButton.enabled = [self.info isUbiquitous];
    //self.moveButton.enabled = ![self.info isUbiquitous];
    //[self.navigationController setToolbarHidden:NO animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self.navigationController setToolbarHidden:YES animated:YES];

}

#pragma mark -  UITableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
    //cell.delegate = self;
    if ((indexPath.row == 0)) {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
        
    } else {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_doctorspecial_middle.png"]];
    }
    cell.theFolderName.text=[NSString stringWithFormat:@"%@",[[theDocumentList objectAtIndex:indexPath.row]valueForKey:@"name"]];
   
    NSString *pathExt=[NSString stringWithFormat:@"%@",[[theDocumentList valueForKey:@"name"]objectAtIndex:indexPath.row]];
    NSLog(@"Path extension is %@",[pathExt pathExtension]);
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
        /*
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MoveDocumentViewController *viewCrtl = [storyboard instantiateViewControllerWithIdentifier:@"MedicalDocumentsViewController"];
        viewCrtl.title = [[theDocumentList valueForKey:@"name"] objectAtIndex:indexPath.row];//[subpath lastPathComponent];
        viewCrtl.mPathSuffix=[[theDocumentList valueForKey:@"name"] objectAtIndex:indexPath.row];
        NSLog(@"path extension is %@",self.mPathSuffix);
        [self.navigationController pushViewController:viewCrtl animated:YES];
        */
        
        MoveDocumentViewController *moveDocumentVC = [[[AppDelegate sharedAppDelegate]theMainStoryBoard] instantiateViewControllerWithIdentifier:MOVEDOCUMENT_VIEW];
        moveDocumentVC.mPathSuffix = [[theDocumentList valueForKey:@"name"] objectAtIndex:indexPath.row];//[subpath lastPathComponent];
        //moveDocumentVC.mPathSuffix=self.thePreviousFilePath;
        NSLog(@"path extension is %@",self.mPathSuffix);
        [self.navigationController pushViewController:moveDocumentVC animated:YES];
        
    }
}

-(NSMutableArray*)theDocumentsCount{
    return [NSString getDirectoriesandFilesinFolder:[[NSString getLibraryPath]stringByAppendingPathComponent:self.mPathSuffix]];
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


@end
