//
//  BaseTableViewCellProtocol.h
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseTableViewCellProtocol <NSObject>
@optional
- (void)setupViews;
- (void)bindViewModel;
@end

