//
//  MyViewUtils.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "MyViewUtils.h"
#import <Masonry/Masonry.h>
@implementation MyViewUtils
#pragma mark - 辅助方法
+(UIBarButtonItem *)createBarBy:(UIButton *)btn
{
    UIView *butView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    [butView addSubview:btn];
    btn.frame = CGRectMake(0, 0, 60, 25);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    return [[UIBarButtonItem alloc] initWithCustomView:butView];
}
+(NSMutableAttributedString *)installAtrribute:(NSString *)first second:(NSString *)second
{
    NSString *text = [NSString stringWithFormat:@"%@%@",first,second];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0]} range:NSMakeRange(first.length, second.length)];
    return string;
}

//设置圆角
+(void)maskLayer:(UIView *)view
{
    //设置所需的圆角位置以及大小
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+(UILabel *)secondCell:(NSString *)name for:(UIView *)view
{
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = name;
    UILabel *text = [UILabel new];
    text.numberOfLines = 0;
    text.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    text.font = [UIFont systemFontOfSize:16.0];
    [view addSubview:label];
    [view addSubview:text];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(text.mas_top);
    }];
    [text setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(8);
        make.right.equalTo(view);
        make.centerY.equalTo(view);
        make.left.equalTo(label.mas_right).offset(8);
    }];
    return text;
}

+(void)clear:(UINavigationController *)navVC barType:(BOOL)isClear
{
    [navVC setNavigationBarHidden:NO];
    navVC.navigationBar.translucent = YES;
    UIColor *color = isClear?[UIColor clearColor]:[UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [navVC.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    navVC.navigationBar.clipsToBounds = isClear;
}
+(void)clearNavBarLine:(UINavigationBar *)navbar
{
    [navbar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navbar.shadowImage = [[UIImage alloc] init];
}

@end
