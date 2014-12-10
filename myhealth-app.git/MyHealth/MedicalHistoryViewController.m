//
//  MedicalHistoryViewController.m
//  MyHealth
//
//  Created by Ashish Chhabra on 10/18/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

/*#import "MedicalHistoryViewController.h"
#import "MedicalHistoryCustomCell.h"
#import "MBProgressHUD.h"
#import "MedicalHistory.h"
#import "AFNetworking.h"
@interface MedicalHistoryViewController ()
{
    MedicalHistoryCustomCell *cell;
    NSIndexPath *selectedIndex;
}
@end

@implementation MedicalHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedIndex = nil;
    [self.tblView_medicalHistory registerNib:[UINib nibWithNibName:@"MedicalHistoryCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    
    MedicalHistory *history = [[MedicalHistory alloc] init];
    NSLog(@"History-->>%@",history.toJSONString);
    
    [MBProgressHUD showHUDAddedTo:_tblView_medicalHistory animated:YES];
    
    _arraySectionRows = [[NSMutableArray alloc] init];
    [_arraySectionRows addObject:@"1"];
    [_arraySectionRows addObject:@"1"];
    [_arraySectionRows addObject:@"1"];
    [_arraySectionRows addObject:@"1"];
    [_arraySectionRows addObject:@"1"];
    [_arraySectionRows addObject:@"1"];
//   AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//    [manager GET:@"https://myhealth.brillisoft.net/iphoneAPIs/api/getPatientHistoryData?patientID=2&formName=presentHealth" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        [MBProgressHUD hideAllHUDsForView:_tblView_medicalHistory animated:YES];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [MBProgressHUD hideAllHUDsForView:_tblView_medicalHistory animated:YES];
//    }];

    // Do any additional setup after loading the view.
    [self getMedicalFormHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
    if ((indexPath.row == 0)) {
        
        cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
        
    } else {
        
        //cell.imgView_bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_doctorspecial_middle.png"]];
    }
    
    return  cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectedIndex.section == section) {
        
        return 6;
    }
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex.section == indexPath.section) {
        
        return;
    }
    selectedIndex = indexPath;
    [_tblView_medicalHistory reloadData];
    //[_tblView_medicalHistory reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}
*/

#import "STCollapseTableView.h"
#import "MedicalHistoryViewController.h"
#import "MedicalHistoryCustomCell.h"
#import "MBProgressHUD.h"
#import "MedicalHistory.h"
#import "AFNetworking.h"
@interface MedicalHistoryViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *headerValues;
    NSMutableArray *arrayGeneralInfo;
    NSMutableArray *arrayGeneralQuestions;
    NSMutableArray *arrayFamilyIllness;
    NSMutableArray *arrayPresentHealth;
    NSMutableArray *arrayPastHistory;
    NSMutableArray *arrayMedication;
    MedicalHistoryCustomCell *medicalCell;
    MedicalHistory *history;
}
@property (weak, nonatomic) IBOutlet STCollapseTableView *tableView;

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;

@end

@implementation MedicalHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setupViewController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupViewController];
    }
    return self;
}

- (void)setupViewController
{
    
    NSArray* colors = @[[UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor purpleColor]];
    headerValues = [[NSMutableArray alloc] init];
    [headerValues addObject:@"General Info"];
    [headerValues addObject:@"General Questions"];
    [headerValues addObject:@"Family illness"];
    [headerValues addObject:@"Present health"];
    [headerValues addObject:@"Past history"];
    [headerValues addObject:@"Medication"];
    [headerValues addObject:@"Doctor's visits"];
    
    
    arrayGeneralInfo = [[NSMutableArray alloc] init];
    [arrayGeneralInfo addObject:@"Name"];
    [arrayGeneralInfo addObject:@"Address"];
    [arrayGeneralInfo addObject:@"Phone number"];
    [arrayGeneralInfo addObject:@"Social security number"];
    [arrayGeneralInfo addObject:@"DOB"];
    [arrayGeneralInfo addObject:@"Emergency contact number"];
    [arrayGeneralInfo addObject:@"Sex"];
    
    arrayGeneralQuestions = [[NSMutableArray alloc] init];
    [arrayGeneralQuestions addObject:@"Blood Type"];
    [arrayGeneralQuestions addObject:@"Weight"];
    [arrayGeneralQuestions addObject:@"Allergies"];
    [arrayGeneralQuestions addObject:@"Blood pressure"];
    [arrayGeneralQuestions addObject:@"Blood results"];
    
    arrayFamilyIllness = [[NSMutableArray alloc] init];
    [arrayFamilyIllness addObject:@"Diabetes"];
    [arrayFamilyIllness addObject:@"High blood pressure"];
    [arrayFamilyIllness addObject:@"Stroke"];
    [arrayFamilyIllness addObject:@"Heart trouble"];
    [arrayFamilyIllness addObject:@"Easy bleeding"];
    [arrayFamilyIllness addObject:@"Jaundice"];
    [arrayFamilyIllness addObject:@"Alcoholism"];
    [arrayFamilyIllness addObject:@"Tuberculosis"];
    [arrayFamilyIllness addObject:@"Obesity"];
    [arrayFamilyIllness addObject:@"Gout"];
    [arrayFamilyIllness addObject:@"Asthma"];
    [arrayFamilyIllness addObject:@"Psychiatric Illness"];
    [arrayFamilyIllness addObject:@"Allergy"];
    [arrayFamilyIllness addObject:@"High Blood Fats"];
    [arrayFamilyIllness addObject:@"Cancer"];
    [arrayFamilyIllness addObject:@"Other"];
    
    arrayPresentHealth = [[NSMutableArray alloc] init];
    [arrayPresentHealth addObject:@"Household contact with anyone with tuberculosis"];
    [arrayPresentHealth addObject:@"Tuberculosis or positive TB test"];
    [arrayPresentHealth addObject:@"Blood in sputum or when coughing"];
    [arrayPresentHealth addObject:@"Excessive bleeding after injury or dental work"];
    [arrayPresentHealth addObject:@"Suicide attempt or plans Sleepwalking"];
    [arrayPresentHealth addObject:@"Wear corrective lenses"];
    [arrayPresentHealth addObject:@"Eye surgery to correct vision Lack vision in either eye Wear a hearing aid"];
    [arrayPresentHealth addObject:@"Stutter or stammer"];
    [arrayPresentHealth addObject:@"Wear a brace or back support Scarlet fever"];
    [arrayPresentHealth addObject:@"Rheumatic fever"];
    [arrayPresentHealth addObject:@"Swollen or painful joints Frequent or severe headaches Dizziness or fainting spells Eye trouble"];
    [arrayPresentHealth addObject:@"Hearing loss"];
    [arrayPresentHealth addObject:@"Recurrent ear infections Chronic or frequent colds Severe tooth or gum trouble Sinusitis"];
    [arrayPresentHealth addObject:@"Hay Fever or allergic rhinitis Head Injury"];
    [arrayPresentHealth addObject:@"Asthma"];
    [arrayPresentHealth addObject:@"Shortness of breath"];
    [arrayPresentHealth addObject:@"Bone, joint or other deformity"];
    [arrayPresentHealth addObject:@"Pain or pressure in chest"];
    [arrayPresentHealth addObject:@"Loss of finger or toe"];
    [arrayPresentHealth addObject:@"Chronic cough"];
    [arrayPresentHealth addObject:@"Painful or trick shoulder or elbow"];
    [arrayPresentHealth addObject:@"Palpitation or pounding heart"];
    [arrayPresentHealth addObject:@"Heart trouble"];
    [arrayPresentHealth addObject:@"Recurrent back pain or any back injury"];
    [arrayPresentHealth addObject:@"High or low blood pressure"];
    [arrayPresentHealth addObject:@"Cramps in your legs"];
    [arrayPresentHealth addObject:@"Trick or locked knee"];
    [arrayPresentHealth addObject:@"Frequent indigestion"];
    [arrayPresentHealth addObject:@"Foot trouble"];
    [arrayPresentHealth addObject:@"Stomach, liver, or intestinal trouble"];
    [arrayPresentHealth addObject:@"Nerve Injury"];
    [arrayPresentHealth addObject:@"Gall bladder trouble or gallstones"];
    [arrayPresentHealth addObject:@"Paralysis (including infantile)"];
    [arrayPresentHealth addObject:@"Epilepsy or seizure"];
    [arrayPresentHealth addObject:@"Jaundice or hepatitis"];
    [arrayPresentHealth addObject:@"Car, train, sea or air sickness"];
    [arrayPresentHealth addObject:@"Broken bones"];
    [arrayPresentHealth addObject:@"Frequent trouble sleeping"];
    [arrayPresentHealth addObject:@"Adverse reaction to medication"];
    [arrayPresentHealth addObject:@"Depression of excessive worry"];
    [arrayPresentHealth addObject:@"Skin diseases"];
    [arrayPresentHealth addObject:@"Loss of memory or amnesia"];
    [arrayPresentHealth addObject:@"Tumor, growth, cyst, cancer"];
    [arrayPresentHealth addObject:@"Nervous trouble of any sort"];
    [arrayPresentHealth addObject:@"Hernia"];
    [arrayPresentHealth addObject:@"Periods of unconsciousness"];
    [arrayPresentHealth addObject:@"Hemorrhoids or rectal disease"];
    [arrayPresentHealth addObject:@"Parent/sibling with diabetes, cancer, stroke or heart disease"];
    [arrayPresentHealth addObject:@"Frequent or painful urination"];
    [arrayPresentHealth addObject:@"Bed wetting since age 12"];
    [arrayPresentHealth addObject:@"X-ray or other radiation therapy"];
    [arrayPresentHealth addObject:@"Kidney stone or blood in urine"];
    [arrayPresentHealth addObject:@"Chemotherapy"];
    [arrayPresentHealth addObject:@"Sugar or albumin in urine"];
    [arrayPresentHealth addObject:@"Asbestos or toxic chemical exposure"];
    [arrayPresentHealth addObject:@"Sexually transmitted diseases"];
    [arrayPresentHealth addObject:@"Recent gain or loss of weight"];
    [arrayPresentHealth addObject:@"Plate, pin or rod in any bone"];
    [arrayPresentHealth addObject:@"Eating disorder (anorexia bulimia, etc.)"];
    [arrayPresentHealth addObject:@"Easy fatiguability"];
    [arrayPresentHealth addObject:@"Been told to cut down or criticized for alcohol use"];
    [arrayPresentHealth addObject:@"Arthritis, Rheumatism, or Bursitis"];
    [arrayPresentHealth addObject:@"Used illegal substances"];
    [arrayPresentHealth addObject:@"Thyroid trouble or goiter"];
    [arrayPresentHealth addObject:@"Used tobacco"];
    [arrayPresentHealth addObject:@"Treated for female disorder"];
    [arrayPresentHealth addObject:@"Change in menstrual pattern"];
    
    arrayPastHistory = [[NSMutableArray alloc] init];
    [arrayPastHistory addObject:@"Have you ever been patient in hospital?"];
    [arrayPastHistory addObject:@"Have you ever had a colonoscopy?"];
    [arrayPastHistory addObject:@"Have you ever received a blood transfusion? "];
    [arrayPastHistory addObject:@"When was your last Tetanus shot?"];
    [arrayPastHistory addObject:@"When was your last Pneumonia shot?"];
    [arrayPastHistory addObject:@"When was your last Flu shot?"];
    [arrayPastHistory addObject:@"Woman: Have you ever been pregnant? (How many times?, How many children have you given birth to?)"];
    [arrayPastHistory addObject:@"Woman: Have you had a PAP smear?"];
    [arrayPastHistory addObject:@"Woman: Have you had a mammogram (breast x-ray)?"];
    
    
    
    self.data = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [colors count] ; i++)
    {
        NSMutableArray* section = [[NSMutableArray alloc] init];
        for (int j = 0 ; j < 3 ; j++)
        {
            [section addObject:[NSString stringWithFormat:@"Cell n°%i", j]];
        }
        [self.data addObject:section];
    }
    
    self.headers = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [colors count] ; i++)
    {
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [header setBackgroundColor:[colors objectAtIndex:i]];
        [self.headers addObject:header];
    }
    
    [_btn_back setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
    
    history = [[MedicalHistory alloc] init];
    NSLog(@"History Model-->>%@",history.toJSONString);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView reloadData];
    [self.tableView openSection:0 animated:NO];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MedicalHistoryCustomCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    [self getDoctorVisit];
    
}

- (IBAction)handleExclusiveButtonTap:(UIButton*)button
{
    [self.tableView setExclusiveSections:!self.tableView.exclusiveSections];
    
    [button setTitle:self.tableView.exclusiveSections?@"exclusive":@"!exclusive" forState:UIControlStateNormal];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [headerValues count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Reuse";
    
    medicalCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.section == 0) {
        
        medicalCell.lbl_heading.text = [arrayGeneralInfo objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        
        medicalCell.lbl_heading.text = [arrayGeneralQuestions objectAtIndex:indexPath.row];
    } else if (indexPath.section == 2) {
        
        medicalCell.lbl_heading.text = [arrayFamilyIllness objectAtIndex:indexPath.row];
    } else if (indexPath.section == 3) {
        
        medicalCell.lbl_heading.text = [arrayPresentHealth objectAtIndex:indexPath.row];
    } else if (indexPath.section == 4) {
        
        medicalCell.lbl_heading.text = [arrayPastHistory objectAtIndex:indexPath.row];
    }
    return medicalCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return arrayGeneralInfo.count;
        
    } else if (section == 1) {
        
        return arrayGeneralQuestions.count;
        
    } else if (section == 2) {
        
        return arrayFamilyIllness.count;
        
    } else if (section == 3) {
        
        return arrayPresentHealth.count;
        
    } else if (section == 4) {
        
        return arrayPastHistory.count;
        
    } else if (section == 5) {
        
        return 5;
        
    } else {
        
        return 5;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UILabel *lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(53, 19, 150, 30)];
    lbl_title.textColor = [UIColor whiteColor];
    lbl_title.text = [headerValues objectAtIndex:section];
    lbl_title.font = [UIFont fontWithName:@"Oswald-Regular" size:15];
    [view addSubview:lbl_title];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 26, 29, 13)];
    [imageView setImage:[UIImage imageNamed:@"icon_folder.png"]];
    [view addSubview:imageView];
    
    UIView *lineSeperator = [[UIView alloc] initWithFrame:CGRectMake(230, 22, 1, 25)];
    lineSeperator.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.8];
    [view addSubview:lineSeperator];
    
    UILabel *lbl_history = [[UILabel alloc] initWithFrame:CGRectMake(240, 28, 70, 15)];
    lbl_history.textColor = [UIColor colorWithRed:117.0f/255.0f green:218.0f/255.0f blue:255.0f/255.0f alpha:1];
    lbl_history.text = @"User's medical history";
    lbl_history.font = [UIFont fontWithName:@"Oswald-Light" size:9];
    [view addSubview:lbl_history];

    
    if (section == 0) {
        
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_ratebg.png"]];
    } else {
        
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_doctorspecial_middle.png"]];
    }
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return [self.headers objectAtIndex:section];
//}
// Navigate Back
-(IBAction)navigateback:(id)sender
{
    self.tableView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getMedicalFormHistory
{
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"patientID": @"1"};
    [manager GET:@"http://myhealth.brillisoft.net/iphoneAPIs/api/getPatientHistoryData?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Resopnse-->%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:_tableView animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:YES];
        NSLog(@"Error: %@", error);
    }];
}
-(void)getMedication
{
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"patientID": @"4"};
    [manager GET:@"http://myhealth.brillisoft.net/iphoneAPIs/api/getPatientHistoryData?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Resopnse-->%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:_tableView animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:YES];
        NSLog(@"Error: %@", error);
    }];
}
-(void)getDoctorVisit
{
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"patientID": @"4"};
    [manager GET:@"http://myhealth.brillisoft.net/iphoneAPIs/api/getPatientHistoryData?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Resopnse-->%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:_tableView animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:YES];
        NSLog(@"Error: %@", error);
    }];
}
@end
