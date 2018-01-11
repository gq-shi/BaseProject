//
//  BaseTableView.m
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "BaseTableView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation BaseTableView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupBaseTableView];
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}
#pragma mark - BaseTableViewProtocol
+(instancetype)creatTableWithStyle:(UITableViewStyle)tableViewStyle viewModel:(id<BaseViewModelProtocol>)viewModel{
    return [[BaseTableView alloc] initWithTableViewStyle:tableViewStyle viewModel:viewModel];
}

-(instancetype)initWithTableViewStyle:(UITableViewStyle)style viewModel:(id<BaseViewModelProtocol>)viewModel{
    if (self = [super initWithFrame:CGRectZero style:style]) {
        [self setupBaseTableView];
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

-(void)setupBaseTableView{
    self.tableFooterView = [UIView new];
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = UITableViewAutomaticDimension;
    self.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark - BaseViewProtocol
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    return [self initWithTableViewStyle:UITableViewStyleGrouped viewModel:viewModel];
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

@end
