//
//  BaseViewModelProtocol.h
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpRequest;
@protocol BaseModelProtocol;
@protocol BaseViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id<BaseModelProtocol>)model;
/**
 *  初始化
 */
- (void)viewModelInitialize;

@end

