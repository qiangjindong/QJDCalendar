//
//  QJDCalendarView.h
//  0124-日历周历切换
//
//  Created by 强进冬 on 2018/1/29.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJDCalendarView;
@protocol QJDCalendarViewDelegate <NSObject>
- (void)calendarView:(UIView *)calendarView didSelectAtIndexPath:(NSIndexPath *)indexPath dateString:(NSString *)dateStr;
@end

@interface QJDCalendarView : UIView
/** 代理 */
@property (nonatomic, weak) id<QJDCalendarViewDelegate> delegate;

+ (instancetype)calendarView;

@end
