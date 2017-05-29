//
//  MitimUser.h
//  Polyglot
//
//  Created by Mitim MacBook on 8/21/13.
//  Copyright (c) 2013 Mitim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MitimUser : NSObject

@property long user_id;
@property int user_type;
@property NSString *user_facebook_id;
@property NSString *sessionToken;
@property NSString *fbUserToken;

@property NSString *user_email;
@property NSString *user_password;
@property NSString *user_photo_url;

@property NSString *user_name;
@property NSString *user_full_name;
@property NSString *user_first_name;
@property NSString *user_last_name;

@property NSString *user_personal_url;

@property NSString *user_bio;

@property NSString *user_location_address;
@property double user_location_latitude;
@property double user_location_longitude;

@property long user_follow_count;
@property long user_event_count;
@property long user_artist_count;
@property long user_venue_count;
@property long user_attend_count;

@property NSDate *user_signup_date;
@property NSDate *user_last_login_date;

@property NSString *user_status;

@property (nonatomic, assign) BOOL isLoggedInWithFB;
@property (nonatomic, assign) BOOL isFindOutMoreAsked;
@property (nonatomic, assign) BOOL hasSharedConnections;

@property (nonatomic, strong) NSArray *businesses;

+ (MitimUser*) getUser;

- (void) save;
- (void) load;
- (NSString*) getLongName;
- (NSString *) getFacebookAccessToken;

@end
