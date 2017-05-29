//
//  NetworkController.m
//  Vouchify
//
//  Created by Mykhailo Timashov on 3/9/16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//


#import "NetworkController.h"
#import "MitimUser.h"
#import "MitimGlobalData.h"
#import "AppDelegate.h"
#import <GBDeviceInfo/GBDeviceInfo.h>
@import AdSupport;

@implementation NetworkController

NetworkController* sharedNetworkController;
+ (NetworkController*) sharedController{
    if (sharedNetworkController == NULL){
        sharedNetworkController = [[NetworkController alloc] init];
    }
    
    return sharedNetworkController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baseUrl = @"http://172.16.0.103/spect8r/api/";
            }
    return self;
}

- (void) sendGetUserRequest:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"getuser" params:NULL completionHandler:^(NSDictionary *data) {
        if (data && data[@"result"] && data[@"result"][@"fb_user_token"]) {
            MitimUser *user = [MitimUser getUser];
            user.fbUserToken = data[@"result"][@"fb_user_token"];
            [user save];
        }
        completionHandler(data);
    }];
}

- (void) sendGetUserRequest:(NSString*)userId completionHandler:(NetworkControllerComplete)completionHandler{
    NSMutableArray *params = [[NSMutableArray alloc] init];
    
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_id", @"key", userId, @"data", nil]];
    
    [self sendRequest:@"getuser" params:params completionHandler:completionHandler];
}

- (void) sendGetVouchesForUserRequest:(NSString*)userId completionHandler:(NetworkControllerComplete)completionHandler {
    
    NSMutableArray *params = [[NSMutableArray alloc] init];
    
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_id", @"key", userId, @"data", nil]];
    
    [self sendRequest:@"getvouchesforuser" params:params completionHandler:completionHandler];
}

- (void) sendPhoneContactsRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"sendphonecontacts" params:params completionHandler:completionHandler];
}


- (void) sendSignUpRequest:(NSString*)email password:(id)password firstName:(id)firstName lastName:(id)lastName address:(id)address fbUserId:(id)fbUserId fbUserToken:(id)fbUserToken completionHandler:(NetworkControllerComplete)completionHandler {
    NSMutableArray *params = [[NSMutableArray alloc] init];
    
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_email", @"key", email, @"data", nil]];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_password", @"key", password, @"data", nil]];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_first_name", @"key", firstName, @"data", nil]];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_last_name", @"key", lastName, @"data", nil]];
    //[params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"address", @"key", address, @"data", nil]];
//    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"mobile", @"key", mobile, @"data", nil]];
    //[params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"gender", @"key", gender, @"data", nil]];
//    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"fb_user_token", @"key", fbUserToken, @"data", nil]];
//    if (userId != NULL) {
//        [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_id", @"key", userId, @"data", nil]];
//    }

    if (fbUserToken) {
        [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"fb_user_token", @"key", fbUserToken, @"data", nil]];
        [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_facebook_id", @"key", fbUserId, @"data", nil]];
        [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"signup_mode", @"key", @"1", @"data", nil]];

    }else{
        [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"signup_mode", @"key", @"2", @"data", nil]];
        
    }
    [self sendRequest:@"user_signup" params:params completionHandler:completionHandler];
}

- (void) sendLoginRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"login" params:params completionHandler:completionHandler];
}
- (void) sendLoginToBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendLogoutRequestWithCompletionHandler:^(NSDictionary *data) {
        [self sendLoginRequest:params completionHandler:completionHandler];
    }];
}

- (void) sendLoginToAdminRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendLogoutRequestWithCompletionHandler:^(NSDictionary *data) {
        [self sendLoginRequest:params completionHandler:completionHandler];
    }];
}

- (void) sendLogoutRequestWithCompletionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"logoff" params:NULL completionHandler:completionHandler];
}
- (void) sendLogoutRequest {
    [self sendLogoutRequestWithCompletionHandler:nil];
}

- (void) sendGetUserConnectionsRequest:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"getuserconnections" params:NULL completionHandler:completionHandler];
}

- (void) sendLocationRequest:(NSString*)locationText completionHandler:(NetworkControllerComplete)completionHandler {
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"suburb_text", @"key", locationText, @"data", nil]];
    [self sendGetRequest:@"autocompletesuburb" params:params completionHandler:completionHandler];
}

- (void) sendServiceRequest:(NSString*)serviceText completionHandler:(NetworkControllerComplete)completionHandler {
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"service_text", @"key", serviceText, @"data", nil]];
    [self sendGetRequest:@"autocompleteservice" params:params completionHandler:completionHandler];
}

- (void) sendAutocompleteSearchRequest:(NSString*)searchText completionHandler:(NetworkControllerComplete)completionHandler {
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"search_text", @"key", searchText, @"data", nil]];
    [self sendGetRequest:@"autocompletesearch" params:params completionHandler:completionHandler];
}

- (void) sendAutocompleteUsersSearchRequest:(NSString*)searchText completionHandler:(NetworkControllerComplete)completionHandler {
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_text", @"key", searchText, @"data", nil]];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"session_token", @"key", [MitimUser getUser].sessionToken, @"data", nil]];
    [self sendGetRequest:@"autocompleteuser" params:params completionHandler:completionHandler];
}

- (void) sendAutocompleteBusinessSearchRequest:(NSString*)searchText completionHandler:(NetworkControllerComplete)completionHandler {
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"bus_text", @"key", searchText, @"data", nil]];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"session_token", @"key", [MitimUser getUser].sessionToken, @"data", nil]];
    [self sendGetRequest:@"autocompletebusiness" params:params completionHandler:completionHandler];
}

-(void)sendGetServiceAreasRequest:(NSArray *)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendGetRequest:@"getserviceareas" params:params completionHandler:completionHandler];
}

- (void) sendSearchBusinessesRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"searchbusinesses" params:params completionHandler:completionHandler];
}

- (void)sendMediaUploadUrlRequest:(NSArray *)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"requestmediauploadurl" params:params completionHandler:completionHandler];
}

- (void)sendConfirmMediaUploadRequest:(NSArray *)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"confirmmediaupload" params:params completionHandler:completionHandler];
}

- (void)sendImageData:(NSData *)imageData toUrl:(NSString *)stringUrl completionHandler:(NetworkControllerUploadComplete)completionHandler{
    NSURL * url = [NSURL URLWithString:stringUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"logo" forHTTPHeaderField:@"fileName"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:imageData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString* respString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        if (completionHandler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error == nil);
            });
        }
    }];
    [task resume];
}

- (void) sendRequest:(NSString*)method params:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    BOOL isRelogin = false;
    if ([method isEqualToString:@"relogin"]) {
        isRelogin = true;
        method = @"login";
    }
    NSLog(@"sendRequest method=%@", method);
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.baseUrl, method];

    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"123456789" forHTTPHeaderField:@"api-key"];
    
    [request setHTTPMethod:@"POST"];
    NSMutableDictionary *mapData = [[NSMutableDictionary alloc] init];
    
    if ([method isEqualToString:@"login"] == false){
        MitimUser *user = [MitimUser getUser];
//        if (([method isEqualToString:@"updatebusinessuser"] || [method isEqualToString:@"deletebusinessuser"]) && user.businessId) {
//            
//        } else if (mapData[@"user_id"] == NULL) {
//            if (IS_ADMIN && [method isEqualToString:@"writeuser"]) {
//            } else {
//                mapData[@"user_id"] = user.userId;
//            }
//        }
//        if ([method isEqualToString:@"getvouchesforbusiness"] && (user.businessId || IS_ADMIN)) {
//            
//        } else if (([method isEqualToString:@"getvouch"] || [method isEqualToString:@"writevouch"]) && IS_ADMIN) {
//            
//        } else {
//            mapData[@"session_token"] = user.sessionToken;
//        }
    }
    
    if (params){
        for (NSDictionary *param in params){
            mapData[param[@"key"]] = param[@"data"];
        }
        if ([method isEqualToString:@"login"]) {
            GBDeviceInfo *device = [GBDeviceInfo deviceInfo];
            NSString *deviceVer = [NSString stringWithFormat:@"IOS %@", [[UIDevice currentDevice] systemVersion]];
            NSString *deviceModel = [[device modelString] stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *appVer = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
            NSString *adv = [self identifierForAdvertising];
            
            [mapData setObject:@"ios" forKey:@"platform"];
            if (deviceVer) [mapData setObject:deviceVer forKey:@"platform_os_version"];
            if (deviceModel) [mapData setObject:deviceModel forKey:@"device_model"];
            if (appVer) [mapData setObject:appVer forKey:@"app_version"];
            [mapData setObject:PLATFORM_PASSWORD forKey:@"platform_password"];
            if (adv) [mapData setObject:adv forKey:@"advertising_id"];
        }
    }
    
    NSLog(@"mapData = %@", mapData);
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.noInternetConnection = false;
        NSDictionary *dict;
        if (error){
            if (error.code == -1009){
        
                self.noInternetConnection = true;
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedString(@"ERROR_NO_INTERNET_CONNECTION", nil), @"error_message", @"fail", @"stat", @"-1009", @"error_code", nil];
            }
            else{
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:error.description, @"error_message", @"fail", @"stat", nil];
            }
        }
        else {
            NSError *jsonError;
            dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if (jsonError){
                NSString* respString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

                dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Error getting data from server.", @"error_message", @"fail", @"stat", respString, @"server_response", nil];
            }
        }
        if (([dict[@"error_code"] isEqualToString:@"4002"] || [dict[@"error_code"] isEqualToString:@"4007"]) && isRelogin){
            NSLog(@"Facebook token error.");
            dispatch_async(dispatch_get_main_queue(), ^{
                [MitimGlobalData hideLoadingPopup];
                [self reloginToFacebook:completionHandler onCompleteMethod:method onCompleteParams:params];
            });
        }
        else if ([dict[@"error_code"] isEqualToString:@"3001"]){
            NSLog(@"Expired token error.");
//            [self sendReloginRequest:^(NSDictionary *data) {
//                if ([data[@"stat"] isEqualToString:@"fail"]){
//                    NSString *errorMessage = data[@"error_message"];
//                    NSLog(@"errorMessage = %@", errorMessage);
//                    NSLog(@"errorCode = %@", data[@"error_code"]);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (completionHandler){
//                            completionHandler([[NSDictionary alloc] initWithObjectsAndKeys: errorMessage, @"error_message", @"fail", @"stat", nil]);
//                        }
//                        [MitimGlobalData hideLoadingPopup];
//                    });
//                }
//                else{
//                    MitimUser *user = [MitimUser getUser];
//                    if (data[@"result"][@"user_id"]){
//                        user.user_id = [data[@"result"][@"user_id"] integerValue];
//                    }
//                    if (data[@"result"][@"session_token"]){
//                        user.sessionToken = data[@"result"][@"session_token"];
//                    }
//                    [user save];
//                    
//                    [self sendRequest:method params:params completionHandler:completionHandler];
//                }
//            }];
        }
        else{
            if ([method isEqualToString:@"login"] && dict[@"result"][@"session_token"]){
                MitimUser *user = [MitimUser getUser];
                user.sessionToken = dict[@"result"][@"session_token"];
                [user save];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionHandler){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRecievNoInternetConnection object:[NSNumber numberWithBool:self.noInternetConnection]];
                    completionHandler(dict);
                }
            });
        }
    }];
    
    [postDataTask resume];
}

- (NSString *)identifierForAdvertising
{
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
    {
        NSUUID *IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        
        return [IDFA UUIDString];
    }
    
    return nil;
}

- (void) reloginToFacebook:(NetworkControllerComplete)completionHandler onCompleteMethod:(NSString*)onCompleteMethod onCompleteParams:(NSArray*)onCompleteParams{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate tryReloginToFacebook:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
            dispatch_async(dispatch_get_main_queue(), ^{
                [MitimGlobalData hideLoadingPopup];
                if (completionHandler) {
                    completionHandler([[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedString(@"ERROR_FACEBOOK_RELOGIN", nil), @"error_message", @"fail", @"stat", nil]);
                }
            });
        } else if (result.isCancelled) {
            NSLog(@"result.isCancelled");
            dispatch_async(dispatch_get_main_queue(), ^{
                [MitimGlobalData hideLoadingPopup];
                if (completionHandler) {
                    completionHandler([[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedString(@"ERROR_FACEBOOK_RELOGIN", nil), @"error_message", @"fail", @"stat", nil]);
                }
            });
        } else {
            NSLog(@"Logged in");
            
            NSArray *params = [self updateFbTokenInParams:onCompleteParams];
            [self sendRequest:onCompleteMethod params:params completionHandler:completionHandler];
        }
    }];
}

- (NSArray*) updateFbTokenInParams:(NSArray*)params{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in params){
        if ([dict[@"key"] isEqualToString:@"fb_user_token"] == false){
            [result addObject:dict];
        }
    }
    MitimUser *user = [MitimUser getUser];
    [result addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"fb_user_token", @"key", user.fbUserToken, @"data", nil]];
    return result;
}

- (void) sendGetRequest:(NSString*)method params:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    NSLog(@"sendGetRequest method=%@", method);
    
    NSMutableString *paramsString = [[NSMutableString alloc] init];
    
    if (params){
        for (NSDictionary *param in params){
            if (paramsString.length == 0) [paramsString appendString:@"?"];
            else [paramsString appendString:@"&"];
            
            [paramsString appendFormat:@"%@=%@", param[@"key"], param[@"data"]];
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", self.baseUrl, method, paramsString];
    urlString = [MitimGlobalData urlEncodeString:urlString];
    NSLog(@"urlString = %@", urlString);

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"GET"];
    

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        self.noInternetConnection = false;
        
        NSDictionary *dict;
        if (error){
            if (error.code == -1009){
                self.noInternetConnection = true;
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedString(@"ERROR_NO_INTERNET_CONNECTION", nil), @"error_message", @"fail", @"stat", @"-1009", @"error_code", nil];
            }
            else{
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:error.description, @"error_message", @"fail", @"stat", nil];
            }
        }
        else {
            NSError *jsonError;
            dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if (jsonError){
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Error getting data from server.", @"error_message", @"fail", @"stat", nil];
            }
        }

        if ([dict[@"error_code"] isEqualToString:@"3001"]){
            NSLog(@"Expired token error.");
//            [self sendReloginRequest:^(NSDictionary *data) {
//                if ([data[@"stat"] isEqualToString:@"fail"]){
//                    NSString *errorMessage = data[@"error_message"];
//                    NSLog(@"errorMessage = %@", errorMessage);
//                    NSLog(@"errorCode = %@", data[@"error_code"]);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (completionHandler){
//                            completionHandler([[NSDictionary alloc] initWithObjectsAndKeys: errorMessage, @"error_message", @"fail", @"stat", nil]);
//                        }
//                        [MitimGlobalData hideLoadingPopup];
//                    });
//                }
//                else{
//                    MitimUser *user = [MitimUser getUser];
//                    if (data[@"result"][@"user_id"]){
//                        user.user_id = [data[@"result"][@"user_id"] integerValue];
//                    }
//                    if (data[@"result"][@"session_token"]){
//                        user.sessionToken = data[@"result"][@"session_token"];
//                    }
//                    [user save];
//                    
//                    NSArray *newParams = [self replaySessionTockenInParams:params];
//                    [self sendGetRequest:method params:newParams completionHandler:completionHandler];
//                }
//            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionHandler){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRecievNoInternetConnection object:[NSNumber numberWithBool:self.noInternetConnection]];
                    completionHandler(dict);
                }
            });
        }
    }];
    
    [dataTask resume];
}

- (NSArray *) replaySessionTockenInParams:(NSArray *)params {
    NSMutableArray *array = [NSMutableArray new];
    if (params) {
        for (NSDictionary *param in params){
            NSMutableDictionary *dict = [NSMutableDictionary new];
            if ([param[@"key"] isEqualToString:@"session_token"]) {
                dict[@"data"] = [MitimUser getUser].sessionToken;
            } else {
                dict[@"data"] = param[@"data"];
            }
            dict[@"key"] = param[@"key"];
            [array addObject:dict];
        }
    }
    return array;
}

- (void) sendContactInfoVerificationRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"requestcontactinfoverification" params:params completionHandler:completionHandler];
}

- (void)sendManualBusinessClaimRequest:(NSArray *)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"requestmanualbusinessclaim" params:params completionHandler:completionHandler];
}

- (void) sendVerifyContactInfoRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"verifycontactinfo" params:params completionHandler:completionHandler];
}

- (void) sendChangePasswordRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"changepassword" params:params completionHandler:completionHandler];
}

- (void) sendWriteVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"writevouch" params:params completionHandler:completionHandler];
    
}

- (void) sendDeleteVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"deletevouch" params:params completionHandler:completionHandler];
}

- (void) sendGetBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"getbusiness" params:params completionHandler:completionHandler];
}

- (void) sendDeleteBusinessImageRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"deleteimage" params:params completionHandler:completionHandler];
}

- (void) sendGetVouchesForBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"getvouchesforbusiness" params:params completionHandler:completionHandler];
}

- (void) sendGetVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"getvouch" params:params completionHandler:completionHandler];
}

- (void) sendCheckForDuplicateUserRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"checkforduplicateuser" params:params completionHandler:completionHandler];
}

- (void) sendPasswordResetRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"sendpasswordresetrequest" params:params completionHandler:completionHandler];
}

- (void) sendNotifyEventRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"notifyevent" params:params completionHandler:completionHandler];
}

- (void) sendGetActivityFeedRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendRequest:@"getactivityfeed" params:params completionHandler:completionHandler];
}

- (void) sendGetSubcategoriesOrServicesRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler{
    [self sendGetRequest:@"getsubcategoriesorservices" params:params completionHandler:completionHandler];
}

- (void) sendWriteBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"writebusiness" params:params completionHandler:completionHandler];
}

- (void) sendChangeBusinessActiveStatusRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"changebusinessactivestatus" params:params completionHandler:completionHandler];
}

- (void) sendSuggestBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"suggestbusiness" params:params completionHandler:completionHandler];
}


- (void) sendSuggestServiceRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"suggestservice" params:params completionHandler:completionHandler];
}

- (void) sendVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"sendvouchrequests" params:params completionHandler:completionHandler];
}

- (void) sendGetBusinessReportRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"getbusinessreport" params:params completionHandler:completionHandler];
}

- (void) sendGetVouchForBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"getvouchrequestsforbusiness" params:params completionHandler:completionHandler];
}

- (void) sendGetBusinessUsersRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"getbusinessusers" params:params completionHandler:completionHandler];
}

- (void) sendGetBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"getbusinessuser" params:params completionHandler:completionHandler];
}

- (void) sendDeleteBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"deletebusinessuser" params:params completionHandler:completionHandler];
}

- (void) sendAddBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"addbusinessuser" params:params completionHandler:completionHandler];
}

- (void) sendUpdateBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler {
    [self sendRequest:@"updatebusinessuser" params:params completionHandler:completionHandler];
}

- (void) sendDeleteUserRequests:(NSString *)userId completionHandler:(NetworkControllerComplete)completionHandler {
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"user_id", @"key", userId, @"data", nil]];
    [self sendRequest:@"deleteuser" params:params completionHandler:completionHandler];
}

@end
