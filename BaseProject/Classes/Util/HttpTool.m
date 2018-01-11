//
//  HttpTool.m
//  mtxz
//
//  Created by 史国强 on 17/1/13.
//  Copyright © 2017年 hljc. All rights reserved.
//


#import "HttpTool.h"
#import <HYBHelperKit/NSDate+HYBHelperKit.h>
#import <YYCache/YYCache.h>
#import <MJExtension/MJExtension.h>
#import <HYBHelperKit/NSObject+HYBHelperKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
static HttpTool *_tool = nil;
@implementation HttpTool

+(instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [HttpTool new];
    });
    return _tool;
}
+ (void)get:(NSString *)url params:(NSDictionary *)params isNeedShowErrorMessage:(BOOL)isNeedShow success:(void (^)(id,BOOL))success failure:(void (^)(NSError *))failure
{
    HttpTool *tool = [HttpTool shareTool];
    if (tool.configerRequestParmasBlock) {
        params = tool.configerRequestParmasBlock(params);
    }
    [[HttpManager shareManager] getWithUrlStr:url parmas:params success:^(id responseObj) {
        BPLOG(@"%@",responseObj);
        if (success) {
            BOOL isSuccess = YES;
            if (tool.configerResultBlock) {
                RACTuple *tuple = [HttpTool shareTool].configerResultBlock([responseObj hyb_filterNullNil],isNeedShow);
                RACTupleUnpack(id result,NSNumber *successNumber) = tuple;
                responseObj = result;
                isSuccess = successNumber.boolValue;
            }
        }
    } failure:^(NSError *error) {
        BPLOG(@"%@",error.localizedDescription);
        if (failure) {
            failure(error);
        }
        if (tool.configerRequestFailBlock) {
            tool.configerRequestFailBlock(error, isNeedShow);
        } else {
            [self errorToast:isNeedShow error:error];
        }
    }];
}
+ (void)post:(NSString *)url params:(NSDictionary *)params isNeedShowErrorMessage:(BOOL)isNeedShow success:(void (^)(id,BOOL))success failure:(void (^)(NSError *))failure
{
    HttpTool *tool = [HttpTool shareTool];
    if (tool.configerRequestParmasBlock) {
        params = tool.configerRequestParmasBlock(params);
    }
    BPLOG(@"请求的URL为:%@\n请求的参数为：\n%@",url,params);
    [[HttpManager shareManager] postWithUrlStr:url parmas:params success:^(id responseObj) {
        BPLOG(@"URL为%@的返回结果为：\n%@",url,responseObj);
        if (success) {
            BOOL isSuccess = YES;
            if (tool.configerResultBlock) {
                RACTuple *tuple = [HttpTool shareTool].configerResultBlock([responseObj hyb_filterNullNil],isNeedShow);
                RACTupleUnpack(id result,NSNumber *successNumber) = tuple;
                responseObj = result;
                isSuccess = successNumber.boolValue;
            }
        }
    } failure:^(NSError *error) {
        BPLOG(@"URL为%@的请求失败信息为：%@",url,error.localizedDescription);
        if (failure) {
            failure(error);
        }
        if (tool.configerRequestFailBlock) {
            tool.configerRequestFailBlock(error, isNeedShow);
        } else {
            [self errorToast:isNeedShow error:error];
        }
    }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params isCache:(BOOL)isCache isNeedShowErrorMessage:(BOOL)isNeedShow success:(void (^)(id,BOOL))success failure:(void (^)(NSError *))failure{
    HttpTool *tool = [HttpTool shareTool];
    if (tool.configerRequestParmasBlock) {
        params = tool.configerRequestParmasBlock(params);
    }
    BPLOG(@"请求的URL为:%@\n请求的参数为：\n%@",url,params);
    [[HttpManager shareManager] postWithUrlStr:url parmas:params success:^(id responseObj) {
        BPLOG(@"URL为%@的返回结果为：\n%@",url,responseObj);
        if (success) {
            BOOL isSuccess = YES;
            if (tool.configerResultBlock) {
                RACTuple *tuple = [HttpTool shareTool].configerResultBlock([responseObj hyb_filterNullNil],isNeedShow);
                RACTupleUnpack(id result,NSNumber *successNumber) = tuple;
                responseObj = result;
                isSuccess = successNumber.boolValue;
            }
            success(responseObj,isSuccess);
            if (isCache && isSuccess && responseObj) {
                YYCache *cache = [YYCache cacheWithName:@"NETCACHE"];
                cache.diskCache.countLimit = 50;
                NSString *dictStr = [params mj_JSONString];
                NSString *key = [url stringByAppendingString:dictStr];
                [cache setObject:responseObj forKey:key];
            }

        }
    } failure:^(NSError *error) {
        BPLOG(@"URL为%@的请求失败信息为：%@",url,error.localizedDescription);
        if (isCache) {
            YYCache *cache = [YYCache cacheWithName:@"NETCACHE"];
            NSString *dictStr = [params mj_JSONString];
            NSString *key = [url stringByAppendingString:dictStr];
            id responseObj = [cache objectForKey:key];
            BOOL isSuccess = YES;
            if (tool.configerResultBlock) {
                RACTuple *tuple = [HttpTool shareTool].configerResultBlock([responseObj hyb_filterNullNil],isNeedShow);
                RACTupleUnpack(id result,NSNumber *successNumber) = tuple;
                responseObj = result;
                isSuccess = successNumber.boolValue;
            }
            if (isSuccess && responseObj) {
                success([responseObj hyb_filterNullNil],isSuccess);
                return;
            }
        }
        if (failure) {
            failure(error);
        }
        if (tool.configerRequestFailBlock) {
            tool.configerRequestFailBlock(error, isNeedShow);
        } else {
            [self errorToast:isNeedShow error:error];
        }
    }];
}

+(void)putUpLoadModel:(HttpUpLoadModel *)model isNeedShowErrorMessage:(BOOL)isNeedShow progress:(void (^)(NSProgress *))progress success:(void (^)(id,BOOL))success failure:(void (^)(NSError *))failure{
    HttpTool *tool = [HttpTool shareTool];
    if (tool.configerRequestParmasBlock) {
        NSMutableDictionary *mutableParams= model.parmas.mutableCopy;
        mutableParams = tool.configerRequestParmasBlock(mutableParams).mutableCopy;
        model.parmas = mutableParams;
    }
    BPLOG(@"请求的URL为:%@\n请求的参数为：\n%@",model.urlStr,model.parmas);
    [[HttpManager shareManager] putUpLoadModel:model progress:progress success:^(id responseObj) {
        BPLOG(@"URL为%@的返回结果为：\n%@",model.urlStr,responseObj);
        if (success) {
            BOOL isSuccess = YES;
            if (tool.configerResultBlock) {
                RACTuple *tuple = [HttpTool shareTool].configerResultBlock([responseObj hyb_filterNullNil],isNeedShow);
                RACTupleUnpack(id result,NSNumber *successNumber) = tuple;
                responseObj = result;
                isSuccess = successNumber.boolValue;
            }
            success(responseObj,isSuccess);
        }

    } failure:^(NSError *error) {
        BPLOG(@"URL为%@的请求失败信息为：%@",model.urlStr,error.localizedDescription);
        if (failure) {
            failure(error);
        }
        if (tool.configerRequestFailBlock) {
            tool.configerRequestFailBlock(error, isNeedShow);
        } else {
            [self errorToast:isNeedShow error:error];
        }
    }];
}

+(void)errorToast:(BOOL)isNeedShow error:(NSError *)error{
    if (!isNeedShow) {
        return;
    }
    NSString *message = @"网络错误";
    if (error.code == NSURLErrorTimedOut) {
        message = @"网络超时";
    } else if (error.code == NSURLErrorBadServerResponse){
        message = @"网络错误";
    }
    [SVProgressHUD showErrorWithStatus:message];
}
@end
