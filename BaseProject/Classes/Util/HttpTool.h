//  HttpTool.h
//  网络请求封装
//  mtxz
//  Created by 史国强 on 17/1/13.
//  Copyright © 2017年 hljc. All rights reserved.
//  网络请求工具类：负责整个项目的所有HTTP请求

#import <Foundation/Foundation.h>
#import "HttpManager.h"
#import <ReactiveObjC/RACTuple.h>
@interface HttpTool : NSObject
/**
格式化请求结果
 *  @param responseObj 网络返回结果
 *  @param isNeedShowError 上层传入的是否需要弹出信息
 */
@property (nonatomic, copy) RACTuple*(^configerResultBlock)(id responseObj,BOOL isNeedShowError);
/**
 配置全局base请求参数
 *  @param parmas     请求参数
 *  return            添加base参数后的请求参数
 */
@property (nonatomic, copy) NSDictionary *(^configerRequestParmasBlock)(NSDictionary *parmas);
/**
 网络请求fail后需要做的操作
 *  @param error     fail error
 *  @param isNeedShowError 上层传入的是否需要弹出信息
 */
@property (nonatomic, copy) void(^configerRequestFailBlock)(NSError *error,BOOL isNeedShowError);
+(instancetype)shareTool;
/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param isNeedShow  返回error是否需要请求管理类弹出错误信息
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params isNeedShowErrorMessage:(BOOL)isNeedShow success:(void (^)(id responseObj,BOOL isSuccess))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param isNeedShow  返回error是否需要请求管理类弹出错误信息
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params isNeedShowErrorMessage:(BOOL)isNeedShow success:(void (^)(id responseObj,BOOL isSuccess))success failure:(void (^)(NSError *error))failure;

/**
 发送一个post请求

 @param url 请求路径
 @param params 请求参数
 @param isCache 是否缓存
 @param isNeedShow 返回error是否需要请求管理类弹出错误信息
 @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)post:(NSString *)url params:(NSDictionary *)params isCache:(BOOL)isCache isNeedShowErrorMessage:(BOOL)isNeedShow success:(void (^)(id,BOOL))success failure:(void (^)(NSError *))failure;
/**
 formdata 图片上传

 @param model 数据模型
 @param isNeedShow 返回error是否需要请求管理类弹出错误信息
 @param progress 上传进度回调
 @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)putUpLoadModel:(HttpUpLoadModel *)model isNeedShowErrorMessage:(BOOL)isNeedShow progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObj,BOOL isSuccess))success failure:(void (^)(NSError *error))failure;
@end
