//
//  DatabaseController.m
//  Heaters1
//
//  Created by Alex on 12/27/15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "DatabaseController.h"
#import "AppDelegate.h"
#import "MitimGlobalData.h"

@implementation DatabaseController
+ (DatabaseController *)sharedManager {
    static DatabaseController *sharedManager = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        sharedManager = [DatabaseController manager];
        [sharedManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [sharedManager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [sharedManager.requestSerializer setValue:@"123456789" forHTTPHeaderField:@"api-key"];
        [sharedManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];

    });
    return sharedManager;
}

#pragma mark - USER APIs

-(void)test:(NSDictionary*)params  onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    NSString *urlStr = API_TEST;
    [self POST:urlStr parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}

-(void)userSignUp:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_SIGNUP parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}

-(void)userLogIn:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_LOGIN parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}

-(void)sendCode:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_SENDCODE parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)verifyCode:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_VERIFYCODE parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)resetPassword:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_RESETPASSWORD parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)upload_photo_description:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_UPLOAD_PHOTO_DESCRIPTION parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)upload_per_service:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_PER_SERVICE parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}

-(void)get_services:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_GET_SERVICES parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)get_userinfo:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_GET_USERINFO parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)get_serviceInfo:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_GET_SERVICEINFO parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)set_like:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_SET_LIKE parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)set_follow:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_SET_FOLLOW parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)get_comments:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_GET_COMMENTS parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)add_comments:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_ADD_COMMENTS parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)get_favorite:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_GET_FAVORITE parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)set_profile:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_SET_PROFILE parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)change_password:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_CHANGE_PASSWORD parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)getAllProviders:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_GET_PROVIDERS parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}
-(void)getServiceWithID:(NSDictionary*)params onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    [self POST:API_GET_SERVICE_WITH_ID parameters:[params mutableCopy] onSuccess:completionBlock onFailure:failureBlock];
}






#pragma mark - Post and Get Function

- (void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
//        [SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        [commonUtils showAlert:@"Error" withMessage:@"Please try again later"];
        failureBlock(nil);
        return;
    }
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSMutableDictionary * tempDic;
    if (parameters == nil) {
        tempDic = [NSMutableDictionary dictionary];
    }else{
        tempDic= [NSMutableDictionary dictionaryWithDictionary:parameters];
    }
    
//    [tempDic setObject:[User sharedInstance].strToken forKey:@"token"];
    parameters = tempDic;

    
    NSLog(@"POST url : %@", url);
    NSLog(@"POST param : %@", parameters);
    NSLog(@"Debug____________POST_____________!pause");
    
    [self POST:url
          parameters:parameters
          success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject){
              NSData* data = (NSData*)responseObject;
              NSError* error = nil;
              NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
              NSLog(@"POST success : %@", dict);
              
              completionBlock(dict);
              
        
          }failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error){
              NSLog(@"POST Error  %@", error);
//              [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
              [commonUtils showAlert:@"Error" withMessage:@"Please try again later"];

              failureBlock(nil);
          }
    ];
    
  }




- (void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
      vImage:(NSData*)vImage
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
//        [SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        [commonUtils showAlert:@"Error" withMessage:@"Please try again later"];

        failureBlock(nil);
        return;
    }
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

    NSLog(@"POST url : %@", url);
    NSLog(@"POST param : %@", parameters);
    NSLog(@"Debug____________POST_____________!pause");
    
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (vImage != nil) {
            [formData appendPartWithFormData:vImage name:@"vImage"];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSData* data = (NSData*)responseObject;
        NSError* error = nil;
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"POST success : %@", dict);
        
       completionBlock(dict);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"POST Error  %@", error);
//        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        [commonUtils showAlert:@"Error" withMessage:@"Please try again later"];

        failureBlock(nil);
    }];
}


- (void)GET:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
//        [SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        [commonUtils showAlert:@"Error" withMessage:@"Please try again later"];

        failureBlock(nil);
        return;
    }
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

    NSLog(@"GET url : %@", url);
    NSLog(@"GET param : %@", parameters);
    
    [self GET:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSData* data = (NSData*)responseObject;
        NSError* error = nil;
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"GET success : %@", dict);
        completionBlock(dict);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"GET Error  %@", error);
//        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        [commonUtils showAlert:@"Error" withMessage:@"Please try again later"];
        failureBlock(nil);
    }];
}

@end
