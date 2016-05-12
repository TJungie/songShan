//
//  JJDataBase.h
//  嵩山野行
//
//  Created by TianJJ on 16/2/20.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@interface JJDataBase : NSObject

@property (strong, nonatomic) FMDatabase *db;

+ (instancetype)ShareDataBase;

//- (void)createDataBase;

- (void)open;

- (void)close;

@end
