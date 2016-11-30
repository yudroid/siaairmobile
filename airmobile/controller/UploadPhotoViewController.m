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
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    ALAssetsLibrary *_assetsLibrary;
#pragma clang diagnostic pop
    NSMutableArray *_groupArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:@"航班详情"];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];

    UIButton *finshButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-10-40, 33, 40, 20)];

    [finshButton setTitle:@"完成"  forState:UIControlStateNormal];
    finshButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC"
                                                  size:10];
    [finshButton addTarget:self
                    action:@selector(finshButtonClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:finshButton];

    
    // Do any additional setup after loading the view from its nib.

    _selectedArray = [NSMutableArray array];
    _collectionArray = [NSMutableArray array];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"AbnormalityReportCollectionViewCell" bundle:nil]
      forCellWithReuseIdentifier:(NSString *)UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER];
    [self getAlbumList];
}

-(void)finshButtonClick:(UIButton *)sender
{
	if (_delegate && [_delegate respondsToSelector:@selector(UploadPhotoViewControllerFinished:)]) {
		[_delegate UploadPhotoViewControllerFinished:_selectedArray];
	}
	[self.navigationController popViewControllerAnimated:YES];
}
    
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionArray.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AbnormalityReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"TakePhoto"];
        cell.selectedBackgroundImageView.hidden = YES;
    }else{
        cell.selectedBackgroundImageView.hidden = NO;
        cell.imageView.image = _collectionArray[indexPath.row-1];

        if ([_selectedArray containsObject:_collectionArray[indexPath.row-1]]) {
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
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
#pragma clang diagnostic pop
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];

    }else{
        AbnormalityReportCollectionViewCell *cell = (AbnormalityReportCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if ([_selectedArray containsObject:_collectionArray[indexPath.row-1]]) {
            cell.isSelected = NO;
            [_selectedArray removeObject:_collectionArray[indexPath.row-1]];
        }else{
            cell.isSelected = YES;
            [_selectedArray addObject:_collectionArray[indexPath.row-1]];
        }
    }

}

#pragma mark - ImagePickerController
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageWriteToSavedPhotosAlbum(image,
                                   self,
                                   @selector(image:didFinishSavingWithError:contextInfo:),
                                   nil);
    [picker dismissViewControllerAnimated:YES completion:^{
        [_collectionArray insertObject:[info objectForKey:UIImagePickerControllerOriginalImage] atIndex:0];
        [_collectionView reloadData];
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:
(NSError *)error contextInfo:(void *)contextInfo;
{
    // Handle the end of the image write process
    if (!error)
        NSLog(@"Image written to photo album");
    else
        NSLog(@"Error writing to photo album: %@",
                  [error localizedDescription]);
}

#pragma mark - CoustomFunction
//获取相册列表
- (void)getAlbumList
{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //获取相册列表
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    _groupArray = [NSMutableArray array];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
         [self getImageWithGroup:group name:groupName];

     } failureBlock:^(NSError *error)
     {
         NSLog(@"error:%@",error.localizedDescription);
     }];
#pragma clang diagnostic pop
}

//根据相册获取下面的图片
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)getImageWithGroup:(ALAssetsGroup *)group name:(NSString *)name
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //根据相册获取下面的图片
        NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
        if (name && ![name isEqualToString:groupName])
        {
            return;
        }

        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {

            if (result) {

                [_collectionArray addObject:[UIImage imageWithCGImage:result.thumbnail]];

//                [_thumbnailArray addObject:[UIImage imageWithCGImage:result.thumbnail]];
//
//                ALAssetRepresentation *representation = result.defaultRepresentation;
//                [_imageArray addObject:representation.url];

            }
            if (index == group.numberOfAssets - 1)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_collectionView reloadData];
                });
            }
        }];
    });
    
    
}
#pragma clang diagnostic pop




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
