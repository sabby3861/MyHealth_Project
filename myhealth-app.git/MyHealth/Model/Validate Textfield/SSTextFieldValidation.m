//
//  SSTextFieldValidation.m
//  STREETSmart
//
//  Created by Sanjay Chauhan on 6/28/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import "SSTextFieldValidation.h"
#import "Constants.h"

@interface SSTextFieldValidation ()
@property (nonatomic, readwrite) SSTextFieldValidationStatus validationStatus;
@end

@implementation SSTextFieldValidation

static const CGFloat kStandardTextFieldHeight = 30;
static const CGFloat kIndicatorStrokeWidth = 2;
static const CGFloat kTextEdgeInset = 6;

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame;
{
    if (!(self = [super initWithFrame:frame])) return nil;
    return [self initialize];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
{
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    return [self initialize];
}

- (instancetype)initialize;
{
    self.borderStyle = UITextBorderStyleNone;
    
    self.validColor = SS_BACKGROUNDCOLOR(blackColor);//[UIColor colorWithHue:0.333 saturation:1 brightness:0.75 alpha:1];
    self.invalidColor = [UIColor redColor];//[UIColor colorWithHue:0 saturation:1 brightness:1 alpha:1];
    self.indeterminateColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    
    //self.layer.borderWidth = 1;
    //self.layer.cornerRadius = 5;
    
    [self addTarget:self action:@selector(validate) forControlEvents:UIControlEventAllEditingEvents];
    
    self.validationStatus = SSTextFieldValidationStatusIndeterminate;
    return self;
}

#pragma mark - Setters
- (void)setRequired:(BOOL)required
{
    _required = required;
    [self validate];
}

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


+(BOOL)isTextFieldEmpty:(UITextField*)theTextField andAlertMessage:(NSString*)message{
    NSLog(@"text is %@",theTextField.text);
    if(theTextField.text.length<1){
        ShowAlertView(@"Medical App", message, nil);
        return TRUE;
    }
    else
        return NO;
    
}



BOOL (^isTextFieldEmpty)(UITextField *,NSString*) = ^(UITextField *theTextField,NSString* message) {
    if(theTextField.text.length<1)
        return YES;
    else
        return NO;
};


/*
- (void)setValidationStatus:(SSTextFieldValidationStatus)status;
{
    _validationStatus = status;
    switch (status) {
        case SSTextFieldValidationStatusIndeterminate:
            self.layer.borderColor = self.indeterminateColor.CGColor;
            self.rightView = self.imageViewForIndeterminateStatus;
            break;
        case SSTextFieldValidationStatusInvalid:
            self.layer.borderColor = self.invalidColor.CGColor;
            self.rightView = self.imageViewForInvalidStatus;
            break;
        case SSTextFieldValidationStatusValid:
            self.layer.borderColor = self.validColor.CGColor;
            self.rightView = self.imageViewForValidStatus;
            break;
    }
    self.rightViewMode = UITextFieldViewModeAlways;
}
*/
- (void)setValidationStatus:(SSTextFieldValidationStatus)status;
{
    _validationStatus = status;
    switch (status) {
        case SSTextFieldValidationStatusIndeterminate:
            self.textColor = self.indeterminateColor;
            self.rightView = self.imageViewForIndeterminateStatus;
            break;
        case SSTextFieldValidationStatusInvalid:
            self.textColor = self.invalidColor;
            self.rightView = self.imageViewForInvalidStatus;
            break;
        case SSTextFieldValidationStatusValid:
            self.textColor = self.validColor;
            self.rightView = self.imageViewForValidStatus;
            break;
    }
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setValidationType:(SSTextFieldValidationType)validationType;
{
    _validationType = validationType;
    switch (validationType) {
        case SSTextFieldValidationTypeEmail:
            [self applyEmailValidation];
            break;
        case SSTextFieldValidationTypeURL:
            [self applyURLValidation];
            break;
        case SSTextFieldValidationTypePhone:
            [self applyPhoneValidation];
            break;
        case SSTextFieldValidationTypeZIP:
            [self applyZIPValidation];
            break;
        default:
            [self clearAllValidationMethods];
            break;
    }
}

- (void)setValidationDelegate:(id<SSTextFieldValidationValidationDelegate>)validationDelegate;
{
    [self clearAllValidationMethods];
    _validationDelegate = validationDelegate;
    [self validate];
}

- (void)setValidationBlock:(SSTextFieldValidationStatus (^)(void))validationBlock;
{
    [self clearAllValidationMethods];
    _validationBlock = validationBlock;
    [self validate];
}

- (void)setValidationRegularExpression:(NSRegularExpression *)validationRegularExpression;
{
    [self clearAllValidationMethods];
    _validationRegularExpression = validationRegularExpression;
    [self validate];
}

#pragma mark - Setting built-in validation types
- (void)applyEmailValidation;
{
    [self clearAllValidationMethods];
    __weak SSTextFieldValidation *weakSelf = self;
    self.validationBlock = ^{
        if (weakSelf.text.length == 0 && !weakSelf.isRequired) {
            return SSTextFieldValidationStatusIndeterminate;
        }
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:NULL];
        NSArray *matches = [detector matchesInString:weakSelf.text options:0 range:NSMakeRange(0, weakSelf.text.length)];
        for (NSTextCheckingResult *match in matches) {
            if (match.resultType == NSTextCheckingTypeLink &&
                [match.URL.absoluteString rangeOfString:@"mailto:"].location != NSNotFound) {
                return SSTextFieldValidationStatusValid;
            }
        }
        return SSTextFieldValidationStatusInvalid;
    };
    [self validate];
}

- (void)applyURLValidation;
{
    [self clearAllValidationMethods];
    __weak SSTextFieldValidation *weakSelf = self;
    self.validationBlock = ^{
        if (weakSelf.text.length == 0 && !weakSelf.isRequired) {
            return SSTextFieldValidationStatusIndeterminate;
        }
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:NULL];
        NSArray *matches = [detector matchesInString:weakSelf.text options:0 range:NSMakeRange(0, weakSelf.text.length)];
        return (NSInteger)matches.count;
    };
    [self validate];
}

- (void)applyPhoneValidation;
{
    [self clearAllValidationMethods];
    __weak SSTextFieldValidation *weakSelf = self;
    self.validationBlock = ^{
        if (weakSelf.text.length == 0 && !weakSelf.isRequired) {
            return SSTextFieldValidationStatusIndeterminate;
        }
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:NULL];
        NSArray *matches = [detector matchesInString:weakSelf.text options:0 range:NSMakeRange(0, weakSelf.text.length)];
        return (NSInteger)matches.count;
    };
    [self validate];
}

- (void)applyZIPValidation;
{
    [self clearAllValidationMethods];
    __weak SSTextFieldValidation *weakSelf = self;
    self.validationBlock = ^{
        if (weakSelf.text.length == 0 && !weakSelf.isRequired) {
            return SSTextFieldValidationStatusIndeterminate;
        }
        NSString *justNumbers = [[weakSelf.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        if (justNumbers.length == 5 || justNumbers.length == 9) {
            return SSTextFieldValidationStatusValid;
        }
        return SSTextFieldValidationStatusInvalid;
    };
    [self validate];
}

- (void)clearAllValidationMethods;
{
    _validationRegularExpression = nil;
    _validationDelegate = nil;
    _validationBlock = nil;
    _validationType = SSTextFieldValidationTypeNone;
}

#pragma mark - Validation
- (void)validate;
{
    if (self.validationDelegate) {
        self.validationStatus = [self.validationDelegate textFieldStatus:self];
    } else if (self.validationBlock) {
        self.validationStatus = self.validationBlock();
    } else if (self.validationRegularExpression) {
        [self validateWithRegularExpression];
    }
}

- (void)validateWithRegularExpression
{
    if (self.text.length == 0 && !self.isRequired) {
        self.validationStatus = SSTextFieldValidationStatusIndeterminate;
    } else if ([self.validationRegularExpression numberOfMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)]) {
        self.validationStatus = SSTextFieldValidationStatusValid;
    } else {
        self.validationStatus = SSTextFieldValidationStatusInvalid;
    }
}

#pragma mark - Indicator Image Generation

/** This shape is a dash */
- (UIImageView *)imageViewForIndeterminateStatus;
{
    CGContextRef context = [self beginImageContextAndSetPathStyle];
    
    CGContextMoveToPoint(context, 6, kStandardTextFieldHeight / 2.f);
    CGContextAddLineToPoint(context, 24, kStandardTextFieldHeight / 2.f);
    CGContextStrokePath(context);
    
    return [self finalizeImageContextAndReturnImageView];
}

/** This shape is an X */
- (UIImageView *)imageViewForInvalidStatus
{
    CGContextRef context = [self beginImageContextAndSetPathStyle];
    
    CGContextMoveToPoint(context, 6, 6);
    CGContextAddLineToPoint(context, 24, 24);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 6, 24);
    CGContextAddLineToPoint(context, 24, 6);
    CGContextStrokePath(context);
    
    return [self finalizeImageContextAndReturnImageView];
}

/** This shape is a check mark */
- (UIImageView *)imageViewForValidStatus;
{
    CGContextRef context = [self beginImageContextAndSetPathStyle];
    
    CGContextMoveToPoint(context, 6, 14);
    CGContextAddLineToPoint(context, 12, 24);
    CGContextAddLineToPoint(context, 24, 6);
    CGContextStrokePath(context);
    
    return [self finalizeImageContextAndReturnImageView];
}

- (CGContextRef)beginImageContextAndSetPathStyle;
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kStandardTextFieldHeight, kStandardTextFieldHeight), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kIndicatorStrokeWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGColorRef strokeColor = self.indeterminateColor.CGColor;
    if (self.validationStatus == SSTextFieldValidationStatusInvalid) strokeColor = self.invalidColor.CGColor;
    if (self.validationStatus == SSTextFieldValidationStatusValid) strokeColor = self.validColor.CGColor;
    
    CGContextSetStrokeColorWithColor(context, strokeColor);
    return context;
}

- (UIImageView *)finalizeImageContextAndReturnImageView;
{
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImageView.alloc initWithImage:image];
}


#pragma mark - Custom UITextField rect sizing
- (CGRect)textRectForBounds:(CGRect)bounds;
{
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, kTextEdgeInset,
                                                          0, kStandardTextFieldHeight - kTextEdgeInset));
}

- (CGRect)editingRectForBounds:(CGRect)bounds;
{
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, kTextEdgeInset,
                                                          0, kStandardTextFieldHeight - kTextEdgeInset));
}


@end