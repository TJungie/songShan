//
//  JJTabBarButton.h
//  150909-weibo
//
//  Created by TJJ on 15/9/9.
//  Copyright (c) 2015年 TJJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJTabBarButton : UIButton

//返回tabBarButton实例
+(instancetype)tabBarButtonWithItem:(UITabBarItem*)item;

//tabbar按钮数据信息
@property (nonatomic,strong) UITabBarItem *item;

@end
