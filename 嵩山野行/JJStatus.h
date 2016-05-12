//
//  JJStatus.h
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJStatus : NSObject
@property (nonatomic, copy) NSString *shareImage;
//分享时间
@property (nonatomic, copy) NSString *shareTime;
//分享地点
@property (nonatomic, copy) NSString *shareLocation;
//分享地点经度
@property (nonatomic, copy) NSString *shareLongitude;
//分享地点纬度
@property (nonatomic, copy) NSString *shareLatitude;
//分享地点海拔高度
@property (nonatomic, copy) NSString *shareAltitude;

+ (instancetype)statusWithDic:(NSDictionary*)dic;
- (instancetype)initWithDic:(NSDictionary*)dic;
@end
