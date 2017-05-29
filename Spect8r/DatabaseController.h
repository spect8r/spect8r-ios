//
//  DatabaseController.h
//  Heaters1
//
//  Created by Alex on 12/27/15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h"
//#import "SHAlertHelper.h"



//#define SERVER_URL @"http://paradiseadult.com/Paradise/api/"
#define SERVER_URL @"http://172.16.0.103/spect8r/api/"



#define API_TEST (SERVER_URL @"test")

#define API_SIGNUP                      (SERVER_URL @"user_signup")
#define API_LOGIN                       (SERVER_URL @"user_login")
#define API_SENDCODE                    (SERVER_URL @"send_code")
#define API_VERIFYCODE                  (SERVER_URL @"verify_code")
#define API_RESETPASSWORD               (SERVER_URL @"reset_password")
#define API_UPLOAD_PHOTO_DESCRIPTION    (SERVER_URL @"upload_photo_description")
#define API_PER_SERVICE                 (SERVER_URL @"upload_per_service")
#define API_GET_SERVICES                (SERVER_URL @"get_services")
#define API_GET_USERINFO                (SERVER_URL @"get_userInfo")
#define API_GET_SERVICEINFO             (SERVER_URL @"get_serviceInfo")
#define API_SET_LIKE                    (SERVER_URL @"set_like")
#define API_SET_FOLLOW                  (SERVER_URL @"set_follow")
#define API_GET_COMMENTS                (SERVER_URL @"get_comments")
#define API_ADD_COMMENTS                (SERVER_URL @"add_comments")
#define API_GET_FAVORITE                (SERVER_URL @"get_favorite")
#define API_SET_PROFILE                 (SERVER_URL @"set_profile")
#define API_CHANGE_PASSWORD             (SERVER_URL @"change_password")
#define API_GET_PROVIDERS               (SERVER_URL @"getAllProviders")
#define API_GET_SERVICE_WITH_ID         (SERVER_URL @"getServiceWithID")


typedef void (^SuccessBlock)(id json);
typedef void (^FailureBlock)(id json);

@interface DatabaseController : AFHTTPRequestOperationManager
{

}

+ (DatabaseController *)sharedManager;


-(void)test:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)userSignUp:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)userLogIn:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)sendCode:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)verifyCode:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)resetPassword:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)upload_photo_description:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)upload_per_service:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)get_services:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)get_userinfo:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)get_serviceInfo:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)set_like:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)set_follow:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)get_comments:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)add_comments:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)get_favorite:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)set_profile:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)change_password:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)getAllProviders:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;
-(void)getServiceWithID:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock;





-(void)POST:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
      onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock;

-(void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
      vImage:(NSData*)vImage
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock;
- (void)GET:(NSString *)url
parameters:(NSMutableDictionary*)parameters
onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock;

@end
