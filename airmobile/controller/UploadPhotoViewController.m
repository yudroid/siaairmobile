//
//  UploadPhotoViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/21.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "AbnormalityReportCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIViewController+Reminder.h"

static const NSString *UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER = @"UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER";

@interface UploadPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
    @property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) NSMutableArray *collectionArray;

@end

@implementation UploadPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:@"航班详情"];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];
    
    // Do any additional setup after loading the view from its nib.

    _selectedArray = [NSMutableArray array];
    _collectionArray = [NSMutableArray array];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"AbnormalityReportCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:(NSString *)UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER];
}

    
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionArray.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AbnormalityReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"相机"];
    }else{
        cell.imageView.image = _collectionArray[indexPath.row-1];
    }

    if ([_selectedArray containsObject:cell]) {
        cell.isSelected = YES;
    }else{
        cell.isSelected = NO;
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(80, 80);
}
    

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
    
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return  8.0;
}
    
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat x= (kScreenWidth-(80*4+15))/2;
    return UIEdgeInsetsMake(8, x, 8, x);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showAnimationTitle:@"设备不支持拍照"];
        return;
    }
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
    {
        [self showAnimationTitle:@"相机访问被限制"];
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];

    }else{
        AbnormalityReportCollectionViewCell *cell = (AbnormalityReportCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if ([_selectedArray containsObject:cell]) {
            cell.isSelected = NO;
            [_selectedArray removeObject:cell];
        }else{
            cell.isSelected = YES;
            [_selectedArray addObject:cell];
        }
    }

}

#pragma mark - ImagePickerController
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [_collectionArray addObject:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [_collectionView reloadData];
    }];
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
