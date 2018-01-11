//
//  BaseTableViewController.m
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "BaseTableViewController.h"
@implementation BaseTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
}

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    return [self initWithTableViewStyle:UITableViewStyleGrouped viewModel:viewModel];
}

-(instancetype)initWithTableViewStyle:(UITableViewStyle)style viewModel:(id<BaseViewModelProtocol>)viewModel{
    if (self = [super initWithViewModel:viewModel]) {
        [self creatTableViewWithStyle:style viewModel:viewModel];
    }
    return self;
}

-(void)creatTableViewWithStyle:(UITableViewStyle)style viewModel:(id<BaseViewModelProtocol>)viewModel{
    BaseTableView *tableView = [[BaseTableView alloc] initWithTableViewStyle:style viewModel:viewModel];
    _tableView = tableView;
    [self.view addSubview:tableView];
    tableView.frame = self.view.bounds;
}

+(instancetype)creatTableViewControllerWithStyle:(UITableViewStyle)tableViewStyle viewModel:(id<BaseViewModelProtocol>)viewModel{
    return [[BaseTableViewController alloc] initWithTableViewStyle:tableViewStyle viewModel:viewModel];
}


@end
