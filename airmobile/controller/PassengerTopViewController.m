//
//  PassengerTopViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerTopViewController.h"
#import "PassengerTopModel.h"

@interface PassengerTopViewController ()

@end

@implementation PassengerTopViewController
{
    NSMutableArray<PassengerTopModel *> *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
    [self initData];
    UIImageView *imageView = [CommonFunction imageView:@"overview_toppsn.png" frame:CGRectMake(0, 65, kScreenWidth, 200)];
    [self.view addSubview:imageView];
    
    //小时分布表格
    UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 65+200+20, kScreenWidth-40, kScreenHeight-10-(65+20+200+20+40))];
    flightHourTableView.delegate = self;
    flightHourTableView.dataSource = self;
    flightHourTableView.showsVerticalScrollIndicator = NO;
    flightHourTableView.backgroundColor = [UIColor whiteColor];
    flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:flightHourTableView];
}

-(void) initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"高峰旅客日排名"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PassengerTopModel *model = array[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.date];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:model.date];
        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(0, 0, cell.frame.size.width/2-20, cell.frame.size.height) text:model.date font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        
        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(cell.frame.size.width/2, 0, cell.frame.size.width/2-20, cell.frame.size.height) text:[NSString stringWithFormat:@"%i",model.count] font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) initData
{
    if(array == nil){
        array = [[NSMutableArray alloc] init];
    }else{
        [array removeAllObjects];
    }
    
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-5-25" count:5410 index:1]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-6-25" count:5230 index:2]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-7-25" count:5120 index:3]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-8-25" count:5048 index:4]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-9-25" count:5042 index:5]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
