//
//  JJstatusCell.h
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJStatus;

@interface JJstatusCell : UITableViewCell
//分享数据
@property (nonatomic, strong) JJStatus *status;
//获取cell实例
+ (JJstatusCell*)cellWithTableView:(UITableView*)tableView;

@end
