//
//  AbnormalityReportViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalityReportViewController.h"
#import "AbnormalityReportCollectionViewCell.h"
#import "UIViewController+Reminder.h"
#import "AbnormalityReportTableViewCell.h"
#import "UploadPhotoViewController.h"
#import "TimePickerView.h"
#import "SJPhotoPicker.h"
#import "SJPickPhotoController.h"
#import "SJAlbumModel.h"
#import "SJPhotoPickerManager.h"
#import "OptionsViewController.h"
#import "AbnormalityReportHistoryTableViewCell.h"
#import "AbnormalModel.h"
#import "ImageViewCollectionViewCell.h"
#import "HttpsUtils+Business.h"
#import "BasisInfoDictionaryModel.h"
#import "BasisInfoEventModel.h"


static const NSString *ABNORMALITYREPORT_TABLECELL_IDENTIFIER =@"ABNORMALITYREPORT_TABLECELL_IDENTIFIER";
static const NSString *ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER = @"ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER";
static const NSString *ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER = @"ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER";

@interface AbnormalityReportViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,TimePickerViewDelegate,OptionsViewControllerDelegate,UploadPhotoViewControllerDelegate>

//控件
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic, strong) TimePickerView * timePickerView;
//约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *abnormalityHistoryViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
//自定义变量
@property (nonatomic, copy) NSArray *tableViewArray;
@property (nonatomic ,strong) NSMutableArray *collectionArray;
@property (nonatomic, strong) AbnormalModel *abnormalModel ;

@end

@implementation AbnormalityReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"异常上报"];
    [self titleViewAddBackBtn];
    
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.scrollEnabled = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"AbnormalityReportTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
    _tableViewArray = @[@"事件类别",@"事件级别",@"事件"];

    _abnormalityHistoryTableView.delegate = self;
    _abnormalityHistoryTableView.dataSource = self;
    [_abnormalityHistoryTableView registerNib:[UINib nibWithNibName:@"AbnormalityReportHistoryTableViewCell" bundle:nil]
                       forCellReuseIdentifier:(NSString *)ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER];

    _abnormalityHistoryViewHeight.constant = _abnormalityHistoryArray.count * 61 +51;


    _photoCollectionView.delegate =self;
    _photoCollectionView.dataSource = self;
    
    [_photoCollectionView registerNib:[UINib nibWithNibName:@"ImageViewCollectionViewCell"  bundle:nil]
           forCellWithReuseIdentifier:(NSString *)ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER];
    _collectionArray = [NSMutableArray array];

    _requireTextView.returnKeyType =UIReturnKeyDone;
    _requireTextView.delegate = self;

    _explainTextView.returnKeyType = UIReturnKeyDone;
    _explainTextView.delegate = self;

//    _explainTextView.text = _abnormalModel.
    _requireTextView.text = _abnormalModel.ask;

    //注册键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    //KVO
    [self.startReportButton addObserver:self
                             forKeyPath:@"enabled"
                                options:NSKeyValueObservingOptionNew
                                context:nil];
    [self.endReportButton addObserver:self
                           forKeyPath:@"enabled"
                              options:NSKeyValueObservingOptionNew
                              context:nil];

    
}


-(void)setAbnormalityHistoryArray:(NSArray *)abnormalityHistoryArray
{
    _abnormalityHistoryArray = abnormalityHistoryArray;
    _abnormalityHistoryViewHeight.constant = _abnormalityHistoryArray.count * 61 +51;
}

-(void)dealloc
{
    [self.startReportButton removeObserver:self forKeyPath:@"enabled"];
    [self.endReportButton removeObserver: self forKeyPath:@"enabled"];
}

// 键盘通知
- (void)keyboardWillShowNotification:(NSNotification *)info
{
    NSDictionary *userInfo = [info userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    _scrollViewBottom.constant = kbSize.height;
    UITextView *textView ;
    if ([_requireTextView isFirstResponder]) {
        textView = _requireTextView;
    }else{
        textView = _explainTextView;
    }
    float y =viewY(textView.superview)+8;
    if (y>self.scrollView.contentOffset.y) {
        [UIView animateWithDuration:1.0 animations:^{
            [self.scrollView setContentOffset:CGPointMake(0, y) animated:YES];
        }];
    }
}
- (void)keyboardWillHideNotification:(NSNotification *)info
{
    _scrollViewBottom.constant = 0;
}

#pragma mark - EVENT

- (IBAction)startReportDatClick:(id)sender {
    
//    [self setupDateView];
}
- (IBAction)endReportDate:(id)sender {
//    [self setupDateView];
}

- (IBAction)phoneButttonClick:(id)sender
{
    UploadPhotoViewController *uploadPhotoVC = [[UploadPhotoViewController alloc]initWithNibName:@"UploadPhotoViewController"
                                                                                          bundle:nil];
    uploadPhotoVC.delegate = self;
    [self.navigationController pushViewController:uploadPhotoVC animated:YES];

//    [[SJPhotoPickerManager shareSJPhotoPickerManager] requestAlbumsWithType:PHAssetCollectionTypeSmartAlbum  albumResult:^(NSArray *albumArray) {
//        SJPickPhotoController *vc = [[SJPickPhotoController alloc] init];
//        SJAlbumModel *model = [[SJAlbumModel alloc] init];
//        NSArray *groupArray = [albumArray mutableCopy];
//        if (groupArray&&groupArray.count>0) {
//            model = groupArray[0];
//        }
//        vc.assetResult = model.assetResult;
//        [self.navigationController pushViewController:vc animated:NO];
//    }];
}

- (void)setupDateView
{
    if (_timePickerView == nil) {
        [UIView animateWithDuration:0.3 animations:^{
            _timePickerView = [[NSBundle mainBundle] loadNibNamed:@"TimePickerView"
                                                            owner:nil
                                                          options:nil][0];
            _timePickerView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
            _timePickerView.delegate = self;
            [self.view addSubview:_timePickerView];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _timePickerView.alpha = 1;
        }];
    }
}


-(void)updateData
{
    [_tableView reloadData];
    [_abnormalityHistoryTableView reloadData];
    _explainTextView.text = @"";
    _requireTextView.text = @"";
}
#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return _tableViewArray.count;
    }else{
        return _abnormalityHistoryArray.count;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _abnormalityHistoryTableView) {
        return 61;
    }
    return 58;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        AbnormalityReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
        NSString *name =_tableViewArray[indexPath.row];
        cell.nameLabel.text =name;
        if ([name isEqualToString:@"事件类别"]) {
            cell.valueLabel.text = _eventType.content;
        }else if([name isEqualToString:@"事件"]){
            cell.valueLabel.text = _event.event;
        }else if ([name isEqualToString:@"事件级别"]){
            cell.valueLabel.text = _eventLevel.content;
        }
        return  cell;
    }else
    {
        AbnormalityReportHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER];
        cell.abnormalModel = self.abnormalityHistoryArray[indexPath.row];
        return  cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(tableView == _abnormalityHistoryTableView){
        return;
    }


    OptionsViewController *optionsVC ;

    NSString *name =_tableViewArray[indexPath.row];
    if ([name isEqualToString:@"事件类别"]) {
        optionsVC = [[OptionsViewController alloc]initWithOptionType:OptionsTypeType];
    }else if([name isEqualToString:@"事件"]){
       optionsVC = [[OptionsViewController alloc]initWithOptionType:OptionsTypeEvent];
        optionsVC.event_type = _eventType.id;
        optionsVC.event_level = _eventLevel.id;
        optionsVC.dispatchType = _DispatchType;
    }else if ([name isEqualToString:@"事件级别"]){
        optionsVC = [[OptionsViewController alloc]initWithOptionType:OptionsTypeEventLevel];
    }else{
        optionsVC = [[OptionsViewController alloc]init];
    }
     optionsVC.delegate = self;
    [self.navigationController pushViewController:optionsVC animated:YES];
}


#pragma mark - collection delegate datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER
                                                                                  forIndexPath:indexPath];
    cell.imageView.image = _collectionArray[indexPath.row];
    return cell;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - TimePickerViewDelegate
-(void)timePickerViewDidEnsure:(NSDate *)date
{
    NSLog(@"选中时间%@",date);
}


#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([[change objectForKey:@"new"]isKindOfClass:[NSNumber class]]) {
        Boolean new = ((NSNumber *)[change objectForKey:@"new"]).boolValue;
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton *button = object;
            if (new) {
                [button setBackgroundColor:[UIColor whiteColor]];
            }else{
//                [button setBackgroundColor:[UIColor grayColor]];
            }
        }

    }

}

-(void)optionsViewControllerFinshedOptionType:(OptionsType)optionType Value:(id)value
{
    switch (optionType) {
        case OptionsTypeType:
            _eventType =value;
            break;
        case OptionsTypeEvent:
            _event = value;
            break;
        case OptionsTypeEventLevel:
            _eventLevel = value;
            break;
        default:

            break;
    }
    [_tableView reloadData];

}

-(void)UploadPhotoViewControllerFinished:(NSArray *)dataArray
{
    _collectionArray = [dataArray copy];
    [_photoCollectionView reloadData];
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
