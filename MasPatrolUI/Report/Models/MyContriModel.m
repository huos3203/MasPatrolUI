//
//  MyContriModel.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "MyContriModel.h"

@implementation MyContriModel
-(NSMutableArray<ReportTaskModel *> *)Questions
{
    if (!_Questions) {
        _Questions = [NSMutableArray new];
    }
    return _Questions;
}
@end
