//
//  JJTabBar.h
//  150909-weibo
//
//  Created by TJJ on 15/9/9.
//  Copyright (c) 2015年 TJJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJTabBar;

@protocol JJTabBarDelegate <NSObject>
@optional
-(void)tabBar:(JJTabBar*)tabBar clickWithBtn:(UIButton*)btn;
-(void)tabBar:(JJTabBar*)tabBar from:(int)from to:(int)to;
-(void)clickPlusBtnWithTabBar:(JJTabBar*)tabBar;
@end

@interface JJTabBar : UIView

@property (nonatomic,assign) id<JJTabBarDelegate> delegate;
//根据传进来的item数据设置按钮
- (void)buttonWithItem:(UITabBarItem*)item;

@end
