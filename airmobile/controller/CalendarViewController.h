//
//  CalendarViewController.h
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/2/25.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "RootViewController.h"
#import <JTCalendar/JTCalendar.h>

@interface CalendarViewController : RootViewController<JTCalendarDelegate>

@property (strong, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (nonatomic,copy) void (^resetDate)(NSDate *date);

@end
