//
//  QJDTableViewCell.h
//  0123-自定义周历
//
//  Created by 强进冬 on 2018/1/23.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QJDWeek;

@interface QJDWeekCalendarCell : UITableViewCell

/** 星期模型 */
@property (nonatomic, strong) QJDWeek *week;

@end
