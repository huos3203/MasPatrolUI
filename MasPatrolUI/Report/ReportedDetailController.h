//
//  ReportedDetailController.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface ReportedDetailController : UIViewController

@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) MASConstraint *scrollView_mas_Bottom;
@end

NS_ASSUME_NONNULL_END
