//
//  KnowledgeBaseViewController.m
//  airmobile
//
//  Created by xuesong on 17/3/30.
//  Copyright © 2017年 杨泉林. All rights reserved.
//


const NSInteger pageSize = 20;
const NSString *KNOWLEDGEBASEIDENTIFIER = @"KNOWLEDGEBASEIDENTIFIER";

#import "KnowledgeBaseViewController.h"
#import <MJRefresh.h>
#import "HttpsUtils+Business.h"
#import "KnowledgeBaseModel.h"
#import "KnowledgeBaseTableViewCell.h"
#import "KnowledgeBaseContentViewController.h"

@interface KnowledgeBaseViewController ()

@property (nonatomic, assign) NSInteger startIndex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableArray;

@end

@implementation KnowledgeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];

    _tableView.tableFooterView = [[UIView alloc]init];
    //添加下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                            refreshingAction:@selector(updateNetwork)];
    //添加上拉加载
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                refreshingAction:@selector(moreNetwork)];

    [_tableView registerNib:[UINib nibWithNibName:@"KnowledgeBaseTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)KNOWLEDGEBASEIDENTIFIER];

    [_tableView.mj_header beginRefreshing];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"知识库"];
    [self titleViewAddBackBtn];
}


-(void)updateNetwork
{
    _startIndex = 0;
    NSDictionary *conds =@{
                           @"start":@(_startIndex).stringValue,
                           @"length":@(pageSize).stringValue};


//    [HttpsUtils mobileKBListWithDictionary:conds Success:^(id responseObj) {
////        // 数据加载完成
////        [_tableView.mj_header endRefreshing];
////        if(![responseObj isKindOfClass:[NSArray class]]){
////            return;
////        }
////        _tableArray = [responseObj DictionaryToModel:[KnowledgeBaseModel class]] ;
////        [_tableView reloadData];
////        _startIndex =20;
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [_tableView.mj_header endRefreshing];
//    }];
    [HttpsUtils mobileKBListWithDictionary:conds Sucess:^(id responseObj) {
                // 数据加载完成
                [_tableView.mj_header endRefreshing];
                if(![responseObj isKindOfClass:[NSArray class]]){
                    return;
                }
                _tableArray = [responseObj DictionaryToModel:[KnowledgeBaseModel class]] ;
                [_tableView reloadData];
                _startIndex =20;

    }  failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_tableView.mj_header endRefreshing];
    }];
}

-(void)moreNetwork
{
    NSDictionary *conds =@{
                           @"start":@(_startIndex).stringValue,
                           @"length":@(pageSize).stringValue};

    [HttpsUtils mobileKBListWithDictionary:conds Sucess:^(id responseObj) {
        if(![responseObj isKindOfClass:[NSArray class]]){
            return;
        }
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:_tableArray];
        [mutableArray addObjectsFromArray:[responseObj DictionaryToModel:[KnowledgeBaseModel class]]];
        _tableArray = [mutableArray copy];
        [_tableView.mj_footer endRefreshing];
        [_tableView reloadData];
        _startIndex +=pageSize;
    }  failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_tableView.mj_header endRefreshing];
    }];

}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowledgeBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)KNOWLEDGEBASEIDENTIFIER];
    cell.knowledgeBaseModel = _tableArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

//    KnowledgeBaseModel *model = _tableArray[0];
    KnowledgeBaseModel *model = _tableArray[indexPath.row];
    KnowledgeBaseContentViewController *knowledgeBaseContentVC = [[KnowledgeBaseContentViewController alloc]initWithNibName:@"KnowledgeBaseContentViewController" bundle:nil];
    knowledgeBaseContentVC.knowledgeBaseModel = model;
    knowledgeBaseContentVC.title = model.title;
    knowledgeBaseContentVC.type = 1;
    [self.navigationController pushViewController:knowledgeBaseContentVC animated:YES];

}
@end
