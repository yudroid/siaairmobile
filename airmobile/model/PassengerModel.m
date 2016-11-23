//
//  PassengerModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/13.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerModel.h"

@implementation PassengerModel

-(NSMutableArray *)getPsnOnPlaneArray
{
    if(_psnOnPlane == nil){
        _psnOnPlane = [NSMutableArray array];
    }
    return _psnOnPlane;
}

-(NSMutableArray *)getPsnHoursArray
{
    if(_psnHours == nil){
        _psnHours = [[NSMutableArray alloc] init];
    }
    return _psnHours;
}

-(NSMutableArray *)getPsnAreasArray
{
    if(_psnAreas == nil){
        _psnAreas = [NSMutableArray array];
    }
    return _psnAreas;
}

-(NSMutableArray *)getPsnTopsArray
{
    if(_psnTops == nil){
        _psnTops = [NSMutableArray array];
    }
    return _psnTops;
}

-(void) updatePassengerSummary: (id)data
{
    if([self isNull:data])
        return;
    _planInCount = [[data objectForKey:@"planInCount"] intValue];
    _realInCount = [[data objectForKey:@"realInCount"] intValue];
    _planOutCount = [[data objectForKey:@"planOutCount"] intValue];
    _realOutCount = [[data objectForKey:@"realOutCount"] intValue];
}

-(void) updatePassengerForecast: (id)data
{
    if([self isNull:data])
        return;
    _hourInCount = [[data objectForKey:@"hourInCount"] intValue];
    _hourOutCount = [[data objectForKey:@"hourOutCount"] intValue];
}

-(void) updateSafetyPassenger: (id)data
{
    if([self isNull:data])
        return;
    _safeCount = [[data objectForKey:@"safeCount"] intValue];
}

-(void) updatePassengerOnboard: (id)data
{
    if([self isNull:data])
        return;
    
    // hour：代表等待时间分类 分为1、2、3、4 对应图中的相应时间段    count：旅客人数
    [[self getPsnOnPlaneArray] removeAllObjects];
    for(NSDictionary *item in data){
        [[self getPsnOnPlaneArray] addObject:item];
    }
}

//@property (nonatomic,copy) NSMutableArray<NSDictionary *> *psnOnPlane;// 旅客机上等待时间
//
//@property (nonatomic,copy) NSMutableArray<FlightHourModel *> *psnHours;// 旅客小时分布：进港旅客、出港旅客、隔离区内
//@property (nonatomic,copy) NSMutableArray<PassengerAreaModel *> *psnAreas;
//
//@property (nonatomic,copy) NSMutableArray<PassengerTopModel *> *psnTops;// 旅客排名

-(void) updatePsnHours: (id)data flag:(int)flag
{
    if([self isNull:data])
        return;
    
    int index = 0;
    for(NSDictionary *item in data){
        FlightHourModel *model = nil;
        if([[self getPsnHoursArray] count]<index+1){
            model = [FlightHourModel new];
            [[self getPsnHoursArray] addObject:model];
        }else{
            model = [[self getPsnHoursArray] objectAtIndex:index];
        }
        switch (flag) {
                
            case 1:
                model.planArrCount = [[item objectForKey:@"count"] intValue];
                break;
                
            case 2:
                model.arrCount = [[item objectForKey:@"count"] intValue];
                break;
                
            case 3:
                model.planDepCount = [[item objectForKey:@"count"] intValue];
                break;
                
            default:
                break;
        }
        index ++;
    }
}

- (void)updatePeakPnsDays:(id)data
{
    if([self isNull:data])
        return;
    int index = 0;
    for(NSDictionary *item in data){
        PassengerTopModel *model = nil;
        if([[self getPsnTopsArray] count]<index+1){
            model = [PassengerTopModel new];
            [[self getPsnTopsArray] addObject:model];
        }else{
            model = [[self getPsnTopsArray] objectAtIndex:index];
        }
        
//        hour：代表日期，如“10-01”
//        count：代表进港旅客人数
//        ratio：代表出港旅客人数
        model.date = [item objectForKey:@"hour"];
        model.count = [[item objectForKey:@"count"] intValue]+[[item objectForKey:@"ratio"] intValue];
        index ++;
        model.index = index;
    }
}

- (void)updateGlqNearPsn:(id)data
{
    if([self isNull:data])
        return;
    int index = 0;
    for(NSDictionary *item in data){
        PassengerAreaModel *model = nil;
        if([[self getPsnAreasArray] count]<index+1){
            model = [PassengerAreaModel new];
            [[self getPsnAreasArray] addObject:model];
        }else{
            model = [[self getPsnAreasArray] objectAtIndex:index];
        }
        
//        hour：指廊名称 count：指廊旅客数 近机位数=所有count数加起来
//        hour：INT（国际）或者DOM（国内） count：国际或者国内旅客数 远机位数=国际+国内旅客数
        NSString *region = [item objectForKey:@"hour"];
        if(region == nil)
            continue;
        if([region isEqualToString:@"INT"] || [region isEqualToString:@"DOM"])
        {
            model.isFar = YES;
        }else{
            model.isFar = NO;
        }
        model.region = [item objectForKey:@"hour"];
        model.count = [[item objectForKey:@"count"] floatValue];
        index ++;
    }
}

@end
