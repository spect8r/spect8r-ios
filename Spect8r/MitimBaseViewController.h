//
//  MitimBaseViewController.h
//  100
//
//  Created by Mykhailo Timashov on 5/20/15.
//  Copyright (c) 2015 Mitim Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimGlobalData.h"
#import "CustomScrollView.h"
#import "ErrorView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Constant.h"
#import "UIViewController+Alerts.h"
typedef enum {
    PopupTypeLocation = 0,
    PopupTypeContact = 1,
} PopupType;

@interface MitimBaseViewController : UIViewController

@property CGFloat width;
@property CGFloat height;
@property CGFloat navheight;
@property CGFloat statheight;
@property (nonatomic, assign) CGFloat sideBarCurrentW;

@property UIImageView *backgroundImageView;
@property CustomScrollView *contentView;
@property UIButton *sideBarCloseButton;
@property BOOL isSideBarOpened;
@property UIBarButtonItem *sidebarButton;
@property ErrorView *errorView;

- (CGFloat) getZeroY ;
- (CGFloat) getStatusBarHeight;
- (CGFloat) getViewHeight;

- (void) showError:(NSString*)errorMessage;
- (BOOL) errorViewExist;

- (void) hideLogo;

- (void) addMenuButton;

- (IBAction)clickedBackButton:(id)sender;
- (IBAction)clickedMenuButton:(id)sender;

- (void) initBackButton;
- (void)logoutFacebook;

- (void)showCustomPopupWithType:(PopupType)type;
- (void) showAlertDialog : (NSString *)title message:(NSString *) message positive:(NSString *)strPositivie negative:(NSString *) strNegative sender:(id) sender;

@end
