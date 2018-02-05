//
//  QJDCalendarCell.m
//  0122-自定义日历
//
//  Created by 强进冬 on 2018/1/24.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import "QJDMonthCalendarCell.h"
#import "QJDMonth.h"
#import "UIView+QJDRoundRect.h"

@interface QJDMonthCalendarCell ()

@property (strong, nonatomic) UILabel *label;
@end

@implementation QJDMonthCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.center = self.contentView.center;
    CGFloat w = self.contentView.frame.size.width * 0.8;
    self.label.bounds = CGRectMake(0, 0, w, w);
    [self.label qjd_roundCornerWith:self.label.frame.size.width / 2];
}

- (void)setMonth:(QJDMonth *)month {
    _month = month;
    self.label.text = month.dayText;
    
    if ([month.dayText isEqualToString:@"今天"]) {
    } else {
        self.label.backgroundColor = [UIColor clearColor];
        if (month.isThisMonth) {
            self.label.textColor = [UIColor blackColor];
        } else {
            self.label.textColor = [UIColor lightGrayColor];
        }
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor colorWithRed:49/255.0 green:147/255.0 blue:222/255.0 alpha:1];
    } else {
        if (self.month.isThisMonth) {
            self.label.textColor = [UIColor blackColor];
            self.label.backgroundColor = [UIColor clearColor];
        } else {
            self.label.textColor = [UIColor lightGrayColor];
            self.label.backgroundColor = [UIColor clearColor];
        }
    }
}

@end
