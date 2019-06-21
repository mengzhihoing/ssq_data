//
//  HttpTool.h
//  ProjectXmall
//
//  Created by zhihong meng on 2017/5/27.
//  Copyright © 2017年 yao liu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AliyunOSSiOS/OSSService.h>

@interface HttpTool : NSObject

+ (void)getWithUrl:(NSString *)url paras:(id)paras success:(void (^)(id result))success failure:(void (^)(NSString *error))failure;

+ (void)postWithUrl:(NSString *)url paras:(id)paras success:(void (^)(id result))success failure:(void (^)(NSString *error))failure;

+ (void)uploadImage:(NSData *)imageData fileName:(NSString *)fileName success:(void (^)(id result))success failure:(void (^)(NSString *error))failure;

+ (void)saveToken:(NSString *)token;

+ (void)clearToken;

///**
// 上传图片到阿里云
//
// @param path 图片路径
// @param success 成功 返回url地址
// @param failure 失败
// */
//+ (void)uploadImageWithPath:(NSString *)path process:(OSSNetworkingUploadProgressBlock )process success:(void(^)(NSString *url))success failure:(void(^)(NSError *error))failure;

///**
// 语言切换
// */
//+ (void)languageChange;
//
///**
// 更新来源
// */
//+ (void)updateSource;

/**
 post 表单请求
 */
//+ (void)postFormDataWithUrl:(NSString *)url paras:(id )paras success:(void (^)(id result))success failure:(void (^)(NSString *error))failure;

@end
