//
//  AppDelegate.m
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

//融云
#define RCAppKey @"p5tvi9dstg024"
#define RCAppSecret @"ojNt4CDTcdpwt"
#define RCAppToken @"W8iNdgPjJOAX8KcSLJ3CdRc8NonwJ+UyLYQ1NzvXaf/z/o3RwBy3btjlh/r39nFjuClUlNAul00hyAmASLsvOFltzwsW2c8TMcz2u+TI3DhcpzldcIB/VQ=="



#import "AppDelegate.h"
#import "FMDB.h"
#import <Foundation/Foundation.h>
#import "JJDataBase.h"
#import <CoreLocation/CoreLocation.h>
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
@interface AppDelegate ()
@property (strong, nonatomic) CLLocationManager *locationMng;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[JJDataBase ShareDataBase] open];
    
    //定位
    //向用户申请访问位置权限
    if ([self.locationMng respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationMng requestAlwaysAuthorization];
    }
    //后台不被挂起
    [self.locationMng setPausesLocationUpdatesAutomatically:NO];
    [self.locationMng setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置
//    
    self.locationMng.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    
//    self.locationMng.distanceFilter = 50;
    
    //开始定位
    [self.locationMng startUpdatingLocation];
    
    //注册融云appKey
    [[RCIM sharedRCIM] initWithAppKey:RCAppKey];
    
    //连接融云服务器
    
    [[RCIM sharedRCIM] connectWithToken:RCAppToken success:^(NSString *userId) {
        NSLog(@"连接成功--%@",userId);
    } error:^(RCConnectErrorCode status) {
         NSLog(@"连接失败--%ld",(long)status);
    } tokenIncorrect:^{
        
        NSLog(@"token错误");
        
    }];
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
   // [[JJDataBase ShareDataBase] close];
}

- (CLLocationManager *)locationMng {
    if (_locationMng == nil) {
        _locationMng = [[CLLocationManager alloc] init];
    }
    return _locationMng;
}
@end
