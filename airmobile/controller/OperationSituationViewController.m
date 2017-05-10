//
//  OperationSituationViewController.m
//  airmobile
//
//  Created by xuesong on 17/3/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "OperationSituationViewController.h"
#import "OperationSituationTableViewCell.h"
#import "WaterWareView.h"
#import "HttpsUtils+Business.h"
#import "OperationSituationView.h"
#import "FlightHourModel.h"


static NSString * tableIdentifier = @"OPERATIONSITUATIONTABLECELL";
@interface OperationSituationViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableKeyArray;
@property (nonatomic, copy) NSArray *tableValueArray;
@property (weak, nonatomic) IBOutlet UIView *brokenLineContentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inOutSegmentedControl;

@property (nonatomic, strong) OperationSituationView *inLineView ;
@property (nonatomic, strong) OperationSituationView *outLineView ;
@property (nonatomic, strong) WaterWareView *waterWareView;

@property (nonatomic, copy) NSArray *inArray;
@property (nonatomic, copy) NSArray *outArray;

@end

@implementation OperationSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTitleView];


    [_tableView registerNib:[UINib nibWithNibName:@"OperationSituationTableViewCell" bundle:nil]  forCellReuseIdentifier:tableIdentifier];

    _tableKeyArray = @[@"进港速度",
                    @"出港速度",@"延误航班数量",@"取消航班数量"];
    _tableValueArray = @[@"",@"",@"",@""];

    _waterWareView = [[WaterWareView alloc]initWithFrame:CGRectMake((viewWidth(_topView)-100)/2, (viewHeight(_topView)-100)/2, 100, 100) color:[CommonFunction colorFromHex:0Xe53dfc7a]];
    _waterWareView.backgroundColor = [CommonFunction colorFromHex:0Xe5bdfcbd];
    _waterWareView.titleLabel.text = @"正在获取";
    //颜色 正常e53dfc7a  小面积延误e5ffc32d 大面积延误e5FF3030
    [_topView addSubview:_waterWareView];


    _inLineView = [[NSBundle mainBundle]loadNibNamed:@"OperationSituationView" owner:nil options:nil][0];
    CGRect inFrame = _inLineView.frame;
    inFrame.size.width = kScreenWidth;
    _inLineView.frame = inFrame;
    [_brokenLineContentView addSubview:_inLineView];
    _outLineView = [[NSBundle mainBundle]loadNibNamed:@"OperationSituationView" owner:nil options:nil][0];
    CGRect outFrame = _outLineView.frame;
    outFrame.size.width = kScreenWidth;
    outFrame.origin.x = kScreenWidth;
    _outLineView.frame = outFrame;
    [_brokenLineContentView addSubview:_outLineView];

    _inArray = [NSArray array];
    _outArray = [NSArray array];


    [self getHttp];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"运营情况"];
    [self titleViewAddBackBtn];
    self.fd_interactivePopDisabled = YES;
}

-(void)getHttp
{
    //正常 、延误
    [HttpsUtils getSummaryInfo:nil success:^(id responesObj) {
        if ([responesObj isKindOfClass:[NSDictionary class]]) {
            NSString *status = [responesObj objectForKey:@"warning"];
            WaterWareStatus wStatus ;
            if([status containsString:@"红色"]){
                wStatus = waterWareStatusDYW;
            }else if([status containsString:@"橙色"]){
                wStatus = waterWareStatusXYW;
            }else if([status containsString:@"黄色"]){
                wStatus = waterWareStatusXYW;
            }else if([status containsString:@"蓝色"]){
                wStatus = waterWareStatusXYW;
            }else{
                wStatus = waterWareStatusZC;
            }
           
            _waterWareView.titleLabel.text = status?:@"";
            [_waterWareView updateStatus:wStatus];
        }

    } failure:nil];
    // 计划进港航班小时分布 /flt/planArrFltPerHour
    [HttpsUtils getPlanArrHours:nil success:^(id responesObj) {
        if ([responesObj isKindOfClass:[NSDictionary class]]) {
            NSArray *plan = [responesObj objectForKey:@"planArrFltH"];
            NSArray *real = [responesObj objectForKey:@"realArrFltH"];
            NSMutableArray *planMutable = [NSMutableArray array];
            for (NSDictionary *dic  in plan ) {
                FlightHourModel *model = [[FlightHourModel alloc]initWithDictionary:dic];
                [planMutable addObject:model];
            }

            NSMutableArray *realMutable = [NSMutableArray array];
            for (NSDictionary *dic  in real ) {
                FlightHourModel *model = [[FlightHourModel alloc]initWithDictionary:dic];
                [realMutable addObject:model];
            }
            _inArray = @[[planMutable copy],[realMutable copy]];
            [_inLineView reDraw:_inArray];
        }
    } failure:nil];
    [HttpsUtils getPlanDepHours:nil success:^(id responesObj) {
        if ([responesObj isKindOfClass:[NSDictionary class]]) {
            _outArray = responesObj;
//            NSArray *plan = [responesObj objectForKey:@"planDepFltH"][@"planDepFltH"];
//            NSArray *real = [responesObj objectForKey:@"realDepFltH"][@"realDepFltH"];
            NSArray *plan = [responesObj objectForKey:@"planDepFltH"];
            NSArray *real = [responesObj objectForKey:@"realDepFltH"];
            NSMutableArray *planMutable = [NSMutableArray array];
            for (NSDictionary *dic  in plan ) {
                FlightHourModel *model = [[FlightHourModel alloc]initWithDictionary:dic];
                [planMutable addObject:model];
            }

            NSMutableArray *realMutable = [NSMutableArray array];
            for (NSDictionary *dic  in real ) {
                FlightHourModel *model = [[FlightHourModel alloc]initWithDictionary:dic];
                [realMutable addObject:model];
            }
            _outArray = @[[planMutable copy],[realMutable copy]];
            [_outLineView reDraw:_outArray];
        }
    } failure:nil];

    //进港速率
    [HttpsUtils fltArrFltTargetSuccess:^(id responesObj) {

//        NSLog(@"%@",responesObj);
//        _tableArray[indexPath.row][@"key"]
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:_tableValueArray];

        NSString *value = @"";

        if ([responesObj isKindOfClass:[NSDictionary class]]) {
            if ([[responesObj objectForKey:@"inSpeed"] isKindOfClass:[NSString class]]) {
                value = [responesObj objectForKey:@"inSpeed"];
                mutableArray[0]=[NSString stringWithFormat:@"%@分/架",value];
            }
        }
        _tableValueArray = [mutableArray copy];
        [_tableView reloadData];
    } failure:^(id error) {
//        NSLog(@"");
    }];
    //出港速率
    [HttpsUtils fltDepFltTargetSuccess:^(id responesObj) {

        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:_tableValueArray];
        if ([responesObj isKindOfClass:[NSDictionary class]]) {
            mutableArray[1]=[NSString stringWithFormat:@"%@%@",[responesObj objectForKey:@"releaseSpeed"]?:@"",@"分/架"];
        }
        _tableValueArray = [mutableArray copy];
        [_tableView reloadData];
    } failure:^(id error) {
        
    }];

    //获取航班信息
    [HttpsUtils getFlightStatusInfo:nil success:^(id responesObj) {
//        NSLog(@"%@",responesObj);
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:_tableValueArray];
        if ([responesObj isKindOfClass:[NSDictionary class]]) {
            mutableArray[2]=[NSString stringWithFormat:@"%ld%@",((NSNumber *)[responesObj objectForKey:@"outDelay"]).longValue+((NSNumber *)[responesObj objectForKey:@"inDelay"]).longValue,@"架"];
            mutableArray[3]=[NSString stringWithFormat:@"%ld%@",((NSNumber *)[responesObj objectForKey:@"outCancel"]).longValue+((NSNumber *)[responesObj objectForKey:@"inCancel"]).longValue,@"架"];
        }
        _tableValueArray = [mutableArray copy];
        [_tableView reloadData];

    } failure:nil];
}

- (IBAction)inOutSegementedValueChanged:(id)sender {

    if (_inOutSegmentedControl.selectedSegmentIndex == 0) {//进港

        [UIView animateWithDuration:0.5 animations:^{
            CGRect inFrame = _inLineView.frame;
            inFrame.origin.x = 0;
            _inLineView.frame =inFrame;
            CGRect outFrame = _outLineView.frame;
            outFrame.origin.x = kScreenWidth;
            _outLineView.frame =outFrame;

        }];
    }else{//出港
        [UIView animateWithDuration:0.5 animations:^{
            CGRect inFrame = _inLineView.frame;
            inFrame.origin.x = -kScreenWidth;
            _inLineView.frame =inFrame;
            CGRect outFrame = _outLineView.frame;
            outFrame.origin.x = 0;
            _outLineView.frame =outFrame;
        }];
    }
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OperationSituationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];

    cell.title.text = _tableKeyArray[indexPath.row];
    cell.value.text = _tableValueArray[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
