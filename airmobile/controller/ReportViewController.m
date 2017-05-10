//
//  ReportViewController.m
//  airmobile
//
//  Created by xuesong on 17/3/30.
//  Copyright © 2017年 杨泉林. All rights reserved.
//
const NSString *REPORTTABLEIDENTIFIER = @"REPORTTABLEIDENTIFIER";

#import "ReportViewController.h"
#import "HttpsUtils+Business.h"
#import "KnowledgeBaseModel.h"
#import "UIViewController+Reminder.h"
#import "ReportTableViewCell.h"
#import "KnowledgeBaseContentViewController.h"
#import "FCFileManager.h"
#import "JSDownloadView.h"
#import "HttpFileDown.h"

@interface ReportViewController ()<ReportTableViewCellDelegate,JSDownloadAnimationDelegate,UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tableArray;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) JSDownloadView *downloadView;
@property (nonatomic, strong) UIDocumentInteractionController *documentVc;
@property (nonatomic, strong) HttpFileDown *httpFileDown;
@property (nonatomic, assign) NSInteger downStatus;
@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    _tableView.tableFooterView = [[UIView alloc]init];
//    _tableArray = @[@"日报",@"周报",@"月报"];
    [self loadDataWithReportItem:ReportItemDay];
}


-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"运行简报"];
    [self titleViewAddBackBtn];
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
    ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)REPORTTABLEIDENTIFIER];
    if (!cell) {
        cell =[[NSBundle mainBundle]loadNibNamed:@"ReportTableViewCell" owner:nil options:nil][0];
    }
    cell.delegate = self;
    KnowledgeBaseModel *model =_tableArray[indexPath.row];
    cell.knowledgeBaseModel = model;
    cell.index = indexPath.row;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    KnowledgeBaseModel *model = _tableArray[indexPath.row];
    KnowledgeBaseContentViewController *knowledgeBaseContentVC = [[KnowledgeBaseContentViewController alloc]initWithNibName:@"KnowledgeBaseContentViewController" bundle:nil];
    knowledgeBaseContentVC.knowledgeBaseModel = model;
    knowledgeBaseContentVC.title = model.title;
    [self.navigationController pushViewController:knowledgeBaseContentVC animated:YES];
}

- (IBAction)segementValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case ReportItemDay:
            [self loadDataWithReportItem:ReportItemDay];
            break;
        case ReportItemWeek:
            [self loadDataWithReportItem:ReportItemWeek];
            break;
        case ReportItemMonth:
            [self loadDataWithReportItem:ReportItemMonth];
            break;
        default:
            break;
    }
}

-(void)loadDataWithReportItem:(ReportItem)reportItem
{
    __weak typeof(self) weakSelf = self;
    void (^successBlock)(id) = ^(NSArray *response){
        weakSelf.tableArray = [response DictionaryToModel:[KnowledgeBaseModel class]];
        [weakSelf.tableView reloadData];
        [weakSelf stopNetWorking];
    };
    void (^failureBlock)(id) = ^(NSError *error) {
        weakSelf.tableArray = [NSArray array];
        [weakSelf.tableView reloadData];
        [weakSelf showAnimationTitle:@"请求失败"];
        [weakSelf stopNetWorking];
    };
    [self starNetWorking];
    switch (reportItem) {
        case ReportItemDay:
        {
            [HttpsUtils mobileDayLogSucess:^(NSArray *response) {
                successBlock(response);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
            break;
        }
        case ReportItemWeek:
        {
            [HttpsUtils mobileWeekLogSucess:^(NSArray *response) {
                successBlock(response);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
            break;
        }
        case ReportItemMonth:
        {
            [HttpsUtils mobileMonthLogSucess:^(NSArray *response) {
                successBlock(response);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
            break;
        }
        default:
            break;
    }
}

-(void)reportTableViewCellViewButtonClick:(UIButton *)sender
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [((KnowledgeBaseModel *)_tableArray[sender.tag]).httpPath stringByReplacingOccurrencesOfString:@"/" withString:@"--"];
    NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",fileName]];
    if (![FCFileManager existsItemAtPath:path]) {
        if (_backgroundView== nil) {
            _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            _backgroundView.tag = 99;
            _backgroundView.backgroundColor = [CommonFunction colorFromHex:0x992F8AEB];
            _downloadView = [[JSDownloadView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-50, CGRectGetHeight(self.view.frame)/2-50, 100, 100)];
            [_backgroundView addSubview:_downloadView];
            _downloadView.delegate = self;
            UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenHeight-100, 100, 50)];
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            [cancelButton addTarget:self action:@selector(cancelButonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_backgroundView addSubview:cancelButton];
        }
        [self.view addSubview:_backgroundView];
        [self downStartWithPath:fileName];
    }else{
        NSURL *url = [NSURL fileURLWithPath:path];
        _documentVc = [UIDocumentInteractionController interactionControllerWithURL:url];
        _documentVc.delegate = self;
        //         [_documentVc presentPreviewAnimated:YES];
        [_documentVc presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
    }
}

-(void)cancelButonClick:(UIButton *)sender
{
    [[self.view viewWithTag:99] removeFromSuperview];
    _httpFileDown = nil;
}

#pragma mark -  animation delegate

- (void)downStartWithPath:(NSString *)path1{

    void (^downloadProgressBlock)(NSProgress*) = ^(NSProgress *downloadProgress){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *progressString  = [NSString stringWithFormat:@"%.2f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount];
            self.downloadView.progress = progressString.floatValue;
        });
    };

    NSURL *(^destinationBlock)(NSURL *, NSURLResponse *) =
    ^(NSURL *targetPath, NSURLResponse *response){
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:@"DownFile"];
        if ( ![FCFileManager existsItemAtPath:path]) {
            [FCFileManager createDirectoriesForPath:path];
        }
        path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",path1]];
        return [NSURL fileURLWithPath:path];
    };

    void (^completionHandlerBlock)(NSURLResponse *, NSURL *, NSError *)=^(NSURLResponse *response, NSURL *filePath, NSError *error){
        _downStatus = 0;
        if (error) {
            //            NSLog(@"%@",error);
            _downStatus = 1;
            [FCFileManager removeItemAtPath:[filePath path]];
        }
        self.downloadView.isSuccess = YES;
        NSString *path = [filePath path];
        //        NSLog(@"************文件路径:%@",path);
        [_tableView reloadData];
    };

    _httpFileDown = [[HttpFileDown alloc]init];

    [_httpFileDown yxjbDownFileWithHttpPath:path1
                                   Progress:^(NSProgress *downloadProgress) {
                                       downloadProgressBlock(downloadProgress);

                                   } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

                                       return destinationBlock(targetPath,response);

                                   } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                       completionHandlerBlock(response,filePath,error);
                                   }];
}
-(void)animationStart
{
    NSLog(@"开始下载");
}
- (void)animationSuspend{
    NSLog(@"暂停下载");
}

- (void)animationEnd{
    NSLog(@"结束下载");
    [self cancelButonClick:nil];

    if(_downStatus ==1){
        [self showAnimationTitle:@"下载失败"];
    }else{
        [self showAnimationTitle:@"下载成功"];
    }
}

#pragma mark - UIDocumentInteractionController 代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
}
- (BOOL)presentOpenInMenuFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    return YES;
}
@end
