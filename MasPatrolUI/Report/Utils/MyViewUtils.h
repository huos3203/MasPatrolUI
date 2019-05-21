//
//  MyViewUtils.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyViewUtils : NSObject
+(NSMutableAttributedString *)installAtrribute:(NSString *)first second:(NSString *)second;
+(void)maskLayer:(UIView *)view;
+(UIBarButtonItem *)createBarBy:(UIButton *)btn;
@end

NS_ASSUME_NONNULL_END
