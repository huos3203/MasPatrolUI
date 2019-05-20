//
//  MyViewUtils.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "MyViewUtils.h"

@implementation MyViewUtils
#pragma mark - 辅助方法

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
@end
