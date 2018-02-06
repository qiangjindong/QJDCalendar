//
//  QJDWeekCalendarView.m
//  0123-自定义周历
//
//  Created by 强进冬 on 2018/1/24.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import "QJDWeekCalendarView.h"
#import "QJDWeekCalendarCell.h"
#import "NSDate+QJDExtension.h"
#import "UIView+QJDExtension.h"
#import "QJDWeek.h"

@interface QJDWeekCalendarView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *weekdayChars;
@property (nonatomic, strong) NSMutableArray<QJDWeek *> *weeks;
/** 月份提示栏 */
@property (nonatomic, strong) UILabel *tipLabel;
/** 上一个按钮 */
@property (nonatomic, strong) UIButton *prevBtn;
/** 下一个按钮 */
@property (nonatomic, strong) UIButton *nextBtn;
/** 分割线 */
@property (nonatomic, strong) UIView *separate;
/** tableView */
@property (nonatomic, strong) UITableView *tableView;

@end


static NSString * const QJDWeekCalendarCellID = @"QJDWeekCalendarCellID";

@implementation QJDWeekCalendarView
@synthesize currentDate = _currentDate;

+ (instancetype)weekCalendarView {
    return [[super alloc] init];
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    [self loadData];
}

#pragma mark - Lazy
- (NSDate *)currentDate {
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

- (NSArray<NSString *> *)weekdayChars {
    if (!_weekdayChars) {
        _weekdayChars = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    }
    return _weekdayChars;
}

- (NSMutableArray<QJDWeek *> *)weeks {
    if (!_weeks) {
        _weeks = [NSMutableArray arrayWithCapacity:self.weekdayChars.count];
    }
    return _weeks;
}

#pragma mark - 系统调用
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

/**
 设置子控件
 */
- (void)setupSubviews {
    // 月份天数提示栏
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.userInteractionEnabled = YES;
    UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [prevBtn setImage:[UIImage imageNamed:@"QJDCalendar.bundle/icon_prev"] forState:UIControlStateNormal];
    [prevBtn addTarget:self action:@selector(prevBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tipLabel addSubview:prevBtn];
    self.prevBtn = prevBtn;
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setImage:[UIImage imageNamed:@"QJDCalendar.bundle/icon_next"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tipLabel addSubview:nextBtn];
    self.nextBtn = nextBtn;
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    // 分割线
    UIView *separate = [[UIView alloc] init];
    separate.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [tipLabel addSubview:separate];
    self.separate = separate;
    
    // tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[QJDWeekCalendarCell class] forCellReuseIdentifier:QJDWeekCalendarCellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [self loadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat labelW = self.qjd_width;
    CGFloat labelH = self.qjd_width / self.weekdayChars.count * 0.8;
    CGFloat btnW = labelH * 2;
    CGFloat btnH = labelH;
    self.tipLabel.font = [UIFont systemFontOfSize:labelH / 2.5];
    self.tipLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.prevBtn.frame = CGRectMake(0, 0, btnW, btnH);
    self.nextBtn.frame = CGRectMake(labelW - btnW, 0, btnW, btnH);
    
    self.separate.frame = CGRectMake(0, self.tipLabel.qjd_height - 0.5, self.qjd_width, 0.5);
    
    self.tableView.frame = CGRectMake(0, labelH, self.qjd_width, self.qjd_height - labelH);
    self.tableView.rowHeight = self.qjd_width / self.weekdayChars.count;
}

#pragma mark - 事件监听
- (void)prevBtnClick {
    self.currentDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:self.currentDate options:0];
    [self loadData];
}

- (void)nextBtnClick {
    self.currentDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:+7 toDate:self.currentDate options:0];
    [self loadData];
}

#pragma mark - 数据源,代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weeks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QJDWeekCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:QJDWeekCalendarCellID];
    cell.week = self.weeks[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(weekCalendarView:didSelectRowAtIndexPath:dateString:)]) {
        [self.delegate weekCalendarView:self
                didSelectRowAtIndexPath:indexPath
                             dateString:self.weeks[indexPath.row].dateString];
    }
}

#pragma mark - 加载数据
- (void)loadData {
    [self.weeks removeAllObjects];
    
    NSInteger previousDayCount = self.currentDate.qjd_dateOfPreviousMonth.qjd_numberOfdays;
    NSInteger curWeekday = self.currentDate.qjd_weekday - 1;
    NSInteger curDay = self.currentDate.qjd_day;
    
    NSInteger year1 = self.currentDate.qjd_year;
    NSInteger month1 = self.currentDate.qjd_month;
    
    NSInteger year2 = self.currentDate.qjd_year;
    NSInteger month2 = self.currentDate.qjd_month;
    
    NSInteger day = 0;
    for (int i = 0; i < self.weekdayChars.count; i ++) {
        day = curDay + (i - curWeekday);
        QJDWeek *week = [[QJDWeek alloc] init];
        // 目标天数 = 当前天数 + 长度, 长度 = 目标下标 - 当前下标
        if (day < 1) { // 上一个月或者上一年
            day = previousDayCount + day;
            year1 = self.currentDate.qjd_dateOfPreviousMonth.qjd_year;
            month1 = self.currentDate.qjd_dateOfPreviousMonth.qjd_month;
            week.dateString = [NSString stringWithFormat:@"%04zd-%02zd-%02zd", year1, month1, day];
        } else { // 本月
            day = curDay + (i - curWeekday);
            week.dateString = [NSString stringWithFormat:@"%04zd-%02zd-%02zd", year2, month2, day];
        }
        week.weekdayText = self.weekdayChars[i];
        week.dayText = [NSString stringWithFormat:@"%zd", day];
        if (i == [NSDate date].qjd_weekday - 1
            && self.currentDate.qjd_weekOfMonth == [NSDate date].qjd_weekOfMonth
            && self.currentDate.qjd_month == [NSDate date].qjd_month
            && self.currentDate.qjd_year == [NSDate date].qjd_year) {
            week.weekdayText = @"今天";
        }
        [self.weeks addObject:week];
    }
    
    self.tipLabel.text = [NSString stringWithFormat:@"%zd月%@日%zd - %zd月%@日%zd", month1, [self.weeks firstObject].dayText, year1, month2, [self.weeks lastObject].dayText, year2];                                                                                                                                                   [self.tableView reloadData];
}

@end
