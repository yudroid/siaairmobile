//
//  TagView.m
//  airmobile
//
//  Created by xuesong on 16/11/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "TagView.h"

@interface TagView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *intervalHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallLabelHeight;

@end

@implementation TagView

-(void)awakeFromNib
{
    [super awakeFromNib];
//    [self.bigLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
}


-(void)bigText:(NSString *) bigText
   bigFontSize:(CGFloat)    bigSize
     smallText:(NSString *) smallText
 smallFontSize:(CGFloat)    smallSize
      interval:(CGFloat)    interval
      tagImage:(UIImage *)  tagImage{
    _bigLabel.text      = bigText;
    _bigLabel.font      = [UIFont fontWithName:@"PingFangSC-Regular" size:bigSize];
    _smallLabel.text    = smallText;
    _smallLabel.font    = [UIFont fontWithName:@"PingFangSC-Light" size:smallSize];
    self.interval       = interval;
    _tagImageView.image = tagImage;

    CGRect bigFrame         = _bigLabel.frame;
    CGRect smallFrame       = _smallLabel.frame;
    bigFrame.size.height    = bigSize *0.8;
    smallFrame.size.height  = smallSize * 0.8;
    _bigLabel.frame         = bigFrame;
    _smallLabel.frame       = smallFrame;

    _bigLabelHeight.constant= bigSize*0.8;

}

-(void)setInterval:(CGFloat)interval
{
    _intervalHeight.constant = interval;
}


-(CGFloat) contentWidth
{
    float bigLabelwidth     = _bigLabel.frame.size.width;
    float smallViewWidth    = _smallView.frame.size.width+4;
    return bigLabelwidth>smallViewWidth?bigLabelwidth:smallViewWidth;
}
-(CGFloat)contentHeight
{
    return viewHeight(_bigLabel)+viewHeight(_smallView)+_intervalHeight.constant;
}



@end
