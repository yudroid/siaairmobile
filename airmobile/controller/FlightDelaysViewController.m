//
//  FlightDelaysViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDelaysViewController.h"
#import "FlightDelaysTableViewCell.h"
#import "FlightDelaysDetailViewController.h"
#import "PersistenceUtils+Business.h"
#import <MJRefresh.h>
#import "SysMessageModel.h"

static const NSString *FLGHTDELAYS_TABLECELL_IDENTIFIER = @"FLGHTDELAYS_TABLECELL_IDENTIFIER";

@interface FlightDelaysViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FlightDelaysViewController
{
    NSMutableArray *data;
    int startIndex;
    int pagesize;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTitle];

    _tableView.delegate = self;
    _tableView.dataSource =self;
    
    startIndex = 0;
    pagesize = 20;
    data = [NSMutableArray array];
    
    // Do any additional setup after loading the view from its nib.
    //添加下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                            refreshingAction:@selector(updateNetwork)];
    //添加上拉加载
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadMoreNetwork)];
    
    [self refreshData];
}

-(void)initTitle
{
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    if(![_type isEqualToString:@"FLIGHT"]){
        [self titleViewAddTitleText:@"指令消息列表"];
    }else{
        [self titleViewAddTitleText:@"航班消息列表"];
    }
    [self titleViewAddBackBtn];

}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(data != nil)
        return [data count];
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightDelaysTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLGHTDELAYS_TABLECELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDelaysTableViewCell"
                                             owner:nil
                                           options:nil][0];
    }
    
    SysMessageModel *model = [[SysMessageModel alloc] initWithDictionary:[data objectAtIndex:indexPath.row]];
    
    cell.authorLabel.text = [NSString stringWithFormat:@"%@", model.createtime];
    cell.titleLabel.text = model.title;
    cell.read = (![model.readtime isEqualToString:@"<null>"]);
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [data objectAtIndex:indexPath.row];
    SysMessageModel *model = [[SysMessageModel alloc] initWithDictionary:dic];
    [PersistenceUtils updateSysMessageRead:model.msgid];
    [self.tabBarView setHasNewMessage:[PersistenceUtils unReadCount]];
    
    FlightDelaysDetailViewController *flightDelaysDetailVC = [[FlightDelaysDetailViewController alloc]initWithNibName:@"FlightDelaysDetailViewController" bundle:nil];
    flightDelaysDetailVC.titleText = model.title;
    flightDelaysDetailVC.timeLabel.text = model.createtime;
    flightDelaysDetailVC.contentText = model.content;
    [self.navigationController pushViewController:flightDelaysDetailVC
                                         animated:YES];
    [dic setValue:[CommonFunction nowDate] forKey:@"readtime"];
    [data setObject:dic atIndexedSubscript:indexPath.row];
    [_tableView reloadData];
}

-(void)refreshData
{
    [data removeAllObjects];
    startIndex = 0;
    [data addObjectsFromArray:[PersistenceUtils findSysMsgListByType:_type start:startIndex num:pagesize]];
    [_tableView reloadData];
    startIndex = (int)[data count];
}

-(void)updateNetwork
{
    [data removeAllObjects];
    startIndex = 0;
    @try {
        [data addObjectsFromArray:[PersistenceUtils findSysMsgListByType:_type start:startIndex num:pagesize]];
        [_tableView reloadData];
    } @catch (NSException *exception) {
        
    } @finally {
        [_tableView.mj_header endRefreshing];
    }
    startIndex = (int)[data count];
}

-(void)loadMoreNetwork
{
    @try {
        [data addObjectsFromArray:[PersistenceUtils findSysMsgListByType:_type start:startIndex num:pagesize]];
        [_tableView reloadData];
    } @catch (NSException *exception) {
        
    } @finally {
        [_tableView.mj_footer endRefreshing];
    }
    startIndex = (int)[data count];
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
