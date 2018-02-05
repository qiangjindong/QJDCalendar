//
//  QJDCalendarView.m
//  0124-日历周历切换
//
//  Created by 强进冬 on 2018/1/29.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import "QJDCalendarView.h"
#import "QJDMonthCalendarView.h"
#import "QJDWeekCalendarView.h"
#import "UIView+QJDRoundRect.h"
#import "UIView+QJDExtension.h"

@interface QJDCalendarView () <QJDMonthCalendarViewDelegate, QJDWeekCalendarViewDelegate>
@property (nonatomic, assign, getter=isWeekCalendarViewShow) BOOL weekCalendarViewShow;
/** 切换按钮 */
@property (nonatomic, strong) UIView *switchButton;
/** 周历 */
@property (nonatomic, strong) QJDWeekCalendarView *weekCalendarView;
/** 月历 */
@property (nonatomic, strong) QJDMonthCalendarView *monthCalendarView;
/** 周历按钮 */
@property (nonatomic, strong) UIButton *weekBtn;
/** 月历按钮 */
@property (nonatomic, strong) UIButton *monthBtn;

@end

@implementation QJDCalendarView

+ (instancetype)calendarView {
    return [[super alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubview];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSubview];
}


/**
 布局子控件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIView *switchButton = self.switchButton;
    CGFloat w = [UIScreen mainScreen].bounds.size.width * 0.6;
    CGFloat h = 40;
    switchButton.qjd_size = CGSizeMake(w, h);
    switchButton.qjd_centerX = self.qjd_centerX;
    switchButton.qjd_y = 64 + 15;
    // 设置圆角
//    switchButton = [switchButton roundCornerWith:switchButton.qjd_height * 0.5];
    // 设置圆角描边
    switchButton.layer.cornerRadius = switchButton.qjd_height * 0.5;
    switchButton.layer.masksToBounds = YES;
    switchButton.layer.borderWidth = 1;
    switchButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIButton *weekBtn = self.weekBtn;
    weekBtn.frame = CGRectMake(0, 0, w * 0.5, h);
    [weekBtn setTitle:@"周" forState:UIControlStateNormal];
    [weekBtn addTarget:self action:@selector(switchWeekAndMonth:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *monthBtn = self.monthBtn;
    monthBtn.frame = CGRectMake(w - w * 0.5, 0, w * 0.5, h);
    [monthBtn setTitle:@"月" forState:UIControlStateNormal];
    [monthBtn addTarget:self action:@selector(switchWeekAndMonth:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.monthCalendarView.frame = CGRectMake(0, CGRectGetMaxY(self.switchButton.frame) + 10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    
    
    self.weekCalendarView.frame = self.monthCalendarView.frame;
}

/**
 设置子控件
 */
- (void)setupSubview {
    // 切换按钮
    UIView *switchButton = [[UIView alloc] init];
    
    UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton addSubview:weekBtn];
    self.weekBtn = weekBtn;
    
    UIButton *monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton addSubview:monthBtn];
    self.monthBtn = monthBtn;
    
    [self addSubview:switchButton];
    self.switchButton = switchButton;
    
    [self setupCalendar];
}

- (void)setupCalendar {
    QJDMonthCalendarView *monthCalendarView = [QJDMonthCalendarView monthCalendarView];
    monthCalendarView.delegate = self;
    [self addSubview:monthCalendarView];
    self.monthCalendarView = monthCalendarView;
    
    QJDWeekCalendarView *weekCalendarView = [QJDWeekCalendarView weekCalendarView];
    weekCalendarView.delegate = self;
    [self addSubview:weekCalendarView];
    self.weekCalendarView = weekCalendarView;
    
    [self switchWeekAndMonth:nil];
}

- (void)switchWeekAndMonth:(UIButton *)btn {
    if ((self.weekBtn == btn && self.weekCalendarViewShow) || (self.monthBtn == btn && !self.weekCalendarViewShow)) return;
    
    self.weekCalendarViewShow = !self.weekCalendarViewShow;
    
    self.monthCalendarView.hidden = self.weekCalendarViewShow;
    self.weekCalendarView.hidden = !self.weekCalendarViewShow;
    
    // 切换时间保持一致
    static NSDate *date = nil;
    if (self.weekCalendarViewShow) {
        date = self.monthCalendarView.currentDate;
    } else {
        date = self.weekCalendarView.currentDate;
    }
    self.monthCalendarView.currentDate = date;
    self.weekCalendarView.currentDate = date;
    
    // 按钮标题和颜色的控制
    if (self.weekCalendarViewShow) {
        self.weekBtn.backgroundColor = [UIColor colorWithRed:49/255.0 green:147/255.0 blue:222/255.0 alpha:1];
        [self.weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.monthBtn.backgroundColor = [UIColor whiteColor];
        [self.monthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        self.weekBtn.backgroundColor = [UIColor whiteColor];
        [self.weekBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.monthBtn.backgroundColor = [UIColor colorWithRed:49/255.0 green:147/255.0 blue:222/255.0 alpha:1];
        [self.monthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

#pragma mark - <QJDMonthCalendarViewDelegate, QJDWeekCalendarViewDelegate>
- (void)monthCalendarView:(QJDMonthCalendarView *)monthCalendarView
 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
               dateString:(NSString *)dateStr {
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectAtIndexPath:dateString:)]) {
        [self.delegate calendarView:monthCalendarView didSelectAtIndexPath:indexPath dateString:dateStr];
    }
}

- (void)weekCalendarView:(QJDWeekCalendarView *)weekCalendarView didSelectRowAtIndexPath:(NSIndexPath *)indexPath dateString:(NSString *)dateStr {
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectAtIndexPath:dateString:)]) {
        [self.delegate calendarView:weekCalendarView didSelectAtIndexPath:indexPath dateString:dateStr];
    }
}

@end
