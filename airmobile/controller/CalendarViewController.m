//
//  CalendarViewController.m
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/2/25.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "CalendarViewController.h"
#import "DateUtils.h"
#import "UIViewController+Reminder.h"

@interface CalendarViewController (){
    NSMutableDictionary *_eventsByDate;

    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;

    NSDate *_dateSelected;
    NSCalendar *_calendar;
}
@end

@implementation CalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self titleViewInit];

    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    _calendarManager.dateHelper.calendar.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
    _calendarManager.dateHelper.calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [self createMinAndMaxDate];

    _calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, 50)];
    _calendarContentView = [[JTHorizontalCalendarView alloc] initWithFrame:CGRectMake(20,105, kScreenWidth-20, (kScreenHeight)/2-80)];

    [self.view addSubview:_calendarMenuView];
    [self.view addSubview:_calendarContentView];

    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
}

//titleView订制
- (void)titleViewInit{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"航班查询"];
    [self titleViewAddBackBtn];
}

- (void)createMinAndMaxDate
{
    // 控件就是这样
    _todayDate = [NSDate date];
    _dateSelected = _todayDate;

    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-24];

    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate days:1];
}

/**
 *  @author yangql, 16-02-25 20:02:34
 *
 *  @brief 个性化设置每个dayView
 *
 */
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Selected date
    if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [CommonFunction colorFromHex:0XFF21395C];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }

    //    if([self haveEventForDay:dayView.date]){
    //        dayView.dotView.hidden = NO;
    //    }
    //    else{
    //        dayView.dotView.hidden = YES;
    //    }
}

/**
 *  @author yangql, 16-02-25 20:02:52
 *
 *  @brief 设置日期选择时候的动画
 *
 *  @param calendar <#calendar description#>
 *  @param dayView  <#dayView description#>
 */
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    NSTimeInterval time = [_todayDate timeIntervalSinceDate:_dateSelected]/60/60;
    if (time<0 || time >48) {
        [self showAnimationTitle:@"请选择今天或者昨天"];
        return;
    }

    // Animation for the circleView
    //    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    //    [UIView transitionWithView:dayView
    //                      duration:.3
    //                       options:0
    //                    animations:^{
    //                        dayView.circleView.transform = CGAffineTransformIdentity;
    //                        [_calendarManager reload];
    //                    } completion:nil];


    // Load the previous or next page if touch a day from another month

    //    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
    //        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
    //            [_calendarContentView loadNextPageWithAnimation];
    //        }
    //        else{
    //            [_calendarContentView loadPreviousPageWithAnimation];
    //        }
    //    };

    self.resetDate([_calendarManager.dateHelper addToDate:_dateSelected days:1]);
    [self.navigationController popViewControllerAnimated:true];
}

/**
 *  @author yangql, 16-02-25 20:02:12
 *
 *  @brief 限制日期最大最小时间
 *
 *  @param calendar <#calendar description#>
 *  @param date     <#date description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];

    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Medium" size:16];

    return label;
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy年MM月";
    }

    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    _calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatShort;
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];

    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Avenir-Light" size:14];
        switch ([view.dayViews indexOfObject:label]) {
            case 0:
                label.text = @"周六";
                break;
            case 1:
                label.text = @"周日";
                break;
            case 2:
                label.text = @"周一";
                break;
            case 3:
                label.text = @"周二";
                break;
            case 4:
                label.text = @"周三";
                break;
            case 5:
                label.text = @"周四";
                break;
            case 6:
                label.text = @"周五";
                break;
            default:
                break;
        }
    }

    return view;
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];

    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    
    view.circleRatio = .8;
    view.dotRatio = 1. / .9;
    
    return view;
}

@end
