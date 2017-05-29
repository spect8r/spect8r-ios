//
//  Register1ViewController.m
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "SetUpProfileViewController.h"
#import "SignInViewController.h"
#import "AppDelegate.h"
#import "UIButton+ButtonsTypes.h"
#import "PostFirstEventViewController.h"
@interface SetUpProfileViewController ()
{
    float prevOffsetY;

}
@end

@implementation SetUpProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preferredStatusBarStyle];
    int tspace = self.height * 0.1f * 0.2f;
    int txtY = self.height * 0.35f;
    int txth = self.height * 0.1f * 0.8f;
    prevOffsetY = 0;
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    [self.imvBack setBackgroundColor:UIColorFromRGB(0x111111)];
    [self.imvBack addSubview:overlay];
    
    NSDictionary *fontAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(24), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:APPNAME attributes:fontAttributes];
    
    float spacing = 6.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [APPNAME length])];
    self.lblAppName = [[UILabel alloc] initWithFrame:CGRectMake(self.width *0.2f, 0, self.width * 0.6f, 30)];
    [self.lblAppName setAttributedText:attributedString];
    [self.lblAppName setTextColor: [UIColor whiteColor]];
    [self.lblAppName setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.lblAppName;
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, self.width, 3)];
    [line1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blue_line"]]];
    [self.view addSubview:line1];
    
    NSString *string1 = @"First, let’s set up your profile";
    NSDictionary *fontAttributes1 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont500(18), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1 attributes:fontAttributes1];
    
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.1f, 30, self.width * 0.8f, 30)];
    [lbltitle setAttributedText:attributedString1];
    [lbltitle setTextColor: [UIColor whiteColor]];
    [lbltitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lbltitle];
    
    
    self.avtProfile = [[APAvatarImageView alloc] initWithFrame:CGRectMake(self.width / 2 - self.height * 0.1f, (txtY + 60) / 2 - self.height * 0.1f, self.height * 0.2f, self.height * 0.2f) borderColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0) borderWidth:2];
    [self.view addSubview:self.avtProfile];
    [self.avtProfile setImage:[UIImage imageNamed:@"avatar"]];
    
    NSString *string2 = @"choose a profile photo";
    NSDictionary *fontAttributes2 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(14), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:string2 attributes:fontAttributes2];
    UILabel *lblselect = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - self.height * 0.1f + 10, (txtY + 60) / 2 - self.height * 0.1f + 10, self.height * 0.2f - 20, self.height * 0.2f - 20)];
    [lblselect setAttributedText:attributedString2];
    [lblselect setTextColor: UIColorFromRGB(0x28bedd)];
    [lblselect setNumberOfLines:2];
    [lblselect setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblselect];

    
    self.btnAccountType = [[JTImageButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY, self.width * 0.8f, txth)];
    [self.btnAccountType createTitle:@"Select your account type" withIcon:[UIImage imageNamed:@"icon_dropdown"] font:MuseosansFont(16) iconHeight:16 iconOffsetY:0];
    [self.btnAccountType.titleLabel setFont:MuseosansFont(16)];
    self.btnAccountType.titleColor = UIColorFromRGB(0xAAAAAA);
    self.btnAccountType.bgColor = UIColorFromRGBAndAlpha(0xFFFFFF, 0.2);
    self.btnAccountType.iconSide = JTImageButtonIconSideRight;
    self.btnAccountType.padding = JTImageButtonPaddingBig;
    self.btnAccountType.borderWidth = 1;
    self.btnAccountType.cornerRadius = 0;
    [self.btnAccountType.imageView setContentMode:UIViewContentModeRight];
    self.btnAccountType.layer.borderColor = [UIColorFromRGB(0xAAAAAA) CGColor];
    self.btnAccountType.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.btnAccountType addTarget:self action:@selector(clickedDropdownButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnAccountType];
    
    self.txtName = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + txth + tspace, self.width * 0.8f, txth)];
    self.txtName.font = MuseosansFont(16);
    [self.txtName setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"name" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    self.txtName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtName.leftViewMode = UITextFieldViewModeAlways;
    [self.txtName setTextColor:[UIColor whiteColor]];
    [self.txtName setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtName.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtName.keyboardType = UIKeyboardTypeDefault;
    self.txtName.returnKeyType = UIReturnKeyNext;
    self.txtName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtName.delegate = self;
    self.txtName.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtName];
    
    self.txtLocation = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + 2 * txth + 2 * tspace, self.width * 0.8f, txth)];
    self.txtLocation.font = MuseosansFont(16);
    [self.txtLocation setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"location" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    [self.txtLocation setTextColor:[UIColor whiteColor]];
    [self.txtLocation setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtLocation.keyboardType = UIKeyboardTypeDefault;
    self.txtLocation.returnKeyType = UIReturnKeyNext;
    self.txtLocation.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtLocation.leftViewMode = UITextFieldViewModeAlways;
    self.txtLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtLocation.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtLocation.delegate = self;
    self.txtLocation.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtLocation];
    
    self.txtPerssionalUrl = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + txth * 3 + 3 * tspace, self.width * 0.8f, txth)];
    self.txtPerssionalUrl.font = MuseosansFont(16);
    [self.txtPerssionalUrl setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"persional url" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    self.txtPerssionalUrl.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtPerssionalUrl.leftViewMode = UITextFieldViewModeAlways;
    [self.txtPerssionalUrl setTextColor:[UIColor whiteColor]];
    [self.txtPerssionalUrl setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtPerssionalUrl.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtPerssionalUrl.keyboardType = UIKeyboardTypeDefault;
    self.txtPerssionalUrl.returnKeyType = UIReturnKeyDone;
    self.txtPerssionalUrl.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtPerssionalUrl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtPerssionalUrl.delegate = self;
    self.txtPerssionalUrl.borderStyle=UITextBorderStyleBezel;
    [self.view addSubview:self.txtPerssionalUrl];
    
    
    self.btnNext = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, (txtY + txth * 4 + 4 * tspace+ self.height - self.navheight - self.navheight - self.statheight) / 2 - txth / 2, self.width * 0.8f, txth)];
    [self.btnNext.titleLabel setFont:MuseosansFont500(18)];
    [self.btnNext setTitle:@"Next" forState:UIControlStateNormal];
    [self.btnNext setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.btnNext setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self.btnNext addTarget:self action:@selector(clickedNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNext];
    
    self.btnSkip = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - self.navheight - self.navheight - self.statheight, self.width , self.navheight)];
    [self.btnSkip addTarget:self action:@selector(clickedSkipButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSkip.titleLabel setFont:MuseosansFont500(18)];
    [self.btnSkip setTitle:@"Skip this setup" forState:UIControlStateNormal];
    [self.btnSkip setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [self.btnSkip setBackgroundColor:UIColorFromRGB(0x000000)];
    [self.view addSubview:self.btnSkip];

    
}

#pragma mark -
#pragma mark - TextField Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {

    if(textField == self.txtName) {
        
        [self.txtLocation becomeFirstResponder];
        
    }
    else if(textField == self.txtLocation) {
        
        [self.txtPerssionalUrl becomeFirstResponder];
        
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
    
    if (self.activeField == self.txtName)
        offsetY = 20;
    else if (self.activeField == self.txtLocation)
        offsetY = 40;
    else if (self.activeField == self.txtPerssionalUrl)
        offsetY = 60;
    
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


- (void) clickedNextButton:(id)sender {
    PostFirstEventViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PostFirstEventViewController"];
    [self.navigationController pushViewController:newViewController animated:true];

}

- (void) clickedDropdownButton:(id)sender {
    
    if (self.btnAccountType.selected == false) {
        self.btnAccountType.selected = true;
    } else {
        self.btnAccountType.selected = false;
    }
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(self.dropDown == nil) {
        CGFloat f = 200;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];

    }
    
}
- (void) clickedSkipButton:(id)sender {
    PostFirstEventViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PostFirstEventViewController"];
    [self.navigationController pushViewController:newViewController animated:true];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}
-(void)rel{
    //    [dropDown release];
    self.dropDown = nil;
}

@end
