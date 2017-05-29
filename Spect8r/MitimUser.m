//
//  MitimUser.m
//  Polyglot
//
//  Created by Mitim MacBook on 8/21/13.
//  Copyright (c) 2013 Mitim. All rights reserved.
//

#import "MitimUser.h"
#import "MitimGlobalData.h"

@implementation MitimUser

MitimUser* currentUser;
+ (MitimUser*) getUser {
    if (currentUser == NULL){
        currentUser = [[MitimUser alloc] init];
        [currentUser load];
    }
    return currentUser;
}

-(void)save{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:self.user_id forKey:@"user_id"];
    [defaults setObject:self.sessionToken forKey:@"sessionToken"];
    
    [defaults setObject:self.fbUserToken forKey:@"fbUserToken"];
    [defaults setObject:self.user_email forKey:@"user_email"];
    [defaults setObject:self.user_password forKey:@"user_password"];
    [defaults setObject:self.user_photo_url forKey:@"user_photo_url"];
    
    
    [defaults setObject:self.user_name forKey:@"user_name"];
    [defaults setObject:self.user_full_name forKey:@"user_full_name"];
    [defaults setObject:self.user_first_name forKey:@"user_first_name"];
    [defaults setObject:self.user_last_name forKey:@"user_last_name"];
    [defaults setObject:self.user_personal_url forKey:@"user_personal_url"];
    [defaults setObject:self.user_bio forKey:@"user_bio"];
    
    [defaults setInteger:self.user_type forKey:@"user_type"];
    
    [defaults setObject:self.user_location_address forKey:@"user_location_address"];
    [defaults setDouble:self.user_location_latitude forKey:@"user_location_latitude"];
    [defaults setDouble:self.user_location_longitude forKey:@"user_location_longitude"];
    
    [defaults setBool:self.isLoggedInWithFB forKey:@"isLoggedInWithFB"];
    
    [defaults setInteger:self.user_follow_count forKey:@"user_follow_count"];
    [defaults setInteger:self.user_event_count forKey:@"user_event_count"];
    [defaults setInteger:self.user_artist_count forKey:@"user_artist_count"];
    [defaults setInteger:self.user_venue_count forKey:@"user_venue_count"];
    [defaults setInteger:self.user_attend_count forKey:@"user_attend_count"];

    [defaults setObject:self.user_signup_date forKey:@"user_signup_date"];
    [defaults setObject:self.user_last_login_date forKey:@"user_last_login_date"];
    [defaults setObject:self.user_status forKey:@"user_status"];

}

-(void)load{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.user_id = [defaults integerForKey:@"user_id"];
    self.sessionToken = [defaults objectForKey:@"sessionToken"];
    
    self.fbUserToken = [defaults objectForKey:@"fbUserToken"];

    self.user_first_name = [defaults objectForKey:@"user_first_name"];
    self.user_last_name = [defaults objectForKey:@"user_last_name"];
    
    self.user_email = [defaults objectForKey:@"user_email"];
    self.user_password = [defaults objectForKey:@"user_password"];
    self.user_photo_url = [defaults objectForKey:@"user_photo_url"];
    self.user_name = [defaults objectForKey:@"user_name"];
    self.user_full_name = [defaults objectForKey:@"user_full_name"];
    self.user_personal_url = [defaults objectForKey:@"user_personal_url"];
    self.user_bio = [defaults objectForKey:@"user_bio"];
    self.user_type = (int)[defaults integerForKey:@"user_type"];

    self.user_location_address = [defaults objectForKey:@"user_location_address"];
    self.user_location_longitude = [defaults doubleForKey:@"user_location_longitude"];
    self.user_location_latitude = [defaults doubleForKey:@"user_location_latitude"];
    
    self.user_follow_count = [defaults integerForKey:@"user_follow_count"];
    self.user_event_count = [defaults integerForKey:@"user_event_count"];
    self.user_artist_count = [defaults integerForKey:@"user_artist_count"];
    self.user_venue_count = [defaults integerForKey:@"user_venue_count"];
    self.user_attend_count = [defaults integerForKey:@"user_attend_count"];
    self.isLoggedInWithFB = [defaults boolForKey:@"isLoggedInWithFB"];
    
    self.user_signup_date = [defaults objectForKey:@"user_signup_date"];
    self.user_last_login_date = [defaults objectForKey:@"user_last_login_date"];
    self.user_status = [defaults objectForKey:@"user_status"];
    

}

- (NSString*) getLongName {
    if (self.user_first_name!=NULL && self.user_first_name.length>0 && self.user_last_name!=NULL && self.user_last_name.length>0){
        return [NSString stringWithFormat:@"%@ %@", self.user_first_name, self.user_last_name];
    }
    return @"";
}

- (NSString *) getFacebookAccessToken {
    if ([FBSDKAccessToken currentAccessToken]) {
        return [FBSDKAccessToken currentAccessToken].tokenString;
    }
    return self.fbUserToken;
}

@end
