//
//  SignInViewController.h
//  Vouchify
//
//  Created by Kostya on 10.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "MitimBaseViewController.h"
#import "CustomTextField.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import "RegisterViewController.h"
//#import "ForgotPasswordViewController.h"

@interface SignInViewController : MitimBaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imvBack;
@property UILabel *lblAppName;

@property UITextField *txtEmailfield;
@property UITextField *txtPasswordfield;
@property UIButton *btnCancel;
@property UIButton *btnForgotPassword;
@property UIButton *btnEmailLogin;
@property UIButton *btnCreatAccount;
@property (weak, nonatomic) UITextField *activeField;

@end
