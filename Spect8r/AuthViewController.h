//
//  ViewController.h
//  Spect8r
//
//  Created by mac on 12/26/16.
//  Copyright © 2016 spect8r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitimBaseViewController.h"
@interface AuthViewController : MitimBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *imvBack;
@property UILabel *lblAppName;
@property CustomScrollView *scrollView;

@property UIButton *btnFBLogin;
@property UIButton *btnEmailLogin;
@property UIButton *btnCreatAccount;
@end

