//
//  TestLocationController.m
//  MasPatrolUI
//
//  Created by admin on 2019/7/18.
//  Copyright © 2019 com. All rights reserved.
//

#import "TestLocationController.h"
#import "LocationManager.h"

@interface TestLocationController ()<LocationManagerDelegate>

@end

@implementation TestLocationController
{
    LocationManager *_locationManager;
    UILabel *_addressLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _addressLabel = [UILabel new];
    _addressLabel.center = self.view.center;
    [self.view addSubview:_addressLabel];
    _locationManager = [[LocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager triggerLocationServices];
}

#pragma mark 定位代理
-(void)updateCurrentLocation:(Location *)location
{
    if (location) {
        NSString *address = [NSString stringWithFormat:@"%@-%@",location.subLocality,location.address];
//        [_delegate handlerOfLocation:location];
        _addressLabel.text = address;
        [_addressLabel sizeToFit];
        NSLog(@"位置:%@",address);
    }else{
        _addressLabel.text = @"地理位置定位失败";
    }
}
-(void)updateCurrentLocationFail:(NSString *)err
{
//    [_delegate handlerOfLocation:nil];
    _addressLabel.text = @"地理位置定位失败";
}


@end
