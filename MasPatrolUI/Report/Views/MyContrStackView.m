//
//  MyContrStackView.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "MyContrStackView.h"
#import <Masonry/Masonry.h>

@interface MyContrStackView()
@property (strong, nonatomic) UIStackView *stackView;
@end

@implementation MyContrStackView
{
    UILabel *firstLabel;
    UILabel *secondLabel;
    UILabel *thirdLabel;
}
-(instancetype)init
{
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    firstLabel = [self installView:@"累计被采纳次数"];
    secondLabel = [self installView:@"上报次数"];
    thirdLabel = [self installView:@"上报待办次数"];
    [self addSubview:self.stackView];
    UIEdgeInsets pading = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(pading);
    }];
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 阴影颜色
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.23].CGColor;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,1);
    // 阴影透明度，默认0
    self.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    self.layer.shadowRadius = 5;
    self.layer.cornerRadius = 2;
}

#pragma mark - api
-(void)reloadData:(NSString *)first second:(NSString *)second third:(NSString *)third
{
    firstLabel.text = first;
    secondLabel.text = second;
    thirdLabel.text = third;
}



-(UILabel *)installView:(NSString *)text
{
    UIView *view = [UIView new];
    UILabel *numLabel = [UILabel new];
    numLabel.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    numLabel.font = [UIFont systemFontOfSize:21.0];
    UILabel *textLabel = [UILabel new];
    textLabel.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    textLabel.font = [UIFont systemFontOfSize:14.0];
    textLabel.text = text;
    [view addSubview:numLabel];
    [view addSubview:textLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.centerY.equalTo(view).offset(-20);
    }];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.centerY.equalTo(view).offset(20);
    }];
    
    [self.stackView addArrangedSubview:view];
    return numLabel;
}


#pragma mark - 自定义View
-(UIStackView *)stackView
{
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _stackView;
}

@end
