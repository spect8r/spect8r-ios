//
//  MitimGlobalData.h
//  InAWord
//
//  Created by Misha Timashov on 5/8/13.
//  Copyright (c) 2013 Misha Timashov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "MitimUser.h"
#import "CommonUtils.h"
//#import "LocationManager.h"
#import "MitimCompleteInterface.h"

static NSString *kRecievNoInternetConnection = @"RecievNoInternetConnection";

@interface MitimGlobalData : NSObject


#define XCODE_COLORS_ESCAPE @"\033["

#define koef ([[UIScreen mainScreen] bounds].size.width/375)

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define LogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogGreen(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg37,108,54;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

#define MULTIPLAYER_NUMBER_WORDS 10
#define COINS_TWO_STARS_COMPLETE 10
#define COINS_THREE_STARS_COMPLETE 15

#define kNavigationBarButtonsTitleFontSize 18.0f
#define kNavigationBarButtonsTitleWidthOffset 6.0f
#define kNavigationBarButtonsTitleHeightOffset 3.0f

#define DEBUG_MODE false

#define KOEF [MitimGlobalData getKoef]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAndAlpha(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_SMALL_IPHONE (IS_IPAD==false && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define IS_SIMULATOR TARGET_OS_SIMULATOR

#define BLUE_COLOR UIColorFromRGB(0x49aacd)
#define APP_COLOR UIColorFromRGBAndAlpha(0x000000, 0.5f)

#define CORNER_RADIUS 10.0

#define AppFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define BoldAppFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define MontserratBoldFont(fontSize) [UIFont fontWithName:@"Montserrat-Bold" size:fontSize]
#define MuseosansFont(fontSize) [UIFont fontWithName:@"MuseoSans-100" size:fontSize]
#define MuseosansFont500(fontSize) [UIFont fontWithName:@"MuseoSans-500" size:fontSize]
#define MuseosansFont700(fontSize) [UIFont fontWithName:@"MuseoSans-700" size:fontSize]
#define MontserratRegularFont(fontSize) [UIFont fontWithName:@"Montserrat-Regular" size:fontSize]
#define LocationNormal(fontSize) [UIFont fontWithName:@"My Font" size:fontSize]

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(angle) (angle * 180.0 * M_PI)

#define IS_ADMIN [[MitimUser getUser].businessRole isEqualToString:@"ADMIN"]

#define PLATFORM_PASSWORD @"kjasdglkglkjdgkdgkldg"

#define kLocationAskPermission @"LocationAskPermission"
#define kLocationAccessDenied @"LocationAccessDenied"

#define kNotificationDontAllowConnect @"NotificationDontAllowConnectFriends"
#define kNotificationRemoveNoFriendsConnected @"NotificationRemoveNoFriendsConnected"
#define kNotificationUpdatePhoneContact @"NotificationUpdatePhoneContact"
#define commonUtils [CommonUtils shared]

+ (NSString *) md5:(NSString *) input;
+ (CGRect) getScreenRect;

+ (CGFloat) getKoef;
+ (void) setKoef: (CGFloat) value;


+ (NSString*)base64forString:(NSString*)str;
+ (NSString*)base64forData:(NSData*)theData;
+ (NSString*)sha256HashFor:(NSString*)input;


+ (bool)isIPad;

+ (NSMutableArray*)shuffleMutableArray:(NSMutableArray*)array;
+(NSString*) shuffleString:(NSString*)str;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (void) setRoundedCornersToImageView:(UIImageView*)imageView;
+ (void) setRoundedCornersToView:(UIView*)view radius:(int)radius;
+ (void) setRoundedCornersToButton:(UIButton*)button;

+ (int)getRandomIntFrom:(int)from to:(int)to;

+ (void) setTimeout:(MitimComplete)callBack;
+ (void) setTimeout:(MitimComplete)callBack time:(int)time;

+ (void)shakeView:(UIView*)view;
+ (void)shakeVerticallyView:(UIView*)view;

+ (NSString*) lingvoWithNumber:(int)number word1:(NSString*)word1 word2:(NSString*)word2 word3:(NSString*)word3;

+ (void) initLoadingPopup:(CGRect)bounds;
+ (void) showLoadingPopup;
+ (void) hideLoadingPopup;

+ (NSString*) convertMobileAndEncrypt:(NSString*)number;
+ (NSString*) convertMobileToInternationalFormatAndValidate:(NSString*)number;
+ (NSString*) convertMobileToDomesticFormatAndValidate:(NSString*)number;

+ (NSString *)urlEncodeString:(NSString*)str;

//+ (NSString*) getAddressLinefromAddress:(NSDictionary*)address;
//+ (NSString*) getAddressLineForBusinessFromAddress:(NSDictionary*)address;
//+ (NSString*) getAddressLineForBusinessProfilefromAddress:(NSDictionary*)address;

+ (NSString *) getInitialFromString:(NSString *)string;


@end
