//
//  FlightDetailModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/23.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface FlightDetailModel : RootModel

@property(nonatomic,assign) NSInteger id;
@property(nonatomic,copy) NSString *fNum;//航班号(进港/出港)
@property(nonatomic,copy) NSString *arrState;//进港状态
@property(nonatomic,copy) NSString *depState;//出港状态
@property(nonatomic,copy) NSString *airLine;//航线(中文名称)
@property(nonatomic,copy) NSString *arrDate;//进港航班日期
@property(nonatomic,copy) NSString *depDate;//出港航班日期
@property(nonatomic,copy) NSString *terminal;//候机楼
@property(nonatomic,copy) NSString *arrSeat;//进港机位
@property(nonatomic,copy) NSString *depSeat;//出港机位
@property(nonatomic,copy) NSString *arrRegion;//进港属性
@property(nonatomic,copy) NSString *depRegion;//出港属性
@property(nonatomic,copy) NSString *model;//机型
@property(nonatomic,copy) NSString *baggage;//行李转盘
@property(nonatomic,copy) NSString *preorderNum;//前序航班号
@property(nonatomic,copy) NSString *preorderState;//前序航班状态
@property(nonatomic,copy) NSString *arrPerson;//进港人数
@property(nonatomic,copy) NSString *depPerson;//出港人数
@property(nonatomic,copy) NSString *gate;//登机口
@property(nonatomic,copy) NSString *checkCounter;//值机柜台
@property(nonatomic,copy) NSString *removeGearDate;//预计撤轮档时间
@property(nonatomic,copy) NSString *aboveTakeoffPlan;//前方起飞  计划
@property(nonatomic,copy) NSString *aboveTakeoffExp;//前方起飞  预计
@property(nonatomic,copy) NSString *aboveTakeoffReal;//前方起飞  实际
@property(nonatomic,copy) NSString *thisArrivePlan;//本站到达 计划
@property(nonatomic,copy) NSString *thisArriveExp;//本站到达 预计
@property(nonatomic,copy) NSString *thisArriveReal;//本站到达 实际
@property(nonatomic,copy) NSString *thisTakeoffPlan;//本站起飞  计划
@property(nonatomic,copy) NSString *thisTakeoffExp;//本站起飞  预计
@property(nonatomic,copy) NSString *thisTakeoffReal;//本站起飞  实际
@property(nonatomic,copy) NSString *afterArrivePlan;//下站到达 计划
@property(nonatomic,copy) NSString *afterArriveExp;//下站到达 预计
@property(nonatomic,copy) NSString *afterArriveReal;//下站到达 实际

@end
