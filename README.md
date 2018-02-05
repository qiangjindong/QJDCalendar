# QJDCalendar
一款简单的日历的视图控件，支持"周历"和"月历"切换。
# 安装
pod 'QJDCalendar'
# 示例
! [示例图片] (AAA)；
# 如何使用
- 导入头文件
```
#import "QJDCalendar.h"
```
- 创建一个可以"周历"和"月历"相互切换的日历
```
    QJDCalendarView *calendarView = [QJDCalendarView calendarView];
    calendarView.frame = [UIScreen mainScreen].bounds;
    calendarView.delegate = self;
    [self.view addSubview:calendarView];
```
- 可以实现代理进行交互
```
- (void)calendarView:(UIView *)calendarView didSelectAtIndexPath:(NSIndexPath *)indexPath dateString:(NSString *)dateStr {
}
```
- 如果想要单独使用月历
```
    QJDMonthCalendarView *monthCalendarView = [QJDMonthCalendarView monthCalendarView];
    monthCalendarView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:monthCalendarView];
```
- 如果想要单独使用周历
```
    QJDWeekCalendarView *weekCalendarView = [QJDWeekCalendarView weekCalendarView];
    weekCalendarView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:weekCalendarView];
```