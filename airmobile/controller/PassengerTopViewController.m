//
//  PassengerTopViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerTopViewController.h"
#import "PassengerTopModel.h"

@interface PassengerTopViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PassengerTopViewController
{
    NSArray<PassengerTopModel *> *array;
}

-(instancetype)initWithDataArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        array = dataArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
//    [self initData];

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                              65,
                                                              kScreenWidth,
                                                              kScreenWidth *369/750)];
    [self.view addSubview:topView];

    UIImageView *imageView = [CommonFunction imageView:@"PeaktravellerBackground"
                                                 frame:CGRectMake(0,
                                                                  0,
                                                                  kScreenWidth,
                                                                  kScreenWidth *369/750)];
    [topView addSubview:imageView];

    UILabel *deapTravellerLabel = [[UILabel alloc]initWithFrame:CGRectMake(21,
                                                                           85/2,
                                                                           100,
                                                                           17)];
    deapTravellerLabel.text = @"高峰旅客";
    deapTravellerLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:21];
    deapTravellerLabel.textColor = [CommonFunction colorFromHex:0XFFefeff0];
    [topView addSubview:deapTravellerLabel];

    UIImage *topImage = [UIImage imageNamed:@"TopList"];
    UIImageView *TopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(22,
                                                                             viewBotton(deapTravellerLabel)+10,
                                                                             topImage.size.width,
                                                                             topImage.size.height)];
    TopImageView.image = topImage;
    [topView addSubview:TopImageView];

    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewX(TopImageView),
                                                                  viewBotton(TopImageView)+10,
                                                                  300,
                                                                  9)];
    timeLabel.text = [NSString stringWithFormat:@"时间范围:%@",@"2016年11月13日-2016年11月13日"];
    timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                     size:21/2];
    timeLabel.textColor = [CommonFunction colorFromHex:0XFFefeff0];
    [topView addSubview:timeLabel];



    //小时分布表格
    UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                                    viewBotton(topView)+8,
                                                                                    kScreenWidth,
                                                                                    kScreenHeight-viewBotton(topView)-49)];
    flightHourTableView.delegate = self;
    flightHourTableView.dataSource = self;
    flightHourTableView.showsVerticalScrollIndicator = NO;
    flightHourTableView.backgroundColor = [UIColor whiteColor];
//    flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    flightHourTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:flightHourTableView];
}

-(void) initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"高峰旅客日排名"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      kScreenWidth,
                                                                      65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PassengerTopModel *model = array[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.date];
    cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                     reuseIdentifier:model.date];
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16,
                                                                                     (viewHeight(cell)-17)/2,
                                                                                     16,
                                                                                     17)];
        headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"PeakList_%ld",indexPath.row+1]];
        [cell addSubview:headerImageView];
        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(headerImageView)+20,
                                                                  0,
                                                                  cell.frame.size.width/2-20-viewTrailing(headerImageView),
                                                                  cell.frame.size.height)
                                                  text:model.date font:35/2
                                         textAlignment:(NSTextAlignmentLeft)
                                          colorFromHex:0xFF000000]];

        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
                                                                  0,
                                                                  kScreenWidth/2-20,
                                                                  cell.frame.size.height)
                                                  text:[NSString stringWithFormat:@"%i",model.count]
                                                  font:35/2
                                         textAlignment:(NSTextAlignmentRight)
                                          colorFromHex:0xFF000000]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//-(void) initData
//{
//    if(array == nil){
//        array = [[NSMutableArray alloc] init];
//    }else{
//        [array removeAllObjects];
//    }
//    
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-5-25" count:5410 index:1]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-6-25" count:5230 index:2]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-7-25" count:5120 index:3]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-8-25" count:5048 index:4]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-9-25" count:5042 index:5]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-7-25" count:5120 index:6]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-8-25" count:5048 index:7]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-9-25" count:5042 index:8]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-7-25" count:5120 index:9]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-8-25" count:5048 index:10]];
//    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-9-25" count:5042 index:11]];
//    
//}

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
