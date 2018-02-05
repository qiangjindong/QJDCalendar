//
//  QJDTableViewCell.m
//  0123-自定义周历
//
//  Created by 强进冬 on 2018/1/23.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import "QJDWeekCalendarCell.h"
#import "QJDWeek.h"
#import "UIView+QJDExtension.h"

@interface QJDWeekCalendarCell ()
@property (strong, nonatomic) UILabel *weekday;
@property (strong, nonatomic) UILabel *day;
@property (strong, nonatomic) UIView *progress;
@property (strong, nonatomic) UILabel *totalTime;
@property (strong, nonatomic) UILabel *weekend;
@end

@implementation QJDWeekCalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *weekday = [[UILabel alloc] init];
        weekday.textAlignment = NSTextAlignmentCenter;
        weekday.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:weekday];
        self.weekday = weekday;
        
        UILabel *day = [[UILabel alloc] init];
        day.textAlignment = NSTextAlignmentCenter;
        day.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:day];
        self.day = day;
        
        UIView *progress = [[UIView alloc] init];
        [self.contentView addSubview:progress];
        self.progress = progress;
        
        UILabel *totalTime = [[UILabel alloc] init];
        totalTime.text = @"00:00";
        totalTime.textAlignment = NSTextAlignmentCenter;
        totalTime.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:totalTime];
        self.totalTime = totalTime;
        
        UILabel *weekend = [[UILabel alloc] init];
        weekend.text = @"WEEKEND";
        weekend.textAlignment = NSTextAlignmentCenter;
        weekend.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:weekend];
        self.weekend = weekend;
        
        weekday.translatesAutoresizingMaskIntoConstraints = NO;
        day.translatesAutoresizingMaskIntoConstraints = NO;
        progress.translatesAutoresizingMaskIntoConstraints = NO;
        totalTime.translatesAutoresizingMaskIntoConstraints = NO;
        weekend.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:weekday
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1.0
                                                                         constant:10],
                                           
                                           [NSLayoutConstraint constraintWithItem:weekday
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:progress
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:0]
                                           ]];

        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:day
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:weekday
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.0
                                                                         constant:-2],
                                           
                                           [NSLayoutConstraint constraintWithItem:day
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:progress
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0]
                                           ]];
        
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:progress
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:totalTime
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1.0
                                                                         constant:-10],
                                           
                                           [NSLayoutConstraint constraintWithItem:progress
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:0],
                                           
                                           [NSLayoutConstraint constraintWithItem:progress
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:weekday
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1.0
                                                                         constant:10],
                                           
                                           [NSLayoutConstraint constraintWithItem:progress
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0
                                                                         constant:2],
                                           ]];
        
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:totalTime
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1.0
                                                                         constant:-10],
                                           
                                           [NSLayoutConstraint constraintWithItem:totalTime
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:progress
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:0],
                                           ]];
        
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:weekend
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.0
                                                                         constant:0],
                                           
                                           [NSLayoutConstraint constraintWithItem:weekend
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:progress
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:2],
                                           ]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setWeek:(QJDWeek *)week {
    _week = week;
    
    self.weekday.text = week.weekdayText;
    self.day.text = week.dayText;
    if ([week.weekdayText isEqualToString:@"周日"] || [week.weekdayText isEqualToString:@"周六"]) {
        self.progress.backgroundColor = [UIColor yellowColor];
        self.weekend.hidden = NO;
    } else {
        self.progress.backgroundColor = [UIColor lightGrayColor];
        self.weekend.hidden = YES;
    }
}

@end
