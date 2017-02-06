//
//  NightShiftRoomViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "NightShiftRoomViewController.h"
#import "NightShiftRoomTableViewCell.h"
#import "DutyModel.h"
#import "HttpsUtils+Business.h"
#import "DutyModel.h"
#import "DAYCalendarView.h"
#import "NSDate+Extension.h"
#import "UIViewController+Reminder.h"

static void *CapturingStillImageContext = &CapturingStillImageContext;
static const NSString *NIGHTSHIFTROOM_TABLECELL_IDENTIFIER = @"NIGHTSHIFTROOM_TABLECELL_IDENTIFIER";

@interface NightShiftRoomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DAYCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray<DutyModel *> *tableArray;

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

    self.fd_interactivePopDisabled = YES;

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

    [self UpdateNetwork];

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
    NSDate *date = _calendarView.selectedDate?:[NSDate date];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    NSLog(@"%@",currentDateStr);
    [self starNetWorking];

    [HttpsUtils getDutyTableByDay:currentDateStr success:^(NSArray *responseObj) {
        if ([responseObj isKindOfClass:[NSArray class]]) {
            _tableArray = [responseObj DictionaryToModel:[DutyModel class]];
            _tableArray= [_tableArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSInteger x1 = ((DutyModel *)obj1).sort;
                NSInteger x2 = ((DutyModel *)obj2).sort;
                return  x1>x2;
            }];
            [_tableView reloadData];
        }
        [self stopNetWorking];

    } failure:^(NSError *error) {
        [self stopNetWorking];

    }];
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

    DutyModel *dutyModel = _tableArray[indexPath.row];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",dutyModel.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
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
