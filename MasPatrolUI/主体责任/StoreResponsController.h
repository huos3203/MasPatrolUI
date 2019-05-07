//
//  StoreResponsController.h
//  MasPatrolUI
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MasRespoModel : NSObject
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *name;
@end

@interface MasRespoCell : UITableViewCell

@property (strong, nonatomic) MasRespoModel *model;
@end

@interface StoreResponsController : UIViewController

@end

NS_ASSUME_NONNULL_END
