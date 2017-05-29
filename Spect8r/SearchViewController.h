//
//  Register1ViewController.h
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimBaseViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "JTImageButton.h"
#import "NIDropDown.h"
#import "NMBottomTabBarController.h"
#import "MKDropdownMenu.h"
@interface SearchViewController : MitimBaseViewController<UITextFieldDelegate, NIDropDownDelegate, MKDropdownMenuDataSource, MKDropdownMenuDelegate>

@property (strong, nonatomic) MKDropdownMenu *navBarMenu;

@property UIImageView *imvBack;
@property UILabel *lblAppName;
@property UIImageView *imvlogo;
@property UIImageView *imvTitle;
@property UIButton *btnPost;
@property UIButton *btnSkip;
@property UIScrollView *scrollView;
@property UITextField *txtSearch;
@property UITextField *txtHeadliner;
@property UITextField *txtSupportingArtist;
@property NIDropDown *dropDown;

@property (weak, nonatomic) UITextField *activeField;
@end

