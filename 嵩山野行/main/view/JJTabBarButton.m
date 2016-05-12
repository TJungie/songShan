//
//  JJTabBarButton.m
//  150909-weibo
//
//  Created by TJJ on 15/9/9.
//  Copyright (c) 2015年 TJJ. All rights reserved.
//
#define JJFont 15
#import "JJTabBarButton.h"
//#import "UIImage+Resizable.h"
@interface JJTabBarButton()
@property (nonatomic,weak) UIButton *bageBtn;
@end
@implementation JJTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        //设置字体样式
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font =[UIFont systemFontOfSize:12];
        
        //添加bage按钮
        
//        UIButton *bageBtn=[[UIButton alloc]init];
//        bageBtn.titleLabel.font=[UIFont systemFontOfSize:JJFont];
//        bageBtn.hidden=YES;
//        bageBtn.userInteractionEnabled=NO;
//        bageBtn.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
//        [self addSubview:bageBtn];
//        self.bageBtn =bageBtn;
//       

    }
    
    return self;
}

//初始化tabBarButton
+(instancetype)tabBarButtonWithItem:(UITabBarItem*)item{
    
    JJTabBarButton *btn=[[JJTabBarButton alloc]init];
    
   // btn.backgroundColor = [UIColor redColor];
    
    btn.item =item;
    
    //设置按钮图片
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectedImage forState:UIControlStateSelected];
    //设置按钮文字
    [btn setTitle:item.title forState:UIControlStateNormal];
    //设置文字颜色
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

    return btn;
}

//去除高亮状态
- (void)setHighlighted:(BOOL)highlighted {
}
//重写按钮图片frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageW=30;
    CGFloat imageH=30;
    CGFloat imageX=(self.frame.size.width-imageW)*0.5;
    CGFloat imageY=0;

    CGRect rect =CGRectMake(imageX, imageY, imageW, imageH);
    
    return rect;
}

//重写按钮文字frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat lableX=0;
    CGFloat lableY=CGRectGetMaxY(self.imageView.frame);
    CGFloat lableW=self.frame.size.width;
    CGFloat lableH=CGRectGetHeight(self.frame)-lableY;

    CGRect rect=CGRectMake(lableX, lableY, lableW, lableH);
    return  rect;
}

//-(void)setItem:(UITabBarItem *)item{
//    
//        _item=item;
//    
//    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
//
//}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    
//    //设置bageBtn文字
//    if (self.item.badgeValue && [self.item.badgeValue intValue]!=0) {
//        self.bageBtn.hidden=NO;
//    [self.bageBtn setTitle:self.item.badgeValue forState:UIControlStateNormal];
//        //设置bageBtn背景图片
//        [self.bageBtn setBackgroundImage:[UIImage resizableImage:@"main_badge_os7"] forState:UIControlStateNormal];
//        
//        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//        
//        dic[NSFontAttributeName] =[UIFont systemFontOfSize:JJFont];
//        
//        //设置frame
//        
//        CGFloat bageW=[self.item.badgeValue sizeWithAttributes:dic].width+10;
//        if (self.item.badgeValue.length==1) {
//            bageW=20;
//        }
//        
//        CGFloat bageH=20;
//        
//        CGFloat bageX=self.frame.size.width-bageW+0;
//        CGFloat bageY=0;
//        
//        self.bageBtn.frame=CGRectMake(bageX, bageY, bageW, bageH);
//    }else{
//        
//        self.bageBtn.hidden=YES;
//    }
//
//    
//}


@end
