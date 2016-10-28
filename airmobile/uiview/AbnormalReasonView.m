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
    NSMutableArray<AbnReasonModel *> *array;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self updateShapeArray];
        
        UILabel *rsnLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-40, 23)];
        rsnLabel.text = @"异常原因分类";
        rsnLabel.font = [UIFont systemFontOfSize:18];
        rsnLabel.textColor = [UIColor blackColor];
        [self addSubview:rsnLabel];
        
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 20+23, kScreenWidth-40, 200)];
        topBgView.layer.borderWidth = 2.0f;
        topBgView.layer.borderColor = [[UIColor blackColor] CGColor];
        [topBgView.layer setCornerRadius:8.0];// 将图层的边框设置为圆脚
        [topBgView.layer setMasksToBounds:YES];// 隐藏边界
        [self addSubview:topBgView];
        
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = topBgView.bounds;
//        gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFF3AB2F7] CGColor], (id)[[CommonFunction colorFromHex:0XFF936DF7] CGColor], nil];
//        [topBgView.layer insertSublayer:gradient atIndex:0];
        
        PNPieChart *abnRsnProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 180, 180) items:shapeArray];
        abnRsnProgress.center = CGPointMake(20+100, 100);
        abnRsnProgress.descriptionTextColor = [UIColor whiteColor];
        abnRsnProgress.descriptionTextFont  = [UIFont systemFontOfSize:11];
        abnRsnProgress.descriptionTextShadowColor = [UIColor clearColor];
        abnRsnProgress.showAbsoluteValues = YES;
        abnRsnProgress.showOnlyValues = YES;
        [abnRsnProgress strokeChart];
        abnRsnProgress.legendStyle = PNLegendItemStyleStacked;
        abnRsnProgress.legendFont = [UIFont systemFontOfSize:10];
        abnRsnProgress.innerCircleRadius = 180/2-40;
        [topBgView addSubview:abnRsnProgress];
        
        UILabel *arrInNum = [CommonFunction addLabelFrame:CGRectMake(0, 0, 80, 35) text:@"100" font:30 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF1B1B1B];
        arrInNum.center = CGPointMake(180/2, 180/2-10);
        [abnRsnProgress addSubview:arrInNum];
        UILabel *arrInLabel = [CommonFunction addLabelFrame:CGRectMake(0, 0, 80, 20) text:@"延误总数" font:17 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF1B1B1B];
        arrInLabel.center = CGPointMake(180/2, 180/2-10+30);
        [abnRsnProgress addSubview:arrInLabel];
        
        UIView *legend = [abnRsnProgress getLegendWithMaxWidth:200];
        [legend setFrame:CGRectMake(topBgView.frame.size.width-legend.frame.size.width-20, topBgView.frame.size.height-legend.frame.size.height-20, legend.frame.size.width, legend.frame.size.height)];
        [topBgView addSubview:legend];
        
        //小时分布表格
        UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 20+23+200+40, kScreenWidth-40, kScreenHeight-10-(65+20+23+200+40+20))];
        flightHourTableView.delegate = self;
        flightHourTableView.dataSource = self;
        flightHourTableView.showsVerticalScrollIndicator = NO;
        flightHourTableView.backgroundColor = [UIColor whiteColor];
        flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:flightHourTableView];
        
    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AbnReasonModel *abnRsn = array[indexPath.row];
    AbnReasonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:abnRsn.reason];
    
    if (!cell) {
        cell = [[AbnReasonTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:abnRsn.reason abnReason:abnRsn];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) updateShapeArray
{
    shapeArray = [NSMutableArray new];
    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:15 color:[CommonFunction colorFromHex:0xFFFF7C36] description:@"天气原因"]];
    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:25 color:[CommonFunction colorFromHex:0xFF17B9E8] description:@"军事控制"]];
    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:25 color:[CommonFunction colorFromHex:0xFFFFC000] description:@"航空公司"]];
    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:20 color:[CommonFunction colorFromHex:0xFFFF2F57] description:@"空管"]];
    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:5 color:[CommonFunction colorFromHex:0xFF2FEE65] description:@"机场"]];
    [shapeArray addObject: [PNPieChartDataItem dataItemWithValue:10 color:[CommonFunction colorFromHex:0xFF5A57D8] description:@"其他"]];
    
    array = [NSMutableArray new];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"天气原因" count:15 percent:0.15]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"军事控制" count:25 percent:0.25]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"航空公司" count:25 percent:0.25]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"空管" count:20 percent:0.2]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"机场" count:5 percent:0.05]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"其他" count:10 percent:0.10]];
}

@end
