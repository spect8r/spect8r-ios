//
//  ViewController.m
//  Spect8r
//
//  Created by mac on 12/26/16.
//  Copyright © 2016 spect8r. All rights reserved.
//

#import "AuthViewController.h"
#import "UILabel+dynamicSizeMe.h"
#import "SignInViewController.h"
#import "RegisterViewController.h"
#import "NMBottomTabBarController.h"
@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];

    self.scrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, [self getViewHeight])];
    [self.view addSubview:self.scrollView];
    
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
    self.lblAppName = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.2f, self.height / 2 - self.navheight - 40, self.width * 0.6f, 30)];
    [self.lblAppName setAttributedText:attributedString];
    [self.lblAppName setTextColor: [UIColor whiteColor]];
    [self.lblAppName setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.lblAppName];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake( self.width * 0.2f, self.height / 2 - self.navheight, self.width * 0.6f , 1)];
    [line1 setBackgroundColor:UIColorFromRGB(0xAAAAAA)];
    [self.view addSubview:line1];
    
    
    NSString *string1 = @"track and share your favorite live music events";
    NSDictionary *fontAttributes1 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(14), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1 attributes:fontAttributes1];
    
    UILabel *lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.2f, self.height / 2 - self.navheight + 10, self.width * 0.6f, 40)];
    [lblDescription setAttributedText:attributedString1];
    [lblDescription setTextColor: [UIColor whiteColor]];
    [lblDescription setTextAlignment:NSTextAlignmentCenter];
    [lblDescription setNumberOfLines:2];
    [self.view addSubview:lblDescription];

    self.btnCreatAccount = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 50, self.width, 50)];
    [self.btnCreatAccount addTarget:self action:@selector(clickedCreateAccoutButton:) forControlEvents:UIControlEventTouchUpInside];

    NSString *createanaccount = @"Create an account";
    [self.btnCreatAccount.titleLabel setFont:MuseosansFont(18)];
    [self.btnCreatAccount setTitle:createanaccount forState:UIControlStateNormal];
    [self.btnCreatAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCreatAccount setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.btnCreatAccount];

    self.btnFBLogin = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height -200, self.width * 0.8f, 60)];
    [self.btnFBLogin.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.btnFBLogin setImage:[UIImage imageNamed:@"btn_facebook"]  forState:UIControlStateNormal];
    [self.btnFBLogin addTarget:self action:@selector(clickedFBButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnFBLogin];
    
    self.btnEmailLogin = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height - 125, self.width * 0.8f, 60)];
    [self.btnEmailLogin.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.btnEmailLogin setImage:[UIImage imageNamed:@"btn_email"] forState:UIControlStateNormal];
    [self.btnEmailLogin addTarget:self action:@selector(clickedEmailButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnEmailLogin];


}

- (void) clickedCreateAccoutButton:(id)sender {
    RegisterViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:newViewController animated:true completion:nil];
    
}
- (void) clickedFBButton:(id)sender {
}
- (void) clickedEmailButton:(id)sender {
    SignInViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self presentViewController:newViewController animated:true completion:nil];
//    NMBottomTabBarController *tabBarController = (NMBottomTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
//    [self presentViewController:tabBarController animated:true completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
