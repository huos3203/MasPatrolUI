//
//  LocationManager.m
//  Recommend
//
//  Created by huoshuguang on 15/6/22.
//  Copyright (c) 2015年 Recommend. All rights reserved.
//

#import "JHLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@implementation JHLocation

@end

@implementation JHLocationManager


-(instancetype)init
{
    
    if (self = [super init]) {
        //定位服务管理对象初始化
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //定位精度10m
        _manager.distanceFilter = 100.0f;  //移动100m之后，重新定位
    }
    return self;
}
-(void)triggerLocationServices
{
    if ([CLLocationManager locationServicesEnabled]) {
        
        if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_manager requestWhenInUseAuthorization];
        }
        else
        {
            [_manager startUpdatingLocation];
        }
    }
    else
    {
        [self requestLocationServicesEnabled];
    }
}

-(void)requestLocationServicesEnabled
{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized:
            // ...
            break;
        case kCLAuthorizationStatusNotDetermined:
            [_manager requestAlwaysAuthorization];
            break;
        case (kCLAuthorizationStatusAuthorizedWhenInUse,kCLAuthorizationStatusRestricted, kCLAuthorizationStatusDenied):
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Background Location Access Disabled" message:@"In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            
            UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"Open Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if (url) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            
            [alertController addAction:openAction];
            [(UIViewController *)_delegate presentViewController:alertController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark -  实现访问地理位置权限的协议方法
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_manager startUpdatingLocation];
    }else{
        [_delegate updateCurrentLocationFail:nil];
    }
}

#pragma mark Core Location委托方法用于实现位置的更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currLocation = [locations lastObject];
    [self reverseGeocde];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
    [_delegate updateCurrentLocationFail:error.localizedDescription];
}

-(void)reverseGeocde
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:_currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = placemarks[0];
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            JHLocation *location = [JHLocation new];
            location.city = city;
            location.subLocality = placemark.subLocality;
            location.address = placemark.name;
            location.latitude = _currLocation.coordinate.latitude;
            location.longitude = _currLocation.coordinate.longitude;
            [_delegate updateCurrentLocation:location];
        }else{
            [_delegate updateCurrentLocationFail:error.localizedDescription];
        }
    }];
}

-(void)geocodeQuery:(NSString *)locationDescription
{
    if (locationDescription == nil || [locationDescription length] == 0) {
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:locationDescription completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"查询记录数：%lu",(unsigned long)[placemarks count]);
        if ([placemarks count] > 0) {
            CLPlacemark* placemark = placemarks[0];
            
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            NSString* strCoordinate  = [NSString stringWithFormat:@"经度:%3.5f \n纬度:%3.5f",coordinate.latitude, coordinate.longitude];
            
            NSDictionary *addressDictionary =  placemark.addressDictionary;
            
            NSString *address = [addressDictionary
                                 objectForKey:(NSString *)kABPersonAddressStreetKey];
            address = address == nil ? @"": address;
            
            NSString *state = [addressDictionary
                               objectForKey:(NSString *)kABPersonAddressStateKey];
            state = state == nil ? @"": state;
            
            NSString *city = [addressDictionary
                              objectForKey:(NSString *)kABPersonAddressCityKey];
            city = city == nil ? @"": city;
            //TODO:根据位置描述定位地理位置后，更新UI
            //            [_delegate updateCurrentLocation:city];
        }
    }];
}
@end
