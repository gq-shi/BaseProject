//
//  BaseViewProtocol.h
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewModelProtocol;
@protocol BaseViewProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;
- (void)bindViewModel;
- (void)setupViews;
- (void)addReturnKeyBoard;
@end

