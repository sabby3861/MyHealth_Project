//
//  DoctorProfileViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 20/10/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "DoctorProfileViewController.h"
#import "DoctorProfileCustomCell.h"
#import "DoctorEducationHistroyCell.h"
#import "DoctorProfileHeaderView.h"
#import "DoctorCommentsCustomCell.h"
#import "DoctorNotesCustomCell.h"
#import "CustomIOS7AlertView.h"
#import "UIImageView+WebCache.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Macros.h"


@interface DoctorProfileViewController ()<CustomIOS7AlertViewDelegate,MFMailComposeViewControllerDelegate>
{
    DoctorProfileCustomCell *cell;
    DoctorEducationHistroyCell *eductaionCell;
    DoctorCommentsCustomCell *commentCell;
    DoctorNotesCustomCell *noteCell;
    
    UIView *docViewFooter;
    UITextView *textViewComment;
    UILabel *addLable;
    NSString *docName;
    int rating;
}
@end

@implementation DoctorProfileViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_tblView_profile registerNib:[UINib nibWithNibName:@"DoctorEducationHistroyCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    [_tblView_profile registerNib:[UINib nibWithNibName:@"DoctorCommentsCustomCell" bundle:nil] forCellReuseIdentifier:@"ReuseCommentCell"];
    [_tblView_profile registerNib:[UINib nibWithNibName:@"DoctorNotesCustomCell" bundle:nil] forCellReuseIdentifier:@"ReuseCustomNotes"];
    
    // Do any additional setup after loading the view.
    _comments = [[CommentListing alloc] init];
    _docNotes = [[Notes alloc] init];
    _degreeArray = [[Degree alloc] init];
    
    _lbl_title.font = [UIFont fontWithName:@"Oswald-Regular" size:15];
    
    rating = 0;
    [self performSelectorOnMainThread:@selector(getDoctorInfo) withObject:nil waitUntilDone:NO];
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    docName = [NSString stringWithFormat:@"%@ %@",[_docInfo valueForKey:@"firstName"],[_docInfo valueForKey:@"lastName"]];
    _lbl_title.text = docName;
    
}

#pragma mark  CustomIOS7AlertView
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        NSLog(@"User details-->>%@",(APP_DELEGATE).patient);
        [parameters setValue:[_docInfo valueForKey:@"doctorID"] forKey:@"doctorID"];
        [parameters setValue:[((APP_DELEGATE).patient) valueForKey:@"patientID"] forKey:@"patientID"];
        
        if ([addLable.text isEqualToString:@"Add Comment"]) {
            
            [parameters setValue:textViewComment.text forKey:@"commentText"];
            [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/addComment?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                _comments.arrayComments = [[responseObject valueForKey:@"DoctorDetails"] valueForKey:@"doctorComments"];
                [_tblView_profile reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [MBProgressHUD hideAllHUDsForView:_tblView_profile animated:YES];
                NSLog(@"Error: %@", error);
            }];

            
        } else {
            
            [parameters setValue:textViewComment.text forKey:@"noteText"];
            [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/addNotes?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                _comments.arrayComments = [[responseObject valueForKey:@"DoctorDetails"] valueForKey:@"doctorComments"];
                [_tblView_profile reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSLog(@"Response-->%@",operation.responseString);
                NSLog(@"Error: %@", error);
            }];

        }
        
       // NSDictionary *parameters = @{@"doctorID": @"1"};
        
        NSLog(@"Send Comment");
    }
    [alertView close];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  UITableView Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        eductaionCell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
        if (_degreeArray.doctorEducation.count) {
            
            eductaionCell.lbl_degree.text = [[_degreeArray.doctorEducation objectAtIndex:indexPath.row] valueForKey:@"educationCollage"];
            eductaionCell.lbl_detail.text = [[_degreeArray.doctorEducation objectAtIndex:indexPath.row] valueForKey:@"educationDescription"];
            
            NSString *commentText = [[_degreeArray.doctorEducation objectAtIndex:indexPath.row] valueForKey:@"educationDescription"];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commentText];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:11] range:NSMakeRange(0, [commentText length])];
            CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(255, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            CGRect newFrame = eductaionCell.lbl_detail.frame;
            newFrame.size.height = rect.size.height;
            eductaionCell.lbl_detail.frame = newFrame;
        }
        
        
      return eductaionCell;
        
    } else if (indexPath.section == 1){
        
        commentCell = [tableView dequeueReusableCellWithIdentifier:@"ReuseCommentCell"];
        commentCell.imgView_user.layer.cornerRadius = 15.0f;
        commentCell.imgView_user.layer.masksToBounds = YES;
        
        if (_comments.arrayComments.count) {
            
            commentCell.lbl_name.text = [[_comments.arrayComments objectAtIndex:indexPath.row] valueForKey:@"firstName"];
            commentCell.lbl_text.text = [[_comments.arrayComments objectAtIndex:indexPath.row] valueForKey:@"commentText"];
            [commentCell.imgView_user setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_comments.arrayComments objectAtIndex:indexPath.row] valueForKey:@"user_image"]]]]];
            NSString *commentText = [[_comments.arrayComments objectAtIndex:indexPath.row] valueForKey:@"commentText"];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commentText];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12] range:NSMakeRange(0, [commentText length])];
            CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(255, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            CGRect newFrame = commentCell.lbl_text.frame;
            newFrame.size.height = rect.size.height;
            commentCell.lbl_text.frame = newFrame;
            
            CGRect sepetarotFrame = commentCell.higylighter.frame;
            sepetarotFrame.origin.y = newFrame.origin.y+newFrame.size.height+10;
            commentCell.higylighter.frame = sepetarotFrame;
            if (indexPath.row == (_comments.arrayComments.count-1)) {
                
                commentCell.higylighter.hidden = YES;
            }
        }
        
        return commentCell;
        
    } else {
        
        noteCell = [tableView dequeueReusableCellWithIdentifier:@"ReuseCustomNotes"];
        if (_docNotes.arrayNotes.count) {
            
            noteCell.lbl_note.text = [[_docNotes.arrayNotes objectAtIndex:indexPath.row] valueForKey:@"noteText"];
            NSString *commentText = [[_docNotes.arrayNotes objectAtIndex:indexPath.row] valueForKey:@"noteText"];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commentText];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12] range:NSMakeRange(0, [commentText length])];
            CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(255, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            CGRect newFrame = noteCell.lbl_note.frame;
            newFrame.size.height = rect.size.height;
            noteCell.lbl_note.frame = newFrame;
            
        }
        return noteCell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return _degreeArray.doctorEducation.count;
        
    } else if (section == 1){
        
        return _comments.arrayComments.count;
        
    } else {
        
        return _docNotes.arrayNotes.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"DoctorProfileHeaderView" owner:self options:nil];
        DoctorProfileHeaderView *docView = [nibObjects objectAtIndex:0];
        
        docView.imgView_doctor.layer.cornerRadius = 45;
        docView.imgView_doctor.layer.masksToBounds = YES;
        
        docView.lbl_name.text = [_docInfo valueForKey:@"firstName"];
        docView.lbl_specialist.text = [_docInfo valueForKey:@"experience"];
        [docView.imgView_doctor setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_docInfo valueForKey:@"doctorImage"]]]]];
        
        [docView.btn_contact setImage: [UIImage imageNamed:@"icon_contactdoctor.png"] forState:UIControlStateNormal];
        [docView.btn_contact setImageEdgeInsets:UIEdgeInsetsMake(0.0, -7.0, 5.0, 5.0)];
        [docView.btn_directions setImage: [UIImage imageNamed:@"icon_directions"] forState:UIControlStateNormal];
        [docView.btn_directions addTarget:self action:@selector(getDirections:) forControlEvents:UIControlEventTouchUpInside];
        [docView.btn_directions setImageEdgeInsets:UIEdgeInsetsMake(0.0, -7.0, 5.0, 5.0)];
        [docView.btn_recommend setImage: [UIImage imageNamed:@"icon_recommenddoctor.png"] forState:UIControlStateNormal];
        [docView.btn_recommend addTarget:self action:@selector(composemail:) forControlEvents:UIControlEventTouchUpInside];
        [docView.btn_recommend setImageEdgeInsets:UIEdgeInsetsMake(0.0, -7.0, 5.0, 5.0)];
        return docView;
        
    }else if(section == 2){
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        view.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:232.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
        UILabel *lbl_heading = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
        lbl_heading.text = @"My Notes";
        lbl_heading.font = [UIFont fontWithName:@"Helvetica Neue-Bold" size:13];
        lbl_heading.textColor = [UIColor colorWithRed:28.0f/255.0f green:149.0f/255.0f blue:266.0f/255.0f alpha:1];
        lbl_heading.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lbl_heading];
        return view;
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"DoctorProfileFooterView" owner:self options:nil];
        docViewFooter = [nibObjects objectAtIndex:0];
        
        
        [((UIButton *)[docViewFooter viewWithTag:1]) addTarget:self action:@selector(addComment:) forControlEvents:UIControlEventTouchUpInside];
        [((UIButton *)[docViewFooter viewWithTag:2]) addTarget:self action:@selector(addNote:) forControlEvents:UIControlEventTouchUpInside];
        
        [((UIButton *)[docViewFooter viewWithTag:11]) addTarget:self action:@selector(rateDoctor:) forControlEvents:UIControlEventTouchUpInside];
        [((UIButton *)[docViewFooter viewWithTag:12]) addTarget:self action:@selector(rateDoctor:) forControlEvents:UIControlEventTouchUpInside];
        [((UIButton *)[docViewFooter viewWithTag:13]) addTarget:self action:@selector(rateDoctor:) forControlEvents:UIControlEventTouchUpInside];
        [((UIButton *)[docViewFooter viewWithTag:14]) addTarget:self action:@selector(rateDoctor:) forControlEvents:UIControlEventTouchUpInside];
        [((UIButton *)[docViewFooter viewWithTag:15]) addTarget:self action:@selector(rateDoctor:) forControlEvents:UIControlEventTouchUpInside];
        
        return docViewFooter;
        
    }
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 250;
        
    } else if (section == 2){
        
        return 40;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        NSString *commentText = [[_degreeArray.doctorEducation objectAtIndex:indexPath.row] valueForKey:@"educationDescription"];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commentText];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:11] range:NSMakeRange(0, [commentText length])];
        CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(255, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        return 40.0f+rect.size.height;
        
    } else if (indexPath.section == 1){
        
        NSString *commentText = [[_comments.arrayComments objectAtIndex:indexPath.row] valueForKey:@"commentText"];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commentText];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12] range:NSMakeRange(0, [commentText length])];
        CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(255, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        return 40.0f+rect.size.height;
        
    } else if (indexPath.section == 2){
        
        NSString *commentText = [[_docNotes.arrayNotes objectAtIndex:indexPath.row] valueForKey:@"noteText"];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commentText];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12] range:NSMakeRange(0, [commentText length])];
        CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(255, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        return 5+rect.size.height;
        
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        
        return 170;
    }
    return 1;
}
// Navigate Back
-(IBAction)navigateback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getDoctorInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[_docInfo valueForKey:@"doctorID"] forKey:@"doctorID"];
    
    
    //[parameters setValue:[((APP_DELEGATE).patient) valueForKey:@"patientID"] forKey:@"patientID"];
    
    
    [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/getDoctorDetails?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        _comments.arrayComments = [[responseObject valueForKey:@"DoctorDetails"] valueForKey:@"doctorComments"];
        _degreeArray.doctorEducation = [[responseObject valueForKey:@"DoctorDetails"] valueForKey:@"doctorEducation"];
        _docNotes.arrayNotes = [[responseObject valueForKey:@"DoctorDetails"] valueForKey:@"doctorNotes"];
        [self showRating:[[[responseObject valueForKey:@"DoctorDetails"] valueForKey:@"thisPatientRate"] intValue]];
        [_tblView_profile reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:_tblView_profile animated:YES];
        NSLog(@"Error: %@", error);
    }];
}
-(void)addComment:(id)sender
{
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] isEqualToString:@"LoggedIn"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please login to make a comment." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    alert.tag = 200;
    alert.delegate = self;
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:@"Send", @"Cancel", nil]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    addLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    addLable.text = @"Add Comment";
    addLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:addLable];
    
    textViewComment = [[UITextView alloc] initWithFrame:CGRectMake(0, 30, 250, 170)];
    textViewComment.text = @"Write comment..";
    [view addSubview:textViewComment];
    [alert setContainerView:view];
    [alert show];
    
}
-(void)addNote:(id)sender
{
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] isEqualToString:@"LoggedIn"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please login to add a note." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    alert.tag = 100;
    alert.delegate = self;
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:@"Send", @"Cancel", nil]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    addLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    addLable.text = @"Add Note";
    addLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:addLable];
    
    textViewComment = [[UITextView alloc] initWithFrame:CGRectMake(0, 30, 250, 170)];
    textViewComment.text = @"Write Note..";
    [view addSubview:textViewComment];
    [alert setContainerView:view];
    [alert show];
    
}
-(void)rateDoctor:(UIButton *)sender
{
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] isEqualToString:@"LoggedIn"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please login to rate a doctor." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }

    if (sender.tag == 11) {
        
        rating = 1;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (sender.tag == 12) {
        
        rating = 2;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (sender.tag == 13) {
        
        rating = 3;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (sender.tag == 14) {
        
        rating = 4;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (sender.tag == 15) {
        
        rating = 5;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = YES;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[_docInfo valueForKey:@"doctorID"] forKey:@"doctorID"];
    [parameters setValue:[((APP_DELEGATE).patient) valueForKey:@"patientID"] forKey:@"patientID"];
    [parameters setValue:[NSString stringWithFormat:@"%d",rating] forKey:@"ratingPoint"];
    
    [manager POST:@"http://myhealth.brillisoft.net/iphoneAPIs/api/rating?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSLog(@"JSON: %@", responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:_tblView_profile animated:YES];
        NSLog(@"Error: %@", error);
    }];
}
-(void)showRating:(int)docRating
{
    if (docRating == 1) {
        
        rating = 1;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (docRating == 2) {
        
        rating = 2;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (docRating == 3) {
        
        rating = 3;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (docRating == 4) {
        
        rating = 4;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
        
    } else if (docRating == 5) {
        
        rating = 5;
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = YES;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = YES;
        
    } else {
        
        ((UIButton *)[docViewFooter viewWithTag:11]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:12]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:13]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:14]).selected = NO;
        ((UIButton *)[docViewFooter viewWithTag:15]).selected = NO;
    }
}
-(void)getDirections:(id)sender
{
    UIApplication *app = [UIApplication sharedApplication];
    
    NSString *coordinates = @"http://maps.apple.com/?daddr=San+Francisco,+CA&saddr=cupertino";
    [app openURL:[NSURL URLWithString: coordinates]];
}
-(IBAction)composemail:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        // Email Subject
        NSString *emailTitle = @"Compose";
        // Email Content
        NSString *messageBody = @"Content..";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"example@gmail.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
