//
//  BaseTabBarController.m
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
@implementation BaseTabBarVCItem
@end

@interface BaseTabBarController ()
@property (nonatomic, strong) NSMutableArray *VCArr;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupChildViewController:(BaseViewController *)childVc title:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage
{
    childVc.tabBarItem =   [[UITabBarItem alloc]initWithTitle:title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *navc = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    childVc.navigationItem.title = title;
    [self.VCArr addObject:navc];
}

-(void)setupBarItemArr:(NSArray<BaseTabBarVCItem *> *)itemArr{
    for (BaseTabBarVCItem *item in itemArr) {
        [self setupChildViewController:item.VC title:item.title normalImage:item.normalImage selectedImage:item.selectedImage];
    }
    self.viewControllers = self.VCArr;
}

-(NSMutableArray *)VCArr{
    if (!_VCArr) {
        _VCArr = @[].mutableCopy;
    }
    return _VCArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
