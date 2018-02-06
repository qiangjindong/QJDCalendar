//
//  QJDCalendarView.m
//  0122-自定义日历
//
//  Created by 强进冬 on 2018/1/23.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import "QJDMonthCalendarView.h"
#import "QJDMonthCalendarCell.h"
#import "NSDate+QJDExtension.h"
#import "UIView+QJDExtension.h"
#import "QJDMonth.h"

@interface QJDMonthCalendarView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *weekdayChars;
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray<QJDMonth *> *monthes;
/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 月份提示栏 */
@property (nonatomic, strong) UILabel *tipLabel;
/** 月份提示栏的上一个按钮 */
@property (nonatomic, strong) UIButton *previousBtn;
/** 月份提示栏的下一个按钮 */
@property (nonatomic, strong) UIButton *nextBtn;
/** 周标签 */
@property (nonatomic, strong) UIView *weekdayView;
/** 周标签lebel数组 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *weekdayLabels;

@end

static NSString * const QJDMonthCalendarCellID = @"QJDMonthCalendarCell";

@implementation QJDMonthCalendarView
@synthesize currentDate = _currentDate;

+ (instancetype)monthCalendarView {
    return [[super alloc] init];
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    [self loadData];
}

#pragma mark - Lazy
- (NSArray<NSString *> *)weekdayChars {
    if (!_weekdayChars) {
        _weekdayChars = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    }
    return _weekdayChars;
}

- (NSMutableArray<QJDMonth *> *)monthes {
    if (!_monthes) {
        _monthes = [NSMutableArray array];
    }
    return _monthes;
}

- (NSDate *)currentDate {
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

- (NSMutableArray<UILabel *> *)weekdayLabels {
    if (!_weekdayLabels) {
        _weekdayLabels = [[NSMutableArray alloc] initWithCapacity:self.weekdayChars.count];
    }
    return _weekdayLabels;
}

#pragma mark - 系统调用
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    // 月份提示栏
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.userInteractionEnabled = YES;
    UIButton *previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousBtn setImage:[UIImage imageNamed:@"QJDCalendar.bundle/icon_prev.png"] forState:UIControlStateNormal];
    [previousBtn addTarget:self action:@selector(previousMonth) forControlEvents:UIControlEventTouchUpInside];
    [tipLabel addSubview:previousBtn];
    self.previousBtn = previousBtn;
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setImage:[UIImage imageNamed:@"QJDCalendar.bundle/icon_next"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    [tipLabel addSubview:nextBtn];
    self.nextBtn = nextBtn;
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    // 周标签
    UIView *weekdayView = [[UIView alloc] init];
    weekdayView.backgroundColor = [UIColor colorWithRed:49/255.0 green:147/255.0 blue:222/255.0 alpha:1];
    for (int i = 0; i < self.weekdayChars.count; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.weekdayChars[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [weekdayView addSubview:label];
        [self.weekdayLabels addObject:label];
    }
    [self addSubview:weekdayView];
    self.weekdayView = weekdayView;
    
    // 设置collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[QJDMonthCalendarCell class] forCellWithReuseIdentifier:QJDMonthCalendarCellID];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self loadData];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnH = self.qjd_width / self.weekdayChars.count * 0.7;
    CGFloat btnW = btnH * 2;
    
    // 月份提示栏
    self.tipLabel.frame = CGRectMake(0, 0, self.qjd_width, btnH);
    self.previousBtn.frame = CGRectMake(0, 0, btnW, btnH);
    self.nextBtn.frame = CGRectMake(self.tipLabel.qjd_width - btnW, 0, btnW, btnH);
    
    // 周标签
    self.weekdayView.frame = CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame), self.qjd_width, 35);
    CGFloat w = self.qjd_width / self.weekdayChars.count;
    CGFloat h = 35;
    CGFloat x, y = 0;
    for (int i = 0; i < self.weekdayChars.count; i ++) {
        x = w * i;
        self.weekdayLabels[i].frame = CGRectMake(x, y, w, h);
    }
    
    // collectionView
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.weekdayView.frame), self.qjd_width, self.qjd_height - CGRectGetMaxY(self.weekdayView.frame));
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(w, w);
}

#pragma mark - 事件监听
- (void)previousMonth {
    self.currentDate = self.currentDate.qjd_dateOfPreviousMonth;
    [self loadData];
}

- (void)nextMonth {
    self.currentDate = self.currentDate.qjd_dateOfNextMonth;
    [self loadData];
}

#pragma mark - 数据源, 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.monthes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QJDMonthCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QJDMonthCalendarCellID forIndexPath:indexPath];
    cell.month = self.monthes[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(monthCalendarView:didSelectItemAtIndexPath:dateString:)]) {
        [self.delegate monthCalendarView:self
                didSelectItemAtIndexPath:indexPath
                              dateString:self.monthes[indexPath.item].dateString];
    }
}

#pragma mark - 加载数据
- (void)loadData {
    [self.monthes removeAllObjects];
    
    NSInteger dayCount = self.currentDate.qjd_numberOfdays;
    NSInteger firstWeekday = self.currentDate.qjd_firstWeekday;
    NSInteger maxDayCount = (dayCount > 29 && (firstWeekday == 6 || firstWeekday == 5) ? 42 : 35);
    
    if (dayCount == 28 && firstWeekday == 0) maxDayCount = 28;
    if (dayCount == 30 && firstWeekday == 5) maxDayCount = 35;
    
    NSInteger day;
    for (int i = 0; i < maxDayCount; i ++) {
        QJDMonth *month = [[QJDMonth alloc] init];
        if (i < firstWeekday) { // 上个月
            day = self.currentDate.qjd_dateOfPreviousMonth.qjd_numberOfdays + i - (firstWeekday - 1);
            month.dateString = [NSString stringWithFormat:@"%04zd-%02zd-%02zd",
                                self.currentDate.qjd_dateOfPreviousMonth.qjd_year,
                                self.currentDate.qjd_dateOfPreviousMonth.qjd_month,
                                day];
            month.thisMonth = NO;
            month.dayText = [NSString stringWithFormat:@"%zd", day];
        } else if (i > firstWeekday + dayCount - 1) { // 下个月
            day = i - (firstWeekday + dayCount - 1);
            month.dateString = [NSString stringWithFormat:@"%04zd-%02zd-%02zd",
                                self.currentDate.qjd_dateOfNextMonth.qjd_year,
                                self.currentDate.qjd_dateOfNextMonth.qjd_month,
                                day];
            month.thisMonth = NO;
            month.dayText = [NSString stringWithFormat:@"%zd", day];
            
        } else { // 本月
            day = i - firstWeekday + 1;
            month.dateString = [NSString stringWithFormat:@"%04zd-%02zd-%02zd",
                                self.currentDate.qjd_year,
                                self.currentDate.qjd_month,
                                day];
            month.thisMonth = YES;
            month.dayText = [NSString stringWithFormat:@"%zd", day];
            if (i == self.currentDate.qjd_firstWeekday - 1 + [NSDate date].qjd_day
                && self.currentDate.qjd_weekOfMonth == [NSDate date].qjd_weekOfMonth
                && self.currentDate.qjd_month == [NSDate date].qjd_month
                && self.currentDate.qjd_year == [NSDate date].qjd_year) {
                month.dayText = @"今天";
            }
        }
        [self.monthes addObject:month];
    }
    
    self.tipLabel.text = [NSString stringWithFormat:@"%zd月 %zd", self.currentDate.qjd_month, self.currentDate.qjd_year];
    [self.collectionView reloadData];
    [self.monthes enumerateObjectsUsingBlock:^(QJDMonth * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.dayText isEqualToString:@"今天"]) {
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
    }];
}

@end
