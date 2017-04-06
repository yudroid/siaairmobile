//
//  KnowledgeBaseContentViewController.m
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

const NSString *KNOWLEDGEBASECONTENT_TABLECELL_IDENTIFIER = @"KNOWLEDGEBASECONTENT_TABLECELL_IDENTIFIER";
#import "KnowledgeBaseContentViewController.h"
#import "KnowledgeBaseContentTableViewCell.h"
#import "JSDownloadView.h"
#import "HttpFileDown.h"
#import <FCFileManager.h>
#import "KnowledgeBaseModel.h"
#import "UIViewController+Reminder.h"
#import "NSString+Size.h"


@interface KnowledgeBaseContentViewController ()<KnowledgeBaseContentTableViewCellDelegate,JSDownloadAnimationDelegate,UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;


@property (nonatomic, strong) JSDownloadView *downloadView;
@property (nonatomic, strong) HttpFileDown *httpFileDown;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIDocumentInteractionController *documentVc;
@property (nonatomic, strong) NSArray *tableArray;
@property (nonatomic, assign) NSInteger downStatus;
@end

@implementation KnowledgeBaseContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];

    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.allowsSelection = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"KnowledgeBaseContentTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)KNOWLEDGEBASECONTENT_TABLECELL_IDENTIFIER];

    [self initialize];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:self.title];
    [self titleViewAddBackBtn];
}


-(void)initialize
{
    _titleLabel.text = _knowledgeBaseModel.title?:@"";
    _summaryLabel.text = _knowledgeBaseModel.memo?:@"";
    _labelLabel.text = _knowledgeBaseModel.typeName?:@"";
    _contentLabel.text = _knowledgeBaseModel.content?:@"";
    _knowledgeBaseModel.httpPath = [_knowledgeBaseModel.httpPath stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    _tableArray = [_knowledgeBaseModel.httpPath componentsSeparatedByString:@","];
    _viewHeight.constant = [self viewHeightSum];


}

-(CGFloat)viewHeightSum
{
    CGFloat titleHeight = [_titleLabel.text sizeWithWidth:kScreenWidth-16 font:[UIFont fontWithName:@"PingFang SC" size:14]].height;

    CGFloat summaryHeight = [_summaryLabel.text sizeWithWidth:kScreenWidth-16 font:[UIFont fontWithName:@"PingFang SC" size:14]].height;

    CGFloat labelHeight = [_labelLabel.text sizeWithWidth:kScreenWidth -16 font:[UIFont fontWithName:@"PingFang SC" size:14]].height;

    CGFloat contentHeight = [_contentLabel.text sizeWithWidth:kScreenWidth -16 font:[UIFont fontWithName:@"PingFang SC" size:14]].height;

    CGFloat tableHeight = _tableArray.count * 50 ;

    return titleHeight + summaryHeight +labelHeight + contentHeight + tableHeight + 8*8 +23*3;

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
    KnowledgeBaseContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)KNOWLEDGEBASECONTENT_TABLECELL_IDENTIFIER];
    cell.nameLabel.text = _tableArray[indexPath.row];
    cell.filePath =_tableArray[indexPath.row];
    cell.tag = indexPath.row;
    cell.delegate = self;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



-(void)functionButtonClick:(UIButton *)sender
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",_tableArray[sender.tag]]];
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
        [self downStartWithPath:_tableArray[sender.tag]];
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

    _httpFileDown = [[HttpFileDown alloc]init];
    [_httpFileDown downFileWithHttpPath:path1
                               Progress:^(NSProgress *downloadProgress) {

                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       NSString *progressString  = [NSString stringWithFormat:@"%.2f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount];
                                       self.downloadView.progress = progressString.floatValue;
                                   });
                               } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {


                                   NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                   NSString *path = [cachesPath stringByAppendingPathComponent:@"DownFile"];
                                   if ( ![FCFileManager existsItemAtPath:path]) {
                                       [FCFileManager createDirectoriesForPath:path];
                                   }
                                   path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",path1]];
                                   return [NSURL fileURLWithPath:path];
                               } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                   _downStatus = 0;
                                   if (error) {
                                       NSLog(@"%@",error);
                                       _downStatus = 1;
                                       [FCFileManager removeItemAtPath:[filePath path]];
                                   }
                                   self.downloadView.isSuccess = YES;
                                   NSString *path = [filePath path];
                                   NSLog(@"************文件路径:%@",path);
                                   [_tableView reloadData];
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
