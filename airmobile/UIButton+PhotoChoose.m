//
//  UIButton+PhotoChoose.m
//  airmobile
//
//  Created by xuesong on 17/1/19.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "UIButton+PhotoChoose.h"
#import "UIControl+SelfViewController.h"
#import "UIViewController+Reminder.h"
#import <objc/runtime.h>


@interface UIButton()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation UIButton (PhotoChoose)

@dynamic isPhotoChoose;
@dynamic photoDidFinished;
@dynamic photoDidCanceled;

-(BOOL)isPhotoChoose
{
    return  ((NSNumber *)objc_getAssociatedObject(self, _cmd)).boolValue;
}

-(void)setIsPhotoChoose:(BOOL)isPhotoChoose
{
    objc_setAssociatedObject(self, @selector(isPhotoChoose), @(isPhotoChoose), OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (isPhotoChoose) {
        [self addTarget:self
                 action:@selector(selfButtonClick:)
       forControlEvents:UIControlEventTouchUpInside];
    }


}

-(PhotoDidFinished)photoDidFinished
{
    return objc_getAssociatedObject(self, _cmd);

}


-(void)setPhotoDidFinished:(PhotoDidFinished)photoDidFinished
{
    objc_setAssociatedObject(self, @selector(photoDidFinished), photoDidFinished, OBJC_ASSOCIATION_COPY);
}



-(PhotoDidCanceled)photoDidCanceled
{
    return  objc_getAssociatedObject(self, _cmd);
}

-(void)setPhotoDidCanceled:(PhotoDidCanceled)photoDidCanceled
{
    objc_setAssociatedObject(self, @selector(photoDidCanceled), photoDidCanceled, OBJC_ASSOCIATION_COPY);
}

-(void)selfButtonClick:(UIButton *)sender
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_3
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:@"拍照"
                                             otherButtonTitles:@"图片", nil];
    [sheet showInView:self.view];
#else
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                                                          picker.allowsEditing = YES;
                                                          picker.delegate = self;
                                                          if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                              [[self rootViewController] showAnimationTitle:@"设备不支持拍照"];
                                                              return;
                                                          }
                                                          picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                          [[self rootViewController] presentViewController:picker animated:YES completion:nil];

                                                      }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"图片"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                                                              picker.delegate = self;
                                                              picker.allowsEditing = YES;
                                                              picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                              [[self rootViewController] presentViewController:picker
                                                                                                      animated:YES
                                                                                                    completion:nil];

                                                          }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    [[self rootViewController] presentViewController:alertController
                                            animated:YES
                                          completion:nil];
    
#endif
}

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
    [[self rootViewController] dismissViewControllerAnimated:YES completion:^{
        UIImage  *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (self.photoDidFinished!=nil) {
            self.photoDidFinished(image);
        }
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[self rootViewController] dismissViewControllerAnimated:YES completion:nil];
    self.photoDidCanceled();
}


@end
