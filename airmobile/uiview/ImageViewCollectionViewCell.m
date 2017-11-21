//
//  ImageViewCollectionViewCell.m
//  airmobile
//
//  Created by xuesong on 16/11/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ImageViewCollectionViewCell.h"
#import "FlyImage.h"
#import "HttpsUtils+Business.h"

@implementation ImageViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                 action:@selector(longPrssAction:)];
    longPress.minimumPressDuration = 1.0;
    [self addGestureRecognizer:longPress];
}

-(void)longPrssAction:(UILongPressGestureRecognizer *)longPrss
{
    if(longPrss.state==UIGestureRecognizerStateBegan){
        self.longPressBlock(self);
    }

}
-(void)setImagePath:(NSString *)imagePath
{
    _imagePath = imagePath;
    [_imageView setIconURL:[HttpsUtils imageDownloadURLWithString:imagePath]];
    _imageView.backgroundColor = [UIColor redColor];
    
}

@end
