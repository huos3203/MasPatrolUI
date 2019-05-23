//
//  StoreTypeColView.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SType_CanDo,
    SType_CantDo,
    SType_Completed,
} StoreTypeFlag;

@interface StoreTypeModel : NSObject
@property (strong, nonatomic) NSString *typeId;
@property (assign, nonatomic) StoreTypeFlag flag;
@property (strong, nonatomic) NSString *title;
@end

@interface StoreTypeCell : UICollectionViewCell
@property (strong, nonatomic) StoreTypeModel *model;
@end

@interface StoreTypeColView : UIView
-(instancetype)initWith:(void(^)(NSString *))handler;
@property (strong, nonatomic) NSArray<StoreTypeModel *> *dataArray;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
