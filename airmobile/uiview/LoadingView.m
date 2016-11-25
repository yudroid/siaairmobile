//
//  LoadingView.m
//  airmobile
//
//  Created by xuesong on 16/11/22.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "LoadingView.h"
#import <FLAnimatedImage.h>

@implementation LoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];

    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"loading" ofType:@"gif"]]];
    //    _imageView.animatedImage = image;
    _contentImageView.image = image.posterImage;
}

@end
