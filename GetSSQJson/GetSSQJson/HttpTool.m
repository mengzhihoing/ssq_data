//
//  HttpTool.m
//  ProjectXmall
//
//  Created by zhihong meng on 2017/5/27.
//  Copyright © 2017年 yao liu. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking.h>

static AFHTTPSessionManager *manager;
static NSTimeInterval kTimeoutInterval = 20;

@implementation HttpTool

+ (AFHTTPSessionManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = kTimeoutInterval;
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //        ((AFJSONResponseSerializer*)manager.responseSerializer).removesKeysWithNullValues = YES;
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"device-source"];
//        [manager.requestSerializer setValue:[UDIDTool getUDID] forHTTPHeaderField:@"device-id"];
//        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"app-type"];
////        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json",@"text/plain", @"text/html",nil];
//
//
//        NSString *token = [UserDataTool getToken];
//
//        if (token) {
//            [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//        } else {
//            [self saveToken:nil];
//        }
//
      
        
        

    });

    return manager;
}

+ (void)saveToken:(NSString *)token {

    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
}

+ (void)clearToken {
    [self saveToken:nil];
}

+ (void)getWithUrl:(NSString *)url paras:(id)paras success:(void (^)(id))success failure:(void (^)(NSString *))failure {
    [[HttpTool shareManager] GET:url
        parameters:paras
        progress:^(NSProgress *_Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
//            NSLog(@"url=%@ 请求回来的结果是%@", url, responseObject);
            if (success) {

                NSInteger code = [responseObject[@"code"] integerValue];

                if (code == 0) {
                    success(responseObject);
                } else {

                    NSString *msg;

                    if (responseObject[@"msg"]) {
                        msg = responseObject[@"msg"];
                    }

                    NSString *errorMsg = [self getErrorMessageWithCode:code message:msg];

                    if (failure) {
                        failure(errorMsg);
                    }
                }
            }

        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
            NSInteger statusCode = response.statusCode;
            //                              NSLog(@"keyCode=%ld",statusCode);

           
                if (error) {
                    failure(error.localizedDescription);
                }
            
        }];
}

+ (void)postWithUrl:(NSString *)url paras:(id)paras success:(void (^)(id))success failure:(void (^)(NSString *))failure {

    //    NSLog(@"header=%@",manager.requestSerializer.HTTPRequestHeaders);

    [[HttpTool shareManager] POST:url
        parameters:paras
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            if (success) {

                NSInteger code = [responseObject[@"code"] integerValue];

                if (code == 200) {
                    success(responseObject);
                } else {

                    NSString *msg;

                    if (responseObject[@"msg"]) {
                        msg = responseObject[@"msg"];
                    }

                    NSString *errorMsg = [self getErrorMessageWithCode:code message:msg];

                    if (failure) {
                        failure(errorMsg);
                    }
                }
            }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSLog(@"url=%@ 请求回来的结果是%@", url, error);

            NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
            NSInteger statusCode = response.statusCode;
            //                              NSLog(@"keyCode=%ld",statusCode);


                if (error) {
                    failure(error.localizedDescription);
                }
            

        }];
}

/**
 
 200：成功
 500：系统异常
 501：参数错误
 602：没有sku记录
 603：验证码错误
 604：您发送的验证码次数过多，请稍后再试
 605：手机号已经被注册
 606：邮箱已经被注册
 607：手机号未注册
 608：邮箱未注册
 609：用户或密码错误
 613：用户或密码错误
 623：未能查询到相关信息
 */
+ (NSString *)getErrorMessageWithCode:(NSInteger)code message:(NSString *)msg {

    NSString *content = @"";

    switch (code) {
    case 500: {
        content = @"系统异常";
    } break;
    case 501: {
        content = @"参数错误";

    } break;
    case 602: {
        content = @"没有sku记录";

    } break;
    case 603: {
        content = @"验证码错误";

    } break;
    case 604: {
        content = @"操作过于频繁，请稍后重试";

    } break;
    case 605: {
        content = @"手机号已经被注册";

    } break;
    case 606: {
        content = @"邮箱已经被注册";

    } break;
    case 607: {
        content = @"该手机号尚未注册，请先注册";

    } break;
    case 608: {
        content = @"该邮箱号尚未注册，请先注册";

    } break;
    case 609: {
        content = @"密码和账户名不匹配，请重新输入";

    } break;

    case 613: {
        content = @"token失效，请重新登录";

    } break;

    case 623: {
        content = @"未能查询到相关信息";

    } break;

    default: {
        if (msg) {
            content = msg;
        } else {
            content = @"未知错误";
        }

    } break;
    }

    return content;
}


@end
