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

@interface PostFirstEventViewController : MitimBaseViewController


@property (weak, nonatomic) IBOutlet UIImageView *imvBack;
@property UILabel *lblAppName;
@property UIImageView *imvPostEvent;
@property UIImage *imgPostEvent;
@property UIButton *btnNext;
@property UIButton *btnSkip;
@property UIButton *btnBack;

@end

