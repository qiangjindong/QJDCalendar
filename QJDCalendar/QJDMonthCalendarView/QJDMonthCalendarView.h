//
//  QJDCalendarView.h
//  0122-自定义日历
//
//  Created by 强进冬 on 2018/1/23.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJDMonthCalendarView;
@protocol QJDMonthCalendarViewDelegate <NSObject>
- (void)monthCalendarView:(QJDMonthCalendarView *)monthCalendarView
 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
               dateString:(NSString *)dateStr;
@end

@interface QJDMonthCalendarView : UIView
/** 当前显示月份的日期 */
@property (nonatomic, strong) NSDate *currentDate;
/** 代理 */
@property (nonatomic, weak) id<QJDMonthCalendarViewDelegate> delegate;

+ (instancetype)monthCalendarView;

@end
