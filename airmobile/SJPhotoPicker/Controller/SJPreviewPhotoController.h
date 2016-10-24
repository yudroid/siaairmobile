//
//  SJPreviewPhotoController.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "SJPhotoModel.h"

@protocol SJPreviewPhotoControllerDelegate <NSObject>

- (void)pickedArrayChangeWithModel:(SJPhotoModel *)model;

@end

@interface SJPreviewPhotoController : RootViewController

@property (nonatomic, strong) NSMutableArray *previewArray;
@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic, strong) id<SJPreviewPhotoControllerDelegate> delegate;

@end
