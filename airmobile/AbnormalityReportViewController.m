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
#import <AssetsLibrary/AssetsLibrary.h>

static const NSString *ABNORMALITYREPORT_TABLECELL_IDENTIFIER =@"ABNORMALITYREPORT_TABLECELL_IDENTIFIER";
static const NSString *ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER = @"ABNORMALITYREPORT_COLLECTIONCELL_IDENTIFIER";

@interface AbnormalityReportViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableViewArray;
@property (weak, nonatomic) IBOutlet UITextView *remarksTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic ,strong) NSMutableArray *collectionArray;
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
    _tableViewArray = @[@"类型",@"部门",@"事件",@"上报人",@"要求"];
    
    
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



#pragma mark - TableViewDelegate TableViewDataSource


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:(NSString *)ABNORMALITYREPORT_TABLECELL_IDENTIFIER];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _tableViewArray[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)phoneButttonClick:(id)sender {
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
    {
        [self showAnimationTitle:@"相机访问被限制"];
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}



#pragma mark - ImagePickerController
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [_collectionArray addObject:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [_photoCollectionView reloadData];
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
