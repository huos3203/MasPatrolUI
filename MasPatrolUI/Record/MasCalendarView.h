//
//  MasCalendarView.h
//  BDDExamplesSwift
//
//  Created by du on 2019/4/24.
//  Copyright © 2019 huoshuguang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///日历选择器封装UI
@interface MasCalendarView : UIControl

/**
 日期选择构造器
 @param handler 选择日期、过滤记录操作
 @return 选择器View
 */
-(instancetype)initWithBlock:(void(^)(NSString *))handler;

@property (strong, nonatomic) UIPickerView *ibYearPickerView;
-(void)showCalendar;
-(void)hiddenCalendar;
@end

NS_ASSUME_NONNULL_END
