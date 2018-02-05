//
//  QJDWeek.h
//  0123-自定义周历
//
//  Created by 强进冬 on 2018/1/24.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJDWeek : NSObject

/** 日期 */
@property (nonatomic, copy) NSString *dateString;
/** 天数 */
@property (nonatomic, copy) NSString *dayText;
/** 周几 */
@property (nonatomic, copy) NSString *weekdayText;

@end
