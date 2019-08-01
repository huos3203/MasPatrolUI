//
//  LocationManager.h
//  Recommend
//
//  Created by huoshuguang on 15/6/22.
//  Copyright (c) 2015年 Recommend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
@interface JHLocation : NSObject

@property(assign,nonatomic)double latitude;   //纬
@property(assign,nonatomic)double longitude;  //经
@property(strong,nonatomic)NSString *city;
@property(strong,nonatomic)NSString *subLocality;
@property(strong,nonatomic)NSString *address;
@end
@protocol JHLocationManagerDelegate <NSObject>

@required
-(void)updateCurrentLocation:(Location *)location;
-(void)updateCurrentLocationFail:(NSString *)err;

@end
@interface JHLocationManager : NSObject<CLLocationManagerDelegate>

//获取定位的权限
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLLocation   *currLocation;
@property(nonatomic,weak)id<LocationManagerDelegate> delegate;


/**
 *  @author shuguang, 15-06-22 16:06:18
 *
 *  开启定位
 *
 *  @since 1.0
 */
-(void)triggerLocationServices;

/**
 *  @author shuguang, 15-06-22 14:06:33
 *  http://nshipster.cn/core-location-in-ios-8/
 
 *  在 iOS 8，取得权限和使用位置服务已经分成两个动作了。
 分别用两个不同的方法取得权限：requestWhenInUseAuthorization 和 requestAlwaysAuthorization。
 前者只能让应用在使用的时候有权获取位置数据；后者会得到跟之前 iOS 一样的后台位置服务。
 *  必须设置的info.plist
 这个值是一个纯文本的字符串，向用户说明了应用预期要使用位置服务:
 现在这个值被拆分成了两个不同的关键字
 1. NSLocationWhenInUseUsageDescription
 2. NSLocationAlwaysUsageDescription
 
 *  @since 1.0
 */
-(void)requestLocationServicesEnabled;

/**
 *  @author shuguang, 15-06-22 15:06:17
 *
 *  地址信息反编码
 *
 *  @since 1.0
 */
-(void)reverseGeocde;

/**
 *  @author shuguang, 15-06-22 16:06:37
 *
 *  根据地理位置描述关键字定位地理位置
 *
 *  @param locationDescription 关键字例如：城南
 *
 *  @since 1.0
 */
-(void)geocodeQuery:(NSString *)locationDescription;

@end
