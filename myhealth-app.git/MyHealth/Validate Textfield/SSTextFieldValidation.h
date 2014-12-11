//
//  SSTextFieldValidation.h
//  STREETSmart
//
//  Created by Sanjay Chauhan on 6/28/14.
//  Copyright (c) 2014 Techmadmin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SSTextFieldValidation;

/** TextField status modes. */
typedef NS_ENUM(NSInteger, SSTextFieldValidationStatus) {
    SSTextFieldValidationStatusIndeterminate = -1,
    SSTextFieldValidationStatusInvalid,
    SSTextFieldValidationStatusValid
};

/** TextField types. */
typedef NS_ENUM(NSUInteger, SSTextFieldValidationType) {
    SSTextFieldValidationTypeNone,
    SSTextFieldValidationTypeEmail,
    SSTextFieldValidationTypeURL,
    SSTextFieldValidationTypePhone,
    SSTextFieldValidationTypeZIP
};

/** The delegate is used for validation if it is assigned. */
@protocol SSTextFieldValidationValidationDelegate <NSObject>
@optional
-(SSTextFieldValidationStatus)textFieldStatus:(SSTextFieldValidation *)textField;
@end

/** SSTextFieldValidation is a class that extends UITextField and adds validation facilities including validation types and visual feedback.
 
 You can either set a type (email, URL, phone, zip, etc.) or set a property to validate via block, NSRegularExpression, or delegate.
 
 The text field will provide visual feedback indicating wheter it's in a valid, invalid, or indeterminate state.
 */
@interface SSTextFieldValidation : UITextField

/** Use this to get the validation status of your text field. */
@property (nonatomic, readonly) SSTextFieldValidationStatus validationStatus;

/** Use this property to easily set a validation type for your text field. */
@property (nonatomic) SSTextFieldValidationType validationType;

/** Normally, an empty text field is considered "indeterminate." Setting isRequired to YES will cause the textfield to be considered invalid even when it is empty. */
@property (nonatomic, getter = isRequired) BOOL required;

/** The color of the indeterminate indicator, default is 75% white. */
@property (nonatomic) UIColor *indeterminateColor;
/** The color of the invalid indicator, default is kind of red. */
@property (nonatomic) UIColor *invalidColor;
/** The color of the invalid indicator, default is kind of green. */
@property (nonatomic) UIColor *validColor;

/** @warning Validation methods (block, Regex, or delegate) and the built-in types are all mutally exclusive, that is, setting any one will clear out the others. */
/** Sets the validation mechanism to be a block.
 @param validationBlock the block to use to validate the text field.
 */
@property (nonatomic, copy) SSTextFieldValidationStatus (^validationBlock)(void);

/** Sets the validation mechanism to be an NSRegularExpression. One or more matches will indicate a valid condition.
 @param validationRegularExpression the regular expression to use.
 */
@property (nonatomic) NSRegularExpression *validationRegularExpression;

/** Sets the validation mechanism to be a SSTextFieldValidationValidationDelegate. */
@property (nonatomic, weak) id <SSTextFieldValidationValidationDelegate> validationDelegate;

+(BOOL)isTextFieldEmpty:(UITextField*)theTextField andAlertMessage:(NSString*)message;
//BOOL getThis :(^isTextFieldEmpty)(UITextField *r,NSString*er);



@end
