//
//  PatrolOptionSelModel.h
//  MasPatrolUI
//
//  Created by admin on 2019/6/11.
//  Copyright © 2019 com. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface PatrolOptionSelModel : JSONModel
@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *clsId;
@end

@interface PatrolOptClsModel : JSONModel

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSMutableArray<PatrolOptionSelModel*> *opts;

@end

NS_ASSUME_NONNULL_END
