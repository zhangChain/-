//
//  MainTabController.m
//  Demo
//
//  Created by zhanghang on 2020/11/15.
//

#import "MainTabController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
@interface MainTabController ()

@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:[HomeViewController new] title:@"首页" image:@"tabbar_home"];
    [self addChildViewController:[MineViewController new] title:@"我的" image:@"tabbar_mine"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image
{
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[image stringByAppendingString:@"_sel"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:childController];
    navi.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [self addChildViewController:navi];
    
}
@end
