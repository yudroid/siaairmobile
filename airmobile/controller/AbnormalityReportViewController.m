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


static const NSString *ABNORMALITYREPORT_TABLECELL_IDENTIFIER =@"ABNORMALITYREPORT_TABLECELL_IDENTIFIER";
static const NSString *ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER = @"ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER";

@interface AbnormalityReportViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,TimePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableViewArray;
@property (weak, nonatomic) IBOutlet UITextView *remarksTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic ,strong) NSMutableArray *collectionArray;
@property (weak, nonatomic) IBOutlet UITableView *abnormalityTableView;
@property (nonatomic, strong) TimePickerView * timePickerView;
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
    [_tableView registerNib:[UINib nibWithNibName:@"AbnormalityReportTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
    _tableViewArray = @[@"类型",@"事件"];

    _abnormalityTableView.delegate = self;
    _abnormalityTableView.dataSource = self;
    [_abnormalityTableView registerNib:[UINib nibWithNibName:@"AbnormalityReportTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
    _tableViewArray = @[@"类型",@"事件"];
    

    _photoCollectionView.delegate =self;
    _photoCollectionView.dataSource = self;
    [_photoCollectionView registerNib:[UINib nibWithNibName:@"AbnormalityReportCollectionViewCell"  bundle:nil]forCellWithReuseIdentifier:(NSString *)ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER];
    _collectionArray = [NSMutableArray array];
    
    _remarksTextView.returnKeyType =UIReturnKeyDone;
    _remarksTextView.delegate = self;
    
    //注册键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}



// 键盘通知
- (void)keyboardWillShowNotification:(NSNotification *)info
{
    NSDictionary *userInfo = [info userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    float y =244-( kScreenHeight-kbSize.height- _remarksTextView.frame.size.height)+8;
    if (y>self.scrollView.contentOffset.y) {
        [UIView animateWithDuration:1.0 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, y);
        }];
    }
}
- (void)keyboardWillHideNotification:(NSNotification *)info
{
    
}



#pragma mark - EVENT

- (IBAction)startReportDatClick:(id)sender {
    [self setupDateView];
}
- (IBAction)endReportDate:(id)sender {
    [self setupDateView];
}

- (IBAction)phoneButttonClick:(id)sender
{
//    UploadPhotoViewController *uploadPhotoVC = [[UploadPhotoViewController alloc]initWithNibName:@"UploadPhotoViewController" bundle:nil];
//    [self.navigationController pushViewController:uploadPhotoVC animated:YES];

    [[SJPhotoPicker shareSJPhotoPicker] showPhotoPickerToController:self pickedAssets:^(NSArray<PHAsset *> *assets) {
        _collectionArray = [NSMutableArray arrayWithArray:assets];
        [_photoCollectionView reloadData];
    }];


}

- (void)setupDateView
{
    if (_timePickerView == nil) {
        [UIView animateWithDuration:0.3 animations:^{
            _timePickerView = [[NSBundle mainBundle] loadNibNamed:@"TimePickerView" owner:nil options:nil][0];
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

#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AbnormalityReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
    cell.nameLabel.text =_tableViewArray[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






#pragma mark - collection delegate datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AbnormalityReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER forIndexPath:indexPath];
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
        [_remarksTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - TimePickerViewDelegate
-(void)timePickerViewDidEnsure:(NSDate *)date
{
    NSLog(@"选中时间%@",date);
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
