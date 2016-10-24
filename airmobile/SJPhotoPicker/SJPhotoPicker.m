//
//  SJPhotoPicker.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/23.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoPicker.h"
#import "SJPhotoPickerNavController.h"
#import "SJPhotoAlbumsController.h"
#import "SJPickPhotoController.h"
#import "SJAlbumModel.h"

@implementation SJPhotoPicker

+ (instancetype)shareSJPhotoPicker {
    
    static SJPhotoPicker *photoPicker = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!photoPicker) {
            photoPicker = [[SJPhotoPicker alloc] init];
        }
    });
    return photoPicker;
}

- (void) showPhotoPickerToController:(UIViewController *)controller pickedAssets:(SJPhotoPickerBlock)photoPickerBlcok {

    NSLog(@"崩溃!!! 你需要在info.plist 中添加访问PhotoLibary权限控制(Privacy - Photo Library Usage Description)");
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                    
                case PHAuthorizationStatusNotDetermined:
                {
                    NSLog(@"用户还没有做出选择");
                    break;
                }
                case PHAuthorizationStatusAuthorized:
                {
                  
                    NSLog(@"用户允许当前应用访问相册");
//                    SJPhotoPickerNavController *vc = [[SJPhotoPickerNavController alloc] init];
//                    [controller.navigationController pushViewController:vc animated:YES];
//                    self.photoPickerBlock = photoPickerBlcok;
//                    SJPhotoAlbumsController *vc = [[SJPhotoAlbumsController alloc] init];
//                    vc.title = @"相册";
//                    [controller.navigationController pushViewController:vc animated:NO];


                    __weak typeof (controller) wcontroller = controller;
                    [[SJPhotoPickerManager shareSJPhotoPickerManager] requestAlbumsWithType:PHAssetCollectionTypeSmartAlbum  albumResult:^(NSArray *albumArray) {
                        SJPickPhotoController *vc = [[SJPickPhotoController alloc] init];
                        SJAlbumModel *model = [[SJAlbumModel alloc] init];
                        NSArray *groupArray = [albumArray mutableCopy];
                        if (groupArray&&groupArray.count>0) {
                            model = groupArray[0];
                        }
                        vc.assetResult = model.assetResult;
                        [wcontroller.navigationController pushViewController:vc animated:NO];
                    }];
                    break;
                }
                case PHAuthorizationStatusDenied:
                {
                    NSLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
                    break;
                }
                case PHAuthorizationStatusRestricted:
                {
                    NSLog(@"家长控制,不允许访问");
                    break;
                }
                default:
                {
                    NSLog(@"default");
                    break;
                }
            }
        });
    }];
}


@end
