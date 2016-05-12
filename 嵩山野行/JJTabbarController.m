//
//  JJTabbarController.m
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import "JJTabbarController.h"
#import "JJTabBar.h"
#import "JJTabBarButton.h"
#import "JJPlusViewController.h"
#import "JJNavigationController.h"
#import "JJHomeViewController.h"
#import "JJDiscoverViewController.h"
#import "JJMapViewController.h"
#import "JJProfileViewController.h"

@interface JJTabbarController ()<JJTabBarDelegate>
//自定义tabbar
@property (nonatomic,weak) JJTabBar *customTabBar;
@property (nonatomic,strong) JJMapViewController *mapVC;
@property (nonatomic,strong) JJHomeViewController *homeVC;
@property (nonatomic,strong) JJDiscoverViewController *disVC;
@property (nonatomic,strong) JJProfileViewController *proVC;
@end

@implementation JJTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置自定义TabBar
    [self setupTabBar];
    
    //设置控制器
    for (JJNavigationController *Nav in self.viewControllers) {
        if ([Nav.topViewController isKindOfClass:[JJHomeViewController class]]) {
            [self settingViewController:Nav.topViewController buttonWithImageName:@"tabbar_home_os7" selectedName:@"tabbar_home_selected_os7" title:@"首页"];
            self.homeVC = (JJHomeViewController*)Nav.topViewController;
        }else if ([Nav.topViewController isKindOfClass:[JJMapViewController class]]){
            [self settingViewController:Nav.topViewController buttonWithImageName:@"tabbar_message_center_os7" selectedName:@"tabbar_message_center_selected_os7" title:@"地图"];
            self.mapVC = (JJMapViewController*)Nav.topViewController;
        }else if ([Nav.topViewController isKindOfClass:[JJDiscoverViewController class]]){
            [self settingViewController:Nav.topViewController buttonWithImageName:@"tabbar_discover_os7" selectedName:@"tabbar_discover_selected_os7" title:@"发现"];
            self.disVC = (JJDiscoverViewController*)Nav.topViewController;
        }else{
            [self settingViewController:Nav.topViewController buttonWithImageName:@"tabbar_profile_os7" selectedName:@"tabbar_profile_selected_os7" title:@"我"];
            self.proVC = (JJProfileViewController*)Nav.topViewController;
        }
    }
}


/**
 *  控制器view显示完毕调用，在此移除Tabbar自带子控件，添加自定义按钮
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //遍历Tabbar子控件
    for (UIView *child in self.tabBar.subviews) {
        //判断子控件类型
        if ([child isKindOfClass:[UIControl class]]) {
            //移除子控件
            [child removeFromSuperview];
        }
     }
}

//设置自定义TabBar
-(void)setupTabBar
{
    JJTabBar *tabBar =[[JJTabBar alloc]init];
    //设置背景
    tabBar.frame =self.tabBar.bounds;
    //添加到系统Tabbar
    [self.tabBar addSubview:tabBar];
    //设置代理
    tabBar.delegate =self;
    //成为控制器属性
    self.customTabBar =tabBar;
    
}

/**
 *  初始化控制器
 *
 *  @param vc           目标控制器
 *  @param imageName    普通状态图片
 *  @param selectedName 选中图片
 *  @param title        标题
 */
-(void)settingViewController:(UIViewController*)vc buttonWithImageName:(NSString*)imageName selectedName:(NSString*)selectedName title:(NSString*)title {
    vc.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage =[UIImage imageNamed:selectedName];
    
    //JJNavigationController *nav=[[JJNavigationController alloc]initWithRootViewController:vc];
    
    //[self addChildViewController:nav];
    
    [self.customTabBar buttonWithItem:vc.tabBarItem];
}

//点击加号按钮
-(void)clickPlusBtnWithTabBar:(JJTabBar*)tabBar
{
    //创建目标控制器
    JJPlusViewController *plusVc =[[JJPlusViewController alloc]init];
    //包装导航控制器
    JJNavigationController *navC =[[JJNavigationController alloc]initWithRootViewController:plusVc];
    //跳转
    [self presentViewController:navC animated:YES completion:nil];
}

//点击tabbar按钮
-(void)tabBar:(JJTabBar*)tabBar clickWithBtn:(UIButton*)btn{
  
    
    
}

- (void)tabBar:(JJTabBar*)tabBar from:(int)from to:(int)to {
    
    self.selectedIndex = to;
    
    if (to==0&&from==0) {
        
    [self.homeVC refresh];
        
    }
    
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
