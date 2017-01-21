//
//  UIButton+PhotoChoose.h
//  airmobile
//
//  Created by xuesong on 17/1/19.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PhotoDidFinished) (UIImage *image);
typedef void (^PhotoDidCanceled) (void);

@interface UIButton (PhotoChoose)

@property (nonatomic, assign) BOOL isPhotoChoose; //是否为相片选择器
@property (nonatomic, copy) PhotoDidFinished photoDidFinished; //选择完之后执行的block
@property (nonatomic, copy) PhotoDidCanceled photoDidCanceled; //取消之后执行的block

@end

