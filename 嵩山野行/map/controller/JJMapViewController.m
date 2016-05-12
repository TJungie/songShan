//
//  JJMapViewController.m
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JJMapViewController.h"
#import "JJStatus.h"
#import "FMDB.h"
#import "AppDelegate.h"
#import "JJDataBase.h"
@interface JJMapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *loactionBtn;
@property (nonatomic, strong) UILabel *centerAddress;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) NSMutableArray *statusArray;
- (IBAction)clickLocationBtn;

@end

@implementation JJMapViewController

- (NSMutableArray *)statusArray {
    if (_statusArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _statusArray = arr;
    }
    return _statusArray;
}

//点击左下角locationBtn按钮显示用户位置
- (IBAction)clickLocationBtn {
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置头部标题
    self.title = @"地图";
    //设置locationBtn按钮样式
    self.loactionBtn.layer.cornerRadius = self.loactionBtn.bounds.size.width*0.5;
    self.loactionBtn.clipsToBounds = YES;
    
    //设置地图代理
    self.mapView.delegate = self;
    //设置追踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置定位图标
    _centerButton = [[UIButton alloc] init];
    _centerButton.frame = CGRectMake(0, 0, 28, 28);
    _centerButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, self.mapView.center.y-7);
    [_centerButton setImage:[UIImage imageNamed:@"radar_icon_location"] forState:UIControlStateNormal];
    [self.view addSubview:_centerButton];
    //
    self.centerAddress = [[UILabel alloc] init];
    [self.view addSubview:self.centerAddress];
    self.centerAddress.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30);
    self.centerAddress.backgroundColor = [UIColor whiteColor];
    self.centerAddress.textColor = [UIColor blackColor];
    self.centerAddress.textAlignment = NSTextAlignmentCenter;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    // 反地理编码；根据经纬度查找地名
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) {
            NSLog(@"找不到该位置");
            return;
        }
        // 当前地标
        CLPlacemark *pm = [placemarks firstObject];
        // 区域名称
        userLocation.title = pm.locality;
        // 详细名称
        userLocation.subtitle = pm.name;

    }];
    
    //保存位置信息
    [self saveLocationData:(MKUserLocation*)userLocation];
}

//区域改变打印地图中点坐标
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {

    CLLocationCoordinate2D cenCoor = mapView.centerCoordinate;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:cenCoor.latitude longitude:cenCoor.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 反地理编码；根据经纬度查找地名
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) {
            NSLog(@"找不到该位置");
            return;
        }
        // 当前地标
        CLPlacemark *pm = [placemarks firstObject];
        self.centerAddress.text = pm.subLocality;
        
    }];
    
    
   
}

//保存位置信息
- (void)saveLocationData:(MKUserLocation*)userLocation {

    //创建位置信息
    NSMutableDictionary *statusDic = [NSMutableDictionary dictionary];
    
    //海拔高度
    CLLocationDistance shareAltitude = userLocation.location.altitude;
    statusDic[@"shareAltitude"] = [NSString stringWithFormat:@"%0.3f",shareAltitude];
    
    //经度
    CLLocationDistance shareLongitude = userLocation.location.coordinate.longitude;
    statusDic[@"shareLongitude"] = [NSString stringWithFormat:@"%0.3f",shareLongitude];
    
    //纬度
    CLLocationDistance shareLatitude = userLocation.location.coordinate.latitude;
    statusDic[@"shareLatitude"] = [NSString stringWithFormat:@"%0.3f",shareLatitude];
    
    //时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSString *dateNow = [formatter stringFromDate:[NSDate date]];
    statusDic[@"shareTime"] = dateNow;
    
    //位置
    statusDic[@"shareLocation"] = userLocation.title;
    
    //照片
    statusDic[@"shareImage"] = @"";
    
    NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:statusDic];
    //存入数据库
    [[JJDataBase ShareDataBase].db executeUpdate:@"insert into shareStatus (status) values (?);",statusData];
    
    self.label1.text = statusDic[@"shareLatitude"];
    self.label2.text = statusDic[@"shareLongitude"];
    self.label3.text = statusDic[@"shareAltitude"];
}
@end
