//
//  UserManagementViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "UserManagementViewController.h"
#import "UIViewController+Reminder.h"
#import "UserManagermentTableViewCell.h"
#import "ModifyPwdView.h"
#import "HttpsUtils+Business.h"
#import "HttpsUtils.h"
#import "AppDelegate.h"
#import <FlyImage.h>
#import "ConcernModel.h"
#import "UserManageSoundTableViewCell.h"
#import "PersistenceUtils+Business.h"


static const NSString *USERMANAGEMENT_TABLECELL_IDENTIFIER = @"USERMANAGEMENT_TABLECELL_IDENTIFIER";

@interface UserManagementViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ModifyPwdViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tableviewArray;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clearMeaageHeight;
@property (weak, nonatomic) IBOutlet UIView *clearMessageView;

@end

@implementation UserManagementViewController
{
    ModifyPwdView *modifyPwdView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"用户管理"];
    [self titleViewAddBackBtn];
    
    _headImageView.layer.cornerRadius =17.5;
    _headImageView.layer.masksToBounds = YES;
    
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableviewArray = @[@"修改密码",@"清除关注",@"声音提示"];
    [_tableView registerNib:[UINib nibWithNibName:@"UserManagermentTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)USERMANAGEMENT_TABLECELL_IDENTIFIER];

    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_headImageView setIconURL:[HttpsUtils imageDownloadURLWithString:appdelegate.userInfoModel.imagePath]];

}
- (IBAction)messageClearButtonClick:(id)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要将消息清除吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PersistenceUtils delectMessage];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)headButtonClick:(id)sender {
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_3
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"图片", nil];
    [sheet showInView:self.view];
#else
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.allowsEditing = YES;
        picker.delegate = self;
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showAnimationTitle:@"设备不支持拍照"];
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];

    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];

    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];

#endif

}

-(void)viewWillAppear:(BOOL)animated
{
    if (![CommonFunction hasFunction:SET_USERMANAGE_HEADER]) {
        _headerViewHeight.constant = 0;
        _headImageView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    if (![CommonFunction hasFunction:SET_USERMANAGE_CLEARMESSAGE]) {
        _clearMeaageHeight.constant = 0;
        _clearMessageView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    if (![CommonFunction hasFunction:SET_USERMANAGE_PASSWORD]) {
        _tableView.hidden = YES;
    }
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
    return 78;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_tableviewArray[indexPath.row] isEqualToString:@"声音提示"]) {
        UserManageSoundTableViewCell *soundCell = [[NSBundle mainBundle] loadNibNamed:@"UserManageSoundTableViewCell" owner:nil options:nil][0];
        return soundCell;
    }else{
        UserManagermentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)USERMANAGEMENT_TABLECELL_IDENTIFIER];
        cell.nameLabel.text= _tableviewArray[indexPath.row];
        return  cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if([_tableviewArray[indexPath.row] isEqualToString:@"修改密码"]){
        modifyPwdView = [[NSBundle mainBundle]loadNibNamed:@"ModifyPwd" owner:nil options:nil][0];
        modifyPwdView.frame = self.view.frame;
        [modifyPwdView createBlurBackgroundWithImage:[self jt_imageWithView:self.view] tintColor:[[UIColor blackColor] colorWithAlphaComponent:0.35] blurRadius:60.0];
        modifyPwdView.delegate = self;
        [self.view addSubview:modifyPwdView];
    }else if ([_tableviewArray[indexPath.row] isEqualToString:@"清除关注"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要将关注信息清除吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ConcernModel removeAll];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];

    }
}
#pragma mark - UIAlertViewDelegate
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_3
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //清除消息
    }
}
#endif
#pragma mark - UIActionSheet
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= _IPHONE_8_3
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
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:nil];
}
#endif
#pragma mark -  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    [self starNetWorking];
    
    [self dismissViewControllerAnimated:YES completion:^{
//        _headImageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage  *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
        image = [UIImage imageWithData:imgData];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"headimage.png"]];
        BOOL result = [UIImagePNGRepresentation(image)writeToFile: filePath atomically:YES];

        if (result) {
            [HttpsUtils headImageUploadSuccess:^(NSData *response) {
                [self showAnimationTitle:@"上传成功"];
                 NSString *imageName = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];

                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userInfoModel.imagePath = imageName;

                [_headImageView setIconURL:[HttpsUtils imageDownloadURLWithString:imageName]];
                _headImageView.backgroundColor = [UIColor redColor];
               
                [self stopNetWorking];

            } failure:^(id error) {
                [self stopNetWorking];
                [self showAnimationTitle:@"上传失败"];
            }];
        }else{
            [self stopNetWorking];
            [self showAnimationTitle:@"上传失败"];
        }
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)jt_imageWithView:(UIView *)view {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:true];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)modifyPwdView:(ModifyPwdView *)_modifyPwdView sureButtonClick:(UIButton *)sender
{
    if (_modifyPwdView.originalLabel.text.length == 0 ||
       _modifyPwdView.newpwdLabel.text.length == 0 ||
       _modifyPwdView.confirmPwdLabel.text.length == 0) {
        [self showAnimationTitle:@"请输入完整"];
        return;
    }
    if (![_modifyPwdView.newpwdLabel.text isEqualToString:_modifyPwdView.confirmPwdLabel.text]) {
        [self showAnimationTitle:@"两个密码不同，请重新输入"];
        return;
    }

    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [HttpsUtils updatePwd:appdelegate.userInfoModel.jobNumber
                      pwd:_modifyPwdView.originalLabel.text
                   newpwd:_modifyPwdView.newpwdLabel.text
                  success:^(id response) {
                      if ([[response objectForKey:@"result"] isEqualToString:@"fail"]) {
                          [self showAnimationTitle:[response objectForKey:@"reason"]];
                      }else{
                          [self showAnimationTitle:@"修改成功"];
                      }
                      [_modifyPwdView cancelButtonClick:nil];
                  } failure:^(NSError *error) {
                      [self showAnimationTitle:@"修改失败"];
                  }];
}

@end
