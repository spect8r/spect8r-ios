//
//  Register1ViewController.m
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "EditEventDetailViewController.h"
#import "SignInViewController.h"
#import "AppDelegate.h"
#import "UIButton+ButtonsTypes.h"
#import "NMBottomTabBarController.h"
@interface EditEventDetailViewController ()
{
    float prevOffsetY;

}
@end

@implementation EditEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int tspace = self.height * 0.1f * 0.2f;
    int txtY = self.height * 0.4f;
    int txth = self.height * 0.1f * 0.8f;
    prevOffsetY = 0;
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    [self.imvBack setBackgroundColor:UIColorFromRGB(0x111111)];
    [self.imvBack addSubview:overlay];
    
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, [self getViewHeight] - 50)];
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 0.1);
    [self.view addSubview:self.scrollView];
    
    self.imvTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, self.width, self.height * 0.26f)];
    
    [self.imvTitle setImage:[UIImage imageNamed:@"titleback"]];
    [self.imvTitle setContentMode:UIViewContentModeScaleAspectFill];
    [self.scrollView addSubview:self.imvTitle];
    
    NSString *string = @"spect8r";
    NSDictionary *fontAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(24), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:fontAttributes];
    
    float spacing = 6.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [string length])];
    self.lblAppName = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.2f, 12, self.width * 0.6f, 30)];
    [self.lblAppName setAttributedText:attributedString];
    [self.lblAppName setTextColor: [UIColor whiteColor]];
    [self.lblAppName setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.lblAppName;
   
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, self.width, 3)];
    [line1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blue_line"]]];
    [self.view addSubview:line1];
    
    self.imvlogo = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 - self.width * 0.14f, self.height * 0.3f, self.width * 0.28f, self.width * 0.15f)];
    [self.scrollView addSubview:self.imvlogo];
    [self.imvlogo setImage:[UIImage imageNamed:@"icon_logo"]];
    [self.imvlogo setContentMode:UIViewContentModeScaleAspectFit];
   
    
    NSString *string1 = @"Edit event details";
    NSDictionary *fontAttributes1 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont500(18), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1 attributes:fontAttributes1];
    
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height * 0.1f - 40, self.width * 0.8f, 30)];
    [lbltitle setAttributedText:attributedString1];
    [lbltitle setTextColor: [UIColor whiteColor]];
    [lbltitle setTextAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:lbltitle];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height * 0.1f, self.width * 0.8f, 2)];
    [line2 setBackgroundColor:UIColorFromRGB(0xAAAAAA)];
    [self.scrollView addSubview:line2];
    
    NSString *string2 = @"Change or add details about your event. More details helps friends and fellow fans find your event.";
    NSDictionary *fontAttributes2 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(12), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:string2 attributes:fontAttributes2];
    
    UILabel *lbltitle2 = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height * 0.1f + 10, self.width * 0.8f, 50)];
    [lbltitle2 setAttributedText:attributedString2];
    [lbltitle2 setTextColor: [UIColor whiteColor]];
    [lbltitle2 setNumberOfLines:2];
    [lbltitle2 setTextAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:lbltitle2];
    
    
    
    self.btnEventDate = [[JTImageButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY, self.width * 0.8f, txth)];
    [self.btnEventDate createTitle:@"event date" withIcon:[UIImage imageNamed:@"icon_calendar"] font:MuseosansFont(16) iconHeight:24 iconOffsetY:-8];
    self.btnEventDate.titleColor = UIColorFromRGB(0xAAAAAA);
    self.btnEventDate.bgColor = UIColorFromRGBAndAlpha(0xFFFFFF, 0.2);
    self.btnEventDate.iconSide = JTImageButtonIconSideRight;
    self.btnEventDate.padding = JTImageButtonPaddingBig;
    self.btnEventDate.borderWidth = 1;
    self.btnEventDate.cornerRadius = 0;
    [self.btnEventDate.imageView setContentMode:UIViewContentModeRight];
    self.btnEventDate.layer.borderColor = [UIColorFromRGB(0xAAAAAA) CGColor];
    self.btnEventDate.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.btnEventDate addTarget:self action:@selector(clickedDropdownButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.btnEventDate];
    
    
    self.txtVenueName = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + txth + tspace, self.width * 0.8f, txth)];
    self.txtVenueName.font = MuseosansFont(16);
    [self.txtVenueName setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"venue name" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    self.txtVenueName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtVenueName.leftViewMode = UITextFieldViewModeAlways;
    [self.txtVenueName setTextColor:[UIColor whiteColor]];
    [self.txtVenueName setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtVenueName.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtVenueName.keyboardType = UIKeyboardTypeDefault;
    self.txtVenueName.returnKeyType = UIReturnKeyNext;
    self.txtVenueName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtVenueName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtVenueName.delegate = self;
    self.txtVenueName.borderStyle=UITextBorderStyleBezel;
    [self.scrollView addSubview:self.txtVenueName];
    
    self.txtHeadliner = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + 2 * txth + 2 * tspace, self.width * 0.8f, txth)];
    self.txtHeadliner.font = MuseosansFont(16);
    [self.txtHeadliner setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"headliner" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    [self.txtHeadliner setTextColor:[UIColor whiteColor]];
    [self.txtHeadliner setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtHeadliner.keyboardType = UIKeyboardTypeDefault;
    self.txtHeadliner.returnKeyType = UIReturnKeyNext;
    self.txtHeadliner.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtHeadliner.leftViewMode = UITextFieldViewModeAlways;
    self.txtHeadliner.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtHeadliner.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtHeadliner.delegate = self;
    self.txtHeadliner.borderStyle=UITextBorderStyleBezel;
    [self.scrollView addSubview:self.txtHeadliner];
    
    self.txtSupportingArtist = [[UITextField alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + txth * 3 + 3 * tspace, self.width * 0.8f, txth)];
    self.txtSupportingArtist.font = MuseosansFont(16);
    [self.txtSupportingArtist setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"supporting artist" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xAAAAAA)}]];
    self.txtSupportingArtist.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
    self.txtSupportingArtist.leftViewMode = UITextFieldViewModeAlways;
    [self.txtSupportingArtist setTextColor:[UIColor whiteColor]];
    [self.txtSupportingArtist setBackgroundColor:UIColorFromRGBAndAlpha(0xFFFFFF, 0.2)];
    self.txtSupportingArtist.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtSupportingArtist.keyboardType = UIKeyboardTypeDefault;
    self.txtSupportingArtist.returnKeyType = UIReturnKeyDone;
    self.txtSupportingArtist.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtSupportingArtist.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtSupportingArtist.delegate = self;
    self.txtSupportingArtist.borderStyle=UITextBorderStyleBezel;
    [self.scrollView addSubview:self.txtSupportingArtist];
    
    self.btnAddAnother = [[JTImageButton alloc] initWithFrame:CGRectMake(self.width * 0.5f, txtY + txth * 4 + 4 * tspace, self.width * 0.4f, 20)];
    [self.btnAddAnother createTitle:@"add another" withIcon:[UIImage imageNamed:@"icon_circleplus"] font:MuseosansFont500(16) iconHeight:16 iconOffsetY:0];
    self.btnAddAnother.titleColor = UIColorFromRGB(0x28bedd);
    self.btnAddAnother.borderWidth = 0;
    self.btnAddAnother.iconSide = JTImageButtonIconSideLeft;
    self.btnAddAnother.padding = JTImageButtonPaddingBig;
    [self.btnAddAnother setContentMode:UIViewContentModeRight];
    [self.btnAddAnother addTarget:self action:@selector(clickedAddAnotherButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.btnAddAnother];

    self.btnPost = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, txtY + txth * 5 + 5 * tspace, self.width * 0.8f, txth)];
    [self.btnPost.titleLabel setFont:MuseosansFont500(18)];
    [self.btnPost setTitle:@"Next" forState:UIControlStateNormal];
    [self.btnPost setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.btnPost setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self.btnPost addTarget:self action:@selector(clickedNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.btnPost];
    
    self.btnSkip = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - self.navheight - self.navheight - self.statheight, self.width , self.navheight)];
    [self.btnSkip addTarget:self action:@selector(clickedSkipButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSkip.titleLabel setFont:MuseosansFont500(18)];
    [self.btnSkip setTitle:@"Skip this setup" forState:UIControlStateNormal];
    [self.btnSkip setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [self.btnSkip setBackgroundColor:UIColorFromRGB(0x000000)];
    [self.view addSubview:self.btnSkip];
    [self resizeScrollView];
}
- (void) clickedNextButton:(id)sender {
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    [self presentViewController:newViewController animated:true completion:nil];
}


- (void) clickedSkipButton:(id)sender {
    NMBottomTabBarController *tabBarController = (NMBottomTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    [self presentViewController:tabBarController animated:true completion:nil];

}
- (void) clickedAddAnotherButton:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)resizeScrollView {
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;

}
#pragma mark -
#pragma mark - TextField Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.txtVenueName) {
        
        [self.txtHeadliner becomeFirstResponder];
        
    }
    else if(textField == self.txtHeadliner) {
        
        [self.txtSupportingArtist becomeFirstResponder];
        
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
    
    if (self.activeField == self.txtVenueName)
        offsetY = 20;
    else if (self.activeField == self.txtHeadliner)
        offsetY = 40;
    else if (self.activeField == self.txtSupportingArtist)
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

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}
-(void)rel{
    //    [dropDown release];
    self.dropDown = nil;
}


- (void) clickedDropdownButton:(id)sender {
    
    if (self.btnEventDate.selected == false) {
        self.btnEventDate.selected = true;
    } else {
        self.btnEventDate.selected = false;
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

@end
