//
//  QJDWeekCalendarView.h
//  0123-自定义周历
//
//  Created by 强进冬 on 2018/1/24.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJDWeekCalendarView;
@protocol QJDWeekCalendarViewDelegate <NSObject>
- (void)weekCalendarView:(QJDWeekCalendarView *)weekCalendarView
 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
              dateString:(NSString *)dateStr;

@end

@interface QJDWeekCalendarView : UIView

/** 当前显示周的日期 */
@property (nonatomic, strong) NSDate *currentDate;
/** 代理 */
@property (nonatomic, weak) id<QJDWeekCalendarViewDelegate> delegate;
+ (instancetype)weekCalendarView;

@end


