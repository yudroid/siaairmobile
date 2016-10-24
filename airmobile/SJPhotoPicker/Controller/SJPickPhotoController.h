//
//  SJPickPhotoController.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "RootViewController.h"
@interface SJPickPhotoController : RootViewController

@property (nonatomic, strong) PHFetchResult *assetResult;

@end
