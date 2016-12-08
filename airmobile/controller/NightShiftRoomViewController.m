//
//  NightShiftRoomViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "NightShiftRoomViewController.h"
#import <DAYCalendarView.h>
#import "NightShiftRoomTableViewCell.h"
#import "DutyModel.h"
#import "HttpsUtils+Business.h"

static void *CapturingStillImageContext = &CapturingStillImageContext;
static const NSString *NIGHTSHIFTROOM_TABLECELL_IDENTIFIER = @"NIGHTSHIFTROOM_TABLECELL_IDENTIFIER";

@interface NightShiftRoomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DAYCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableArray;

@end

@implementation NightShiftRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"值班表"];
    [self titleViewAddBackBtn];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NightShiftRoomTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)NIGHTSHIFTROOM_TABLECELL_IDENTIFIER];

    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                                    action:@selector(leftSwipeGestureRecognizerEvent)];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [_calendarView addGestureRecognizer:leftSwipeGestureRecognizer];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                                     action:@selector(rightSwipeGestureRecognizerEvent)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_calendarView addGestureRecognizer:rightSwipeGestureRecognizer];



    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectDate:)
                                                 name:@"SelectedDate"
                                               object:nil];


}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SelectedDate" object:nil];
}

-(void)selectDate:(NSNotification *)notification
{
    [self UpdateNetwork];
}

-(void)UpdateNetwork
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:_calendarView.selectedDate];
    NSLog(@"%@",currentDateStr);


    [HttpsUtils getDutyTableByDay:currentDateStr success:^(NSArray *responseObj) {
        if ([responseObj isKindOfClass:[NSArray class]]) {
            NSMutableArray *depMutableArray = [NSMutableArray array];
            //            for (NSDictionary *depDic in responseObj) {
            //                DeptInfoModel *deptModel = [[DeptInfoModel alloc]initWithDictionary:depDic];
            //                [depMutableArray addObject:deptModel];
            //            }
            //            array = [depMutableArray copy];
            //            _resultArry = [NSMutableArray array];
            //            for (int i = 0; i<array.count; i++) {
            //                // 初始时都是折叠状态（bool不能直接放在数组里）
            //                [_resultArry addObject:[NSNumber numberWithBool:NO]];
            //            }
            [_tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)loadData
{
    NSDictionary *dic = @{@"userName":@"通讯录",@"section":@"AddressBook",@"duty":@"duty",@"phone":@"AddressBook",@"date":@"date"};
    DutyModel *dutuModel1 = [[DutyModel alloc]initWithDictionary:dic];
    _tableArray= @[dutuModel1];
}

#pragma mark - EVENT
-(void)leftSwipeGestureRecognizerEvent
{
    [_calendarView jumpToNextMonth];

}
-(void)rightSwipeGestureRecognizerEvent
{
    [_calendarView jumpToPreviousMonth];
    
}
#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NightShiftRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)NIGHTSHIFTROOM_TABLECELL_IDENTIFIER];
    cell.dutyModel = _tableArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
