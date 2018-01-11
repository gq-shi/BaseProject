//
//  BaseTableViewProtocol.h
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "BaseViewProtocol.h"

@protocol BaseTableViewProtocol <BaseViewProtocol>
+(instancetype)creatTableWithStyle:(UITableViewStyle)tableViewStyle viewModel:(id<BaseViewModelProtocol>)viewModel;
-(instancetype)initWithTableViewStyle:(UITableViewStyle)style viewModel:(id<BaseViewModelProtocol>)viewModel;
@end

