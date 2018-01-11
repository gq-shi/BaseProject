//
//  HttpManager.m
//  mtxz
//
//  Created by 史国强 on 16/9/26.
//  Copyright © 2016年 hljc. All rights reserved.
//
#import "HttpManager.h"

@implementation HttpUpLoadModel
-(NSString *)name{
    if (kIsEmptyString(_name)) {
        _name = @"uploadfile";
    }
    return _name;
}
-(NSString *)fileName{
    if (kIsEmptyString(_fileName)) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        _fileName = [NSString stringWithFormat:@"%@.jpg", str];
    }
    return _fileName;
}
-(NSString *)mimeType{
    if (kIsEmptyString(_mimeType)) {
        _mimeType = @"image/jpg";
    }
    return _mimeType;
}
+(instancetype)creatUpLoadModelWithUrlStr:(NSString *)urlStr parmas:(NSDictionary *)parmas imageData:(id)imageData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType{
    HttpUpLoadModel *model = [HttpUpLoadModel new];
    model.urlStr = kGetSafeString(urlStr);
    model.parmas = parmas;
    model.imageData = imageData;
    model.name = name;
    model.fileName = fileName;
    model.mimeType = mimeType;
    return model;
}

-(void)transformData:(id<AFMultipartFormData>  _Nonnull)formData{
    if (kIsEmptyObject(self.imageData)) {
        return;
    }
    if ([self.imageData isKindOfClass:[UIImage class]]) {
        NSData *data = UIImageJPEGRepresentation(self.imageData, 0.5);
        [formData appendPartWithFileData:data name:self.name fileName:self.fileName mimeType:self.mimeType];
    } else if ([self.imageData isKindOfClass:[NSString class]]) {
        NSString *imageStr = self.imageData;
        NSURL *url = [NSURL fileURLWithPath:imageStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [formData appendPartWithFileData:data name:self.name fileName:self.fileName mimeType:self.mimeType];

//        [formData appendPartWithFileURL:url name:self.name error:nil];
    } else if ([self.imageData isKindOfClass:[NSData class]]){
        [formData appendPartWithFileData:self.imageData name:self.name fileName:self.fileName mimeType:self.mimeType];
    } else if ([self.imageData isKindOfClass:[NSURL class]]) {
        [formData appendPartWithFileURL:self.imageData name:self.name error:nil];
    }
}
@end

static HttpManager *_httpManager;
static NSTimeInterval const kNormalTimeout = 30;
@interface HttpManager ()
@property(strong, nonatomic)AFHTTPSessionManager *manager;

@end

@implementation HttpManager

-(AFHTTPSessionManager *)getHttpSessionManager{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kGetSafeString(self.baseUrlStr)]];
    //mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/plain", @"text/javascript",@"text/xml", nil];
    manager.requestSerializer.timeoutInterval = kNormalTimeout;
    return manager;
}

+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpManager = [HttpManager new];
        _httpManager.manager = [_httpManager getHttpSessionManager];
        _httpManager.manager.requestSerializer.timeoutInterval = kNormalTimeout;
    });
    return _httpManager;
}

-(NSURLSessionDataTask *)postWithUrlStr:(NSString *)urlStr parmas:(NSDictionary *)parmas success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *task = [self.manager POST:urlStr ? urlStr :@"" parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    return task;
}
-(NSURLSessionDataTask *)getWithUrlStr:(NSString *)urlStr parmas:(NSDictionary *)parmas success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *task = [self.manager GET:urlStr ? urlStr : @"" parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    return task;
}

-(NSURLSessionDataTask *)putUpLoadModel:(HttpUpLoadModel *)model progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *task = [self.manager POST:model.urlStr parameters:model.parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [model transformData:formData];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    return task;
}


@end
