//
//  ViewController.m
//  Vouchify
//
//  Created by Kostya on 03.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "RegisterViewController.h"
#import "SignInViewController.h"
#import "AppDelegate.h"
#import "UIButton+ButtonsTypes.h"
#import "String.h"
#import "SetUpProfileViewController.h"
#import "AFNetworking.h"
#import "DatabaseController.h"
@interface RegisterViewController ()

@property (nonatomic, strong) UIBarButtonItem* cancelButtonItem;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];
    
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    UIImage *imgBack = [UIImage imageNamed:@"back_login"];
    [self.imvBack setImage:imgBack];
    [self.imvBack addSubview:overlay];
    
    NSString *string = @"spect8r";
    NSDictionary *fontAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(32), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:fontAttributes];
    
    float spacing = 6.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [string length])];
    self.lblAppName = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.2f, 40, self.width * 0.6f, 30)];
    [self.lblAppName setAttributedText:attributedString];
    [self.lblAppName setTextColor: [UIColor whiteColor]];
    [self.lblAppName setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.lblAppName];
    
    self.btnFBLogin = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, 100, self.width * 0.8f, 60)];
    [self.btnFBLogin.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.btnFBLogin setImage:[UIImage imageNamed:@"btn_facebook"]  forState:UIControlStateNormal];
    [self.btnFBLogin addTarget:self action:@selector(clickedFBButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnFBLogin];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake( 0, 170, self.width / 2 - 20, 1)];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake( self.width / 2 + 20, 170, self.width / 2 - 20, 1)];
    [line1 setBackgroundColor:UIColorFromRGB(0xAAAAAA)];
    [line2 setBackgroundColor:UIColorFromRGB(0xAAAAAA)];
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    
    UILabel *or = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - 20, 160, 40, 20)];
    [or setText:@"or"];
    [or setFont:MuseosansFont(14)];
    [or setTextColor: UIColorFromRGB(0xAAAAAA)];
    [or setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:or];
    
    
    self.btnCreatAccount = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 50, self.width , 50)];
    [self.btnCreatAccount addTarget:self action:@selector(clickedSignInButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCreatAccount.titleLabel setFont:MuseosansFont(18)];
    [self.btnCreatAccount setTitle:@"Already have an account? Sign in" forState:UIControlStateNormal];
    [self.btnCreatAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCreatAccount setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.btnCreatAccount];
    
   
    self.btnEmailLogin = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height - 120, self.width * 0.8f, 50)];
    [self.btnEmailLogin.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.btnEmailLogin setImage:[UIImage imageNamed:@"btn_createaccount"]  forState:UIControlStateNormal];
//    [self.btnEmailLogin setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self.btnEmailLogin addTarget:self action:@selector(clickedEmailButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnEmailLogin];
    
    int tspace = (int)(self.height - 160 - 25 - 100 - 30 - 200) / 4;
    int txtY = 195;
    
    self.txtUsernamefield = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY, self.width * 0.8f, 45)];
    self.txtUsernamefield.font = MuseosansFont(16);
    [self.txtUsernamefield setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"username" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    self.txtUsernamefield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtUsernamefield.leftViewMode = UITextFieldViewModeAlways;
    [self.txtUsernamefield setTextColor:[UIColor whiteColor]];
    [self.txtUsernamefield setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtUsernamefield.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtUsernamefield.keyboardType = UIKeyboardTypeDefault;
    self.txtUsernamefield.returnKeyType = UIReturnKeyNext;
    self.txtUsernamefield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtUsernamefield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtUsernamefield.delegate = self;
    self.txtUsernamefield.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtUsernamefield];
    
    self.txtEmailfield = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + 45 + tspace, self.width * 0.8f, 45)];
    self.txtEmailfield.font = MuseosansFont(16);
    [self.txtEmailfield setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"email" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    self.txtEmailfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtEmailfield.leftViewMode = UITextFieldViewModeAlways;
    [self.txtEmailfield setTextColor:[UIColor whiteColor]];
    [self.txtEmailfield setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtEmailfield.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtEmailfield.keyboardType = UIKeyboardTypeDefault;
    self.txtEmailfield.returnKeyType = UIReturnKeyNext;
    self.txtEmailfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtEmailfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtEmailfield.delegate = self;
    self.txtEmailfield.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtEmailfield];
    
    self.txtPasswordfield = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + 90 + 2 * tspace, self.width * 0.8f, 45)];
    self.txtPasswordfield.font = MuseosansFont(16);
    [self.txtPasswordfield setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    [self.txtPasswordfield setTextColor:[UIColor whiteColor]];
    [self.txtPasswordfield setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtPasswordfield.keyboardType = UIKeyboardTypeDefault;
    self.txtPasswordfield.secureTextEntry = YES;
    self.txtPasswordfield.returnKeyType = UIReturnKeyNext;
    self.txtPasswordfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtPasswordfield.leftViewMode = UITextFieldViewModeAlways;
    self.txtPasswordfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtPasswordfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtPasswordfield.delegate = self;
    self.txtPasswordfield.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtPasswordfield];
    
    self.txtConfirmPasswordfield = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + 135 + 3 * tspace, self.width * 0.8f, 45)];
    self.txtConfirmPasswordfield.font = MuseosansFont(16);
    [self.txtConfirmPasswordfield setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"confirm password" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    self.txtConfirmPasswordfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtConfirmPasswordfield.leftViewMode = UITextFieldViewModeAlways;
    [self.txtConfirmPasswordfield setTextColor:[UIColor whiteColor]];
    [self.txtConfirmPasswordfield setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtConfirmPasswordfield.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtConfirmPasswordfield.keyboardType = UIKeyboardTypeDefault;
    self.txtConfirmPasswordfield.returnKeyType = UIReturnKeyDone;
    self.txtConfirmPasswordfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtConfirmPasswordfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtConfirmPasswordfield.secureTextEntry = YES;
    self.txtConfirmPasswordfield.delegate = self;
    self.txtConfirmPasswordfield.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtConfirmPasswordfield];
    
    self.checkbox = [[UIButton alloc] initWithFrame:CGRectMake(self.width / 2 - 110, txtY + 190 + 3 * tspace, 18, 18)];
    [self.checkbox setImage:[UIImage imageNamed:@"checkboxon"] forState:UIControlStateSelected];
    [self.checkbox setImage:[UIImage imageNamed:@"checkboxoff"] forState:UIControlStateNormal];
    [self.checkbox addTarget:self action:@selector(clickedCheckBox:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkbox];
    
    UILabel *lblcheckbox = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - 80, txtY + 190 + 3 * tspace, 200, 18)];
    [lblcheckbox setFont:MuseosansFont(14)];
    [lblcheckbox setText:@"Agree to Terms & Conditions"];
    [lblcheckbox setTextColor:UIColorFromRGB(0xFFFFFF)];
    [self.view addSubview:lblcheckbox];


}
#pragma mark -
#pragma mark - TextField Delegate
float prevOffsetY = 0;

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.txtUsernamefield) {
        
        [self.txtEmailfield becomeFirstResponder];
        
    }
    else if(textField == self.txtEmailfield) {
        
        [self.txtPasswordfield becomeFirstResponder];
        
    }
    else if(textField == self.txtPasswordfield) {
        
        [self.txtConfirmPasswordfield becomeFirstResponder];
        
    }
    
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
    self.activeField.delegate = self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self registNotification];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self unregistNotification];
}
-(void) registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void) unregistNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShown:(NSNotification*)notification
{
    float offsetY = 0;
    
    if (self.activeField == self.txtUsernamefield)
        offsetY = 20;
    else if (self.activeField == self.txtEmailfield)
        offsetY = 40;
    else if (self.activeField == self.txtPasswordfield)
        offsetY = 60;
    else if (self.activeField == self.txtConfirmPasswordfield)
        offsetY =80;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect f = self.view.frame;
        f.origin.y -= offsetY - prevOffsetY;//(offsetY + deltaY);
        prevOffsetY = offsetY;
        self.view.frame = f;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
        prevOffsetY = 0;

    }];
}


- (void) clickedSignInButton:(id)sender {

    SignInViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self presentViewController:newViewController animated:true completion:nil];
    
}
- (void) clickedFBButton:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate loginToFacebookFromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
            dispatch_async(dispatch_get_main_queue(), ^{
                [MitimGlobalData hideLoadingPopup];
                [self showError:NSLocalizedString(@"ERROR_FACEBOOK_LOGIN", nil)];
            });
        } else if (result.isCancelled) {
            NSLog(@"isCancelled");
            dispatch_async(dispatch_get_main_queue(), ^{
                [MitimGlobalData hideLoadingPopup];
            });
        } else {
            NSLog(@"Logged in with FB.");
            [self getMyFacebookInfo];
        }
    }];

}

- (void) getMyFacebookInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MitimGlobalData showLoadingPopup];
    });
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,first_name,last_name,email,gender"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
//            NSMutableArray *params = [[NSMutableArray alloc] init];
//            [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"fb_user_token", @"key", [[MitimUser getUser] getFacebookAccessToken], @"data", nil]];
//            [self checkForDuplicateFacebookUserWithParams:params result:result];
            NSString *firstName = [result valueForKey:@"first_name"];
            NSString *lastName = [result valueForKey:@"last_name"];
            NSString *email = [result valueForKey:@"email"];
            NSString *gender = [result valueForKey:@"gender"];
            NSString *FB_id = [result valueForKey:@"id"];
            
            MitimUser *user = [MitimUser getUser];
            user.user_first_name = firstName;
            user.user_last_name = lastName;
            [user save];
            
            NSMutableDictionary *registrationData = [[NSMutableDictionary alloc] init];
            registrationData[@"fb_user_token"] = [[MitimUser getUser] getFacebookAccessToken];
            if (firstName) registrationData[@"user_first_name"] = firstName;
            if (lastName) registrationData[@"user_last_name"] = lastName;
            if (email) registrationData[@"user_email"] = email;
            if (FB_id) registrationData[@"user_facebook_id"] = FB_id;
            if (gender) {
//                registrationData[@"gender"] = [gender isEqualToString:@"female"] ? @"F" : @"M";
            }
            NSLog(@"registrationData = %@", registrationData);
            
            [self Register:registrationData];

        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MitimGlobalData hideLoadingPopup];
                [self showError:NSLocalizedString(@"ERROR_FACEBOOK_LOGIN", nil)];
            });
        }
    }];
}

- (void) registerWithFacebook:(NSMutableDictionary*)registrationData {
    MitimUser *user = [MitimUser getUser];
    user.isLoggedInWithFB = true;
    [user save];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MitimGlobalData hideLoadingPopup];
        SetUpProfileViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SetUpProfileViewController"];
        newViewController.registrationData = registrationData;
        newViewController.isFacebook = true;
        [self.navigationController pushViewController:newViewController animated:true];
    });
}
- (void) clickedEmailButton:(id)sender {
    if (![self checkValid]){
        return;
    }
    if ([FBSDKAccessToken currentAccessToken] != NULL) {
        [[FBSDKLoginManager new] logOut];
    }
    
    NSMutableDictionary *registrationData = [[NSMutableDictionary alloc] init];
    registrationData[@"user_name"] = self.txtUsernamefield.text;
    registrationData[@"user_email"] = self.txtEmailfield.text;
    registrationData[@"user_password"] = self.txtPasswordfield.text;


    [self Register:registrationData];
//    
//    SignInViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
//    [self presentViewController:newViewController animated:true completion:nil];

}

-(void)Register:(id)params {
    [MitimGlobalData showLoadingPopup];
//    NetworkController *networkController = [NetworkController sharedController];
//    [networkController sendSignUpRequest:params[@"user_email"] password:params[@"user_password"] firstName:params[@"user_first_name"] lastName:params[@"user_last_name"] address:params[@"user_location_address"] fbUserId:params[@"user_facebook_id"] fbUserToken:params[@"fb_user_token"] completionHandler:^(NSDictionary *data) {
//        NSString *errorMessage = data[@"error_message"];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MitimGlobalData hideLoadingPopup];
//        });
//        if ([data[@"stat"] isEqualToString:@"fail"]){
//            NSLog(@"errorMessage = %@", errorMessage);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.view endEditing:true];
//                [self showError:errorMessage];
//            });
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
////                NSMutableDictionary *registrationData = [[NSMutableDictionary alloc] init];
////                registrationData[@"email"] = self.emailTextField.text;
////                registrationData[@"password"] = self.passwordTextField.text;
////                
////                RegisterViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Register1ViewController"];
////                newViewController.registrationData = registrationData;
////                newViewController.isFacebook = false;
////                [self.navigationController pushViewController:newViewController animated:true];
//            });
//        }
//    }];
    
//    NSMutableDictionary *signupArray = [[NSMutableDictionary alloc] init];;
//    [signupArray setObject:[NSString stringWithFormat:@"%d", appController.userType] forKey:@"user_type"];
//    [signupArray setObject:self.txtUserName.text forKey:@"user_name"];
//    [signupArray setObject:[self.txtEmail.text lowercaseString] forKey:@"user_email"];
//    [signupArray setObject:[commonUtils md5:self.txtPassword.text] forKey:@"user_password"];
//    [signupArray setObject:self.txtBirthday.text forKey:@"user_birthday"];
//    [signupArray setObject:[NSNumber numberWithDouble:appController.user_current_latitude] forKey:@"user_latitude"];
//    [signupArray setObject:[NSNumber numberWithDouble:appController.user_current_longitude] forKey:@"user_longitude"];
//    [signupArray setObject:self.txtLocation.text forKey:@"user_location"];
//    
//    [JSWaiter ShowWaiter:self.view title:@"Sign Up..." type:0];
//    self.isLoadingBase = YES;
    
    [[DatabaseController sharedManager] userSignUp:params onSuccess:^(id response){
        
        [MitimGlobalData hideLoadingPopup];
        
        
        int status = [[response objectForKey:@"status"] intValue];
        
        if (status == 200) {
            
//            if (appController.userType == 0) {
//                
//                [self gotoMainPage];
//            } else {
//                UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp2ViewController"];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//            
        } else {
            NSString *msg = [response objectForKey:@"msg"];
            [commonUtils showAlert:@"Warning" withMessage:msg];
            
        }
        
    }onFailure:^(id error){
        
        [MitimGlobalData showLoadingPopup];
//        self.isLoadingBase = NO;
        
        [commonUtils showVAlertSimple:@"Warning" body:@"Please try again later!" duration:1.5];
    }];
    

}

- (void) clickedCheckBox:(id)sender {
    if (self.checkbox.selected == false) {
        self.checkbox.selected = true;
    } else {
        self.checkbox.selected = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) checkValid {
    
    if (_txtUsernamefield.text.length == 0) {
        
        [self showAlertDialog:@"" message:INPUT_USERNAME positive:OK negative:nil sender:self];
        return NO;
    }
    
    if (self.txtEmailfield.text.length == 0) {
        
        [self  showAlertDialog:@"" message:INPUT_EMAIL positive:OK negative:nil sender:self];
        return NO;
    }
    
    if (self.txtPasswordfield.text.length == 0) {
        
        [self showAlertDialog:@"" message:INPUT_PWD positive:OK negative:nil sender:self];
        return NO;
    }
    
    if (self.txtConfirmPasswordfield.text.length == 0) {
        
        [self showAlertDialog:@"" message:INPUT_CONFIRM_PWD positive:OK negative:nil sender:self];
        return NO;
    }
    if (self.txtPasswordfield.text != self.txtConfirmPasswordfield.text){
        
        [self showAlertDialog:@"" message:INPUT_PWD_AGAIN positive:OK negative:nil sender:self];
        return NO;
    }
    
    if (!self.checkbox.selected) {
        
        [self showAlertDialog:@"" message:AGREE_TERMS positive:OK negative:nil sender:self];
        return NO;
    }
    return YES;
}


@end
