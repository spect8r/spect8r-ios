//
//  AppDelegate.h
//  Spect8r
//
//  Created by mac on 12/26/16.
//  Copyright © 2016 spect8r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MitimGlobalData.h"
#import "NetworkController.h"

typedef void (^FacebookHandler)(FBSDKLoginManagerLoginResult *result, NSError *error);
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (void) loginToFacebook:(FacebookHandler)handler;
- (void) loginToFacebookFromViewController:(UIViewController *)vc handler:(FacebookHandler)handler;
- (void) tryReloginToFacebook:(FacebookHandler)handler;


@end

