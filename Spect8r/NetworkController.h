//
//  NetworkController.h
//  Vouchify
//
//  Created by Mykhailo Timashov on 3/9/16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkControllerComplete)(NSDictionary *data);
typedef void (^NetworkControllerUploadComplete)(BOOL complete);


@interface NetworkController : NSObject <NSURLSessionDelegate>

@property NSString *baseUrl;

@property (nonatomic, assign) BOOL noInternetConnection;

+ (NetworkController*) sharedController;
- (void) sendSignUpRequest:(NSString*)email password:(id)password firstName:(id)firstName lastName:(id)lastName address:(id)address fbUserId:(id)fbUserId fbUserToken:(id)fbUserToken completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendLoginRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendWriteVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendPhoneContactsRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendLogoutRequest;
- (void) sendGetUserConnectionsRequest:(NetworkControllerComplete)completionHandler;
- (void) sendContactInfoVerificationRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendVerifyContactInfoRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendChangePasswordRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetUserRequest:(NetworkControllerComplete)completionHandler;
- (void) sendGetUserRequest:(NSString*)userId completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
//- (void) sendGetVouchesRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetVouchesForBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetVouchesForUserRequest:(NSString*)userId completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendLocationRequest:(NSString*)locationText completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendServiceRequest:(NSString*)serviceText completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendAutocompleteBusinessSearchRequest:(NSString*)searchText completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendSearchBusinessesRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendDeleteVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendAutocompleteSearchRequest:(NSString*)searchText completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetVouchForBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendCheckForDuplicateUserRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendPasswordResetRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetSubcategoriesOrServicesRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendNotifyEventRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendWriteBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendSuggestBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendSuggestServiceRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetActivityFeedRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetServiceAreasRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendMediaUploadUrlRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendConfirmMediaUploadRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendLoginToBusinessRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendLoginToAdminRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendVouchRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetBusinessReportRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetBusinessUsersRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendChangeBusinessActiveStatusRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendGetBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler ;
- (void) sendUpdateBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendDeleteBusinessImageRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendAddBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendAutocompleteUsersSearchRequest:(NSString*)searchText completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendDeleteBusinessUserRequests:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;

- (void) sendManualBusinessClaimRequest:(NSArray*)params completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendDeleteUserRequests:(NSString *)userId completionHandler:(NetworkControllerComplete)completionHandler;
- (void) sendImageData:(NSData*)imageData toUrl:(NSString*) stringUrl completionHandler:(NetworkControllerUploadComplete)completionHandler;

@end
