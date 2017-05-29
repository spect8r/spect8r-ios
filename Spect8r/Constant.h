//
//  Constant.h
//  Videobout
//
//  Created by MidnightSun on 27/10/16.
//  Copyright © 2016 sierretech. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#ifndef Constant_h
#define Constant_h



#define APPNAME       @"spect8r"


#define PRIMARYCOLOR ([UIColor colorWithRed:0.965f green:0.557f blue:0.337f alpha:1])

#define USERNAME       @"username"
#define PASSWORD       @"password"
#define EMAIL          @"email"
#define PHONENUMBER    @"phonenumber"
#define PROVIDERID     @"providerid"
#define COUNTRYNAME    @"countryname"
#define UID            @"uid"
#define PHOTOURL       @"photourl"
#define COUNTVIDEO     @"countvideo"
#define COUNTCHALLEGE  @"countchallege"
#define COUNTFAVORITE  @"countfavorite"


#define VIDEOID         @"videoid"
#define VIDEOTITLE      @"videoTitle"
#define VIDEOURL        @"videoUrl"
#define VIDEOTHUMBURL   @"videothumbUrl"
#define VIDEOCHALLENGID     @"videochallengeId"
#define VIDEOUPVOTECOUNT    @"videoupvoteCount"
#define VIDEOCOMMENTCOUNT   @"videocommentCount"
#define VIDEOFAVORITEFLAG   @"videofavoriteFlag"
#define VIDEOUPVOTEFLAG     @"videoupvoteFlag"
#define VIDEOSHAREFLAG      @"videoshareFlag"
#define VIDEOUSERID         @"videouserid"
#define VIDEOUSERNAME       @"videousername"
#define VIDEOUSERPHOTO      @"videouserphoto"
#define VIDEOCATEGORY       @"videocategory"

#define CHALLENGEID         @"challengeid"
#define CHALLENGETITLE      @"challengeTitle"
#define CHALLENGETHUMBURL   @"challengethumbUrl"
#define CHALLENGEVIDEOURL       @"challengevideoUrl"
#define CHALLENGEVIDEOCOUNT     @"challengevideoCount"
#define CHALLENGEUPVOTECOUNT    @"challengeupvoteCount"
#define CHALLENGECOMMENTCOUNT   @"challengecommentCount"
#define CHALLENGEUPVOTEFLAG     @"challengeupvoteFlag"
#define CHALLENGEFAVORITEFLAG   @"challengefavoriteFlag"
#define CHALLENGESHAREFLAG      @"challengeshareFlag"
#define VIDEOARRAY              @"videoArray"


#define COMMENT             @"comment"
#define COMMENTID           @"commentid"
#define USERDICT            @"userdict"

#define EMPTY               @""

#define PROFILE_SIZE (CGSizeMake(256.0f, 256.0f))
#define IMAGE_SIZE (CGSizeMake(512.0f, 512.0f))

#define CATEGORYNAMES @"categoryNames"
#define CHALLENGENAMES @"challengeNames"
#define CATEGORYARRAY @[@"categoryNames", @"", nil]
//
//#define PREF_EMAIL @"pref_email";
//#define PREF_USER_ID @"pref_user_id";
//#define PREF_PASSWORD @"pref_password";
//#define PREF_USERNAME @"pref_last_name";
//#define PREF_SOCIAL_LOGIN @"pref_social_login";
//#define PREF_PROFILE_URL @"pref_profile_url";
//#define PREF_PHONENUMBER @"pref_phone_number";
//#define PREF_PROVIDE_ID @"pref_provide_id";
//#define PREF_COUNTRY @"pref_country";
//#define PREF_CHALLENGE_COUNT @"pref_challenge_count";
//#define PREF_VIDEO_FAVORITE_COUNT @"pref_video_favorite_count";
//#define PREF_VIDEO_COUNT @"pref_video_count";

#endif /* Constant_h */
static inline void delay(NSTimeInterval delay, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

static UIColor * UIColorWithHexString(NSString *hex) {
    unsigned int rgb = 0;
    [[NSScanner scannerWithString:
      [[hex uppercaseString] stringByTrimmingCharactersInSet:
       [[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEF"] invertedSet]]]
     scanHexInt:&rgb];
    return [UIColor colorWithRed:((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0
                            blue:((CGFloat)(rgb & 0xFF)) / 255.0
                           alpha:1.0];
}
