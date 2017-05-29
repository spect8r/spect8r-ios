//
//  ViewController.h
//  Vouchify
//
//  Created by Kostya on 03.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimBaseViewController.h"
#import "CustomTextField.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SSCheckBoxView.h"
@interface RegisterViewController : MitimBaseViewController <UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imvBack;
@property UILabel *lblAppName;

@property UITextField *txtUsernamefield;
@property UITextField *txtEmailfield;
@property UITextField *txtPasswordfield;
@property UITextField *txtConfirmPasswordfield;

@property UIButton *checkbox;
@property UIButton *btnFBLogin;
@property UIButton *btnEmailLogin;
@property UIButton *btnCreatAccount;
@property (weak, nonatomic) UITextField *activeField;

- (void) clickedEmailButton:(id)sender;
- (void) clickedFBButton:(id)sender;
- (void) clickedSignInButton:(id)sender;

@end

