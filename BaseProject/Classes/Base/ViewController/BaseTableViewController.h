//
//  BaseTableViewController.h
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"
@interface BaseTableViewController : BaseViewController
@property (nonatomic, weak, readonly) BaseTableView *tableView;
+(instancetype)creatTableViewControllerWithStyle:(UITableViewStyle)tableViewStyle viewModel:(id<BaseViewModelProtocol>)viewModel;
-(instancetype)initWithTableViewStyle:(UITableViewStyle)style viewModel:(id<BaseViewModelProtocol>)viewModel;
@end
