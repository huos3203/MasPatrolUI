//
//  PatrolOptionSelModel.m
//  MasPatrolUI
//
//  Created by admin on 2019/6/11.
//  Copyright © 2019 com. All rights reserved.
//

#import "PatrolOptionSelModel.h"

@implementation PatrolOptionSelModel

@end

@implementation PatrolOptClsModel


-(NSMutableArray<PatrolOptionSelModel *> *)opts
{
    if (!_opts) {
        _opts = [NSMutableArray new];
    }
    return _opts;
}

@end
