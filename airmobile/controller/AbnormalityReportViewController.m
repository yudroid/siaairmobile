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
#import "UIButton+PhotoChoose.h"
#import "FlyImage.h"
#import "PersistenceUtils+Business.h"
#import "SpecialModel.h"
#import "SafeguardModel.h"
#import "AppDelegate.h"
#import "TimePickerView.h"
#import "UIViewController+Reminder.h"
#import "DateUtils.h"
#import "NSString+Size.h"
#import "AFAppDotNetUpdateFileClient.h"
#import "OrderOptionsViewController.h"

static const NSString *ABNORMALITYREPORT_TABLECELL_IDENTIFIER =@"ABNORMALITYREPORT_TABLECELL_IDENTIFIER";
static const NSString *ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER = @"ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER";
static const NSString *ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER = @"ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER";

@interface AbnormalityReportViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,OptionsViewControllerDelegate,UICollectionViewDelegateFlowLayout,TimePickerViewDelegate,OrderOptionsViewControllerDelegate>

//控件
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UITableView    *abnormalityHistoryTableView;
@property (weak, nonatomic) IBOutlet UIButton       *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton       *saveButton;
@property (weak, nonatomic) IBOutlet UIButton       *iphoneButton;
@property (weak, nonatomic) IBOutlet UITextView     *requireTextView;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;

//约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *abnormalityHistoryViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

//自定义变量
@property (nonatomic, copy)          NSArray *tableViewArray;
@property (nonatomic, strong)        AbnormalModel *abnormalModel ;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (nonatomic, strong)        NSMutableArray *nImageArray;//上报历史后添加的新图片
@property (nonatomic, copy)          NSArray        *abnormalityHistoryArray;
@property (nonatomic ,strong)        NSMutableArray *collectionArray;
@property (nonatomic, copy)          NSArray        *imageFilePath;
@property (nonatomic, copy)          NSDictionary   *orderDic;

@end

@implementation AbnormalityReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.reportState = ReportStateStarted;

    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:self.title];
    [self titleViewAddBackBtn];
    
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.scrollEnabled = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"AbnormalityReportTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
    if (self.reportType == ReportTypeOrder) {
        _tableViewArray = @[@"监察类型",@"保障类型",@"事项标准",@"环节名称"];
        _tableViewHeight.constant = 232;
    }else if (self.reportType == ReportTypeCommon){
        _tableViewArray = @[@"监察类型",@"保障类型",@"事项标准"];
    }

    _abnormalityHistoryTableView.delegate = self;
    _abnormalityHistoryTableView.dataSource = self;
    [_abnormalityHistoryTableView registerNib:[UINib nibWithNibName:@"AbnormalityReportHistoryTableViewCell" bundle:nil]
                       forCellReuseIdentifier:(NSString *)ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER];

    _abnormalityHistoryViewHeight.constant = _abnormalityHistoryArray.count * 70 +51;


    _photoCollectionView.delegate =self;
    _photoCollectionView.dataSource = self;
    
    [_photoCollectionView registerNib:[UINib nibWithNibName:@"ImageViewCollectionViewCell"  bundle:nil]
           forCellWithReuseIdentifier:(NSString *)ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER];
    _collectionArray = [NSMutableArray array];

    _requireTextView.returnKeyType =UIReturnKeyDone;
    _requireTextView.delegate = self;




//    _explainTextView.text = _abnormalModel.
    _requireTextView.text = _abnormalModel.memo;

    //注册键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];


    //设置该按钮支持拍照
    _iphoneButton.isPhotoChoose = YES;
    _iphoneButton.photoDidFinished = ^(UIImage *image){
        NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
        image = [UIImage imageWithData:imgData];
        if (_collectionArray.count>=6) {
            [self showAnimationTitle:@"您最多可以选择6张"];
            return ;
        }
        [_collectionArray addObject:image];
        [_photoCollectionView reloadData];
    };


    [self loadAbnsRecord];


    [_timeButton setTitle:[DateUtils convertToString:[DateUtils getNow] format:@"HH:mm"] forState:UIControlStateNormal];

}
-(void)addNetworkingCancel:(UIView *)view
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, viewHeight(view)-100, viewWidth(view), 60)];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [view addSubview:button];
    [button addTarget:self action:@selector(networkingCancelButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)networkingCancelButtonEvent:(UIButton *)sender
{
    NSArray *array = [AFAppDotNetUpdateFileClient sharedClient].tasks;
    for (NSURLSessionDataTask *task in array) {
        [task cancel];
    }
    [self stopNetWorking];
}

-(void)setEventAbnormalModel:(AbnormalModel *)abnormalModel
{
    NSDictionary * dic= [[PersistenceUtils findBasisInfoEventWithEventId:(int)abnormalModel.event] lastObject];
    self.event = [[BasisInfoEventModel alloc]initWithDictionary:dic];
    NSDictionary *dic1= [[PersistenceUtils findBasisInfoDictionaryWithid:self.event.event_type] lastObject];
    self.controlType = [[BasisInfoDictionaryModel alloc] initWithDictionary:dic1];
    NSDictionary *dic2 = [[PersistenceUtils findBasisInfoDictionaryWithid:self.event.dispatch_type] lastObject];
    self.ensureType = [[BasisInfoDictionaryModel alloc]initWithDictionary:dic2];
    self.requireTextView.text = abnormalModel.memo;

    [self.tableView reloadData];
    _collectionArray = [NSMutableArray arrayWithArray:[abnormalModel.pathList componentsSeparatedByString:@","]];
    [_collectionArray removeObject:@""];
    [_photoCollectionView reloadData];
}


- (IBAction)timeButtonClick:(id)sender {
    TimePickerView *timePickView = [[NSBundle mainBundle] loadNibNamed:@"TimePickerView" owner:nil options:nil][0];
    timePickView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    timePickView.delegate = self;
    [self.view addSubview:timePickView];
}

-(void)setAbnormalityHistoryArray:(NSArray *)abnormalityHistoryArray
{
    _abnormalityHistoryArray = abnormalityHistoryArray;
    CGFloat sum = 0;
    for (AbnormalModel *model in _abnormalityHistoryArray) {
        sum += [self abnormalityHistoryTableHeightWithAbnormal:model];
    }
    _abnormalityHistoryViewHeight.constant = sum +51;
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

- (IBAction)cancelButtonClick:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒"
                                                                   message:@"确定要取消吗"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }]];[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}
- (IBAction)saveButtonClick:(id)sender {

    if (_requireTextView.text.length == 0) {
        [self showAnimationTitle:@"请填写事件描述"];
        return;
    }
    _nImageArray = [NSMutableArray array];
    NSMutableArray *imagePath = [NSMutableArray array];
    for (id model in _collectionArray) {
        if ([model isKindOfClass:[UIImage class]]) {
            [_nImageArray addObject:model];
        }else if([model isKindOfClass:[NSString class]]){
            [imagePath addObject:model];
        }
    }
    self.imageFilePath = [imagePath copy];
    if (_nImageArray.count>0) {
        int  index = 0;
        NSMutableArray *filePathArray = [NSMutableArray arrayWithArray:imagePath];
        UIView *view = [self starNetWorkingWithString:@"" Y:64];
        [self addNetworkingCancel:view];
        [self uploadImageIndex:index filePathArray:filePathArray failure:^(id error) {
            [self stopNetWorking];
            [self showAnimationTitle:@"上传失败"];
        }];
    }else{
//        [self starNetWorking];
        [self sendAbnsReported];
    }
}


-(void)OrderOptionsDidSelectReports:(NSDictionary *)reportsDic
{
    _orderDic  = reportsDic;
    [_tableView reloadData];
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

        AbnormalModel *abnormalModel = self.abnormalityHistoryArray[indexPath.row];

        return [self abnormalityHistoryTableHeightWithAbnormal:abnormalModel];
    }
    return 58;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        AbnormalityReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
        NSString *name =_tableViewArray[indexPath.row];
        cell.nameLabel.text =name;
        if ([name isEqualToString:@"监察类型"]) {
            cell.valueLabel.text = _controlType.content;
        }else if([name isEqualToString:@"事项标准"]){
            cell.valueLabel.text = _event.event;
        }else if ([name isEqualToString:@"保障类型"]){
            cell.valueLabel.text = _ensureType.content;
        }else if([name isEqualToString:@"环节名称"]){
            if(_orderDic!=nil){
                cell.valueLabel.text = _orderDic[@"name"];
            }else{
                cell.valueLabel.text = @"";
            }
        }
        return  cell;
    }else{
        AbnormalityReportHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)ABNORMALITYREPORT_HISTORYTABLECELL_IDENTIFIER];
        cell.abnormalModel = self.abnormalityHistoryArray[indexPath.row];
        return  cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(tableView == _abnormalityHistoryTableView){
        AbnormalModel *model = self.abnormalityHistoryArray[indexPath.row];
        [self setEventAbnormalModel:model];
//        [self judgeReportStateWithAbnormalModel:model];
        return;
    }
    OptionsViewController *optionsVC ;

    NSString *name =_tableViewArray[indexPath.row];
    if ([name isEqualToString:@"监察类型"]) {
        optionsVC = [[OptionsViewController alloc]initWithOptionType:OptionsTypeType];
    }else if([name isEqualToString:@"事项标准"]){
        if (_controlType.content.length==0 ) {
            [self showAnimationTitle:@"请选择检查类型"];
            return;
        }else if(_ensureType.content.length == 0){
            [self showAnimationTitle:@"请选择保障类型"];
            return;
        }
       optionsVC = [[OptionsViewController alloc]initWithOptionType:OptionsTypeEvent];
        optionsVC.controlType = _controlType.id;
        optionsVC.ensureType = _ensureType.id;
    }else if ([name isEqualToString:@"保障类型"]){
        optionsVC = [[OptionsViewController alloc]initWithOptionType:OptionsTypeEventLevel];
    }else if([name isEqualToString:@"环节名称"]){
        OrderOptionsViewController *orderOptionsVC = [[OrderOptionsViewController alloc]initWithNibName:@"OrderOptionsViewController" bundle:nil];
        orderOptionsVC.delegate = self;
        [self.navigationController pushViewController:orderOptionsVC animated:YES];
    }
     optionsVC.delegate = self;
    [self.navigationController pushViewController:optionsVC animated:YES];
}


#pragma mark - collection delegate datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionArray.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 16, 8, 16);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER forIndexPath:indexPath];

        id item =  _collectionArray[indexPath.row];
    if ([item isKindOfClass:[UIImage class]]) {
        cell.imageView.image = _collectionArray[indexPath.row];
        __weak typeof(self) wSelf = self;
        cell.longPressBlock = ^(UICollectionViewCell *cell){
            [_collectionArray removeObject:((ImageViewCollectionViewCell *)cell).imageView.image];
            [wSelf.photoCollectionView reloadData];
        };

    }else if ([item isKindOfClass:[NSString class]]){
        cell.imagePath = _collectionArray[indexPath.row];
        __weak typeof(self) wSelf = self;
        cell.longPressBlock = ^(UICollectionViewCell *cell){
            [_collectionArray removeObject:((ImageViewCollectionViewCell *)cell).imagePath];
            [wSelf.photoCollectionView reloadData];
        };

    }
    cell.tag = indexPath.row;

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

-(CGFloat)abnormalityHistoryTableHeightWithAbnormal:(AbnormalModel *)model
{
    NSDictionary * dic = [[PersistenceUtils findBasisInfoEventWithEventId:(int)model.event] lastObject];
    BasisInfoEventModel *eventModel = [[BasisInfoEventModel alloc]initWithDictionary:dic];
    CGSize size1 = [eventModel.event sizeWithWidth:kScreenWidth - 32 font:[UIFont fontWithName:@"PingFang SC" size:15]];
    CGSize size2 = [model.memo sizeWithWidth:kScreenWidth - 32 font:[UIFont fontWithName:@"PingFang SC" size:12]];
    return size1.height+size2.height + 24;
}

#pragma mark - TimePickerViewDelegate
-(void)timePickerViewDidSelectDate:(NSDate *)date
{
//    NSLog(@"%@",date);

    [_timeButton setTitle:[DateUtils convertToString:date format:@"hh:mm"] forState:UIControlStateNormal];
}




-(void)optionsViewControllerFinshedOptionType:(OptionsType)optionType Value:(id)value
{
    switch (optionType) {
        case OptionsTypeType:
            _controlType = value;
            _event = nil;
            break;
        case OptionsTypeEvent:
            _event = value;
            break;
        case OptionsTypeEventLevel:
            _ensureType = value;
            _event = nil;
            break;
        default:

            break;
    }
    [_tableView reloadData];
}

-(void)loadAbnsRecord
{
    [self starNetWorkingWithY:64];
    [HttpsUtils getDispatchAbns:self.isSpecial? _specialModel.id:(int)_safefuardModel.id
                           type:1
                        success:^(NSArray *response) {
                            [self stopNetWorking];
                            if ([response isKindOfClass:[NSArray class]]) {
                                //将字段数组转为对象数组
                                self.abnormalityHistoryArray = [response DictionaryToModel:[AbnormalModel class]];
//                                AbnormalModel *model = [[AbnormalModel alloc]init];
//                                model.event = 90;
//                                model.memo = @"12321";
//                                model.userID = 123;
//                                model.flightID = 2341432;
//                                model.safeguardID = 7;
//                                model.arriveTime = @"20:20";
//                                model.pathList = @"1490862737568/abnormalImage.jpg,1490862737671/abnormalImage.jpg,1490862737869/abnormalImage.jpg";
//                                self.abnormalityHistoryArray =@[model];
                            }
                            [self.abnormalityHistoryTableView reloadData];
                        }failure:^(NSError *error) {
                            [self stopNetWorking];
                            [self showAnimationTitle:@"获取历史列表失败"];
                        }];

}

-(void)uploadImageIndex:(int)index filePathArray:(NSMutableArray *)filePathArray failure:(void (^)(id))failure
{

    __block  int newIndex = index;
    __block  NSMutableArray *blockFilePathArray = [filePathArray mutableCopy];
    if (self.nImageArray.count>0&&index<self.nImageArray.count) {
        [self updateNetWorkingWithString:[NSString stringWithFormat:@"正在上传第%d张，共%ld张",index+1,self.nImageArray.count]];
        [HttpsUtils unusualImageUploadImage:self.nImageArray[index] Success:^(id response) {
            [blockFilePathArray addObject:[[NSString alloc] initWithData:response  encoding:NSUTF8StringEncoding]];
            if (index+1 != self.nImageArray.count) {
            }else{
                self.imageFilePath = [blockFilePathArray copy];
            }
            newIndex++;
            [self uploadImageIndex:newIndex
                     filePathArray:(NSMutableArray *)blockFilePathArray
                           failure:failure];
        } failure:^(id error) {
            [self stopNetWorking];
            failure(error);
        }];
    }else{
        [self updateNetWorkingWithString:@"异常上报"];
        [self sendAbnsReported];
    }
}

-(void)sendAbnsReported
{
    AppDelegate *appdelete = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    if (self.reportType == ReportTypeOrder) {
        if (_orderDic == nil ) {
            [self showAnimationTitle:@"请选择一个环节"];
            return;
        }
        [HttpsUtils saveOtherABNDispatchAbn:_flightId.intValue
                                 dispatchId:_orderDic[@"id"]?((NSNumber *)_orderDic[@"id"]).intValue:0
                               dispatchName:_orderDic[@"name"]?:@""
                                     userId:(int)appdelete.userInfoModel.id
                                    eventId:self.event.basisid
                                       memo:self.requireTextView.text
                                  arrveTime:_timeButton.titleLabel.text
                                    imgPath:[self.imageFilePath componentsJoinedByString:@","]
                                    success:^(id response) {
                                        [self stopNetWorking];
                                        if([response isEqualToString:@"0"]){
                                            [self showAnimationTitle:@"上报失败"];
                                            return;
                                        }
                                        [self showAnimationTitle:@"上报成功"];
                                    }
                                    failure:^(NSError *error) {
                                        [self stopNetWorking];
                                        [self showAnimationTitle:@"上报失败"];
                                    }];

    }else{
        [HttpsUtils saveDispatchAbnStart:self.isSpecial?(int)_flightId.integerValue:(int)_safefuardModel.fid
                              dispatchId:self.isSpecial? _specialModel.id:(int)_safefuardModel.id
                                  userId:(int)appdelete.userInfoModel.id
                                 eventId:self.event.basisid
                                    memo:self.requireTextView.text
                                    flag:self.isSpecial?@"true":@"false"
                               arrveTime:_timeButton.titleLabel.text
                                 imgPath:[self.imageFilePath componentsJoinedByString:@","]
                                 success:^(id response) {
                                     [self stopNetWorking];
                                     if([response isEqualToString:@"0"]){
                                         [self showAnimationTitle:@"上报失败"];
                                         return ;
                                     }
                                     [self showAnimationTitle:@"上报成功"];
                                 }
                                 failure:^(NSError *error) {
                                     [self stopNetWorking];
                                     [self showAnimationTitle:@"上报失败"];
                                 }];

    }

//    NSLog(@"图片路径----：%@",[self.imageFilePath componentsJoinedByString:@","]);
}

@end
