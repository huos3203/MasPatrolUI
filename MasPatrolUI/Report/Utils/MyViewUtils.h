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
typedef enum : NSUInteger {
    Task_TODO,
    Task_Doing,
    Task_Done,
    Task_TimeOut,
    Task_Invalid,
} TaskFlagType;

@interface MyViewUtils : NSObject
+(NSMutableAttributedString *)installAtrribute:(NSString *)first second:(NSString *)second;
+(void)maskLayer:(UIView *)view;
+(UIBarButtonItem *)createBarBy:(UIButton *)btn;
+(UILabel *)secondCell:(NSString *)name for:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
