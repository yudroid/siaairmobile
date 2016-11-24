//
//  UploadPhotoViewController.h
//  airmobile
//
//  Created by xuesong on 16/10/21.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@protocol UploadPhotoViewControllerDelegate <NSObject>

-(void)UploadPhotoViewControllerFinished:(NSArray *)dataArray;

@end

@interface UploadPhotoViewController : RootViewController

@property (nonatomic, weak) id<UploadPhotoViewControllerDelegate> delegate;

@end
