//
//  CommonViewController.m
//  Videobout
//
//  Created by MidnightSun on 26/10/16.
//  Copyright © 2016 sierretech. All rights reserved.
//

#import "CommonViewController.h"
#import "AppDelegate.h"


@implementation CommonViewController

@synthesize userListTitle;

-(void) viewDidLoad{
    [super viewDidLoad];
}

- (void) showLoadingView {
    
    AppDelegate *App = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    HUD = [[MBProgressHUD alloc] initWithView:App.window];
    
    [App.window addSubview:HUD];
    HUD.minSize = CGSizeMake(100.f, 100.f);
    
    // Set the hud to display with a color
    HUD.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    
    HUD.delegate = nil;
    HUD.labelText = nil;
    
    [HUD show:YES];
}

- (void) showWhiteLoadingView {
    
    AppDelegate *App = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    HUD = [[MBProgressHUD alloc] initWithView:App.window];
    HUD.activityIndicatorColor = [UIColor whiteColor];
    
    [App.window addSubview:HUD];
    HUD.minSize = CGSizeMake(100.f, 100.f);
    
    // Set the hud to display with a color
    HUD.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    
    HUD.delegate = nil;
    HUD.labelText = nil;
    
    [HUD show:YES];
}


- (void) showLoadingViewWithTitle:(NSString *) title sender:(id) sender
{
    AppDelegate *App = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    HUD = [[MBProgressHUD alloc] initWithView:App.window];
    
    [App.window addSubview:HUD];
    HUD.minSize = CGSizeMake(100.f, 100.f);
    
    // Set the hud to display with a color
    HUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.70];
    
    HUD.delegate = sender;
    HUD.labelText = title;
    
    [HUD show:YES];
}

- (void) hideLoadingView {
    
    [HUD hide:YES];
}

- (void) hideLoadingView : (NSTimeInterval) delay {
    
    [HUD hide:YES afterDelay:delay];
}

- (void)showToastMessage:(NSString *)message
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color = [UIColor colorWithRed:0.23 green:0.5 blue:0.82 alpha:0.7];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.margin = 10.0f;
    hud.yOffset = 150.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5f];
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
