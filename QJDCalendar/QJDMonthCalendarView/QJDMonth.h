//
//  QJDMonth.h
//  0122-自定义日历
//
//  Created by 强进冬 on 2018/1/23.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJDMonth : NSObject

/** 日期 */
@property (nonatomic, copy) NSString *dateString;
/** 是否为本月 */
@property (nonatomic, assign, getter=isThisMonth) BOOL thisMonth;
/** 天数 */
@property (nonatomic, copy) NSString *dayText;

@end
