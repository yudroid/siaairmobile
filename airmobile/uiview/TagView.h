//
//  TagView.h
//  airmobile
//
//  Created by xuesong on 16/11/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView

@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;
@property (nonatomic, assign) CGFloat interval;
@property (weak, nonatomic) IBOutlet UIView *smallView;

-(void)bigText:(NSString *)bigText bigFontSize:(CGFloat)bigSize smallText:(NSString *)smallText smallFontSize:(CGFloat)smallSize interval:(CGFloat)interval tagImage:(UIImage *)tagImage;

-(CGFloat) contentWidth;
-(CGFloat) contentHeight;

@end
