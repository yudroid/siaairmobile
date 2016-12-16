//
//  LoadingView.h
//  airmobile
//
//  Created by xuesong on 16/11/22.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLAnimatedImageView;

@interface LoadingView : UIView

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end
