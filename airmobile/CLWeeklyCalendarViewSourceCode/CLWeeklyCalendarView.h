//
//  CLWeeklyCalendarView.h
//  Deputy
//
//  Created by Caesar on 30/10/2014.
//  Copyright (c) 2014 Caesar Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CLWeeklyCalendarViewDelegate <NSObject>

// Keys for customize the calendar behavior
extern NSString *const CLCalendarWeekStartDay;    //The Day of weekStart from 1 - 7 - Default: 1
extern NSString *const CLCalendarDayTitleTextColor; //Day Title text color,  Mon, Tue, etc label text color
extern NSString *const CLCalendarSelectedDatePrintFormat;   //Selected Date print format,  - Default: @"EEE, d MMM yyyy"
extern NSString *const CLCalendarSelectedDatePrintColor;    //Selected Date print text color -Default: [UIColor whiteColor]
extern NSString *const CLCalendarSelectedDatePrintFontSize; //Selected Date print font size - Default : 13.f
extern NSString *const CLCalendarBackgroundImageColor;      //BackgroundImage color - Default : see applyCustomDefaults.

-(NSDictionary *)CLCalendarBehaviorAttributes;       //Optional Function, Set the calendar behavior attributes by using above keys

-(void)dailyCalendarViewDidSelect: (NSDate *)date;


@end

//周日历
@interface CLWeeklyCalendarView : UIView

@property (nonatomic, weak) id<CLWeeklyCalendarViewDelegate> delegate;//代理
@property (nonatomic, strong) NSDate *selectedDate; //选择日期

- (void)redrawToDate: (NSDate *)dt;  //重新绘制  日期

-(void)updateWeatherIconByKey: (NSString *)key; //更新

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
