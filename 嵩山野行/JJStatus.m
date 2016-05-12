//
//  JJStatus.m
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import "JJStatus.h"

@implementation JJStatus

+ (instancetype)statusWithDic:(NSDictionary*)dic {

    return [[JJStatus alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary*)dic {
    if (self = [super init]) {
    [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
