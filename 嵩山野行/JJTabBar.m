//
//  JJTabBar.m
//  150909-weibo
//
//  Created by TJJ on 15/9/9.
//  Copyright (c) 2015年 TJJ. All rights reserved.
//

#import "JJTabBar.h"
#import "JJTabBarButton.h"
@interface JJTabBar()
@property (nonatomic,strong) NSMutableArray *tabBarButtons;
@property (nonatomic,weak) UIButton *selBtn;
@property (nonatomic,weak) UIButton *plusButton;
@end

@implementation JJTabBar

- (NSMutableArray *)tabBarButtons{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        //添加加号按钮
        [self addPlus];
    }
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    //布局customTabBar子控件
    for (int i = 0; i<self.tabBarButtons.count; i++) {
        //从数组中取出按钮
        JJTabBarButton *btn = self.tabBarButtons[i];
        //设置按钮frame
        CGFloat btnW= self.bounds.size.width/(self.tabBarButtons.count+1);
        CGFloat btnH= self.bounds.size.height;
        CGFloat btnX= btnW*i;
        CGFloat btnY= 0;
        if (i>1) {
            btnX+=btnW;
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //绑定tag
        btn.tag = i;
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 0) {
            [self btnClick:btn];
        }
    }

    //设置加号按钮frame
    self.plusButton.frame = CGRectMake(0, 0, 64, 44);
    
    self.plusButton.center = self.center;
}

//监听加号按钮点击
- (void)plusButtonClick {
    //通知代理执行逻辑
    if ([self.delegate respondsToSelector:@selector(clickPlusBtnWithTabBar:)]) {
        
        [self.delegate clickPlusBtnWithTabBar:self];
    }
    //取消按钮选中
   // self.selBtn.selected=NO;
    
}


/**
 *  监听Tabbar按钮点击
 *
 *  @param btn 选中的按钮
 */
- (void)btnClick:(UIButton*)btn {
    //通知代理执行逻辑
//    
//    if ([self.delegate respondsToSelector:@selector(tabBar:clickWithBtn:)]) {
//        
//        [self.delegate tabBar:self clickWithBtn:btn];
//        
//    }
    
    if ([self.delegate respondsToSelector:@selector(tabBar:from:to:)]) {
        
        [self.delegate tabBar:self from:(int)self.selBtn.tag to:(int)btn.tag];
        
    }

    //上个按钮取消选中
    self.selBtn.selected = NO;
    //选中当前按钮
    btn.selected = YES;
    //保存当前选中按钮
    self.selBtn = btn;
}

- (void)buttonWithItem:(UITabBarItem*)item {
    //创建按钮
    JJTabBarButton *homeBtn =[JJTabBarButton tabBarButtonWithItem:item];
    //添加按钮到tabbar
    [self addSubview:homeBtn];
    //添加按钮到数组
    [self.tabBarButtons addObject:homeBtn];
}

//3、添加加号按钮
-(void)addPlus{
    UIButton *plusBtn =[[UIButton alloc]init];

    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];

    [self addSubview:plusBtn];
    
    self.plusButton =plusBtn;
    
    [plusBtn addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchDown];
}
@end
