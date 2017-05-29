//
//  SignInViewController.m
//  Vouchify
//
//  Created by Kostya on 10.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "SignInViewController.h"
//#import "NetworkController.h"
#import "AppDelegate.h"
#import "UIButton+ButtonsTypes.h"
#import "RegisterViewController.h"
#import "GBDeviceInfo.h"
#import "AuthViewController.h"
#import "SetUpProfileViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];
        
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    UIImage *imgBack = [UIImage imageNamed:@"back_login"];
    [self.imvBack setImage:imgBack];
    [self.imvBack addSubview:overlay];
    
    NSDictionary *fontAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(24), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:APPNAME attributes:fontAttributes];
    
    float spacing = 6.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [APPNAME length])];
    self.lblAppName = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.2f, self.height / 2 - 44 - 40, self.width * 0.6f, 30)];
    [self.lblAppName setAttributedText:attributedString];
    [self.lblAppName setTextColor: [UIColor whiteColor]];
    [self.lblAppName setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.lblAppName];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake( self.width * 0.2f, self.height / 2 - 44, self.width * 0.6f , 1)];
    [line1 setBackgroundColor:UIColorFromRGB(0xAAAAAA)];
    [self.view addSubview:line1];
    
    
    NSString *string1 = @"track and share your favorite live music events";
    NSDictionary *fontAttributes1 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(14), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1 attributes:fontAttributes1];
    
    UILabel *lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.2f, self.height / 2 - 44 + 10, self.width * 0.6f, 40)];
    [lblDescription setAttributedText:attributedString1];
    [lblDescription setTextColor: [UIColor whiteColor]];
    [lblDescription setTextAlignment:NSTextAlignmentCenter];
    [lblDescription setNumberOfLines:2];
    [self.view addSubview:lblDescription];

    self.btnCreatAccount = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 50, self.width , 50)];
    [self.btnCreatAccount addTarget:self action:@selector(clickedCreateAccoutButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCreatAccount.titleLabel setFont:MuseosansFont(18)];
    [self.btnCreatAccount setTitle:@"Create an account" forState:UIControlStateNormal];
    [self.btnCreatAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCreatAccount setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.btnCreatAccount];
    
    self.btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.15f, self.height - 65, self.width * 0.25f, 15)];
    [self.btnCancel addTarget:self action:@selector(clickedCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    NSString *string4 = @"Cancel";
    NSDictionary *fontAttributes4 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(14), NSFontAttributeName, UIColorFromRGB(0x28bedd), NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:string4 attributes:fontAttributes4];
    [self.btnCancel setAttributedTitle:attributedString4 forState:UIControlStateNormal];
    [self.btnCancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.btnCancel setTitleColor:UIColorFromRGB(0x00FFFF) forState:UIControlStateNormal];
    [self.view addSubview:self.btnCancel];
    
    self.btnForgotPassword = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.4f, self.height - 65, self.width * 0.45f, 15)];
    [self.btnForgotPassword addTarget:self action:@selector(clickedForgotPasswordButton:) forControlEvents:UIControlEventTouchUpInside];
    NSString *string3= @"Forgot password?";
    NSDictionary *fontAttributes3 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(14), NSFontAttributeName, UIColorFromRGB(0x28bedd), NSForegroundColorAttributeName,nil];
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:string3 attributes:fontAttributes3];
    [self.btnForgotPassword setAttributedTitle:attributedString3 forState:UIControlStateNormal];
    [self.btnForgotPassword setTitleColor:UIColorFromRGB(0x00FFFF) forState:UIControlStateNormal];
    [self.btnForgotPassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.view addSubview:self.btnForgotPassword];
    
    
    self.btnEmailLogin = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height - 125, self.width * 0.8f, 60)];
    [self.btnEmailLogin.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.btnEmailLogin setImage:[UIImage imageNamed:@"btn_email"] forState:UIControlStateNormal];
    [self.btnEmailLogin addTarget:self action:@selector(clickedEmailButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnEmailLogin];
    
    self.txtEmailfield = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height - 250, self.width * 0.8f, 50)];
    self.txtEmailfield.font = MuseosansFont(16);
    self.txtEmailfield.placeholder = @"Email(Required)";
    [self.txtEmailfield setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"username" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}]];
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
    
    self.txtPasswordfield = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height - 185, self.width * 0.8f, 50)];
    self.txtPasswordfield.font = MuseosansFont(16);
    [self.txtPasswordfield setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}]];
    [self.txtPasswordfield setTextColor:[UIColor whiteColor]];
    [self.txtPasswordfield setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtPasswordfield.keyboardType = UIKeyboardTypeDefault;
    self.txtPasswordfield.secureTextEntry = YES;
    self.txtPasswordfield.returnKeyType = UIReturnKeyDone;
    self.txtPasswordfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtPasswordfield.leftViewMode = UITextFieldViewModeAlways;
    self.txtPasswordfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtPasswordfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtPasswordfield.delegate = self;
    self.txtPasswordfield.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtPasswordfield];
    
}
#pragma mark -
#pragma mark - TextField Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.txtEmailfield) {
        
        [self.txtPasswordfield becomeFirstResponder];
        
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
    float offsetY = 50;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect f = self.view.frame;
        f.origin.y -= offsetY;//(offsetY + deltaY);
        self.view.frame = f;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
    [self.activeField resignFirstResponder];
}





- (void) clickedCreateAccoutButton:(id)sender {
    RegisterViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:newViewController animated:true completion:nil];

}
- (void) clickedCancelButton:(id)sender {
    AuthViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthViewController"];
    [self presentViewController:newViewController animated:true completion:nil];
    

}
- (void) clickedForgotPasswordButton:(id)sender {
}
- (void) clickedFBButton:(id)sender {
}
- (void) clickedEmailButton:(id)sender {
    SetUpProfileViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavSetUpProfileViewController"];
    [self presentViewController:newViewController animated:true completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clickedBackBarButton:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
