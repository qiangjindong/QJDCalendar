//
//  NSDate+QJDExtension.m
//  0122-自定义日历
//
//  Created by 强进冬 on 2018/1/22.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import "NSDate+QJDExtension.h"
#import <objc/runtime.h>

@implementation NSDate (QJDExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}

+ (NSDate *)qjd_dateWithFormat:(NSString *)fmt str:(NSString *)str {
    NSDateFormatter *fmter = [[NSDateFormatter alloc] init];
    fmter.dateFormat = fmt != nil ? fmt : @"yyyy-MM-dd HH:mm:ss";
    return [fmter dateFromString:str];
}

- (NSString *)qjd_stringWithFormat:(NSString *)fmt {
    NSDateFormatter *fmter = [[NSDateFormatter alloc] init];
    fmter.dateFormat = fmt != nil ? fmt : @"yyyy-MM-dd HH:mm:ss";
    return [fmter stringFromDate:self];
}

- (NSInteger)qjd_day {
    NSDateComponents *cmpts = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return cmpts.day;
}

- (NSInteger)qjd_weekday {
    NSDateComponents *cmpts = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    return cmpts.weekday;
}

- (NSInteger)qjd_weekOfMonth {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfMonth fromDate:self];
}

- (NSInteger)qjd_month {
    NSDateComponents *cmpts = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return cmpts.month;
}

- (NSInteger)qjd_year {
    NSDateComponents *cmpts = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return cmpts.year;
}

- (NSInteger)qjd_firstWeekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 1:周日 2:周一 ... 7:周六
    calendar.firstWeekday = 1;
    NSDateComponents *cmpts = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    cmpts.day = 1;
    NSDate *firstDate = [calendar dateFromComponents:cmpts];
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDate];
    return firstWeekday - 1;
}

- (NSInteger)qjd_numberOfdays {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSDate *)qjd_dateOfPreviousMonth {
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self options:0];
}

- (NSDate *)qjd_dateOfNextMonth {
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:+1 toDate:self options:0];
}

@end
