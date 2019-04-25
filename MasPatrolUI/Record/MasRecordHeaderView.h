//
//  MasRecordHeaderView.h
//  BDDExamplesSwift
//
//  Created by du on 2019/4/24.
//  Copyright © 2019 huoshuguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasRecordHeaderView : UIView

/**
 构造器
 @param showHandler 响应按钮事件,显示View
 @return 返回对象
 */
-(instancetype)initWith:(NSString *)title Block:(void(^)(void))showHandler;
///刷新状态
-(void)reloadYear:(NSString *)year num:(NSString *)num;

@end
