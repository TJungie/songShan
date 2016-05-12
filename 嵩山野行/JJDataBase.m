//
//  JJDataBase.m
//  嵩山野行
//
//  Created by TianJJ on 16/2/20.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import "JJDataBase.h"
#import "FMDB.h"
@interface JJDataBase ()
@end

@implementation JJDataBase

- (FMDatabase *)db {
    if (_db == nil) {
        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"shareStatus.sqlite"];
        

        _db = [[FMDatabase alloc] initWithPath:fileName];
    }
    return _db;
}

+ (instancetype)ShareDataBase {
    
   static JJDataBase *_instance;
    
   static dispatch_once_t oneToten;
    
    dispatch_once(&oneToten, ^{
        
        _instance = [[self alloc] init];

    });
    
    return _instance;

}

- (void)open {
    
     // 2.打开数据库
    if ( [self.db open] ) {
        NSLog(@"数据库打开成功");
        
        // 创表
        BOOL result = [self.db executeUpdate:@"create table if not exists shareStatus (id integer primary key autoincrement, status blob);"];
        
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    } else {
        NSLog(@"数据库打开失败");
    }

}

- (void)close {
 
    if ([self.db close]) {
        NSLog(@"关闭数据库");
    }else{
    
        NSLog(@"无法关闭数据库");
    }

}

@end
