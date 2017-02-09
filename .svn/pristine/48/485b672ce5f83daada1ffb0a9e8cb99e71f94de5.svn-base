//
//  BBQNetAPIClient.h
//  BBQ
//
//  Created by 朱琨 on 15/10/28.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef NS_ENUM(NSUInteger, NetworkMethod) {
    NetworkMethodGet,
    NetworkMethodPost,
    NetworkMethodPut,
    NetworkMethodDelete,
};
@interface BBQNetAPIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedJsonClient;
+ (instancetype)changeJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

//
//- (void)reportIllegalContentWithType:(IllegalContentType)type
//                          withParams:(NSDictionary*)params;

- (void)uploadImage:(UIImage *)image path:(NSString *)path name:(NSString *)name
       successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
       failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      progerssBlock:(void (^)(CGFloat progressValue))progress;

@end
