//
//  CommonViewController.h
//  Videobout
//
//  Created by MidnightSun on 26/10/16.
//  Copyright © 2016 sierretech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CustomScrollView.h"
#import "ErrorView.h"


@interface CommonViewController : UIViewController{
    MBProgressHUD * HUD;
}


@property CGFloat width;
@property CGFloat height;
@property UIImageView *backgroundImageView;

@property CustomScrollView *contentView;
@property ErrorView *errorView;
- (CGFloat) getZeroY ;
- (CGFloat) getStatusBarHeight;
- (CGFloat) getViewHeight;


- (void) showWhiteLoadingView;
- (void) hideLoadingView;
- (void) showLoadingView;
- (void) hideLoadingView : (NSTimeInterval) delay;
- (void) showLoadingViewWithTitle:(NSString *) title sender:(id) sender;

- (void) showAlertDialog : (NSString *)title message:(NSString *) message positive:(NSString *)strPositivie negative:(NSString *) strNegative sender:(id) sender;


@property int userListTitle;

@end
