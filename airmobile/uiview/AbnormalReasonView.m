//
//  AbnormalReasonView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalReasonView.h"
#import "AbnReasonTableViewCell.h"
#import "AbnReasonModel.h"

@implementation AbnormalReasonView
{
    NSMutableArray *shapeArray;
    NSArray<AbnReasonModel *> *array;
    UITableView *flightHourTableView;
    PNPieChart *abnRsnProgress;
    UIView *topBgView;
}

- (instancetype)initWithFrame:(CGRect)      frame
                    dataArray:(NSArray *)   dataArray
{
    self = [super initWithFrame:frame];
    
    if(self){


        array                   = dataArray;
        [self updateShapeArray];
        CGFloat topBgViewWidth  = kScreenWidth-2*px2(22);
        topBgView       = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image          = [UIImage imageNamed:@"AbnormalReasonChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];
        
        abnRsnProgress  = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 10, viewHeight(topBgView)-20, viewHeight(topBgView)-20) items:shapeArray];
        abnRsnProgress.center       = CGPointMake(20+100, viewHeight(topBgView)/2);
        abnRsnProgress.descriptionTextColor         = [UIColor whiteColor];
        abnRsnProgress.descriptionTextFont          = [UIFont systemFontOfSize:11];
        abnRsnProgress.descriptionTextShadowColor   = [UIColor clearColor];
        abnRsnProgress.showAbsoluteValues           = YES;
        abnRsnProgress.showOnlyValues               = YES;
        [abnRsnProgress strokeChart];
        abnRsnProgress.legendStyle                  = PNLegendItemStyleStacked;
        abnRsnProgress.legendFont                   = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        abnRsnProgress.innerCircleRadius            = viewHeight(abnRsnProgress)/2-40;
        [topBgView addSubview:abnRsnProgress];

        
        UILabel *arrInNum = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                     (viewY(abnRsnProgress)+viewHeight(abnRsnProgress))/2-35/2-12,
                                                                     viewWidth(abnRsnProgress),
                                                                     24)
                                                     text:@([self sum]).stringValue
                                                     font:32 textAlignment:(NSTextAlignmentCenter)
                                             colorFromHex:0xFF129cc4];
        [abnRsnProgress addSubview:arrInNum];
        UILabel *arrInLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                       viewBotton(arrInNum)+10,
                                                                       viewWidth(abnRsnProgress),
                                                                       13)
                                                       text:@"延误总数"
                                                       font:17
                                              textAlignment:(NSTextAlignmentCenter)
                                               colorFromHex:0xFF129cc4];
        [abnRsnProgress addSubview:arrInLabel];
        
        UIView *legend = [abnRsnProgress getLegendWithMaxWidth:200];
        [legend setFrame:CGRectMake(topBgView.frame.size.width-legend.frame.size.width-20,
                                    topBgView.frame.size.height-legend.frame.size.height-20,
                                    legend.frame.size.width,
                                    legend.frame.size.height)];
        [topBgView addSubview:legend];
        
        //小时分布表格
        flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                                        viewBotton(topBgView)+20,
                                                                                        kScreenWidth,
                                                                                        kScreenHeight-viewBotton(topBgView)-20)];
        flightHourTableView.delegate                        = self;
        flightHourTableView.dataSource                      = self;
        flightHourTableView.showsVerticalScrollIndicator    = NO;
        flightHourTableView.backgroundColor                 = [UIColor whiteColor];
        flightHourTableView.separatorStyle                  = UITableViewCellSeparatorStyleNone;
        flightHourTableView.tableFooterView                 = [[UIView alloc]init];
        [self addSubview:flightHourTableView];

//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(loadData:)
//                                                     name:@""
//                                                   object:nil];

    }
    
    return self;
}

-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"" object:nil];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return px_px_2_3(82, 128);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AbnReasonModel *abnRsn = array[indexPath.row];
    AbnReasonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:abnRsn.reason];
    
    if (!cell) {
        cell = [[AbnReasonTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                            reuseIdentifier:abnRsn.reason
                                                  abnReason:abnRsn
                                                        sum:[self sum]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) updateShapeArray
{
    NSDictionary *colorDic = @{@"天气"  :[CommonFunction colorFromHex:0xFFFFB6C1] ,
                               @"军事活动"  :[CommonFunction colorFromHex:0xFFADD8E6] ,
                               @"航空公司"  :[CommonFunction colorFromHex:0xFF87CEFA] ,
                               @"空管"     :[CommonFunction colorFromHex:0xFFFFA07A] ,
                               @"旅客"     :[CommonFunction colorFromHex:0xFFF08080] ,
                               @"其他"     :[CommonFunction colorFromHex:0xFF90EE90]
                               };
    shapeArray = [NSMutableArray new];
    for (AbnReasonModel *model in array) {
        [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:model.count
                                                               color:[colorDic objectForKey:model.reason]
                                                         description:model.reason]];
    }

}

-(NSInteger)sum
{
    NSInteger s = 0;
    for (AbnReasonModel *model in array) {
        s +=model.count;
    }
    return s;
}

-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSArray class]]) {

        if(!array || array.count == 0 )
        {
            array = notification.object;

            [flightHourTableView reloadData];

            [self updateShapeArray];

            abnRsnProgress  = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 10, viewHeight(topBgView)-20, viewHeight(topBgView)-20) items:shapeArray];
            abnRsnProgress.center       = CGPointMake(20+100, viewHeight(topBgView)/2);
            abnRsnProgress.descriptionTextColor         = [UIColor whiteColor];
            abnRsnProgress.descriptionTextFont          = [UIFont systemFontOfSize:11];
            abnRsnProgress.descriptionTextShadowColor   = [UIColor clearColor];
            abnRsnProgress.showAbsoluteValues           = YES;
            abnRsnProgress.showOnlyValues               = YES;
            [abnRsnProgress strokeChart];
            abnRsnProgress.legendStyle                  = PNLegendItemStyleStacked;
            abnRsnProgress.legendFont                   = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
            abnRsnProgress.innerCircleRadius            = viewHeight(abnRsnProgress)/2-40;
            [topBgView addSubview:abnRsnProgress];

        }


    }
}
@end
