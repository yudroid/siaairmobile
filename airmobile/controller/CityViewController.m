//
//  CityViewController.m
//  KaiYa
//
//  Created by VIPUI_CC on 16/2/17.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "CityViewController.h"
#import "KyAirportService.h"
#import "StringUtils.h"
#import "KyAirportService.h"
#import "UIViewController+Reminder.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation CityViewController{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSMutableArray * _sectionArray;

    NSMutableArray * _searchArray;
    UITextField *_searchTextF;
    BOOL _dmst;// 国内国际区域属性
    BOOL _searchFlag;

    UIView *_noResultView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleViewInit];
    self.view.backgroundColor = [CommonFunction colorFromHex:0XFFF7F7F7];

    // 初始的时候不是搜索状态
    _searchFlag = false;
    // 从SQLITE中加载各航站数据替换原来demo
    _dmst = true;


    //创建展示的,tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64+44, kScreenWidth, kScreenHeight - 64-44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    [self createSearch];

    [self initAirportArray];

    if(_dataArray!=nil && _dataArray.count>1&&((NSArray*)_dataArray[0]).count==9&&((NSArray*)_dataArray[1]).count==0){
        [self starNetWorking];
        [[KyAirportService sharedKyAirportService] cacheAirportSucess:^{
            [self initAirportArray];
            [self stopNetWorking];
        } failure:^{
            [self stopNetWorking];
            [self showAnimationTitle:@"获取失败"];

        }];
    }
}

/**
 *  @author yangql, 16-02-24 12:02:06
 *
 *  @brief  初始化航站信息并进行展示
 */
-(void) initAirportArray
{
    //开辟空间
    _dataArray=[NSMutableArray array];
    _sectionArray=[NSMutableArray array];

    NSString *region = _dmst?@"1":@"0";
    __block NSArray *airportArr = [[KyAirportService sharedKyAirportService] loadAirportByRegion:region];


    [_sectionArray addObject:@"热门"];
    [_dataArray addObject:[[KyAirportService sharedKyAirportService] findFavouriteAirport:region]];

    for (int i='A'; i<='Z'; i++) {
        NSMutableArray * arr = [NSMutableArray array];
        NSString * string = [NSString stringWithFormat:@"%c",i];
        [_sectionArray addObject:string];
        // 将航站按照首字母进行分组
        for(Airport *airport in airportArr){
            if([string isEqualToString:airport.first]){
                [arr addObject:airport];
            }
        }
        [_dataArray addObject:arr];
    }
    [_tableView reloadData];
}

- (void)createSearch{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headerView;

    _searchTextF = [[UITextField alloc]initWithFrame:CGRectMake(13, 64+5, kScreenWidth - 13*2, 32)];
    _searchTextF.delegate = self;
    _searchTextF.layer.cornerRadius = 5;
    _searchTextF.layer.masksToBounds = YES;
    _searchTextF.backgroundColor = [UIColor whiteColor];
    UIButton *searchImgV = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [searchImgV setImage:[UIImage imageNamed:@"search"] forState:(UIControlStateNormal)];
    _searchTextF.leftView = searchImgV;
    _searchTextF.placeholder = @"搜索城市名,三字码";
    _searchTextF.leftViewMode = UITextFieldViewModeAlways;
    _searchTextF.font = [UIFont systemFontOfSize:14];
    _searchTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_searchTextF];


    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    tap.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:tap];

    // 创建搜索无内容的提示信息
    _noResultView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+44, kScreenWidth, kScreenHeight - 64)];
    _noResultView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_noResultView];
    UIImageView *noSearchImgV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 156/2)/2, 81, 78, 78)];
    noSearchImgV.image = [UIImage imageNamed:@"chose_area_search"];
    [_noResultView addSubview:noSearchImgV];
    UILabel *noSearchLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 81+78+24, kScreenWidth, 17)];
    noSearchLabel.textAlignment = NSTextAlignmentCenter;
    noSearchLabel.text = @"无结果,请试试其他关键词";
    noSearchLabel.font = [UIFont systemFontOfSize:15];
    noSearchLabel.textColor = [CommonFunction colorFromHex:0XFF9F9F9F];
    [_noResultView addSubview:noSearchLabel];
    _noResultView.hidden = true;
}

/**
 *  @author yangql, 16-02-26 17:02:32
 *
 *  @brief <#Description#>
 *
 *  @param textField <#textField description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searchTextF resignFirstResponder];
    //更新搜索结果
    if (_searchArray) {
        [_searchArray removeAllObjects];
    }else{
        _searchArray = [[NSMutableArray alloc]init];
    }

    _searchFlag = true;
    // 如果搜索框内容为空直接返回重新刷新数据
    if([StringUtils isNullOrEmpty:_searchTextF.text]){
        _noResultView.hidden = true;
        _searchFlag = false;
        [_tableView reloadData];
    }else{

        // yangql修改 根据机场的cn和Search内容比较对数据进行筛选
        for (NSMutableArray * array in _dataArray) {
            for (Airport *airport in array) {
                if ([airport.cn rangeOfString:[_searchTextF.text uppercaseString]].location!=NSNotFound || [airport.iata rangeOfString:[_searchTextF.text uppercaseString]].location!=NSNotFound) {
                    NSInteger status = 0;
                    for (Airport *searchAirport in _searchArray) {
                        if ([airport.cn isEqualToString: searchAirport.cn]||[airport.iata isEqualToString: searchAirport.iata]) {
                            status = 1;
                        }
                    }
                    if (status == 0) {
                        [_searchArray addObject:airport];
                    }
                }
            }
        }

        //判断搜索结果
        if([_searchArray count]==0){
            _noResultView.hidden = false;
        }else{
            _noResultView.hidden = true;
            [_tableView reloadData];
        }
    }
    return NO;
}
- (void)tap{
    [_searchTextF resignFirstResponder];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    //需要返回一个数组
    //用valueForKey只能在本层级字典中查找，而self.carsArray是数组，且没有title关键字
    //用valueForKeyPath可以在本级及下级字典数组中查找，有path路径
    return _sectionArray;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 30, 28)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 28)];
    if (section == 0) {
        label.text = [NSString stringWithFormat:@"%@城市",_sectionArray[section]];
    }else{
        label.text = _sectionArray[section];

    }
    view.backgroundColor = [CommonFunction colorFromHex:0XFFF7F7F7];
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!_searchFlag) {
        return _dataArray.count;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!_searchFlag) {
        return [_dataArray[section] count];
    }
    else{
        NSUInteger count= [_searchArray count];
        return count;
    }

}

/**
 *  @author yangql, 16-02-24 18:02:18
 *
 *  @brief 获取UITableViewCell
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Airport *airport = nil;
    if (!_searchFlag) {
        airport = _dataArray[indexPath.section][indexPath.row];
    }else{
        airport = _searchArray[indexPath.row];
    }
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:airport.iata];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:airport.iata];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",airport.cn,airport.iata];

    return cell;

}

/**
 *  @author yangql, 16-02-25 15:02:48
 *
 *  @brief 行选中事件，关闭视图，回传选中的航站
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Airport *airport = nil;
    if (!_searchFlag) {
        airport = _dataArray[indexPath.section][indexPath.row];
    }else{
        airport = _searchArray[indexPath.row];
    }
//    NSLog(@"当前选中的机场为cn:%@ iata:%@", airport.cn, airport.iata);
    self.resetCity(airport);
    [self.navigationController popViewControllerAnimated:true];
}
//titleView订制
- (void)titleViewInit{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];


    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"国内城市",@"国际"]];
    segmentedControl.frame = CGRectMake(70,20+6, (kScreenWidth - 70 * 2), 31);
    segmentedControl.tintColor = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget: self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

}
-(void)segmentedControlAction:(UISegmentedControl *)segmentedControl
{
    _searchFlag = false;
    _searchTextF.text = @"";
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            _dmst = true;
            break;
        }
        case 1:
        {
            _dmst = false;
            break;
        }
        default:
            break;
    }
    [self initAirportArray];
    [_tableView reloadData];

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
