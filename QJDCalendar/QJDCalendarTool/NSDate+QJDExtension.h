//
//  NSDate+QJDExtension.h
//  0122-自定义日历
//
//  Created by 强进冬 on 2018/1/22.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (QJDExtension)

/** 当天是多少号 */
@property (nonatomic, assign, readonly) NSInteger qjd_day;
/** 当天是周几 */
@property (nonatomic, assign, readonly) NSInteger qjd_weekday;
/** 月包含的周数 */
@property (nonatomic, assign, readonly) NSInteger qjd_weekOfMonth;
/** 当天所在月份 */
@property (nonatomic, assign, readonly) NSInteger qjd_month;
/** 当天所在年份 */
@property (nonatomic, assign, readonly) NSInteger qjd_year;

/** 当月第一天是周几 */
@property (nonatomic, assign, readonly) NSInteger qjd_firstWeekday;
/** 当月有多少天 */
@property (nonatomic, assign, readonly) NSInteger qjd_numberOfdays;

NS_ASSUME_NONNULL_BEGIN
/** 上一个月的日期 */
@property (nonatomic, strong, readonly, nonnull) NSDate *qjd_dateOfPreviousMonth;
/** 下一个月的日期 */
@property (nonatomic, strong, readonly, nonnull) NSDate *qjd_dateOfNextMonth;
NS_ASSUME_NONNULL_END

/**
 将时间转成字符串
 @param fmt 时间格式字符串
 @return 字符串时间
 */
- (nonnull NSString *)qjd_stringWithFormat:(nullable NSString *)fmt;

/**
 将字符串转成时间
 @param fmt 时间格式字符串
 @param str 字符串时间
 @return 时间对象
 */
+ (nonnull NSDate *)qjd_dateWithFormat:(nullable NSString *)fmt str:(nonnull NSString *)str;

- (nonnull NSDateComponents *)deltaFrom:(nonnull NSDate *)from;

@end
