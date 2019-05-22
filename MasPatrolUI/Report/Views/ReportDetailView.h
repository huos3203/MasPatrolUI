//
//  ReportDetailView.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/22.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReportDetailViewModel : NSObject
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *preImgUrl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *detailImgUrl;
@property (strong, nonatomic) NSString *detailText;
@property (strong, nonatomic) NSString *ren;
@property (strong, nonatomic) NSString *shixian;
@end



@interface ReportDetailView : UIView

-(void)reloadData:(ReportDetailViewModel *)model;

@end

NS_ASSUME_NONNULL_END
