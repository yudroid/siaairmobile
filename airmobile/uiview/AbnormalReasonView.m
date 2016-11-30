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
}

- (instancetype)initWithFrame:(CGRect)      frame
                    dataArray:(NSArray *)   dataArray
{
    self = [super initWithFrame:frame];
    
    if(self){
        
//        [self updateShapeArray];
//
//        UILabel *rsnLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-40, 23)];
//        rsnLabel.text = @"异常原因分类";
//        rsnLabel.font = [UIFont systemFontOfSize:18];
//        rsnLabel.textColor = [UIColor blackColor];
//        [self addSubview:rsnLabel];

        array                   = dataArray;
        [self updateShapeArray];
        CGFloat topBgViewWidth  = kScreenWidth-2*px2(22);
        UIView *topBgView       = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image          = [UIImage imageNamed:@"AbnormalReasonChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];

        
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = topBgView.bounds;
//        gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFF3AB2F7] CGColor], (id)[[CommonFunction colorFromHex:0XFF936DF7] CGColor], nil];
//        [topBgView.layer insertSublayer:gradient atIndex:0];
        
        PNPieChart *abnRsnProgress  = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 10, viewHeight(topBgView)-20, viewHeight(topBgView)-20) items:shapeArray];
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
        UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
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
        
    }
    
    return self;
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
                                                  abnReason:abnRsn];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) updateShapeArray
{
    NSDictionary *colorDic = @{@"天气原因"  :[CommonFunction colorFromHex:0xFFFF7C36] ,
                               @"军事控制"  :[CommonFunction colorFromHex:0xFF17B9E8] ,
                               @"航空公司"  :[CommonFunction colorFromHex:0xFFFF7C36] ,
                               @"空管"     :[CommonFunction colorFromHex:0xFFFF2F57] ,
                               @"机场"     :[CommonFunction colorFromHex:0xFF2FEE65] ,
                               @"其他"     :[CommonFunction colorFromHex:0xFF5A57D8]
                               };
    shapeArray = [NSMutableArray new];
    for (AbnReasonModel *model in array) {
        [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:model.count
                                                               color:[colorDic objectForKey:model.reason]
                                                         description:model.reason]];
    }
//    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:15 color:[CommonFunction colorFromHex:0xFFFF7C36] description:@"天气原因"]];
//    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:25 color:[CommonFunction colorFromHex:0xFF17B9E8] description:@"军事控制"]];
//    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:25 color:[CommonFunction colorFromHex:0xFFFFC000] description:@"航空公司"]];
//    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:20 color:[CommonFunction colorFromHex:0xFFFF2F57] description:@"空管"]];
//    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:5 color:[CommonFunction colorFromHex:0xFF2FEE65] description:@"机场"]];
//    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:10 color:[CommonFunction colorFromHex:0xFF5A57D8] description:@"其他"]];

//    array = [NSMutableArray new];
//    [array addObject: [[AbnReasonModel alloc] initWithReason:@"天气原因" count:15 percent:0.15]];
//    [array addObject: [[AbnReasonModel alloc] initWithReason:@"军事控制" count:25 percent:0.25]];
//    [array addObject: [[AbnReasonModel alloc] initWithReason:@"航空公司" count:25 percent:0.25]];
//    [array addObject: [[AbnReasonModel alloc] initWithReason:@"空管" count:20 percent:0.2]];
//    [array addObject: [[AbnReasonModel alloc] initWithReason:@"机场" count:5 percent:0.05]];
//    [array addObject: [[AbnReasonModel alloc] initWithReason:@"其他" count:10 percent:0.10]];
}

-(NSInteger)sum
{
    NSInteger s = 0;
    for (AbnReasonModel *model in array) {
        s +=model.count;
    }
    return s;
}
@end
