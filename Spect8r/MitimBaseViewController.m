//
//  MitimBaseViewController.m
//  100
//
//  Created by Mykhailo Timashov on 5/20/15.
//  Copyright (c) 2015 Mitim Games. All rights reserved.
//

#import "MitimBaseViewController.h"
#import "PopupView.h"
#import "Constant.h"
#import "String.h"
@interface MitimBaseViewController () <PopupViewDelegate>

@property (nonatomic, weak) PopupView *popupView;

@end

@implementation MitimBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.sideBarCurrentW = self.revealViewController.currentW;
    
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    
    CGFloat backgroundImageW = self.width * 580 / 1125;
    CGFloat backgroundImageH = backgroundImageW;
    CGFloat backgroundImageX = 0;
    CGFloat backgroundImageY = [self getViewHeight] - backgroundImageH;
    
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundImageX, backgroundImageY, backgroundImageW, backgroundImageH)];
    [self.backgroundImageView setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:self.backgroundImageView];
    
    self.navheight=self.navigationController.navigationBar.frame.size.height;
    self.statheight=[UIApplication sharedApplication].statusBarFrame.size.height;
    self.contentView = [[CustomScrollView alloc] initWithFrame:self.view.bounds];
    self.contentView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 0.1);
    [self.view addSubview:self.contentView];

    [self initBackButton];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *oldTitle = self.title;
    NSString *newTitle = nil;
    if (oldTitle == nil) oldTitle = self.navigationItem.title;
    newTitle = [oldTitle uppercaseString];
    if (self.title == nil) {
        self.navigationItem.title = newTitle;
    } else {
        self.title = newTitle;
    }
}

- (void) addMenuButton{
//    if (self.revealViewController){
//        self.isSideBarOpened = false;
//        
//        self.sidebarButton = [[UIBarButtonItem alloc]
//                                          initWithImage:[UIImage imageNamed:@"sideBarButton"]
//                                          style:UIBarButtonItemStylePlain
//                                          target:self
//                                          action:@selector(clickedMenuButton:)];
//        self.navigationItem.leftBarButtonItem = self.sidebarButton;
//        
//        self.sideBarCloseButton = [[UIButton alloc] initWithFrame:self.view.bounds];
//        [self.sideBarCloseButton setHidden:true];
//        [self.sideBarCloseButton addTarget:self action:@selector(clickedMenuButton:) forControlEvents:UIControlEventTouchDown];
//        
//        if (self.tabBarController){
//            [self.tabBarController.view addSubview:self.sideBarCloseButton];
//        }
//        else{
//            [self.view addSubview:self.sideBarCloseButton];
//        }
//    }
}

- (IBAction)clickedMenuButton:(id)sender{
    [self.view endEditing:true];
    self.isSideBarOpened = !self.isSideBarOpened;
//    [self.revealViewController revealToggle:sender];
    
    if (self.isSideBarOpened){
        [self.sideBarCloseButton.superview bringSubviewToFront:self.sideBarCloseButton];
        self.sideBarCloseButton.hidden = false;
    }
    else{
        self.sideBarCloseButton.hidden = true;
    }
}
//


- (CGFloat) getZeroY {
//    CGFloat result = [UIApplication sharedApplication].statusBarFrame.size.height;
//    if (self.navigationController && self.navigationController.navigationBar.hidden == false){
//        result += self.navigationController.navigationBar.frame.size.height;
//    }
    return 0;
}

- (CGFloat) getStatusBarHeight {
    CGFloat result = [UIApplication sharedApplication].statusBarFrame.size.height;
    return result;
}

- (CGFloat) getViewHeight {
    CGFloat result = self.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    
    if (self.navigationController && self.navigationController.navigationBar.hidden==false){
        result -= self.navigationController.navigationBar.frame.size.height;
    }
    if (self.tabBarController && self.tabBarController.tabBar.hidden==false){
        result -= self.tabBarController.tabBar.frame.size.height;
    }
    return result;
}

- (void) showError:(NSString*)errorMessage {
    if (self.errorView) {
        [self.errorView removeFromSuperview];
    }
    CGFloat ERROR_VIEW_HEIGHT = self.width * 0.2;
    CGRect errorFrame = CGRectMake(0, [self getViewHeight] - ERROR_VIEW_HEIGHT, self.width, ERROR_VIEW_HEIGHT);
    
    self.errorView = [[ErrorView alloc] initWithFrame:errorFrame errorMessage:errorMessage];
    self.errorView.alpha = 0;
    self.errorView.userInteractionEnabled = false;
    [self.view addSubview:self.errorView];
    [UIView animateWithDuration:0.5 animations:^{
        self.errorView.alpha = 1;
    }];
}

- (BOOL) errorViewExist {
    if (self.errorView && self.errorView.superview) return true;
    return false;
}

- (void) hideLogo{
    self.backgroundImageView.hidden = true;
}

- (void) initBackButton {
    if (self.navigationController && self.navigationController.viewControllers.count>1 && self.navigationItem.leftBarButtonItem==NULL){
        self.navigationItem.hidesBackButton = true;
        
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(12, 12, 30, 30)];
        [back addTarget:self action:@selector(clickedBackButton:) forControlEvents:UIControlEventTouchUpInside];
        [back setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                          initWithCustomView:back];
        self.navigationItem.leftBarButtonItem = backButton;
        
    }
}

-(IBAction)clickedBackButton:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)logoutFacebook
{
    MitimUser *user = [MitimUser getUser];
    user.fbUserToken = NULL;
    user.isLoggedInWithFB = false;
    [user save];
    if ([FBSDKAccessToken currentAccessToken]) {
        [[FBSDKLoginManager new] logOut];
    }
}

- (void)showCustomPopupWithType:(PopupType)type {
    if (self.popupView == NULL) {
        [self disableScreen:true];
        PopupView *popupView = [[PopupView alloc] initWithFrame:self.view.bounds type:type];
        popupView.delegate = self;
        self.popupView = popupView;
        [self.view addSubview:self.popupView];
        [self.popupView setAlpha:0];
        [UIView animateWithDuration:1 animations:^{
            [self.popupView setAlpha:1];
        }];
    }
}

- (void)dontAllowButtonClickedWithType:(PopupType)type {
    [UIView animateWithDuration:0.4 animations:^{
        [self.popupView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.popupView removeFromSuperview];
        [self disableScreen:false];
        if (type == PopupTypeLocation) {
            [[NSUserDefaults standardUserDefaults] setBool:1 forKey:kLocationAccessDenied];
        } else if (type == PopupTypeContact) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDontAllowConnect object:nil];
        }
    }];
}

- (void)allowButtonClickedWithType:(PopupType)type {
    [UIView animateWithDuration:0.4 animations:^{
        [self.popupView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.popupView removeFromSuperview];
        [self disableScreen:false];
//        if (type == PopupTypeLocation) {
//            [LocationManager sharedManager];
//        }
//        else if (type == PopupTypeContact) {
//            
//        }
    }];
}

- (void)disableScreen:(BOOL)disable {
    if (self.tabBarController) {
        [self.tabBarController.tabBar setUserInteractionEnabled:!disable];
    }
    if (self.navigationController) {
        [self.navigationController.navigationBar setUserInteractionEnabled:!disable];
    }
}
- (void) showAlertDialog : (NSString *)title message:(NSString *) message positive:(NSString *)strPositivie negative:(NSString *) strNegative sender:(id) sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    if(strPositivie != nil) {
        UIAlertAction * yesButton = [UIAlertAction
                                     actionWithTitle:strPositivie
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         //Handel your yes please button action here
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
        
        [alert addAction:yesButton];
    }
    
    if(strNegative != nil) {
        UIAlertAction * noButton = [UIAlertAction
                                    actionWithTitle:strPositivie
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handel your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
        
        [alert addAction:noButton];
    }
    
    [sender presentViewController:alert animated:YES completion:nil];
}

@end
