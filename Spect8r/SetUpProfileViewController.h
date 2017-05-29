//
//  Register1ViewController.h
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimBaseViewController.h"
#import "CustomTextField.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SSCheckBoxView.h"
#import "APAvatarImageView.h"
#import "NIDropDown.h"
#import "JTImageButton.h"

@interface SetUpProfileViewController : MitimBaseViewController <UITextViewDelegate, NIDropDownDelegate>

@property NSMutableDictionary *registrationData;
@property BOOL isFacebook;

@property (weak, nonatomic) IBOutlet UIImageView *imvBack;
@property UILabel *lblAppName;
@property NIDropDown *dropDown;
@property UITextField *txtAccountType;
@property UITextField *txtName;
@property UITextField *txtLocation;
@property UITextField *txtPerssionalUrl;
@property JTImageButton *btnAccountType;
@property APAvatarImageView *avtProfile;
@property UIButton *btnNext;
@property UIButton *btnSkip;
@property (weak, nonatomic) UITextField *activeField;

@end

