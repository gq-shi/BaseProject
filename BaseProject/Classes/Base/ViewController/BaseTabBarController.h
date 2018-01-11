//
//  BaseTabBarController.h
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface BaseTabBarVCItem :NSObject
@property (nonatomic, strong) BaseViewController *VC;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@end

@interface BaseTabBarController : UITabBarController
-(void)setupBarItemArr:(NSArray <BaseTabBarVCItem *>*)itemArr;
@end
