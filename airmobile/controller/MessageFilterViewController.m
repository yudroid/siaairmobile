//
//  MessageFilterViewController.m
//  airmobile
//
//  Created by xuesong on 16/12/5.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "MessageFilterViewController.h"
#import "MessageFilterView.h"

static const NSString *MessageFilter_TABLECELL_IDENTIFIER = @"MessageFilter_TABLECELL_IDENTIFIER";

@interface MessageFilterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableArray;
@end

@implementation MessageFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"我的"];
    [self titleViewAddBackBtn];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];

    _tableArray = @[@"机位变更消息",@"航班状态消息",@"登机口过滤",@"自定义过滤"];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:(NSString *)MessageFilter_TABLECELL_IDENTIFIER];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)MessageFilter_TABLECELL_IDENTIFIER];
    cell.textLabel.text = _tableArray[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageFilterView *view = [[NSBundle mainBundle]loadNibNamed:@"MessageFilterView" owner:nil options:nil][0];

    view.frame = self.view.frame;

    [view createBlurBackgroundWithImage:[self jt_imageWithView:self.view] tintColor:[[UIColor blackColor] colorWithAlphaComponent:0.35] blurRadius:60.0];
    [self.view addSubview:view];

}

- (UIImage *)jt_imageWithView:(UIView *)view {

    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:true];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
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
