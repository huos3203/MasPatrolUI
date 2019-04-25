//
//  MasCalendarView.m
//  BDDExamplesSwift
//
//  Created by du on 2019/4/24.
//  Copyright © 2019 huoshuguang. All rights reserved.
//

#import "MasCalendarView.h"
#import <Masonry/Masonry.h>
@interface MasCalendarView()<UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSArray *yearArray;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *calendarView;
@end

@implementation MasCalendarView
{
    void(^ComfirmHandler)(NSString *);
}
-(instancetype)initWithBlock:(void (^)(NSString *))handler
{
    self = [super init];
    ComfirmHandler = handler;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCalendar)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    [self installView];
    return self;
}

-(void)installView
{
    self.backgroundColor = [UIColor colorWithRed:22 green:0 blue:0 alpha:.7];
    //半透明背景
    //    [self addSubview:self.backView];
    //    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
    //       make.top.left.right.bottom.equalTo(self);
    //    }];
    //picker
    [self addSubview:self.calendarView];
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.backView.mas_bottom);
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@150);
    }];
}

///半透明背景View
-(UIView *)backView
{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    }
    return _backView;
}
///日历选择器
-(UIView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [UIView new];
        _calendarView.backgroundColor = [UIColor grayColor];
        //日期view
        UIPickerView *picker = [UIPickerView new];
        picker.backgroundColor = [UIColor whiteColor];
        picker.delegate = self;
        [_calendarView addSubview:picker];
        [picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(_calendarView);
        }];
        //分割线
        UIView *left = [UIView new];
        left.backgroundColor = [UIColor darkTextColor];
        [_calendarView addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_calendarView);
            make.height.equalTo(@1);
            make.width.equalTo(@(self.bounds.size.width/3));
            make.centerY.equalTo(_calendarView);
        }];
        UIView *right = [UIView new];
        right.backgroundColor = [UIColor darkTextColor];
        [_calendarView addSubview:right];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_calendarView);
            make.height.width.equalTo(left);
            make.centerY.equalTo(_calendarView);
        }];
        //确定按钮
        UIButton *confirm = [UIButton new];
        confirm.backgroundColor = [UIColor whiteColor];
        [confirm setTitle:@"确定" forState:UIControlStateNormal];
        [confirm setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_calendarView addSubview:confirm];
        [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picker.mas_bottom).offset(10);
            make.left.right.equalTo(_calendarView);
            make.bottom.equalTo(_calendarView);
            make.height.equalTo(@40);
        }];
        [confirm addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calendarView;
}
#pragma mark UI action
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //y小于screen.frame.y - 150
    CGFloat yy = 150;
    CGFloat ky = [gestureRecognizer locationInView:self].y;
    BOOL yB = (ky < [[UIScreen mainScreen] bounds].size.height - yy);
    if (yB) {
        return true;
    }
    return false;
}

///按钮事件
-(void)confirmAction:(UIButton *)confirm
{
    if (ComfirmHandler) {
        ComfirmHandler(self.year);
        [self hiddenCalendar];
    }
}
///显示动画
-(void)showCalendar
{
    self.alpha = 0;
    UIView *topView = [[UIApplication sharedApplication] keyWindow];
    [topView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(topView);
        make.center.equalTo(topView);
    }];
    [UIView transitionWithView:self.calendarView duration:.1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self.ibYearPickerView reloadAllComponents];
    }];
}

///隐藏日历
- (void)hiddenCalendar
{
    [self removeFromSuperview];
}

#pragma mark Data getter
-(NSString *)year
{
    if (!_year) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        _year = [formatter stringFromDate:[NSDate date]];
        return _year;
    }
    return _year;
}

-(NSArray *)yearArray
{
    if (!_yearArray) {
        NSMutableArray *array = [NSMutableArray new];
        NSInteger curYear = [self.year integerValue];
        int i = 0;
        while (i < 5) {
            NSString *year = [NSString stringWithFormat:@"%ld",curYear - i];
            [array addObject:year];
            i++;
        }
        _yearArray = [array copy];
    }
    return _yearArray;
}

#pragma mark - Picker
#pragma mark data
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.yearArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    for(UIView *speartorView in pickerView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = [UIColor clearColor];//隐藏分割线
        }
    }
    return self.yearArray[row];
}

#pragma mark delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.year = self.yearArray[row];
}

@end
