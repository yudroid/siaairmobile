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
#import "FlightFilterView.h"

@interface KnowledgeBaseViewController ()<UITextFieldDelegate,FlightFilterViewDelegate>

@property (nonatomic, assign) NSInteger startIndex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableArray;
@property (nonatomic, strong) UIView *searBar;
@property (nonatomic, strong) UITextField *searContentTextField;

@end

@implementation KnowledgeBaseViewController
{
        FlightFilterView        *filterView;
}

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

    //添加过滤条件View
    filterView = [[[NSBundle mainBundle] loadNibNamed:@"FlightFilterView"
                                                owner:nil
                                              options:nil] lastObject];
    filterView.frame = CGRectMake(0, 64, kScreenWidth, 200);
    filterView.alpha = 0;
    filterView.delegate = self;
    [self.view addSubview:filterView];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"知识库"];
    [self titleViewAddBackBtn];

        //过滤按钮
        UIButton *filterButton = [[UIButton alloc]
                                  initWithFrame:CGRectMake(kScreenWidth-36, 33, 18, 18)];
        [filterButton setBackgroundImage:[UIImage imageNamed:@"ListIcon"]
                                forState:UIControlStateNormal];
        [filterButton addTarget:self
                         action:@selector(filterButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:filterButton];
        //查询按钮
        UIButton *searchButton = [[UIButton alloc]
                                  initWithFrame:CGRectMake(kScreenWidth-72, 33, 18, 18)];
        [searchButton setBackgroundImage:[UIImage imageNamed:@"FlightSearchIconBig"]
                                forState:UIControlStateNormal];
        [searchButton addTarget:self
                         action:@selector(searchButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:searchButton];
    
        //搜索条
        _searBar = [[UIView alloc]
                    initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 64)];
        _searBar.backgroundColor = [UIColor
                                    colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
        [self.titleView addSubview:_searBar];
    
        //返回按钮
        UIButton *searchBackButton = [[UIButton alloc]
                                      initWithFrame:CGRectMake(0, 20, 51, 44)];
        searchBackButton.backgroundColor = [UIColor clearColor];
        //    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [searchBackButton setImage:[UIImage imageNamed:@"back"]
                          forState:(UIControlStateNormal)];
        [searchBackButton setImage:[UIImage imageNamed:@"back"]
                          forState:(UIControlStateSelected)];
        [_searBar addSubview:searchBackButton];
        [searchBackButton addTarget:self
                             action:@selector(searchBackButtonClick:)
                   forControlEvents:(UIControlEventTouchUpInside)];
        //查询文本输入框
    
        //背景
        UIImageView *searchTextBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(searchBackButton), (44- px_px_2_3(59, 91))/2+20, kScreenWidth-viewTrailing(searchBackButton)-16,px_px_2_3(59, 91) )];
        searchTextBackgroundImageView.image = [UIImage imageNamed:@"SearchTextBackground"];
        [_searBar addSubview:searchTextBackgroundImageView];
    
        //放大镜图标
        UIImageView *searchTagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(11, 17)+viewX(searchTextBackgroundImageView), viewY(searchTextBackgroundImageView)+(viewHeight(searchTextBackgroundImageView)-15)/2, 15, 15)];
        searchTagImageView.image = [UIImage imageNamed:@"SearchIconBig"];
    //    searchTagImageView.backgroundColor = [UIColor redColor];
        [_searBar addSubview:searchTagImageView];
    
        _searContentTextField = [[UITextField alloc]
                                             initWithFrame:CGRectMake(px_px_2_3(14, 22)+viewTrailing(searchTagImageView), viewY(searchTextBackgroundImageView), viewWidth(searchTextBackgroundImageView)-viewTrailing(searchTagImageView)-px_px_2_3(14, 22), viewHeight(searchTextBackgroundImageView))];
        _searContentTextField.placeholder = @"请输入查询内容";
        _searContentTextField.delegate = self;
        _searContentTextField.returnKeyType = UIReturnKeySearch;
        _searContentTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:px_px_2_3(26, 40)];
        [_searBar addSubview:_searContentTextField];

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
//        NSLog(@"%@",error);
        [_tableView.mj_header endRefreshing];
    }];
}


#pragma mark - EVENT
-(void)filterButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        filterView.frame = CGRectMake(0, 64, kScreenWidth, 200);
        filterView.alpha = 1;
    }];
}
-(void)searchButtonClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        _searBar.frame = CGRectMake(0, 0, kScreenWidth, 64);
    }];

}
-(void)searchBackButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        _searBar.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, 64);
    }];
//    flightNo = _searContentTextField.text;
    [_tableView.mj_header beginRefreshing];

}
-(void)searchBarSearchButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];

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
//        NSLog(@"%@",error);
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
    return 104;
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
