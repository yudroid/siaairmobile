//
//  UserManagementViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "UserManagementViewController.h"
#import "UIViewController+Reminder.h"

static const NSString *USERMANAGEMENT_TABLECELL_IDENTIFIER = @"USERMANAGEMENT_TABLECELL_IDENTIFIER";

@interface UserManagementViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableviewArray;
@end

@implementation UserManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"我的"];
    [self titleViewAddBackBtn];
    
    _headImageView.layer.cornerRadius =17.5;
    _headImageView.layer.masksToBounds = YES;
    
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableviewArray = @[@"原密码",@"新密码",@"确认密码"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:(NSString *)USERMANAGEMENT_TABLECELL_IDENTIFIER];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)headButtonClick:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"图片", nil];
    [sheet showInView:self.view];
    
}
- (IBAction)nameButtonClick:(id)sender {
}

#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableviewArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)USERMANAGEMENT_TABLECELL_IDENTIFIER];
    cell.textLabel.text= _tableviewArray[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIActionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    if (buttonIndex == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showAnimationTitle:@"设备不支持拍照"];
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark -  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        _headImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
