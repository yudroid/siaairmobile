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

static const NSString *NIGHTSHIFTROOM_TABLECELL_IDENTIFIER = @"NIGHTSHIFTROOM_TABLECELL_IDENTIFIER";

@interface NightShiftRoomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DAYCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    
    [_tableView registerNib:[UINib nibWithNibName:@"NightShiftRoomTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)NIGHTSHIFTROOM_TABLECELL_IDENTIFIER];

    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipeGestureRecognizerEvent)];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [_calendarView addGestureRecognizer:leftSwipeGestureRecognizer];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeGestureRecognizerEvent)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_calendarView addGestureRecognizer:rightSwipeGestureRecognizer];
    
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NightShiftRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)NIGHTSHIFTROOM_TABLECELL_IDENTIFIER];
    return cell;
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
