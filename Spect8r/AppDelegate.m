//
//  AppDelegate.m
//  Spect8r
//
//  Created by mac on 12/26/16.
//  Copyright © 2016 spect8r. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyBoardManager/IQKeyboardManager.h"
#import <AddressBookUI/AddressBookUI.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:APP_COLOR];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:MuseosansFont(24)}];
    [[UINavigationBar appearance] setBackgroundColor:APP_COLOR];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UILabel appearance] setFont:MuseosansFont(16)];
    [[UIButton appearance] setFont:MuseosansFont500(18)];
    [[UITextField appearance] setFont:MuseosansFont(16)];
//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UITabBar appearance] setTintColor:APP_COLOR];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -500) forBarMetrics:UIBarMetricsDefault];
    
//    [GMSServices provideAPIKey:@"AIzaSyBI6K2FvGsi81jOnrWMKeEtzTi64YPpKsQ"];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
} 
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Spect8r"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
- (void) loginToFacebook:(FacebookHandler)handler {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile", @"user_friends", @"email"] fromViewController:self.window.rootViewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {}
        else if (result.isCancelled) {}
        else {
            MitimUser *user = [MitimUser getUser];
            user.fbUserToken = [FBSDKAccessToken currentAccessToken].tokenString;
            [user save];
            [self checkContact];
        }
        if (handler) handler(result, error);
    }];
}

- (void) loginToFacebookFromViewController:(UIViewController *)vc handler:(FacebookHandler)handler {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile", @"user_friends", @"email"] fromViewController:vc handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {}
        else if (result.isCancelled) {}
        else {
            MitimUser *user = [MitimUser getUser];
            user.fbUserToken = [FBSDKAccessToken currentAccessToken].tokenString;
            [user save];
            [self checkContact];
        }
        if (handler) handler(result, error);
    }];
}

- (void) tryReloginToFacebook:(FacebookHandler)handler {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:NSLocalizedString(@"ERROR_FACEBOOK_RELOGIN", nil)
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", nil)
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [self loginToFacebook:handler];
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [alert addAction:okButton];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)checkContact {
//    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
//        // The user has previously given access, add the contact
//        [self getContacts];
//    }
}

- (void)getContacts {
//    CFErrorRef *error = NULL;
//    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
//    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
//    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
//    
//    NSMutableArray *contacts = [[NSMutableArray alloc] init];
//    
//    for(int i = 0; i < numberOfPeople; i++) {
//        ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
//        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
//        
//        for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
//            NSString *phoneNumber = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
//            phoneNumber = [MitimGlobalData convertMobileAndEncrypt:phoneNumber];
//            if (phoneNumber){
//                NSDictionary *dict = [NSDictionary dictionaryWithObject:phoneNumber forKey:@"encrypted_contact"];
//                [contacts addObject:dict];
//            }
//        }
//    }
//    if (contacts.count > 0) {
//        NetworkController *networkController = [NetworkController sharedController];
//        NSMutableArray *params = [[NSMutableArray alloc] init];
//        [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"phone_contacts", @"key", contacts, @"data", nil]];
//        [networkController sendPhoneContactsRequest:params completionHandler:^(NSDictionary *data) {
//            
//            NSString *errorMessage = data[@"error_message"];
//            
//            NSLog(@"sendContacts completeHandler data=%@", data);
//            if ([data[@"stat"] isEqualToString:@"fail"]){
//                NSLog(@"errorMessage = %@", errorMessage);
//            }
//            else{
//                MitimUser *user = [MitimUser getUser];
//                user.contactsShouldSend = false;
//                [user save];
//            }
//        }];
//    }
//    else {
//        
//    }
}

@end
