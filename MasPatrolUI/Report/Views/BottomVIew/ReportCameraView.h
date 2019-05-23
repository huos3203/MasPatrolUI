//
//  ReportCameraView.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    Cell_CanDel,
    Cell_CanPreview,
    Cell_Add,
} CameraCellType;
@interface ReportCameraModel : NSObject
@property (assign, nonatomic) CameraCellType type;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *url;
@end

@interface ReportCameraColCell : UICollectionViewCell
@property (strong, nonatomic) ReportCameraModel *model;
@end

@interface ReportCameraView : UIView
@property (strong, nonatomic) NSArray<ReportCameraModel *> *dataArray;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
