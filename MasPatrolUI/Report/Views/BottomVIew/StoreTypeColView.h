//
//  StoreTypeColView.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreTypeCell : UICollectionViewCell
@property (strong, nonatomic) NSString *title;
@end

@interface StoreTypeColView : UIView
@property (strong, nonatomic) NSArray *dataArray;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
