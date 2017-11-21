//
//  TabFlightSearchViewController.m
//  airmobile
//
//  Created by xuesong on 17/2/28.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "TabFlightSearchViewController.h"
#import "FlightViewController.h"
#import "UIViewController+Reminder.h"
#import "HttpsUtils+Business.h"
#import "FlightModel.h"
#import "UIViewController+Reminder.h"
#import "FlightDetailViewController.h"
#import "AirlineModel.h"

@interface TabFlightSearchViewController ()<TabBarViewDelegate>

@end

@implementation TabFlightSearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage
                                                 selectedType:TabBarSelectedTypeFlight
                                                     delegate:self];
    [self.view insertSubview:self.tabBarView
                aboveSubview:self.view];
}

/**
 *  @author yangql, 16-02-25 18:02:36
 *
 *  @brief 查询按钮进行查询操作
 */
- (void)seekButtonClick{
//    NSLog(@"%s",__func__);
//    FlightViewController *flightVC = [[FlightViewController alloc]init];

    NSDictionary *conds;
    switch (self.queryflag) {
        case FlightSearchTypeFlightNo:{
            conds =@{@"search_flightNO"   : [self.flightNumberTextF.text uppercaseString]?:@"",
                   @"search_date"       :self.fltDate,
                   @"search_startCity"  :@"",
                   @"search_endCity"    :@"",
                   @"search_seat"       :@"",
                   @"search_fltRegNo"   :@"",
                   @"search_airline"    :self.airlineModel.nametw?:@"",
                   @"start"             :@(0).stringValue,
                   @"length"            :@(20).stringValue};
            break;
        }
        case FlightSearchTypeCity:{
            conds =@{@"search_flightNO"   :@"",
                     @"search_airline"    :@"",
                     @"search_seat"       :@"",
                     @"search_fltRegNo"   :@"",
                     @"search_date"       :self.fltDate,
                     @"search_startCity"  :self.outCity.cn?:@"",
                     @"search_endCity"    :self.arriveCity.cn?:@"",
                     @"start"             :@(0).stringValue,
                     @"length"            :@(20).stringValue};
            break;
        }
        case FlightSearchTypePlaneNo:{
            conds =@{@"search_flightNO"   :@"",
                     @"search_date"       :self.fltDate,
                     @"search_startCity"  :@"",
                     @"search_endCity"    :@"",
                     @"search_seat"       :@"",
                     @"search_fltRegNo"   :[self.flightNumberTextF.text uppercaseString]?:@"",
                     @"search_airline"    :self.airlineModel.nametw?:@"",
                     @"start"             :@(0).stringValue,
                     @"length"            :@(20).stringValue};
            break;

        }
        case FlightSearchTypeSeat:{
            conds =@{@"search_flightNO"   :@"",
                     @"search_date"       :self.fltDate,
                     @"search_startCity"  :@"",
                     @"search_endCity"    :@"",
                     @"search_seat"       :[self.flightNumberTextF.text uppercaseString]?:@"",
                     @"search_fltRegNo"   :@"",
                     @"search_airline"    :self.airlineModel.nametw?:@"",
                     @"start"             :@(0).stringValue,
                     @"length"            :@(20).stringValue};
            break;

        }
        default:{

        }
    }
    [self loadMoreNetwork:conds];
}

-(void)loadMoreNetwork:(NSDictionary *)conds
{
    [self starNetWorking];
    [HttpsUtils queryFlightList:conds success:^(id responseObj) {
        // 数据加载完成
        [self stopNetWorking];
        if(![responseObj isKindOfClass:[NSArray class]]){
            return;
        }
        NSMutableArray *mutableArray = [NSMutableArray array];
        [mutableArray addObjectsFromArray:[responseObj DictionaryToModel:[FlightModel class]]];
        if (mutableArray.count == 0) {
            [self showAnimationTitle:@"没有查询到航班"];
        }else if (mutableArray.count == 1){

            if (![CommonFunction hasFunction:FL_DETAIL]) {
                [self pushflightListViewControllerWithFlightModel:[mutableArray copy]];
                return;
            }
            [self pushflightDetailViewControllerWithFlightModel:[mutableArray firstObject]];

        }else{
            [self pushflightListViewControllerWithFlightModel:[mutableArray copy]];

        }
    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
        [self stopNetWorking];
        [self showAnimationTitle:@"网络加载失败"];
    }];
}

-(void)pushflightDetailViewControllerWithFlightModel:(FlightModel*)flight
{
    FlightDetailViewController *flightDetailVC = [[FlightDetailViewController alloc]initWithNibName:@"FlightDetailViewController"
                                                                                             bundle:nil];
    flightDetailVC.flightNo = flight.fNum;
    flightDetailVC.flightId = flight.id;
    flightDetailVC.flightType = flight.flightType;
//    flightDetailVC.isSpecial =  flight.special.boolValue;
    [self.navigationController pushViewController:flightDetailVC animated:YES];

}
-(void)pushflightListViewControllerWithFlightModel:(NSArray *)array
{
    FlightViewController *flightVC = [[FlightViewController alloc]init];
    if(self.queryflag==FlightSearchTypeFlightNo){
        flightVC.flightNo = [self.flightNumberTextF.text uppercaseString];
        flightVC.airlineModel = self.airlineModel;
    }else if(self.queryflag == FlightSearchTypeCity){
        flightVC.outCity = self.outCity;
        flightVC.arriveCity = self.arriveCity;
    }else if(self.queryflag == FlightSearchTypePlaneNo){
        flightVC.planeNo = [self.flightNumberTextF.text uppercaseString]?:@"";
    }else if (self.queryflag == FlightSearchTypeSeat){
        flightVC.seat = [self.flightNumberTextF.text uppercaseString]?:@"";
    }
    flightVC.flightDate = self.fltDate;
    flightVC.dataArray = array;
    [self.navigationController pushViewController:flightVC animated:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
