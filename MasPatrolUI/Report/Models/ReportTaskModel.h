//
//  ReportTaskModel.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface ReportTaskModel : JSONModel

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *ClassifId;
@property (strong, nonatomic) NSString *ClassifName;
@property (strong, nonatomic) NSString *EventName;
@property (strong, nonatomic) NSString *QuestionSubDate;
@property (strong, nonatomic) NSString *QuestionOffDate;
@property (strong, nonatomic) NSString *AppId;
@property (strong, nonatomic) NSString *EventId;
@property (strong, nonatomic) NSString *QuestionDesc;
@property (strong, nonatomic) NSString *QuestionIcon;
@property (strong, nonatomic) NSString *QuestionLocationIcon;
@property (strong, nonatomic) NSString *QuestionStatus;
@property (strong, nonatomic) NSString *QuestionReporterCode;
@property (strong, nonatomic) NSString *QuestionReporterName;
@property (strong, nonatomic) NSString *QuestionAreaCode;
@property (strong, nonatomic) NSString *QuestionAreaName;
@property (strong, nonatomic) NSString *QuestionFixedLocation;
@property (strong, nonatomic) NSString *QuestionFixedLongitude;
@property (strong, nonatomic) NSString *QuestionFixedLatitude;

@end

NS_ASSUME_NONNULL_END
