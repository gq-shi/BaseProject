//
//  BaseView.m
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "BaseView.h"
#import <ReactiveObjC/ReactiveObjC.h>
@implementation BaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (void)bindViewModel{}
- (void)setupViews{}
- (void)addReturnKeyBoard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    @weakify(self);
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}

-(void)dealloc{

}
@end
